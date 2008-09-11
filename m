From: dhruva <dhruva@ymail.com>
Subject: Re: PATCH: git-p4 optional handling of RCS keywords
Date: Thu, 11 Sep 2008 09:36:34 +0530 (IST)
Message-ID: <880457.35643.qm@web95006.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, GIT SCM <git@vger.kernel.org>,
	Jing Xue <jingxue@digizenstudio.com>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Thu Sep 11 06:08:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KddUF-0006Z9-HV
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 06:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbYIKEGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 00:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbYIKEGi
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 00:06:38 -0400
Received: from n2b.bullet.mail.in2.yahoo.com ([203.104.19.41]:20266 "HELO
	n2b.bullet.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750712AbYIKEGh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 00:06:37 -0400
X-Greylist: delayed 77798 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Sep 2008 00:06:37 EDT
Received: from [202.86.4.170] by n2.bullet.mail.in2.yahoo.com with NNFMP; 11 Sep 2008 04:06:35 -0000
Received: from [203.104.18.48] by t1.bullet.in.yahoo.com with NNFMP; 11 Sep 2008 04:06:35 -0000
Received: from [127.0.0.1] by omp104.mail.in2.yahoo.com with NNFMP; 11 Sep 2008 04:06:35 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 11664.55511.bm@omp104.mail.in2.yahoo.com
Received: (qmail 36087 invoked by uid 60001); 11 Sep 2008 04:06:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=gSthO6oYAJbQcKXjH5Zy0JYvwlsJ7Hd+SHIxlpbfxVr3YUpKjt3an/SmN4ktXzJ0cy4gXOiTVxcwglut+TqtdWvkTibjh9xwV04IG834SmiVz+ZhuciN45Pxq9QC/tCZ5RgWZAp9/ziGDrnTXTw1q/6D3j3Bh0PS62kjimRPN+w=;
X-YMail-OSG: V5YPIPAVM1kJ6klr2Odtb0P17KQxDf0Lfm6qE49hQe9wrru4ciUIePZSJ43G_F4JQeolHAlzMg_oWAnBJ.RRDWIxT1gVPbGo.YOe3g0Kk5oPcjD.9.HJ4c.pCMrvmZw-
Received: from [202.3.112.9] by web95006.mail.in2.yahoo.com via HTTP; Thu, 11 Sep 2008 09:36:34 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95579>

Hello,


Commit message: Modifying RCS keywords prevents submitting to p4 from git due to missing hunks. Optional shrinking of RCS keywords in git-p4. New option git-p4.kwstrip set to true or false controls the behavior..

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
             cmd.gitdir = os..path.abspath(".git")


-dhruva


----- Original Message ----
> From: Simon Hausmann <simon@lst.de>
> > +       kwval = kwval.lower();
> > +        if "false" == kwval:
> > +            kwstrip = False
> > +        elif "true" == kwval:
> > +            kwstrip = True
> 
> I have another style nitpick, sorry :). Please use "kwval == "false" instead 
> of the other way around.

There was a reason for keeping the constant as lvalue to avoid typos like '=' instead from '==' from 'C' school, I realize that python throws an error when such things happen. Must say that programming languages are becoming smarter and taking away the charm of programming...
 
> Otherwise your patch looks good to me, I think it's a very good option to add. 
> Please resend with commit message so that Junio can include it.


      Add more friends to your messenger and enjoy! Go to http://in.messenger.yahoo.com/invite/
