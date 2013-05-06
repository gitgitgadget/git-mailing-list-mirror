From: David Foster <davidfstr@gmail.com>
Subject: Bug: git-p4: Sometimes p4 generates Windows-style output on OS X
Date: Mon, 06 May 2013 10:59:36 -0700
Message-ID: <5187EF88.6040707@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070404000402070804080400"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 06 19:59:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZPhR-0001bb-3N
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 19:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab3EFR7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 13:59:40 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:37340 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab3EFR7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 13:59:40 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so2133948pbc.3
        for <git@vger.kernel.org>; Mon, 06 May 2013 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type;
        bh=muOE4lVGz1zXV2s9I2Lh/lCPCKKSyMTgc4hS5K/+aQU=;
        b=PXiQOXAV0K6VK55CTTgoJZxTwXd5VcO0jwqrOjxPj9oKFsLNckLFMbNrD7JqhRxWwV
         QG7+l9sSa564jeJpQEQw+Uji5DerERbIDcaWjIEKczHFDEAh1Rie3MZTmZ6kT1gYsA3d
         0lI6Nkl5xsx+jcn4ub9SP3rM4dkL6dQO79VQTlzoLtpmcTtK9EgwFXULI/haFRhN9VLS
         GQtrK8g4lNu4TiQj3939Ah1268zEjVT2qGU3vfifLbyyta5Bmg7BCvqDyBbp0ZSn1SN+
         WRV+DJvDuURS5id5PH1smQK27eQgAgMYL9QAcn2oVOdp62Zqu61Ji8C2zFw91sxcT34N
         edZA==
X-Received: by 10.66.9.10 with SMTP id v10mr1309681paa.171.1367863179775;
        Mon, 06 May 2013 10:59:39 -0700 (PDT)
Received: from Lain.local ([209.119.210.194])
        by mx.google.com with ESMTPSA id j13sm26645549pat.17.2013.05.06.10.59.37
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 10:59:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223480>

This is a multi-part message in MIME format.
--------------070404000402070804080400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've observed that the p4 command that git-p4 delegates to occasionally 
outputs Windows-style line endings even on the OS X platform. When this 
happens, git-p4 gets very confused and crashes out.

I've attached a patch which seems to fix the issue in my case. Now this 
patch is a pretty bad hack, and I don't recommend that it be accepted 
as-is. It is just a starting point.

A real fix would determine in advance whether Perforce was going to emit 
Windows-style output. Since I don't know the circumstances under which 
this happens on non-Windows platforms, I can't provide a better patch. 
Someone who has intimate knowledge of p4's operating modes would be best 
to examine what's really going on with p4.

P.S. In case it matters, I am not subscribed to this mailing list, so 
you will need to CC me for any replies to reach me.

---
David Foster
http://dafoster.net/

--------------070404000402070804080400
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="0001-Compensate-for-Windows-style-output-from-the-p4-comm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Compensate-for-Windows-style-output-from-the-p4-comm.pa";
 filename*1="tch"

>From aef963f0c45dea81f3e6f30d3b4185a0983ca4de Mon Sep 17 00:00:00 2001
From: David Foster <davidfstr@gmail.com>
Date: Mon, 6 May 2013 10:50:01 -0700
Subject: [PATCH] Compensate for Windows-style output from the p4 command on
 non-Windows systems.

---
 git-p4.py |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 647f110..949d66d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1454,6 +1454,24 @@ class P4Submit(Command, P4UserMap):
             tmpFile = open(fileName, "rb")
             message = tmpFile.read()
             tmpFile.close()
+            
+            # HACK: If Perforce spontaneously generates Windows-style output,
+            #       compensate by assuming the entire p4 command went into
+            #       Windows mode.
+            if separatorLine not in message:
+                print "WARNING: Perforce has spontaneously decided to generate Windows-style output. Compensating."
+                
+                # Assume that Perforce is now inexplicably operating in Windows mode
+                self.isWindows = True
+                
+                # Retroactively rewrite expected output
+                submitTemplate = submitTemplate.replace("\n", "\r\n")
+                separatorLine = separatorLine.replace("\n", "\r\n")
+                newdiff = newdiff.replace("\n", "\r\n")
+                
+                if separatorLine not in message:
+                    raise ValueError('Confused. Thought Perforce went into Windows mode but apparently something else is wrong.')
+            
             submitTemplate = message[:message.index(separatorLine)]
             if self.isWindows:
                 submitTemplate = submitTemplate.replace("\r\n", "\n")
-- 
1.7.7.5 (Apple Git-26)


--------------070404000402070804080400--
