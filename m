From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/2] commit.c: check for lock error and return early
Date: Tue, 15 Apr 2014 16:46:48 -0700
Message-ID: <1397605608-12128-3-git-send-email-sahlberg@google.com>
References: <1397605608-12128-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 01:47:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaD4H-0001Uy-Of
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 01:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbaDOXqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 19:46:55 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:41490 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaDOXqx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 19:46:53 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so2161153iec.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 16:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I/FSdZGafeu0T2HLJ+NiS9Sb9/a1CgwGzi4aSFPu32M=;
        b=MeekLrR7SJ/BsNQ+d81+synoSJplfdmI3eZJ8RUPB4j4Yvmak/cY5eqWBk7UIX01xx
         ZPcAhEGmVsqVqvoV0hlfJyo6O63OIQFXu9F2adk/J21CVaJ1D+aOMtzm7dN3yZR+tbLQ
         9JW0zgNzDGnbt7l1ZvOjZPhGw6W2eSEhsYAyx7DWgdmmtBNg1A0NXaa0hVTVmD9UQLHd
         26ucw0QJ/ttj9XYbei+z50tqKhpI8QqGBY0WZsNH9ckaDTKBhVokRL38cNv0fRKwcj8k
         21fCvWPflglTTDXiSB8AVs+3E/ddip7bm4uCZkaYNHqLZbYFmrR/mpe2oyfXjx44x3md
         DmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I/FSdZGafeu0T2HLJ+NiS9Sb9/a1CgwGzi4aSFPu32M=;
        b=ZXTVsUM/qZtW0yHm2N8/Vecp9xs7L8GxswMIiQrmdAf7qU6k77ZkoVby9hOhOFRvZ4
         qZ4EhKz1nG3sld3HLLksoi7AaW6Tq9U/TT9Kd9zfow6v018Ctjrhd20WtC9hgBxsb5B8
         dAQKVHXxaUuMRfv4r4mCBOvk2PmiCUSOHpttbKCpyjcwGJK5iy+HCH84e53WYTIUq+vQ
         V06v4i8dB6p3PYW6PaQ72natx0rVA91ek2GILpmNNTcnWfivN5Yv+CiNgo8yO6XIIhXz
         YFf92NbfgkJuOitARwO5ikxyfwQCyLYFh3qX+0ASnQw0bDkdzA602CJ8D3iUKi956wlO
         OBaA==
X-Gm-Message-State: ALoCoQkjjtuWegzUxg/dPJvqHMB+hZ1PVKaDhW4ofTM9nubCts3lf9hyip71+tdjWGT7ZvkdfmQysXWrJM8dz2bQjZ1pHmQDcYpkv52CJz3ZAEt2SdDsmzvMERdqlLOSZ7ZUOxFXeTXDMiwjTUFGLZYiJyHhH0q2KSTkNeXgThtNn5It0AHemuJ5LHJXmESIgcoHf2b1UfVk
X-Received: by 10.182.95.68 with SMTP id di4mr2399977obb.4.1397605612913;
        Tue, 15 Apr 2014 16:46:52 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si2914403yhd.5.2014.04.15.16.46.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Apr 2014 16:46:52 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BCFA631C1D6;
	Tue, 15 Apr 2014 16:46:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7EF79E099E; Tue, 15 Apr 2014 16:46:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.503.ge4c3920.dirty
In-Reply-To: <1397605608-12128-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246311>

Move the check for the lock failure to happen immediately after
lock_any_ref_for_update().
Previously the lock and the check-if-lock-failed was separated by a handful
of string manipulation statements.

Moving the check to occur immediately after the failed lock makes the
code slightly easier to read and makes it follow the pattern of
 try-to-take-a-lock()
 if (check-if-lock-failed){
    error
 }

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..c6320f1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1672,6 +1672,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 					   ? NULL
 					   : current_head->object.sha1,
 					   0, NULL);
+	if (!ref_lock) {
+		rollback_index_files();
+		die(_("cannot lock HEAD ref"));
+	}
 
 	nl = strchr(sb.buf, '\n');
 	if (nl)
@@ -1681,10 +1685,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (!ref_lock) {
-		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
-	}
 	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
 		rollback_index_files();
 		die(_("cannot update HEAD ref"));
-- 
1.9.1.503.ge4c3920.dirty
