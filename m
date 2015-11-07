From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 2/3] git-p4: add option to system() to return subshell status
Date: Sat,  7 Nov 2015 01:07:52 +0000
Message-ID: <1446858473-19911-3-git-send-email-luke@diamand.org>
References: <1446858473-19911-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, sunshine@sunshineco.com,
	larsxschneider@gmail.com, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 02:08:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zurzi-00076V-UN
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 02:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbbKGBI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 20:08:29 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32785 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbbKGBIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 20:08:07 -0500
Received: by pabfh17 with SMTP id fh17so138367532pab.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 17:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LWr6ucbjUM087peoYuQBDeLZWOP2oCp+bnRQmos2Ecw=;
        b=ek9OX3xo92gowXHA5dyW/pkJg7UDxVxGM/Pr2GpjRhqsMtOEsjvD7gsp6vUxvHa4Ya
         ALMt2dlpgIeeAKVXMbm9GZhMtogbZbHZp/HkAiWsaVj4scbquzVZTCoogYN16t0eIu3v
         M//8ve67uFFS+zyuCT4nMpkzqKSxgjUKwHpOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LWr6ucbjUM087peoYuQBDeLZWOP2oCp+bnRQmos2Ecw=;
        b=KFgkgWdg+0gdwkVDfIdNa+BiNGcmYBr7lZ88B8/1x0nt14raT8zSou19DygmbCSRx8
         2yTotun6J9t1apwJM/NZUJHBnPdyoIm9VujsoHasfxT90VVedqMFPQqWnobIqTNpFjNE
         s3+F2HRG+Nvuhc7/aMXjOu2BmQsPz3BeOyHMEY9Ah9Z+wBMjEPFSujsDdKal2MH1oS6J
         CLEtdvTTNIdsaGovzPIuLaXuYFCCKK+D25lhF4Tani9LWGccm5xEbYtkwP+ji69JYjL9
         dAmZI967YC1FzQh2f8hIzUQGv0ASRw/x7j2WfvA1A6kQXZB0wTtStvKi+zjo6xZkXTKs
         zI7g==
X-Gm-Message-State: ALoCoQlyMvvhByGuKmGL8bqXC/vROP1BpGYLxD7qey/ixAmFcgy7R5RvcbD/pxWtwzg5N/Q41jeu
X-Received: by 10.66.248.8 with SMTP id yi8mr21635168pac.62.1446858487020;
        Fri, 06 Nov 2015 17:08:07 -0800 (PST)
Received: from lgd-kipper.local ([216.38.147.4])
        by smtp.gmail.com with ESMTPSA id t13sm2239577pbs.88.2015.11.06.17.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2015 17:08:06 -0800 (PST)
X-Mailer: git-send-email 2.6.0.rc3.238.gc07a1e8
In-Reply-To: <1446858473-19911-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281011>

Add an optional parameter ignore_error to the git-p4 system()
function. If used, it will return the subshell exit status
rather than throwing an exception.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0093fa3..9d55f9c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -192,14 +192,16 @@ def p4_has_move_command():
     # assume it failed because @... was invalid changelist
     return True
 
-def system(cmd):
+def system(cmd, ignore_error=False):
     expand = isinstance(cmd,basestring)
     if verbose:
         sys.stderr.write("executing %s\n" % str(cmd))
     retcode = subprocess.call(cmd, shell=expand)
-    if retcode:
+    if retcode and not ignore_error:
         raise CalledProcessError(retcode, cmd)
 
+    return retcode
+
 def p4_system(cmd):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
-- 
2.6.0.rc3.238.gc07a1e8
