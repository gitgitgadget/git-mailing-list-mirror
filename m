From: Jeff King <peff@peff.net>
Subject: Re: Unapplied patches reminder
Date: Mon, 19 Oct 2009 02:49:55 -0400
Message-ID: <20091019064955.GB1457@coredump.intra.peff.net>
References: <20091019052030.6117@nanako3.lavabit.com>
 <7v63aci8id.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 08:50:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzm4C-0004K0-S5
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 08:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbZJSGty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 02:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbZJSGty
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 02:49:54 -0400
Received: from peff.net ([208.65.91.99]:36271 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbZJSGtx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 02:49:53 -0400
Received: (qmail 15337 invoked by uid 107); 19 Oct 2009 06:53:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 19 Oct 2009 02:53:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Oct 2009 02:49:55 -0400
Content-Disposition: inline
In-Reply-To: <7v63aci8id.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130661>

On Sun, Oct 18, 2009 at 04:31:54PM -0700, Junio C Hamano wrote:

> > From:	Jeff King <peff@peff.net>
> > Subject: Re: [BUG?] git-cvsimport: path to cvspsfile
> > Date:	Wed, 23 Sep 2009 15:14:29 -0400
> > Message-ID: <20090923191428.GA30104@coredump.intra.peff.net>
> >
> >     Bug. The script does a chdir() and then looks at the cvspsfile later. I
> >     think "-A" would have the same problem. Here is a totally untested patch
> >     to address the issue. Johannes, will this is_absolute_path actually work
> >     on Windows? I think The Right Way would be to use
> >     File::Spec::file_name_is_absolute, but I haven't checked whether that is
> >     part of core perl and if so, which version it appeared in.
> 
> My understanding of this is that it is a typical "how about this" that is
> still waiting for a follow-up discussion that will result in an eventual
> solution.

Yep. I got comments from JSixt, but I never got around to re-rolling.
Here it is, though still only lightly tested by me (happily, I have not
had to touch CVS for a few years).

-- >8 --
Subject: [PATCH] cvsimport: fix relative argument filenames

One of the first things that cvsimport does is chdir to the
newly created git repo. This means that any filenames given
to us on the command line will be looked up relative to the
git repo directory. This is probably not what the user
expects, so let's remember and prepend the original
directory for relative filenames.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-cvsimport.perl |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1ad20ac..a7d215c 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -579,10 +579,21 @@ sub get_headref ($) {
 	return $r;
 }
 
+my $user_filename_prepend = '';
+sub munge_user_filename {
+	my $name = shift;
+	return File::Spec->file_name_is_absolute($name) ?
+		$name :
+		$user_filename_prepend . $name;
+}
+
 -d $git_tree
 	or mkdir($git_tree,0777)
 	or die "Could not create $git_tree: $!";
-chdir($git_tree);
+if ($git_tree ne '.') {
+	$user_filename_prepend = getwd() . '/';
+	chdir($git_tree);
+}
 
 my $last_branch = "";
 my $orig_branch = "";
@@ -644,7 +655,7 @@ unless (-d $git_dir) {
 -f "$git_dir/cvs-authors" and
   read_author_info("$git_dir/cvs-authors");
 if ($opt_A) {
-	read_author_info($opt_A);
+	read_author_info(munge_user_filename($opt_A));
 	write_author_info("$git_dir/cvs-authors");
 }
 
@@ -679,7 +690,7 @@ unless ($opt_P) {
 	$? == 0 or die "git-cvsimport: fatal: cvsps reported error\n";
 	close $cvspsfh;
 } else {
-	$cvspsfile = $opt_P;
+	$cvspsfile = munge_user_filename($opt_P);
 }
 
 open(CVS, "<$cvspsfile") or die $!;
-- 
1.6.5.1.121.g1a4d5
