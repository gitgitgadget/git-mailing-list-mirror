From: Jerzy Kozera <jerzy.kozera@gmail.com>
Subject: Re: [PATCH] git-p4: Fixed handling of file names with spaces
Date: Fri, 14 Jan 2011 22:45:45 +0000
Message-ID: <A0F152FE-C659-4F9B-9625-505AA5DAF942@gmail.com>
References: <AANLkTi=Cp=FCuJdthr7JfML6jdNzUiDAUPjrWpTQfWGk@mail.gmail.com> <1294944715-5647-1-git-send-email-jerzy.kozera@gmail.com> <m28vyncffu.fsf@igel.home>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, gitster@pobox.com, msclrhd@googlemail.com
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jan 14 23:46:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdsPK-000540-0n
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 23:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab1ANWqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 17:46:03 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54543 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab1ANWqB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 17:46:01 -0500
Received: by ewy5 with SMTP id 5so1828733ewy.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 14:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-mailer;
        bh=kmTe+jbuiiUnPKaez/44QUAfd/WEq90Q84TjMvJktLA=;
        b=n13bgKsthHVxFxN4Z4EcXRc1w3XNv/GD1+rMBVaSROUHlO5a/QARCUECyWOA2XhInI
         EofaDBPiyXYs8I3ALgpV7OUf/iRpOrflRHEm6txfGSFl6RzRLf+0x7nv5M+mr1Dz/tHU
         ji5nvwY1s0k0BuGAKbX553mscz5UWyc5spJ+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=aJuqnPOoiEQ14omTg58ZdzB+wVxJoAuz7d/UMBJdQ/VYUiGGgB4wrnl/psVt/kP4S5
         BQozsun3njLUYw6Cv04IzIJ0aY9bzAgEMoqsbX9ZszVKTsbb7XZMih73zBqDxAKWhF1x
         5JqWGizQ0WUO3nngvEv0KIaLzwQQhOiB3WRnk=
Received: by 10.216.173.7 with SMTP id u7mr48792wel.50.1295045148892;
        Fri, 14 Jan 2011 14:45:48 -0800 (PST)
Received: from jk.home (host81-151-227-102.range81-151.btcentralplus.com [81.151.227.102])
        by mx.google.com with ESMTPS id p4sm954751wer.29.2011.01.14.14.45.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 14:45:47 -0800 (PST)
In-Reply-To: <m28vyncffu.fsf@igel.home>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165128>

On 14 Jan 2011, at 22:01, Andreas Schwab wrote:
> Can those file names also include a double quote or a backquote or a
> dollar sign?


Double quote and backquote get escaped by git so they are not a problem:
$ git diff-tree -r HEAD^ HEAD
:000000 100644 0000000000000000000000000000000000000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 A	"\" \\ $"

But as you can see above, the dollar sign remains intact, so it needs to be handled as well - patch below takes it into account.

Thanks,
Jerzy

---
 contrib/fast-import/git-p4 |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..d930908 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -47,7 +47,7 @@ def p4_build_cmd(cmd):
     real_cmd += "%s" % (cmd)
     if verbose:
         print real_cmd
-    return real_cmd
+    return real_cmd.replace('$', '\\$')
 
 def chdir(dir):
     if os.name == 'nt':
@@ -139,12 +139,12 @@ def setP4ExecBit(file, mode):
         if p4Type[-1] == "+":
             p4Type = p4Type[0:-1]
 
-    p4_system("reopen -t %s %s" % (p4Type, file))
+    p4_system("reopen -t %s \"%s\"" % (p4Type, file))
 
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
-    result = p4_read_pipe("opened %s" % file)
+    result = p4_read_pipe("opened \"%s\"" % file)
     match = re.match(".*\((.+)\)\r?$", result)
     if match:
         return match.group(1)
@@ -666,7 +666,7 @@ class P4Submit(Command):
                 for f in editedFiles:
                     p4_system("revert \"%s\"" % f);
                 for f in filesToAdd:
-                    system("rm %s" %f)
+                    system("rm \"%s\"" % f.replace('$', '\\$'))
                 return
             elif response == "a":
                 os.system(applyPatchCmd)
-- 
1.7.1
