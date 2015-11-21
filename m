From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 2/3] git-p4: add option to system() to return subshell status
Date: Sat, 21 Nov 2015 09:54:40 +0000
Message-ID: <1448099681-20183-3-git-send-email-luke@diamand.org>
References: <1448099681-20183-1-git-send-email-luke@diamand.org>
Cc: larsxschneider@gmail.com, Junio C Hamano <gitster@pobox.com>,
	peff@peff.net, sunshine@sunshineco.com,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 10:55:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a04t3-0008Bh-EK
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 10:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759790AbbKUJzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2015 04:55:06 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35486 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbbKUJzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2015 04:55:00 -0500
Received: by pacej9 with SMTP id ej9so141161121pac.2
        for <git@vger.kernel.org>; Sat, 21 Nov 2015 01:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LWr6ucbjUM087peoYuQBDeLZWOP2oCp+bnRQmos2Ecw=;
        b=eA4PV5ml+4l4WgMj8ji4gOWEajVbSeQWGpknTZ+fswiezENPYA0uK/QzHb/6Wpa18m
         Y8wUVUEV1Zgb5z/DdwcO7E2aSwK7ut9TkDb8pixjDlpmr6l/QetdIn/8GN3sJ1YiFEWK
         iga+deLTjGk4+omr4zmTbbaCqPVv9YdINOBKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LWr6ucbjUM087peoYuQBDeLZWOP2oCp+bnRQmos2Ecw=;
        b=B/93DM50YpDh4g1H78HyA9CizYxXpSmGsN0czmgGKgyFPuRvp+Pb4E45Z6/4KLvckW
         SO6Hd5sw1bPqVvO5dFKbXoK8mdNn2wC3e0Q+K3VrHWPftTHK7WW0p02+eg/6/N2JOR1N
         vASBfZMOdjKGrf37obylVJQ1p2oy6D9rkglK4jI4wIh1qMEpFMuS7zJbfDEdh2ugjPvZ
         OVaBK/HnUesKqFjwiyQ4cOV/5Uik64U4vLZacgrhlcwp745AlfPRBEQGofz+bt3y5pMy
         NziQ6RdnvUrMH4cT8+5+AuSOugDuKYjwNjTqOS8+YwjLYX7P/pc4eWDjrNu0F8CEm1On
         8b4Q==
X-Gm-Message-State: ALoCoQkgpx7h1GvJdhGvWZek+Ve0RaigC/W30SEvV0o+YyFSQCiqyP1pMmR2UB/71wM6fra7KWak
X-Received: by 10.66.124.165 with SMTP id mj5mr24250631pab.97.1448099700025;
        Sat, 21 Nov 2015 01:55:00 -0800 (PST)
Received: from lgd-kipper.corp.roku ([216.38.147.4])
        by smtp.gmail.com with ESMTPSA id xi8sm2949984pab.9.2015.11.21.01.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2015 01:54:59 -0800 (PST)
X-Mailer: git-send-email 2.6.3.492.g06488d6
In-Reply-To: <1448099681-20183-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281550>

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
