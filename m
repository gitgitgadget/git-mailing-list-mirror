From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Don't checkout the full tree if avoidable
Date: Mon, 1 Oct 2007 04:08:55 -0700
Message-ID: <20071001110855.GB10079@muzzle>
References: <1191000259190-git-send-email-stevenrwalter@gmail.com> <7vejgftgef.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Walter <stevenrwalter@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 13:09:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcJ96-0007NG-IX
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 13:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbXJALI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 07:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbXJALI5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 07:08:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34354 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbXJALI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 07:08:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6AE307DC093;
	Mon,  1 Oct 2007 04:08:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vejgftgef.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59599>

Junio C Hamano <gitster@pobox.com> wrote:
> Steven Walter <stevenrwalter@gmail.com> writes:
>
> > In most cases of branching, the tree is copied unmodified from the trunk
> > to the branch.  When that is done, we can simply start with the parent's
> > index and apply the changes on the branch as usual.
> >
> > Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
>
> Eric, do you like this one?

Junio, thanks for pinging me about it, I haven't been following the ML
very closely and forgot about this issue.

Steven Walter wrote:
> One criticism of the patch: the trees_match function probably needs to
> be re-written.  My SVN::Perl-foo is weak.

Yep :)

Steven:

How does the following work for you?  Which version of SVN do you have,
by the way?  I just found a bug with the way SVN::Client::diff() is
exported for SVN 1.1.4, hence the SVN::Pool->new_default_sub usage.

From: Steven Walter <stevenrwalter@gmail.com>
Date: Fri, 28 Sep 2007 13:24:19 -0400
Subject: [PATCH] Don't checkout the full tree if avoidable

In most cases of branching, the tree is copied unmodified from the trunk
to the branch.  When that is done, we can simply start with the parent's
index and apply the changes on the branch as usual.

[ew: rewritten from Steven's original to use SVN::Client instead
     of the command-line svn client.

     Since SVN::Client connects separately, we'll share our
     authentication providers array between our usages of
     SVN::Client and SVN::Ra, too.  Bypassing the high-level
     SVN::Client library can avoid this, but the code will be
     much more complex.  Regardless, any implementation of this
     seems to require restarting a connection to the remote
     server.

     Also of note is that SVN 1.4 and later allows a more
     efficient diff_summary to be done instead of a full diff,
     but since this code is only to support SVN < 1.4.4, we'll
     ignore it for now.]

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   64 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 484b057..777e436 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1847,6 +1847,16 @@ sub find_parent_branch {
 			$gs->ra->gs_do_switch($r0, $rev, $gs,
 					      $self->full_url, $ed)
 			  or die "SVN connection failed somewhere...\n";
+		} elsif ($self->ra->trees_match($new_url, $r0,
+			                        $self->full_url, $rev)) {
+			print STDERR "Trees match:\n",
+			             "  $new_url\@$r0\n",
+			             "  ${\$self->full_url}\@$rev\n",
+				     "Following parent with no changes\n";
+			$self->tmp_index_do(sub {
+			    command_noisy('read-tree', $parent);
+			});
+			$self->{last_commit} = $parent;
 		} else {
 			print STDERR "Following parent with do_update\n";
 			$ed = SVN::Git::Fetcher->new($self);
@@ -3027,28 +3037,32 @@ BEGIN {
 	}
 }
 
+sub _auth_providers () {
+	[
+	  SVN::Client::get_simple_provider(),
+	  SVN::Client::get_ssl_server_trust_file_provider(),
+	  SVN::Client::get_simple_prompt_provider(
+	    \&Git::SVN::Prompt::simple, 2),
+	  SVN::Client::get_ssl_client_cert_file_provider(),
+	  SVN::Client::get_ssl_client_cert_prompt_provider(
+	    \&Git::SVN::Prompt::ssl_client_cert, 2),
+	  SVN::Client::get_ssl_client_cert_pw_prompt_provider(
+	    \&Git::SVN::Prompt::ssl_client_cert_pw, 2),
+	  SVN::Client::get_username_provider(),
+	  SVN::Client::get_ssl_server_trust_prompt_provider(
+	    \&Git::SVN::Prompt::ssl_server_trust),
+	  SVN::Client::get_username_prompt_provider(
+	    \&Git::SVN::Prompt::username, 2)
+	]
+}
+
 sub new {
 	my ($class, $url) = @_;
 	$url =~ s!/+$!!;
 	return $RA if ($RA && $RA->{url} eq $url);
 
 	SVN::_Core::svn_config_ensure($config_dir, undef);
-	my ($baton, $callbacks) = SVN::Core::auth_open_helper([
-	    SVN::Client::get_simple_provider(),
-	    SVN::Client::get_ssl_server_trust_file_provider(),
-	    SVN::Client::get_simple_prompt_provider(
-	      \&Git::SVN::Prompt::simple, 2),
-	    SVN::Client::get_ssl_client_cert_file_provider(),
-	    SVN::Client::get_ssl_client_cert_prompt_provider(
-	      \&Git::SVN::Prompt::ssl_client_cert, 2),
-	    SVN::Client::get_ssl_client_cert_pw_prompt_provider(
-	      \&Git::SVN::Prompt::ssl_client_cert_pw, 2),
-	    SVN::Client::get_username_provider(),
-	    SVN::Client::get_ssl_server_trust_prompt_provider(
-	      \&Git::SVN::Prompt::ssl_server_trust),
-	    SVN::Client::get_username_prompt_provider(
-	      \&Git::SVN::Prompt::username, 2),
-	  ]);
+	my ($baton, $callbacks) = SVN::Core::auth_open_helper(_auth_providers);
 	my $config = SVN::Core::config_get_config($config_dir);
 	$RA = undef;
 	my $self = SVN::Ra->new(url => $url, auth => $baton,
@@ -3112,6 +3126,24 @@ sub get_log {
 	$ret;
 }
 
+sub trees_match {
+	my ($self, $url1, $rev1, $url2, $rev2) = @_;
+	my $ctx = SVN::Client->new(auth => _auth_providers);
+	my $out = IO::File->new_tmpfile;
+
+	# older SVN (1.1.x) doesn't take $pool as the last parameter for
+	# $ctx->diff(), so we'll create a default one
+	my $pool = SVN::Pool->new_default_sub;
+
+	$ra_invalid = 1; # this will open a new SVN::Ra connection to $url1
+	$ctx->diff([], $url1, $rev1, $url2, $rev2, 1, 1, 0, $out, $out);
+	$out->flush;
+	my $ret = (($out->stat)[7] == 0);
+	close $out or croak $!;
+
+	$ret;
+}
+
 sub get_commit_editor {
 	my ($self, $log, $cb, $pool) = @_;
 	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
-- 
Eric Wong
