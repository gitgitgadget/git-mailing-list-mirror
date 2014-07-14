From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 11/19] refs.c: make remove_empty_directories always set errno to something sane
Date: Mon, 14 Jul 2014 13:58:53 -0700
Message-ID: <1405371541-32121-12-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLk-00037o-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757204AbaGNU7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:42 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:38665 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756876AbaGNU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:06 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so1031662pde.4
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cvp6MKJicaLTyL/o6v+RKx5UkuoG160MlPtedCiUBGA=;
        b=n4y1kGbEXoYdXB6PmmI+YEhg3ARQmBXjY0y/e5XyPkUBdoLU2fZTImSpxCXDZgGms3
         lhc/NItiU3gbpgTJRMPQ0lLAhpXtCGBQEo2UVl/nDyjwh5lN8rWdXdQEyeLwUHB3PLD+
         HmUfN4H9wQBvAARZ+YiRfsN3LxzvRv0JuUTtvIWUtWNq0TrGzUqiJ4rT8jwfEzzctBJN
         pcXdF4PpKpLWvwsFTxaeyz/y+CLX3HRYV1dqBAy9Fy/aE5/pZEgLAAWhQdFcYuTDUl37
         W+JIEjyy+LxVprAGsgRun2m36gpA86jSK3dQQVvaytdN3tfePTLmou9dm2cKZ7EC53P4
         +BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cvp6MKJicaLTyL/o6v+RKx5UkuoG160MlPtedCiUBGA=;
        b=BS/BYhHgp0r3e+pYg2H3qUmJaznB/bzBkLORadVhS6+SkkvpgXLi76mkLA8R5z8eeK
         5JnveZU6DkZ2N/pK5xMJMop2IAUH8qtewdUFmvGxIZp7Mkjivbd6CbtiaKZxArQ8kmI9
         0r08GCcp62rKzt8GdKxDFZ+d++D6xQL7mBz6eRMRqwwlqQZu/ooFEnPPoztVY6U2EIYY
         fVtGjDqolL7F0wWEylmacs00UbZx40l29vJzzGgm1Wfw8sBI36q0cIoxCOOXq4jI3PT2
         ELju8W5tPSLsL9uNmNA6lIn0g84UP0/CpSd0FWKTon6BXNa1q2zQ0fN0/bQq0qgTUCXa
         Li7Q==
X-Gm-Message-State: ALoCoQn7RauzvQFPlEFQrCruUXB/4g4FNHYEzucJjh0UJ+KzsnWkgLr2OnWp7x0X67RFovy1pNZD
X-Received: by 10.70.103.237 with SMTP id fz13mr8922167pdb.4.1405371546047;
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v44si712346yhv.0.2014.07.14.13.59.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D2CE831C391;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8D2A8E08FA; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253527>

Making errno when returning from remove_empty_directories() more
obviously meaningful, which should provide some peace of mind for
people auditing lock_ref_sha1_basic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
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
2.0.1.546.gf603308
