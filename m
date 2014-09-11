From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/19] lockfile: remove unable_to_lock_error
Date: Wed, 10 Sep 2014 20:12:11 -0700
Message-ID: <20140911031211.GV18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:12:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRuoI-00048v-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbaIKDMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:12:34 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35945 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbaIKDMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:12:14 -0400
Received: by mail-pd0-f178.google.com with SMTP id p10so9519487pdj.37
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ypWogw4YXWYx1ORwTkqJXZkQ7faEkKcCSag/H6fdJX0=;
        b=i6xsKWX4XTrw24vvRmnMCd2LYS8BS7svqk08ZMvkwRlsPNuIYCFDqMee9sWcAesKHY
         6tbA6MMcuxhUOQvYT5FjyGvFP1qCC7w1QNxMlUo1yCbKvt08EyHx/WTxiWy/waqvt+ct
         1ueWU4Pr/9sjFo1hTgJphOvDijiREjzCQFhlqRMXQ9oZZJBpThQI9QOvYT8btYnmS7ck
         /Y/q+qFj26limJ19WI1qoY89B7ysjOuUkqsY/YYHLImYosE+QpXCVs+mhQ5uwZwYEZvl
         AcaZqWD23H08HRA8dfoFWRQW46+GthURBTG5CgCdRtzpjgkstIYhgDzwc/wgHIx5G9/a
         ltGA==
X-Received: by 10.68.95.129 with SMTP id dk1mr26160943pbb.25.1410405133865;
        Wed, 10 Sep 2014 20:12:13 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id wh10sm16688959pac.20.2014.09.10.20.12.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:12:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256829>

The former caller uses unable_to_lock_message now.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 cache.h    |  1 -
 lockfile.c | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/cache.h b/cache.h
index 03a6144..995729f 100644
--- a/cache.h
+++ b/cache.h
@@ -558,7 +558,6 @@ struct lock_file {
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
-extern int unable_to_lock_error(const char *path, int err);
 extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
 extern NORETURN void unable_to_lock_index_die(const char *path, int err);
diff --git a/lockfile.c b/lockfile.c
index a921d77..dbd4101 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -176,16 +176,6 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 			    absolute_path(path), strerror(err));
 }
 
-int unable_to_lock_error(const char *path, int err)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	unable_to_lock_message(path, err, &buf);
-	error("%s", buf.buf);
-	strbuf_release(&buf);
-	return -1;
-}
-
 NORETURN void unable_to_lock_index_die(const char *path, int err)
 {
 	struct strbuf buf = STRBUF_INIT;
-- 
2.1.0.rc2.206.gedb03e5
