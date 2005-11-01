From: Ben Lau <benlau@ust.hk>
Subject: git-mv dest ending with slash would deletes file only
Date: Tue, 01 Nov 2005 12:20:01 +0800
Message-ID: <4366ECF1.1010401@ust.hk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030508020604030706040209"
X-From: git-owner@vger.kernel.org Tue Nov 01 05:20:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWnd1-00076W-Ts
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 05:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVKAEUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 23:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVKAEUE
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 23:20:04 -0500
Received: from mx5.ust.hk ([143.89.13.25]:22035 "EHLO mx5.ust.hk")
	by vger.kernel.org with ESMTP id S932563AbVKAEUD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 23:20:03 -0500
Received: from [143.89.135.159] (atz113.rd.ust.hk [143.89.135.159])
	by mx5.ust.hk (8.12.11/8.12.11) with ESMTP id jA14JwNi062638
	for <git@vger.kernel.org>; Tue, 1 Nov 2005 12:19:58 +0800 (HKT)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10925>

This is a multi-part message in MIME format.
--------------030508020604030706040209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

    I just tried to use the git-mv to move several files to another 
directory. As the bash's auto completetion leaves the dest path ending 
with slash, the command become:

$ git-mv entry.c Documentation/
Ignoring path Documentation//entry.c

$ git status
#
# Updated but not checked in:
#   (will commit)
#
#       deleted:  entry.c
#

   Checked from the source, git-update-index do not accept 
multiple-successive-slashes (verify_path()@update-index.c), which should 
be considered as one slash according to POSIX standard.

   However, changes the verify_path() function do not help. It seems 
that git consider file with single slash and multiple slashes as two 
different object. Therefore, I added a line inside git-mv script to 
replace multiple-successive-slashes as one and it works fine in my 
system now.


--------------030508020604030706040209
Content-Type: text/x-patch;
 name="git-mv-remove-multi-slashes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-mv-remove-multi-slashes.patch"

diff --git a/git-mv.perl b/git-mv.perl
index 17e35b0..283d7e1 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -92,6 +92,7 @@ while(scalar @srcArgs > 0) {
     $src = shift @srcArgs;
     $dst = shift @dstArgs;
     $bad = "";
+    $dst =~ s/\/+/\//g;
 
     if ($opt_v) {
 	print "Checking rename of '$src' to '$dst'\n";
diff --git a/update-index.c b/update-index.c

--------------030508020604030706040209--
