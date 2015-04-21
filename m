From: Dave Boutcher <daveboutcher@gmail.com>
Subject: [PATCH 3/3] git-multimail: Add stdout option to config
Date: Wed, 22 Apr 2015 07:04:47 +0800
Message-ID: <1429657487-10809-3-git-send-email-daveboutcher@gmail.com>
References: <1429657487-10809-1-git-send-email-daveboutcher@gmail.com>
Cc: mhagger@alum.mit.edu, Dave Boutcher <daveboutcher@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 01:05:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkhEP-0008MN-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 01:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbbDUXFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 19:05:25 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36246 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbbDUXFX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 19:05:23 -0400
Received: by pdea3 with SMTP id a3so255696923pde.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5gNZkZ3btt+7OAjZfkCi5+CbkeNqW4MsLjzeivf6Lmo=;
        b=I1H2Hny9XopIdgp94opKc00klQCMyway2T/TBM3be0gmfS6Iv9BFWP6OgZjIJpKOKm
         8iniL+Ufk7k6QFjMFHedNUiKQ5pb7+tJcZdSPFPs9d3hbWbkZoOanDDMebIT5GHkyODU
         p+1PXSgW4qaJ9cnXPxJxNDPlD9efyf34vzeknq90ts8XgNHul6P078UaW4qQ8+GdZrpc
         UQEfdHnYn385g+HNyziHwivrxOO+VTE9C3Y+zR7FckgYmKCO4x+S5/50QbsfZfrWj5qx
         NfnIX2NUoTybFTjca6ZTunImUSa3hhktAdhlPFBec41hLSuq06idN1Qu7SNbNJ0wG1RM
         +r3Q==
X-Received: by 10.68.227.195 with SMTP id sc3mr41721729pbc.64.1429657523398;
        Tue, 21 Apr 2015 16:05:23 -0700 (PDT)
Received: from smtp.gmail.com ([23.27.206.118])
        by mx.google.com with ESMTPSA id gl2sm3026146pbc.52.2015.04.21.16.05.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 Apr 2015 16:05:22 -0700 (PDT)
Received: by smtp.gmail.com (Postfix, from userid 501)
	id AD7D947FA06A; Wed, 22 Apr 2015 07:05:17 +0800 (CST)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1429657487-10809-1-git-send-email-daveboutcher@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267569>

Add a stdout option to the config that is equivalent to the --stdout
command line option. This allows for easier debugging for a hook

Signed-off-by: Dave Boutcher <daveboutcher@gmail.com>
---
 git-multimail/README           |  5 +++++
 git-multimail/git_multimail.py | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/git-multimail/README b/git-multimail/README
index 49e0937..0235b83 100644
--- a/git-multimail/README
+++ b/git-multimail/README
@@ -400,6 +400,11 @@ multimailhook.quiet
 
     Do not output the list of email recipients from the hook
 
+multimailhook.stdout
+
+    For debugging, send emails to stdout rather than to the
+    mailer.  Equivalent to the --stdout command line option
+
 Email filtering aids
 --------------------
 
diff --git a/git-multimail/git_multimail.py b/git-multimail/git_multimail.py
index 095110a..35a1140 100755
--- a/git-multimail/git_multimail.py
+++ b/git-multimail/git_multimail.py
@@ -1585,6 +1585,9 @@ class Environment(object):
         quiet (bool)
             On success do not write to stderr
 
+        stdout (bool)
+            Write email to stdout rather than emailing. Useful for debugging
+
     """
 
     REPO_NAME_RE = re.compile(r'^(?P<name>.+?)(?:\.git)$')
@@ -1598,6 +1601,7 @@ class Environment(object):
         self.refchange_showlog = False
         self.commitlogopts = ['-C', '--stat', '-p', '--cc']
         self.quiet = False
+        self.stdout = False
 
         self.COMPUTED_KEYS = [
             'administrator',
@@ -1753,6 +1757,10 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
             'quiet', default=False
             )
 
+        self.stdout = config.get_bool(
+            'stdout', default=False
+            )
+
         maxcommitemails = config.get('maxcommitemails')
         if maxcommitemails is not None:
             try:
@@ -2563,7 +2571,7 @@ def main(args):
                 sys.stderr.write('    %s : %r\n' % (k, v))
             sys.stderr.write('\n')
 
-        if options.stdout:
+        if options.stdout or environment.stdout:
             mailer = OutputMailer(sys.stdout)
         else:
             mailer = choose_mailer(config, environment)
-- 
2.3.0
