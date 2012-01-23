From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: make install rewrites source files
Date: Mon, 23 Jan 2012 15:18:18 +0100 (CET)
Message-ID: <hbf.20120123bz2f@bombur.uio.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 15:18:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpKj2-0003NJ-ND
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 15:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab2AWOSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 09:18:20 -0500
Received: from mail-out1.uio.no ([129.240.10.57]:34735 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442Ab2AWOSU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 09:18:20 -0500
Received: from mail-mx4.uio.no ([129.240.10.45])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RpKiw-00080O-WF
	for git@vger.kernel.org; Mon, 23 Jan 2012 15:18:19 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx4.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RpKiw-0006Zk-K3
	for git@vger.kernel.org; Mon, 23 Jan 2012 15:18:18 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id 190AE12B5; Mon, 23 Jan 2012 15:18:18 +0100 (CET)
X-UiO-Ratelimit-Test: rcpts/h 1 msgs/h 1 sum rcpts/h 2 sum msgs/h 1 total rcpts 2101 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 5675E3C92E565F21719B371B4FDC095C8082E85F
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 924 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188992>

INSTALL says we can install a profiled Git with
	$ make profile-all
	# make install prefix=...
This does not work: 'make install' notices that the build flags has
changed and rebuilds Git - presumably without using the profile info.
The patch below fixes this.

However, make install should not write to the source directory in any
case.  That fails as root if root lacks write access there, due to NFS
mounts that map root to nobody etc.  At least git-instaweb and
GIT-BUILD-OPTIONS are rewritten.  You can simulate this with
    su nobody -s /bin/bash -c 'make -k install'
after configuring with prefix=<directory owned by nobody>.


Index: INSTALL
--- INSTALL~
+++ INSTALL
@@ -29,6 +29,6 @@ If you're willing to trade off (much) lo
 faster git you can also do a profile feedback build with
 
-	$ make profile-all
-	# make prefix=... install
+	$ make profile-all     prefix=...
+	# make profile-install prefix=...
 
 This will run the complete test suite as training workload and then
Index: Makefile
--- Makefile~	2012-01-19 01:36:02.000000000 +0100
+++ Makefile	2012-01-23 14:44:56.554980323 +0100
@@ -2695,5 +2695,5 @@ cover_db_html: cover_db
 ### profile feedback build
 #
-.PHONY: profile-all profile-clean
+.PHONY: profile-all profile-clean profile-install
 
 PROFILE_GEN_CFLAGS := $(CFLAGS) -fprofile-generate -DNO_NORETURN=1
@@ -2708,2 +2708,5 @@ profile-all: profile-clean
 	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" -j1 test
 	$(MAKE) CFLAGS="$(PROFILE_USE_CFLAGS)" all
+
+profile-install:
+	$(MAKE) CFLAGS="$(PROFILE_USE_CFLAGS)" install
