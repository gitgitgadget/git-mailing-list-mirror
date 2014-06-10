From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 11/48] refs.c: make remove_empty_directories alwasy set errno to something sane
Date: Tue, 10 Jun 2014 15:28:59 -0700
Message-ID: <1402439376-25839-12-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUaJ-0006ZG-Q6
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbaFJWbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:42 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:59498 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-ve0-f202.google.com with SMTP id oz11so493471veb.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IOkMI2Dv98lnsRLcl4avgUrqndE5y8h0V6R8BuNt/Fc=;
        b=kQF27n+3LEZEqSBq1VEuT3z5pLPMR+BYViJ44vRq6gxUfPl5cDhQV6ws2WToRLvte1
         K4mguzq05iMfP+5QJ+CxNEGiJWt8B2Wk6KxvqF1WpJ/qnaNuZGw+60VlDzJ2Hl1/bZRF
         IS6tFaUb7FirncucdwsXGJgAuaoU0EWzKqAOGoOxDsTREhZezVTU3rd0v1LycwNEgJwz
         n9V+luMCY6eLaMWNdheDXeso67erbLNTwaL7mpB0qsXRlI739nUYTUk2AJdUViT2Qnbm
         ikZexkvYKbOaCu5nKHUYeoklNys2BZszYLIOzGcrpSQkp9Rg42mtfgXG5WiL6Mj4CrDk
         oPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IOkMI2Dv98lnsRLcl4avgUrqndE5y8h0V6R8BuNt/Fc=;
        b=dzuMxjbe1yu2i8l2aUeVprCEYeKcH/lx14wHBFCvEoAx9xtAZnXLm3xTETN9kPL/7H
         ONRfMniAIuIuxAMGoPLFvE80I960SUINAYYVsUwlu2U6pIbkmzD5wejLzHpIWA7xYmFA
         KHn8/EDg/DSgjD2bbIh9bwSYUWxEVJU2fyMw2El8QGxIoAXyiZT3QqQkZOiSeDmNsxpN
         R1W/sp2Pf2L17Jfdo1gZJaLy/KgJXbLPV9BRIbs6g7+6YEC9sZKHFjGWKvjjEYXTO3F5
         Kq6dC651Ev0rm3u4tuIa+GTQKDGnwhFklgT4wXasRQQzOcMxaCovFz0y0C/2TF61LXH1
         GjDQ==
X-Gm-Message-State: ALoCoQlQDGB2UuW4dIu/2uYw1rQjQHvm3kFMgXGvIJGMGtbGGLMfGnenR1T9GGnD3lGuZzQ4EO4X
X-Received: by 10.58.247.202 with SMTP id yg10mr111270vec.1.1402439380468;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1395558yhj.5.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 525FA31C746;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F2BC6E12D0; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251301>

Making errno when returning from remove_empty_directories() more
obviously meaningful, which should provide some peace of mind for
people auditing lock_ref_sha1_basic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3631a3b..dd28214 100644
--- a/refs.c
+++ b/refs.c
@@ -1932,14 +1932,16 @@ static int remove_empty_directories(const char *file)
 	 * only empty directories), remove them.
 	 */
 	struct strbuf path;
-	int result;
+	int result, save_errno;
 
 	strbuf_init(&path, 20);
 	strbuf_addstr(&path, file);
 
 	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
+	save_errno = errno;
 
 	strbuf_release(&path);
+	errno = save_errno;
 
 	return result;
 }
@@ -2028,6 +2030,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
+/* This function should make sure errno is meaningful on error */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
-- 
2.0.0.574.g30c2c5e
