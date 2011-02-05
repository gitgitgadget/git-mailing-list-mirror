From: Rafael Kitover <rkitover@io.com>
Subject: [PATCH] more portable absolute dir check in Git.pm
Date: Sat, 05 Feb 2011 11:19:28 -0500
Organization: CPAN
Message-ID: <4D4D7890.3020906@io.com>
Reply-To: rkitover@io.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000900080302000104090309"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 17:19:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plkre-0002da-91
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 17:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab1BEQTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 11:19:52 -0500
Received: from smtp.prismnet.com ([209.198.128.91]:59570 "EHLO
	smtp.prismnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab1BEQTw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 11:19:52 -0500
Received: from [127.0.0.1] (c-76-98-235-160.hsd1.pa.comcast.net [76.98.235.160])
	(authenticated bits=0)
	by smtp.prismnet.com (8.14.4/8.14.4) with ESMTP id p15GJoJD006070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 5 Feb 2011 10:19:51 -0600 (CST)
	(envelope-from rkitover@io.com)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Spam-Status: No, score=0.0 required=10.0 tests=RDNS_DYNAMIC
	autolearn=disabled version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp.prismnet.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166101>

This is a multi-part message in MIME format.
--------------000900080302000104090309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I was trying to get msysGit to work with activeperl. I'm not sure how 
far I got, I will revisit this problem in the future, but here is a patch.

It removes a problematic make fragment that doesn't work on nmake (and 
probably dmake as well.) As well as a better absolute dir check in Git.pm .

--------------000900080302000104090309
Content-Type: text/plain;
 name="0001-more-portable-absolute-dir-check-in-Git.pm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-more-portable-absolute-dir-check-in-Git.pm.patch"

>From 49f6d63f760d8b0b6988ce8cf4ed175965c3bf4b Mon Sep 17 00:00:00 2001
From: Rafael Kitover <rkitover@cpan.org>
Date: Sat, 5 Feb 2011 11:13:31 -0500
Subject: [PATCH] more portable absolute dir check in Git.pm

---
 perl/Git.pm      |    4 +++-
 perl/Makefile.PL |    7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 6cb0dd1..dee06e1 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -101,6 +101,7 @@ use Error qw(:try);
 use Cwd qw(abs_path);
 use IPC::Open2 qw(open2);
 use Fcntl qw(SEEK_SET SEEK_CUR);
+use File::Spec ();
 }
 
 
@@ -184,7 +185,8 @@ sub repository {
 		};
 
 		if ($dir) {
-			$dir =~ m#^/# or $dir = $opts{Directory} . '/' . $dir;
+                        File::Spec->file_name_is_absolute($dir)
+				or $dir = $opts{Directory} . '/' . $dir;
 			$opts{Repository} = abs_path($dir);
 
 			# If --git-dir went ok, this shouldn't die either.
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 0b9deca..7ceec50 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -1,10 +1,13 @@
 use ExtUtils::MakeMaker;
 
 sub MY::postamble {
-	return <<'MAKE_FRAG';
+	my $make_frag = <<'MAKE_FRAG';
 instlibdir:
 	@echo '$(INSTALLSITELIB)'
 
+MAKE_FRAG
+
+	$make_frag .= <<'MAKE_FRAG' if $^O ne 'MSWin32';
 ifneq (,$(DESTDIR))
 ifeq (0,$(shell expr '$(MM_VERSION)' '>' 6.10))
 $(error ExtUtils::MakeMaker version "$(MM_VERSION)" is older than 6.11 and so \
@@ -14,6 +17,8 @@ endif
 endif
 
 MAKE_FRAG
+
+	return $make_frag;
 }
 
 my %pm = ('Git.pm' => '$(INST_LIBDIR)/Git.pm');
-- 
1.7.3.1


--------------000900080302000104090309--
