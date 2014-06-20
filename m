From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 11/48] refs.c: make remove_empty_directories always set errno to something sane
Date: Fri, 20 Jun 2014 07:42:52 -0700
Message-ID: <1403275409-28173-12-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05H-0003jx-7l
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbaFTOqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:23 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:47771 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so505219vcb.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BNOVEXvf/W/g0xBnLdm0n0W6qsXvras52yRS8FCB1kg=;
        b=Dlp1X0MH9fBaSweH7Iuz4ntR38ovMZsZmWFzTJ5eV+a83VfBSAFysxX1XLdYdl2dpt
         ZEsB7uzYFmMcM/Dz8HjfGzxdWS/qBSIlHshIEYVy4IsegbU6ZLRtU6gzWSqp/zW7zEa3
         8dH751bIxnRUuEdcvCz6OVezOQOhQZxm0Opk7AJdSsdqgrKOOoeHLjR6MeGT658kmrLW
         Km0KkHiFUTWpPvhpYX+Fswwjpqxv8Uy5TOqCVz1AlYMV/McFhTj5XwlpkDZ9yr+FT26F
         6Ps76Z7posAxdNex4hqAyFRIHOt3gb/uN71u0qJO4BbfZhjVzRMGSozm7ob1tc1qJL2h
         PaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BNOVEXvf/W/g0xBnLdm0n0W6qsXvras52yRS8FCB1kg=;
        b=IsCB0KA0992CTG8CUTlyg1pqrQXfhzGTpnCLvuioWIUJOqBoWZkj3fEroCJuTbWboQ
         5j8j2DrFH5CSRosZMWCBDCz8YbOLWXNO+p6AaBI7On0hyo+b2D6qGPX5U0yN+gCuAZq3
         fOB9NELBT0RJIYtawCDhKCYfQNSwp16jUteP2RVo+eaGWUelc+L7/RxJsJ94KNmIvBIB
         /aucwreLFRlkp75p8zl3BNwZT7dZJlZDsAXvRzIptSs+0zGikc5YgdqGM1YKCwibqq4a
         ABN14DkxPnUnwqLoUYBxhO9XOBAm6dL3KQDbbyXeNkjRlJB4Er/qqFullNv7WYqw3twX
         i7MA==
X-Gm-Message-State: ALoCoQkS6I1TztVoX6NNx8FuKoxjkRLkN7Zvo0KQ0LBIu6xgqfCJ9bt/kyD6sF0I1o1v3/O10W6P
X-Received: by 10.58.187.44 with SMTP id fp12mr1527207vec.24.1403275412612;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si664702yhb.3.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 772FF5A40F4;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2806FE0651; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252261>

Making errno when returning from remove_empty_directories() more
obviously meaningful, which should provide some peace of mind for
people auditing lock_ref_sha1_basic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index a48f805..cc69581 100644
--- a/refs.c
+++ b/refs.c
@@ -1960,14 +1960,16 @@ static int remove_empty_directories(const char *file)
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
@@ -2056,6 +2058,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
+/* This function should make sure errno is meaningful on error */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
-- 
2.0.0.420.g181e020.dirty
