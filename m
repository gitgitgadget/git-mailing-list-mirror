From: Dave Boutcher <daveboutcher@gmail.com>
Subject: [PATCH 2/3] git-multimail: Add a quiet option to prevent outputting email addresses from hook
Date: Wed, 22 Apr 2015 07:04:46 +0800
Message-ID: <1429657487-10809-2-git-send-email-daveboutcher@gmail.com>
References: <1429657487-10809-1-git-send-email-daveboutcher@gmail.com>
Cc: mhagger@alum.mit.edu, Dave Boutcher <daveboutcher@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 01:05:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkhEK-0008Ik-V0
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 01:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbbDUXFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 19:05:19 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32780 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbbDUXFS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 19:05:18 -0400
Received: by paboj16 with SMTP id oj16so254665490pab.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EoBojY5EkPl0QoZrop7f4YoHKFAT3fCjR1XkybqgC9M=;
        b=cUyFB6G2JE7ozA9jLNab37C7x2qELXubRH4ydsFz6h4x0Knnjea3V7uS8VRL6Xt7YK
         PrHRqN9jgcq/rJQjyp7bdZVwwst/B9/AWsQRECwBUmm55Pey38wISl+BzsOPlBwMTQH9
         2NjbC95WznId5xVZk5gDHpH1C6tjR9r+u5ACIkXRw5exBApjDiObgvXY6ELqK88j/SjG
         YEkTXXz8SF46EUHT47t09vpbaExWzWouKiPSqHgm1KMphCA1S3gMboHUyU0ASJBqj7Xt
         vZ/ShlvY5eoT8gG0hoDbdA/iB9wHlrjbSRRRFv0IygE9FiUsjzgttUnhlgZL7mumUg0J
         675g==
X-Received: by 10.70.118.194 with SMTP id ko2mr41977606pdb.162.1429657518098;
        Tue, 21 Apr 2015 16:05:18 -0700 (PDT)
Received: from smtp.gmail.com ([23.27.206.118])
        by mx.google.com with ESMTPSA id g10sm3081736pdm.29.2015.04.21.16.05.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 Apr 2015 16:05:16 -0700 (PDT)
Received: by smtp.gmail.com (Postfix, from userid 501)
	id BC8A747FA068; Wed, 22 Apr 2015 07:05:12 +0800 (CST)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1429657487-10809-1-git-send-email-daveboutcher@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267568>

We have a very log list of recipients...displaying that list
on every push is annoying

Add an option to prevent printing the list of email addresses from
the hook

Signed-off-by: Dave Boutcher <daveboutcher@gmail.com>
---
 git-multimail/README           |  3 +++
 git-multimail/git_multimail.py | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-multimail/README b/git-multimail/README
index a40847a..49e0937 100644
--- a/git-multimail/README
+++ b/git-multimail/README
@@ -396,6 +396,9 @@ multimailhook.replyToRefchange
     - The value "none", in which case the Reply-To: field will be
       omitted.
 
+multimailhook.quiet
+
+    Do not output the list of email recipients from the hook
 
 Email filtering aids
 --------------------
diff --git a/git-multimail/git_multimail.py b/git-multimail/git_multimail.py
index 5ed253f..095110a 100755
--- a/git-multimail/git_multimail.py
+++ b/git-multimail/git_multimail.py
@@ -1582,6 +1582,9 @@ class Environment(object):
             commit mail.  The value should be a list of strings
             representing words to be passed to the command.
 
+        quiet (bool)
+            On success do not write to stderr
+
     """
 
     REPO_NAME_RE = re.compile(r'^(?P<name>.+?)(?:\.git)$')
@@ -1594,6 +1597,7 @@ class Environment(object):
         self.logopts = []
         self.refchange_showlog = False
         self.commitlogopts = ['-C', '--stat', '-p', '--cc']
+        self.quiet = False
 
         self.COMPUTED_KEYS = [
             'administrator',
@@ -1745,6 +1749,10 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
             'refchangeshowlog', default=self.refchange_showlog
             )
 
+        self.quiet = config.get_bool(
+            'quiet', default=False
+            )
+
         maxcommitemails = config.get('maxcommitemails')
         if maxcommitemails is not None:
             try:
@@ -2376,7 +2384,8 @@ class Push(object):
                     % (change.refname, change.old.sha1, change.new.sha1,)
                     )
             else:
-                sys.stderr.write('Sending notification emails to: %s\n' % (change.recipients,))
+                if not self.environment.quiet:
+                    sys.stderr.write('Sending notification emails to: %s\n' % (change.recipients,))
                 extra_values = {'send_date': send_date.next()}
                 mailer.send(
                     change.generate_email(self, body_filter, extra_values),
-- 
2.3.0
