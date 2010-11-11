From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: selectable configurations that change with each
	request
Date: Thu, 11 Nov 2010 22:36:37 +0100
Message-ID: <20101111213456.21127.36449.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Julio Lajara <julio.lajara@alum.rpi.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 22:37:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGepb-0005vD-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 22:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698Ab0KKVhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 16:37:13 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33675 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab0KKVhM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 16:37:12 -0500
Received: by wyb28 with SMTP id 28so1164092wyb.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 13:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=hY/OplWLX6XCtIE4gov9m9YsxnDDTUuuA/xoW07+T5o=;
        b=olPsmQWEUrKpdaLGVSSpCGBKf3cpBQr2XI3HysqiessQrn5ZobtQb4ALElzDWbeP5Z
         +PhyWX1YHshXkVI1mJGhk6g8u4gDoXFZvo2Tf3xCOXqMfusM4S/PVeYprMuZ2Tefh+fC
         FGNReFa7+/F2sa929ewGei5142lrcLlvMa00o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=l3GRoWx0e1e7in3R0VMsg+M5eCWpPrtmNo9O97pysQn2tb1LDFEp7BV2uUjNgBcc2E
         HHbTcjNtwe4aQY1O19vxVq+jv1my9ygpR6af3QRtcF3P8UO9iKbRasYHoPk0xkJxFOr/
         8W/cSUunTSd0iB6watrv0xtkiB8yoJIbwYLZc=
Received: by 10.216.172.194 with SMTP id t44mr2812376wel.86.1289511429059;
        Thu, 11 Nov 2010 13:37:09 -0800 (PST)
Received: from localhost.localdomain (abvw231.neoplus.adsl.tpnet.pl [83.8.220.231])
        by mx.google.com with ESMTPS id e12sm1628695wer.12.2010.11.11.13.37.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 13:37:07 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oABLacsj021177;
	Thu, 11 Nov 2010 22:36:49 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161301>

Allow selecting whether configuration file should be (re)parsed on each
request (the default, for backward compatibility with configurations that
change per session, see commit 7f425db (gitweb: allow configurations that
change with each request, 2010-07-30)), or whether should it be parsed only
once (for performance speedup for persistent environments, though currently
only FastCGI is able to make use of it, when flexibility is not important).
You can also have configuration file parsed only once, but have parts of
configuration (re)evaluated once per each request.

This is done by introducing $per_request_config variable: if set to code
reference, this code would be run once per request, while config file would
be parsed only once.  For example gitolite's contrib/gitweb/gitweb.conf
fragment mentioned in 7f425db could be rewritten as

  our $per_request_config = sub {
  	$ENV{GL_USER} = ($cgi && $cgi->remote_user) || "gitweb";
  };

to make use of this feature.

If $per_request_config is not a code reference, it is taken to be boolean
variable, to choose between running config file for each request
(flexibility), and running config file only once (performance in
persistent environments).

The default value for $per_request_config is 1 (true), which means that
old configuration that require to change per session (like gitolite's)
will keep working.


Because there is a call to evaluate_gitweb_config() in the run() subroutine
(the call in run_config() is not invoked at first request to avoid double
running it), therefore evaluate_git_version() could be moved back there, and
is now evaluated only once.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Commit 7f425db914 says: 

    Probably in the end there should be a way to specify in the
    configuration whether a particular installation wants the speedup or
    the flexibility.  But for now it is easier to just undo the relevant
    change.

This is the way... well, at least a proposal.

 gitweb/README      |    7 +++++++
 gitweb/gitweb.perl |   23 +++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index bf3664f..6646fda 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -246,6 +246,13 @@ not include variables usually directly set during build):
    http://www.andre-simon.de due to assumptions about parameters and output).
    Useful if highlight is not installed on your webserver's PATH.
    [Default: highlight]
+ * $per_request_config
+   If set to code reference, it would be run once per each request.  You can
+   set parts of configuration that change per session, e.g. by setting it to
+     sub { $ENV{GL_USER} = $cgi->remote_user || "gitweb"; }
+   Otherwise it is treated as boolean value: if true gitweb would process
+   config file once per request, if false it would process config file only
+   once.  The default is true.
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7dbaf0c..c3cfefb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -599,6 +599,14 @@ sub filter_snapshot_fmts {
 		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
 }
 
+# If it is set to code reference, it is code that it is to be run once per
+# request, allowing updating configurations that change with each request,
+# while running other code in config file only once.
+#
+# Otherwise, if it is false then gitweb would process config file only once;
+# if it is true then gitweb config would be run for each request.
+our $per_request_config = 1;
+
 our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
 sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
@@ -1068,12 +1076,18 @@ sub reset_timer {
 	our $number_of_git_cmds = 0;
 }
 
+our $first_request = 1;
 sub run_request {
 	reset_timer();
 
 	evaluate_uri();
-	evaluate_gitweb_config();
-	evaluate_git_version();
+	if ($per_request_config) {
+		if (ref($per_request_config) eq 'CODE') {
+			$per_request_config->();
+		} elsif (!$first_request) {
+			evaluate_gitweb_config();
+		}
+	}
 	check_loadavg();
 
 	# $projectroot and $projects_list might be set in gitweb config file
@@ -1126,6 +1140,10 @@ sub evaluate_argv {
 
 sub run {
 	evaluate_argv();
+	evaluate_gitweb_config();
+	evaluate_git_version();
+
+	$first_request = 1;
 
 	$pre_listen_hook->()
 		if $pre_listen_hook;
@@ -1139,6 +1157,7 @@ sub run {
 
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
+		$first_request = 0;
 
 		last REQUEST if ($is_last_request->());
 	}
