From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git-cvsimport: path to cvspsfile
Date: Wed, 23 Sep 2009 15:14:29 -0400
Message-ID: <20090923191428.GA30104@coredump.intra.peff.net>
References: <20090923182756.GA12430@onyx.camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 21:15:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqXIy-0005Rj-Se
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 21:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbZIWTOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 15:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbZIWTOT
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 15:14:19 -0400
Received: from peff.net ([208.65.91.99]:39582 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562AbZIWTOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 15:14:17 -0400
Received: (qmail 32565 invoked by uid 107); 23 Sep 2009 19:17:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 23 Sep 2009 15:17:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Sep 2009 15:14:29 -0400
Content-Disposition: inline
In-Reply-To: <20090923182756.GA12430@onyx.camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128991>

On Wed, Sep 23, 2009 at 08:27:56PM +0200, Kacper Kornet wrote:

> When I use:
> 
> git cvs-import -C <dir> -P <cvspsfile>
> 
> it looks for <cvpsfile> relative to <dir>, not the working directory.
> Is it a bug or a feature?

Bug. The script does a chdir() and then looks at the cvspsfile later. I
think "-A" would have the same problem. Here is a totally untested patch
to address the issue. Johannes, will this is_absolute_path actually work
on Windows? I think The Right Way would be to use
File::Spec::file_name_is_absolute, but I haven't checked whether that is
part of core perl and if so, which version it appeared in.

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1ad20ac..08a30ec 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -579,10 +579,26 @@ sub get_headref ($) {
 	return $r;
 }
 
+sub is_absolute_path {
+	local $_ = shift;
+	return m{^/};
+}
+
+my $user_filename_prepend = '';
+sub munge_user_filename {
+	my $name = shift;
+	return is_absolute_path($name) ?
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
@@ -644,7 +660,7 @@ unless (-d $git_dir) {
 -f "$git_dir/cvs-authors" and
   read_author_info("$git_dir/cvs-authors");
 if ($opt_A) {
-	read_author_info($opt_A);
+	read_author_info(munge_user_filename($opt_A));
 	write_author_info("$git_dir/cvs-authors");
 }
 
@@ -679,7 +695,7 @@ unless ($opt_P) {
 	$? == 0 or die "git-cvsimport: fatal: cvsps reported error\n";
 	close $cvspsfh;
 } else {
-	$cvspsfile = $opt_P;
+	$cvspsfile = munge_user_filename($opt_P);
 }
 
 open(CVS, "<$cvspsfile") or die $!;
