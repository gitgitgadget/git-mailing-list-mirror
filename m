From: dhruva <dhruva@ymail.com>
Subject: PATCH: git-p4 optional handling of RCS keywords [was: Re: git-p4 and keyword expansion]
Date: Wed, 10 Sep 2008 10:43:26 +0530 (IST)
Message-ID: <201191.94038.qm@web95010.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: GIT SCM <git@vger.kernel.org>, Jing Xue <jingxue@digizenstudio.com>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Wed Sep 10 07:14:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdI2I-0000Zf-6z
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 07:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbYIJFNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 01:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbYIJFN3
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 01:13:29 -0400
Received: from n1a.bullet.in.yahoo.com ([202.43.219.18]:21883 "HELO
	n1a.bullet.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750859AbYIJFN3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 01:13:29 -0400
Received: from [202.86.4.171] by n1.bullet.in.yahoo.com with NNFMP; 10 Sep 2008 05:13:26 -0000
Received: from [203.104.18.95] by t2.bullet.in.yahoo.com with NNFMP; 10 Sep 2008 05:13:26 -0000
Received: from [127.0.0.1] by omp109.mail.in2.yahoo.com with NNFMP; 10 Sep 2008 05:13:26 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 280453.53004.bm@omp109.mail.in2.yahoo.com
Received: (qmail 94116 invoked by uid 60001); 10 Sep 2008 05:13:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Diibgt8hacN0OrVyP65l2bFY7/f+ZyTazQUJbxzDBy9KIhCxcOSQpbUdGu6DjHTqjfimpBSAIqyVEMtrgbyKykk7VwmXUAzEao70MlTIoAJ51pR5pe1Q6M7x4V33rjDRmbKLOGa28nyOkPdifSZBF84QLEe5Pat9vff9FOMDcwU=;
X-YMail-OSG: eGV5zvoVM1ln.UUhFXRb0r23if.1yKRrENRjVQXcJNvldhXUzyh57GIJaL2c3dt3gxZNlSweYURzGUsCutBuLYbAFbxG4p_r5SSRA5DTl6vqdPHjLudwoOQHibHDfDU-
Received: from [202.3.112.9] by web95010.mail.in2.yahoo.com via HTTP; Wed, 10 Sep 2008 10:43:26 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95480>

Hello,
 I would like to submit my first patch to the git community.

I have introduced a new configuration option to 'git-p4' "kwstrip". If enabled, the RCS keywords gets unexpanded like it is done with out the patch and disabling it explicitly retains the RCS keywords as in the original p4 source. The default (in the absence) is 'false' to ensure backward compatibility. To override, you can put the following lines in your '.gitconfig' file..

[git-p4]
        kwstrip = false



The patch to git-p4 (based on origin/next branch):

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2216cac..ad37d0b 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -16,6 +16,9 @@ from sets import Set;

 verbose = False

+# Handling of RCS keyowrds. To ensure backward compatibility, the default
+# is to strip keywords. Default behavior is controlled here
+kwstrip = True

 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
@@ -975,10 +978,11 @@ class P4Sync(Command):
                 sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
                 continue

-            if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
-                text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
-            elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
-                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', text)
+            if kwstrip:
+                if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
+                    text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
+                elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
+                    text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', text)

             contents[stat['depotFile']] = text

@@ -1850,6 +1854,16 @@ def main():
         (cmd, args) = parser.parse_args(sys..argv[2:], cmd);
     global verbose
     verbose = cmd.verbose
+
+    global kwstrip
+    kwval = gitConfig("git-p4.kwstrip")
+    if len(kwval) > 0:
+       kwval = kwval.lower();
+        if "false" == kwval:
+            kwstrip = False
+        else if "true" == kwval:
+            kwstrip = True
+
     if cmd.needsGit:
         if cmd.gitdir == None:
             cmd.gitdir = os.path.abspath(".git")



----- Original Message ----
> From: Jing Xue <jingxue@digizenstudio.com>
> To: dhruva <dhruva@ymail.com>
> Cc: GIT SCM <git@vger.kernel.org>
> Sent: Tuesday, 9 September, 2008 11:08:48 PM
> Subject: Re: git-p4 and keyword expansion
> 
> On Tue, Sep 09, 2008 at 04:44:11PM +0530, dhruva wrote:
> > Hello,
> 
> Hi,
> 
> > I feel the configuration must be set the first time only, when you
> > clone using 'git-p4 clone'. Altering it in between will be very
> > confusing!
> > Ideally, the setting must be transferred when the git repo
> > (cloned from git-p4) is cloned using standard git. Is it something
> > possible (well, I am new to git and am exploring. Any extra
> > information would help).
> >
> > My proposal is as follows:
> > 1. Add an extra command line argument to 'git-p4 clone' to either  
> > enable/disable keyword expansion
> > 2. Store that information under the .git folder in a file that is  
> > copied when someone clones that repo
> > 3. Use the stored information in future 'git-p4 sync/rebase'
> 
> Any way to make it optional would be welcome by me.

Done


> If you do come up with a "formal" patch, you might want to
> explicitly add Simon Hausmann to the To list, for he's the git-p4
> author.

Done

-dhruva



      Add more friends to your messenger and enjoy! Go to http://in.messenger.yahoo.com/invite/
