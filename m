From: John Keeping <john@keeping.me.uk>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 19:43:06 +0000
Message-ID: <20130312194306.GE2317@serenity.lan>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
 <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
 <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan>
 <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McClure <matthewlmcclure@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 20:43:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFV6t-0008Js-BC
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 20:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab3CLTnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 15:43:16 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:35614 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab3CLTnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 15:43:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 1B3AD606515;
	Tue, 12 Mar 2013 19:43:15 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KxS2jvcLffwr; Tue, 12 Mar 2013 19:43:14 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 1E7B76064D7;
	Tue, 12 Mar 2013 19:43:08 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217988>

On Tue, Mar 12, 2013 at 12:23:52PM -0700, David Aguilar wrote:
> I don't think we could do this without adding an additional flag
> to trigger this change in behavior (e.g. --null-sha1-for-....?)
> so that existing users are unaffected by the change.
> 
> It feels like forcing the null SHA-1 is heavy-handed, but I
> haven't thought it through enough.
> 
> While this may be a quick way to get this behavior,
> I wonder if there is a better way.
> 
> Does anybody else have any comments/suggestions on how to
> better accomplish this?

How about something like "--symlink-all" where the everything in the
right-hand tree is symlink'd?

Something like this perhaps:

-- >8 --
diff --git a/git-difftool.perl b/git-difftool.perl
index 0a90de4..cab7c45 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -85,7 +85,7 @@ sub exit_cleanup
 
 sub setup_dir_diff
 {
-	my ($repo, $workdir, $symlinks) = @_;
+	my ($repo, $workdir, $symlinks, $symlink_all) = @_;
 
 	# Run the diff; exit immediately if no diff found
 	# 'Repository' and 'WorkingCopy' must be explicitly set to insure that
@@ -159,10 +159,10 @@ EOF
 		}
 
 		if ($rmode ne $null_mode) {
-			if ($rsha1 ne $null_sha1) {
-				$rindex .= "$rmode $rsha1\t$dst_path\0";
-			} else {
+			if ($symlink_all or $rsha1 eq $null_sha1) {
 				push(@working_tree, $dst_path);
+			} else {
+				$rindex .= "$rmode $rsha1\t$dst_path\0";
 			}
 		}
 	}
@@ -299,6 +299,7 @@ sub main
 		prompt => undef,
 		symlinks => $^O ne 'cygwin' &&
 				$^O ne 'MSWin32' && $^O ne 'msys',
+		symlink_all => undef,
 		tool_help => undef,
 	);
 	GetOptions('g|gui!' => \$opts{gui},
@@ -308,6 +309,7 @@ sub main
 		'y' => sub { $opts{prompt} = 0; },
 		'symlinks' => \$opts{symlinks},
 		'no-symlinks' => sub { $opts{symlinks} = 0; },
+		'symlink-all' => \$opts{symlink_all},
 		't|tool:s' => \$opts{difftool_cmd},
 		'tool-help' => \$opts{tool_help},
 		'x|extcmd:s' => \$opts{extcmd});
@@ -346,7 +348,7 @@ sub main
 	# will invoke a separate instance of 'git-difftool--helper' for
 	# each file that changed.
 	if (defined($opts{dirdiff})) {
-		dir_diff($opts{extcmd}, $opts{symlinks});
+		dir_diff($opts{extcmd}, $opts{symlinks}, $opts{symlink_all});
 	} else {
 		file_diff($opts{prompt});
 	}
@@ -354,13 +356,13 @@ sub main
 
 sub dir_diff
 {
-	my ($extcmd, $symlinks) = @_;
+	my ($extcmd, $symlinks, $symlink_all) = @_;
 	my $rc;
 	my $error = 0;
 	my $repo = Git->repository();
 	my $workdir = find_worktree($repo);
 	my ($a, $b, $tmpdir, @worktree) =
-		setup_dir_diff($repo, $workdir, $symlinks);
+		setup_dir_diff($repo, $workdir, $symlinks, $symlink_all);
 
 	if (defined($extcmd)) {
 		$rc = system($extcmd, $a, $b);
