From: dhruva <dhruva@ymail.com>
Subject: git-p4 and keyword expansion
Date: Mon, 8 Sep 2008 09:55:25 +0530 (IST)
Message-ID: <554296.48174.qm@web95003.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: GIT SCM <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 06:33:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcYR8-0004JM-QG
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 06:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbYIHEcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 00:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbYIHEcG
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 00:32:06 -0400
Received: from n1b.bullet.mail.tp2.yahoo.com ([203.188.202.108]:41376 "HELO
	n1b.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750804AbYIHEcG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 Sep 2008 00:32:06 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Sep 2008 00:32:05 EDT
Received: from [203.188.202.70] by n1.bullet.mail.tp2.yahoo.com with NNFMP; 08 Sep 2008 04:25:27 -0000
Received: from [202.43.196.224] by t1.bullet.mail.tp2.yahoo.com with NNFMP; 08 Sep 2008 04:25:26 -0000
Received: from [203.212.168.60] by t1.bullet.tpe.yahoo.com with NNFMP; 08 Sep 2008 04:25:26 -0000
Received: from [203.104.18.54] by t1.bullet.kr1.yahoo.com with NNFMP; 08 Sep 2008 04:25:26 -0000
Received: from [127.0.0.1] by omp106.mail.in2.yahoo.com with NNFMP; 08 Sep 2008 04:25:25 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 636117.92412.bm@omp106.mail.in2.yahoo.com
Received: (qmail 48951 invoked by uid 60001); 8 Sep 2008 04:25:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=mmbA4a6QAyvuHbh67PgMCY+kne680bIFyAjIb1/Hq+GUDg8PPyIqZaMszQ503cfF8kjgwH5mcDTMN87RL4QBTb2v/u5kfUoXN6dsAl2SpmVYXv7blL2pYFw2PbWAxzTUINzcixo8R9fmVkWx389A00/m9NIq7qkkAqdIUZ+XZN4=;
X-YMail-OSG: jwz2bzMVM1n1QXVugrj44ud5RdrTPhlBPsxpT4z2TrsXACvo_pv94re1GTm0996EbctapWD7bguGQjfiPtWhbBCIDkKCxIEDFR9QvDo6ofN8Jxt6RjXVwWupWmzXFNk-
Received: from [202.3.112.9] by web95003.mail.in2.yahoo.com via HTTP; Mon, 08 Sep 2008 09:55:25 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95214>

Hi,
 The git-p4 script unexpands all p4 keywords before feeding it to git fastimport. When there is a new version, it records only the diffs minus the keyword contents at it unexpands and then feeds to fastimport. When trying to submit back to perforce, applying a patch on top of the latest file in p4 with the keyword expanded fails because we have not tracked that difference. Patch applying fails and expects you to manually (out of git) to do a 'p4 submit' and get back and do 'git-p4 submit --continue'.
 Removing the keyword unexpanding code in 'git-p4' with the following patch makes it work:
diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2216cac..35c7914 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -975,10 +975,10 @@ class P4Sync(Command):
                 sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
                 continue

-            if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
-                text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
-            elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'bi
-                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|R
+            #if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
+            #    text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
+            #elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'b
+            #    text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|

             contents[stat['depotFile']] = text

Rationale:
1. The expanded keyword is stored in git repo
2. You edit the file and commit into git (the keyword does not change)
3. When a new version of the same file comes from p4 (through git-p4 sync), it will have a new keyword content. Hence, the keyword change is tracked and 'git-p4 rebase' can apply the patch with not hunk rejections
4. When comitting back to p4 through 'git-p4 submit', the change in keyword contents are tracked and there is a hunk for it. Therefore, the patch applies cleanly and submit goes through..

I am looking for feedback/suggestions on this. I am planning to use git-p4 on production level and am trying to seel to company wide (quite a large group) as an alternative to p4 (still using p4 as final centralized backend to satisfy the management).

with best regards,
dhruva


      Connect with friends all over the world. Get Yahoo! India Messenger at http://in.messenger.yahoo.com/?wm=n/
