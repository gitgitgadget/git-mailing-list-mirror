From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/19] wrapper.c: add a new function unlink_or_msg
Date: Wed, 10 Sep 2014 20:05:40 -0700
Message-ID: <20140911030540.GG18279@google.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 11 05:05:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRuhf-0000Ol-Nj
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbaIKDFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:05:44 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:55604 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaIKDFn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:05:43 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so7623414pad.0
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uiYgN6ZiOEjsuTcz0Q2M4AWWATIHsw8mi5lM4c5rzX4=;
        b=iEqPfDQgasFcAfYcmPHG1bDxhQIxJ+cpJhAabKd8WKJPj0OvYGMjHCK+FwBQKgBwkY
         5SF4wM0jFOg8duKC7MZw2zPyU5cFMo6ZfIS2AZ+Pxces6rwuLbrwyHulNAClxecg/zP2
         0yfPJcmaRaOJuk28RoiiPf7VQsY9Ge09j+7jCwBuMuOESlG3FcQueC1wKnrtLTPTvn8r
         XPvxJKiDARNReCmchjZq9SxUNRc+BdTw+Q48VvBpiKIfsUkqTwQD4zCCMSkPmGISCMpm
         sSGfYSevBjMTGfr2IqSRZnHWYrXaP6wzhcLYakb/Bi/OB7fnxoJOMGOpXgrGGEWZM+22
         /sqQ==
X-Received: by 10.70.103.79 with SMTP id fu15mr20756132pdb.126.1410404743235;
        Wed, 10 Sep 2014 20:05:43 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id qx4sm8748469pbc.14.2014.09.10.20.05.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:05:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256815>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Jul 2014 11:20:36 -0700

This behaves like unlink_or_warn except that on failure it writes the message
to its 'err' argument, which the caller can display in an appropriate way or
ignore.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h |  9 +++++++++
 wrapper.c         | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 611e77b..5ee140c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -307,6 +307,8 @@ extern char *gitbasename(char *);
 
 #include "wildmatch.h"
 
+struct strbuf;
+
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list params);
 extern void vwritef(int fd, const char *prefix, const char *err, va_list params);
@@ -710,6 +712,13 @@ void git_qsort(void *base, size_t nmemb, size_t size,
  * not exist.
  */
 int unlink_or_warn(const char *path);
+ /*
+  * Tries to unlink file.  Returns 0 if unlink succeeded
+  * or the file already didn't exist.  Returns -1 and
+  * appends a message to err suitable for
+  * 'error("%s", err->buf)' on error.
+  */
+int unlink_or_msg(const char *file, struct strbuf *err);
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success which includes trying to remove a directory that does
diff --git a/wrapper.c b/wrapper.c
index c9605cd..ec7a08b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -438,6 +438,20 @@ static int warn_if_unremovable(const char *op, const char *file, int rc)
 	return rc;
 }
 
+int unlink_or_msg(const char *file, struct strbuf *err)
+{
+	int rc = unlink(file);
+
+	assert(err);
+
+	if (!rc || errno == ENOENT)
+		return 0;
+
+	strbuf_addf(err, "unable to unlink %s: %s",
+		    file, strerror(errno));
+	return -1;
+}
+
 int unlink_or_warn(const char *file)
 {
 	return warn_if_unremovable("unlink", file, unlink(file));
-- 
2.1.0.rc2.206.gedb03e5
