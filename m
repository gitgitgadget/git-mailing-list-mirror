From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v2] urlmatch.c: recompute ptr after append_normalized_escapes
Date: Thu, 12 Sep 2013 07:15:40 -0700
Message-ID: <c8915eaaf877abe0e69864ffdc6c50f@f74d39fa044aa309eaea14b9f57fe79>
References: <75d702a744eb33a456622dd2ff901abef83e51d8.1378979451.git.trast@inf.ethz.ch>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 16:15:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK7gW-00054G-DV
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 16:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab3ILOPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 10:15:48 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33979 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab3ILOPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 10:15:47 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so1160274pab.12
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=+8foOixWPqnfe99GSx3SUaf8nwKW8BUmQbmZ4UgHVSA=;
        b=wIvzAPXh9Po053uIQ6tmkLx3yQIDzDa0U/quqjj1S6Pv+tV1ltMGiwLWIEw68i0xdc
         Ec4uJfsLxdGqiQQxbrV4FGWEkZeVbJrZV/Y5KvaYavAWfwVtDUu8xv0K3bfFcGSgCDUr
         17HQFvEWYgLjzlspY4bjiaYTAHDLkIl4yq2f4MgI+O4HfL9pLd5Y06DCv9tABqaTZw0D
         MQ1xpO8CKvrRnL4GLCeNAAllfVVEzC8Zeg5bUWmTM5Ro9P6GYpLzkHjfyD6e6sKyEA18
         YyBoX/PuypMq8slhdzs6lATOwwLK5y3Xd+foD/FYz/9sBw6zZHyDxb7zzpP6AGk5Kt02
         EK9A==
X-Received: by 10.66.168.7 with SMTP id zs7mr9879862pab.152.1378995347027;
        Thu, 12 Sep 2013 07:15:47 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kz4sm5111421pbc.39.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 07:15:46 -0700 (PDT)
In-Reply-To: <75d702a744eb33a456622dd2ff901abef83e51d8.1378979451.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234652>

On Sep 12, 2013, at 02:57, Thomas Rast wrote:

> The calls to strbuf_add* within append_normalized_escapes() can
> reallocate the buffer passed to it.  Therefore, the seg_start pointer
> into the string cannot be kept across such calls.

Thanks for finding this.

> It went undetected for a while because it does not fail the test: the
> calls to test-urlmatch-normalization happen inside a $() substitution.
> 
> I checked the other call sites to append_normalized_escapes() for the
> same type of problem, and they seem to be okay.

> diff --git a/urlmatch.c b/urlmatch.c
> index 1db76c8..59abc80 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -281,7 +281,8 @@ char *url_normalize(const char *url, struct url_info *out_info)
> 		url_len--;
> 	}
> 	for (;;) {
> -		const char *seg_start = norm.buf + norm.len;
> +		const char *seg_start;
> +		size_t prev_len = norm.len;

How about a more descriptive name for what prev_len is?  It's actually the
segment start offset.

> 		const char *next_slash = url + strcspn(url, "/?#");
> 		int skip_add_slash = 0;
> 		/*
> @@ -297,6 +298,7 @@ char *url_normalize(const char *url, struct url_info *out_info)
> 			strbuf_release(&norm);
> 			return NULL;
> 		}
> +		seg_start = norm.buf + prev_len;

A comment would be nice here to remind folks who might be tempted to
revert this to the previous version why it's being done this way.

I'm sure at some point someone will propose a "simplification" patch
otherwise.

Also some nits.  The patch description should be imperative mood
(cf. Documentation/SubmittingPatches).  And instead of mentioning the seg_start
pointer in the description (which will be meaningless to just about everyone and
it's clear from the diff), mention the bad thing the code was doing in more
general terms that will be clear to anyone familiar with a strbuf.

So how about this patch instead...

-- 8< --
From: Thomas Rast <trast@inf.ethz.ch>
Subject: urlmatch.c: recompute pointer after append_normalized_escapes

When append_normalized_escapes is called, its internal strbuf_add* calls can
cause the strbuf's buf to be reallocated changing the value of the buf pointer.

Do not use the strbuf buf pointer from before any append_normalized_escapes
calls afterwards.  Instead recompute the needed pointer.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 urlmatch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/urlmatch.c b/urlmatch.c
index 1db76c89..01c67467 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -281,8 +281,9 @@ char *url_normalize(const char *url, struct url_info *out_info)
 		url_len--;
 	}
 	for (;;) {
-		const char *seg_start = norm.buf + norm.len;
+		const char *seg_start;
+		size_t seg_start_off = norm.len;
 		const char *next_slash = url + strcspn(url, "/?#");
 		int skip_add_slash = 0;
 		/*
 		 * RFC 3689 indicates that any . or .. segments should be
@@ -297,6 +298,8 @@ char *url_normalize(const char *url, struct url_info *out_info)
 			strbuf_release(&norm);
 			return NULL;
 		}
+		/* append_normalized_escapes can cause norm.buf to change */
+		seg_start = norm.buf + seg_start_off;
 		if (!strcmp(seg_start, ".")) {
 			/* ignore a . segment; be careful not to remove initial '/' */
 			if (seg_start == path_start + 1) {
-- 
1.8.3
