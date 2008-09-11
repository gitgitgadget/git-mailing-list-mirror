From: dhruva <dhruva@ymail.com>
Subject: Re: PATCH: git-p4 optional handling of RCS keywords
Date: Thu, 11 Sep 2008 14:48:52 +0530 (IST)
Message-ID: <680862.54393.qm@web95006.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Simon Hausmann <simon@lst.de>, Tor Arvid Lund <torarvid@gmail.com>,
	GIT SCM <git@vger.kernel.org>,
	Jing Xue <jingxue@digizenstudio.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 11:20:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdiLL-0000Kc-Lq
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 11:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYIKJS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 05:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbYIKJS4
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 05:18:56 -0400
Received: from n2a.bullet.in.yahoo.com ([202.43.219.19]:30255 "HELO
	n2a.bullet.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751720AbYIKJSz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 05:18:55 -0400
Received: from [202.86.4.170] by n2.bullet.in.yahoo.com with NNFMP; 11 Sep 2008 09:18:52 -0000
Received: from [203.104.18.50] by t1.bullet.in.yahoo.com with NNFMP; 11 Sep 2008 09:18:52 -0000
Received: from [127.0.0.1] by omp111.mail.in2.yahoo.com with NNFMP; 11 Sep 2008 09:18:52 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 770909.40307.bm@omp111.mail.in2.yahoo.com
Received: (qmail 54683 invoked by uid 60001); 11 Sep 2008 09:18:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=r1keGrZq4B0I+0OgJxsvbmteol1yz/pQB7shYbdTbJnvhBeCHCH4jlcJ7pAOAe3+sUF74F57AVBBP7LdAVODiQKX8FUGcfY0bT+9UYDhJyA03Tr7+WRniB370WP8YrlLgFgyLm0ZOXdlFu8F7nUL2tFaNefNn6C6Lm10aCkHTqY=;
X-YMail-OSG: KtEGyeEVM1n5FDXfcqDqiWrpwbpL_LCuULE6pfv1GML4r8r_e4ghBnpj4h9p.ygMT47FJeCfSGEo0PosWQXYbiHUfD_ZMcux5RJq5AAON5GcOpX_INy7GeDdO3t9G98-
Received: from [202.3.112.9] by web95006.mail.in2.yahoo.com via HTTP; Thu, 11 Sep 2008 14:48:52 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95599>

>From aa822b35925b893de049b6cc4d1531dc476ade56 Mon Sep 17 00:00:00 2001
From: Dhruva Krishnamurthy <dhruva@siml6.eng.btc.netapp.in>
Date: Thu, 11 Sep 2008 14:36:32 +0530
Subject: [PATCH] Modifying RCS keywords prevents submitting to p4 from git due to missing hunks. Optional shrinking of RCS keywords in git-p4. New option git-p4.kwstrip set to true or false controls the behavior


Signed-off-by: Dhruva Krishnamurthy <dhruva@ymail.com>
---
 contrib/fast-import/git-p4 |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2216cac..ac8b7f7 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -16,6 +16,9 @@ from sets import Set;

 verbose = False

+# Handling of RCS keyowrds. To ensure backward compatibility, the default
+# is to strip keywords. Default behavior is controlled here
+kwstrip = True

 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
@@ -975,7 +978,9 @@ class P4Sync(Command):
                 sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
                 continue

-            if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
+            if not kwstrip:
+               pass
+            elif stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
                 text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
             elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
                 text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', text)
@@ -1850,6 +1855,16 @@ def main():
         (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
     global verbose
     verbose = cmd.verbose
+
+    global kwstrip
+    kwval = gitConfig("git-p4.kwstrip")
+    if len(kwval) > 0:
+       kwval = kwval.lower();
+        if kwval == "false":
+            kwstrip = False
+        elif kwval == "true":
+            kwstrip = True
+
     if cmd.needsGit:
         if cmd.gitdir == None:
             cmd.gitdir = os.path.abspath(".git")
--
1.6.0.1.442.g17b2f

-dhruva



      Get an email ID as yourname@ymail.com or yourname@rocketmail.com. Click here http://in.promos.yahoo.com/address
