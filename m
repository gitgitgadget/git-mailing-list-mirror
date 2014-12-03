From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/14] lockfile: make 'unable_to_lock_message' private
Date: Tue, 2 Dec 2014 21:27:34 -0800
Message-ID: <20141203052734.GX6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:27:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2TV-0002AV-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbaLCF1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:27:38 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:48053 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbaLCF1h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:27:37 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so12516276iec.8
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wxaaHWmMfYHJRJHsR04E5wGAm3OUAy4dtxrMSrY1bYE=;
        b=fplRCwIUuUGO0B8VLzDrSUjUsZ6IOzXBvpk0AbgT5sR08bgWrKJNhrruHYpmjUTNx0
         cH2kjvgsyw3jX0uV9ZLjv32WO/PGhTYgtQMTJCGl8DZVRjv1a6WIkjBq/JO/bxgcEAXi
         55vK0UDjD7/ua6Ms/J6yhn9ZTQF5Hc8HZed2PMxYzjMkTPO7/j5IKjRxTWWTns82k9Vu
         JmbdVueTVKJkx0duspSS/1xUyLXv6rAfNzAxYTDVYx2uDrirC12JrqlHaaaoyFvpNoUK
         cXutuQixH0IKPQcS0ZnZvMAnryaYiUHyz8Tpx7f/edox4QY+vrRJ30FYnRzZI8mStlm4
         7P/Q==
X-Received: by 10.43.119.131 with SMTP id fu3mr5725803icc.56.1417584456969;
        Tue, 02 Dec 2014 21:27:36 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id 126sm1093279ion.12.2014.12.02.21.27.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:27:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260638>

The old external callers now use the message passed back by
hold_lock_file_for_update / hold_lock_file_for_append instead of
trying to interpret errno.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.

Thoughts?

 lockfile.c | 42 +++++++++++++++++++++---------------------
 lockfile.h |  2 --
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 8d8d5ed..7121370 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -98,6 +98,27 @@ static void resolve_symlink(struct strbuf *path)
 	strbuf_reset(&link);
 }
 
+static void unable_to_lock_message(const char *path, int flags, int err,
+			    struct strbuf *buf)
+{
+	if (err != EEXIST) {
+		strbuf_addf(buf, "Unable to create '%s.lock': %s",
+			    absolute_path(path), strerror(err));
+	} else if (flags & LOCK_OUTSIDE_REPOSITORY) {
+		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
+		    "If no other git process is currently running, this probably means\n"
+		    "another git process crashed earlier. Make sure no other git process\n"
+		    "is running and remove the file manually to continue.",
+			    absolute_path(path), strerror(err));
+	} else {
+		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
+		    "If no other git process is currently running, this probably means a\n"
+		    "git process crashed in this repository earlier. Make sure no other git\n"
+		    "process is running and remove the file manually to continue.",
+			    absolute_path(path), strerror(err));
+	}
+}
+
 static int lock_file(struct lock_file *lk, const char *path,
 		     int flags, struct strbuf *err)
 {
@@ -149,27 +170,6 @@ static int lock_file(struct lock_file *lk, const char *path,
 	return lk->fd;
 }
 
-void unable_to_lock_message(const char *path, int flags, int err,
-			    struct strbuf *buf)
-{
-	if (err != EEXIST) {
-		strbuf_addf(buf, "Unable to create '%s.lock': %s",
-			    absolute_path(path), strerror(err));
-	} else if (flags & LOCK_OUTSIDE_REPOSITORY) {
-		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
-		    "If no other git process is currently running, this probably means\n"
-		    "another git process crashed earlier. Make sure no other git process\n"
-		    "is running and remove the file manually to continue.",
-			    absolute_path(path), strerror(err));
-	} else {
-		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
-		    "If no other git process is currently running, this probably means a\n"
-		    "git process crashed in this repository earlier. Make sure no other git\n"
-		    "process is running and remove the file manually to continue.",
-			    absolute_path(path), strerror(err));
-	}
-}
-
 int hold_lock_file_for_update(struct lock_file *lk, const char *path,
 			      int flags, struct strbuf *err)
 {
diff --git a/lockfile.h b/lockfile.h
index b4d29a3..02e26fe 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -71,8 +71,6 @@ struct lock_file {
 #define LOCK_NO_DEREF 1
 #define LOCK_OUTSIDE_REPOSITORY 2
 
-extern void unable_to_lock_message(const char *path, int, int err,
-				   struct strbuf *buf);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path,
 				     int, struct strbuf *err);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path,
