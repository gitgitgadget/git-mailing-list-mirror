From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin
	command.
Date: Sun, 23 Dec 2007 20:52:32 -0500
Message-ID: <20071224015232.GB12616@fieldses.org>
References: <20071211195712.GA3865@bitplanet.net> <Pine.LNX.4.64.0712111549490.5349@iabervon.org> <1197416286.7552.4.camel@hinata.boston.redhat.com> <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 02:53:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6cVA-0000wP-Ts
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 02:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbXLXBwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 20:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbXLXBwm
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 20:52:42 -0500
Received: from mail.fieldses.org ([66.93.2.214]:36809 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbXLXBwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 20:52:41 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J6cUb-0003gN-15; Sun, 23 Dec 2007 20:52:33 -0500
Content-Disposition: inline
In-Reply-To: <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69200>

On Tue, Dec 11, 2007 at 07:12:54PM -0800, Junio C Hamano wrote:
>  * HEAD discovery
> 
>    The code can be lifted from the scripted version and transplanted to
>    git-remote.  And to make "origin" and other remotes added by "git
>    remote add", this logic needs to be moved to "git remote".

A rough first attempt appended.

Cleaning up in "remote rm" is a bit of a pain once a remote can contain
symbolic-refs.  Would it make sense to add something like a "git
update-ref -D <refname>" that deletes anything at that path with no
checking?

Thanks for outlining these remote improvements, by the way, I really
look forward to them.  I'll do what I can, but will probably be much too
slow....

--b.

commit fecdb5c0d118767c216302e2c91950cca04f9a26
Author: J. Bruce Fields <bfields@citi.umich.edu>
Date:   Fri Dec 21 19:55:09 2007 -0500

    git-remote: make add -f guess HEAD, as clone does
    
    Has a few ugly bits.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

diff --git a/git-remote.perl b/git-remote.perl
index d13e4c1..3299029 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -270,12 +270,57 @@ sub show_remote {
 	return 0;
 }
 
+sub guess_head {
+	my ($subdir, $head_sha1) = @_;
+	my $found = 0;
+
+	for ($git->command('for-each-ref', "$subdir")) {
+		chomp;
+		m|^([0-9a-f]{40})\s[a-z]+\s$subdir/(.*)$| || die();
+		my ($sha1, $ref) = ($1, $2);
+
+		if ($sha1 eq $head_sha1) {
+			$found = $ref;
+			# prefer "master" if it matches:
+			if ($ref eq "master") {
+				last;
+			}
+		}
+	}
+	return $found
+}
+
+sub fix_head {
+	my ($remote) = @_;
+
+	my $subdir = "refs/remotes/$remote";
+	my $head_sha1 = $git->command(qw(rev-parse --verify), "$subdir/HEAD");
+	chomp($head_sha1);
+
+	unlink($git->repo_path."/$subdir/HEAD");
+	my $found = guess_head($subdir, $head_sha1);
+	if (!$found) {
+		# Just leave it as a a bare sha1
+		$git->command("update-ref", "$subdir/HEAD", "$head_sha1");
+		return;
+	}
+	$git->command("symbolic-ref", "$subdir/HEAD", "$subdir/$found");
+	$git->command("config", "branch.$found.remote", "$remote");
+	$git->command("config", "branch.$found.merge", "refs/heads/$found");
+}
+
 sub add_remote {
 	my ($name, $url, $opts) = @_;
 	if (exists $remote->{$name}) {
 		print STDERR "remote $name already exists.\n";
 		exit(1);
 	}
+
+	# Tricky!: magic HEAD setup should only be done when
+	# "mirror", "master", and "track" options aren't given.
+	# And for orthagonality perhaps we should also provide a
+	# "track head" optio., compatible with "track" but not
+	# the other two....
 	$git->command('config', "remote.$name.url", $url);
 	my $track = $opts->{'track'} || ["*"];
 
@@ -286,7 +331,17 @@ sub add_remote {
 				"+refs/heads/$_:refs/remotes/$name/$_");
 	}
 	if ($opts->{'fetch'}) {
-		$git->command('fetch', $name);
+		if (!$opts->{'mirror'} && !$opts->{'master'}
+					&& !$opts->{'track'}) {
+			my $refspec = "+refs/heads/*:refs/remotes/$name/*";
+
+			# XXX: can there be a remote refs/heads/HEAD??
+			$git->command('fetch', $name, $refspec,
+					"HEAD:refs/remotes/$name/HEAD");
+			fix_head($name);
+		} else {
+			$git->command('fetch', $name);
+		}
 	}
 	if (exists $opts->{'master'}) {
 		$git->command('symbolic-ref', "refs/remotes/$name/HEAD",
@@ -338,11 +393,11 @@ sub rm_remote {
 		}
 	};
 
-	my @refs = $git->command('for-each-ref',
-		'--format=%(refname) %(objectname)', "refs/remotes/$name");
-	for (@refs) {
-		($ref, $object) = split;
-		$git->command(qw(update-ref -d), $ref, $object);
+	# Ugh: update-ref doesn't work on symref (as "HEAD" may be),
+	# but the following won't work on packed refs, for example.
+	for ($git->command('for-each-ref',
+			'--format=%(refname)', "refs/remotes/$name")) {
+		unlink($git->repo_path."/$_");
 	}
 	return 0;
 }
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 636aec2..5576f2a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -69,7 +69,7 @@ test_expect_success 'add another remote' '
 	tokens_match "origin second" "$(git remote)" &&
 	check_remote_track origin master side &&
 	check_remote_track second master side another &&
-	check_tracking_branch second master side another &&
+	check_tracking_branch second HEAD master side another &&
 	git for-each-ref "--format=%(refname)" refs/remotes |
 	sed -e "/^refs\/remotes\/origin\//d" \
 	    -e "/^refs\/remotes\/second\//d" >actual &&
