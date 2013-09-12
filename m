From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] urlmatch.c: recompute ptr after append_normalized_escapes
Date: Thu, 12 Sep 2013 11:30:54 -0700
Message-ID: <xmqqioy5q4dd.fsf@gitster.dls.corp.google.com>
References: <75d702a744eb33a456622dd2ff901abef83e51d8.1378979451.git.trast@inf.ethz.ch>
	<c8915eaaf877abe0e69864ffdc6c50f@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 20:31:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKBfZ-00089q-CY
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 20:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134Ab3ILSbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 14:31:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755754Ab3ILSbC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 14:31:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25CD641E0D;
	Thu, 12 Sep 2013 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YShW8dRVU0OFxDTqyBEvKL8xeHk=; b=DVM53u
	nXWO/h3fkonETQN18P4/4M96tjbXCGYxf8yZw6Ef/tyE/j30IpFzzKyfUksKz6Uf
	nHkhsJPT7tR/DTMg7KRFA49TEn9/0HuSZjcrussFSZwo+0aCih8yNKNor8QYNK15
	NjOwEvzb0TmwJKTG2RzHsHmUpe/8fQPXTnyjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gB55AOeTTKz7KOOg19baJ3fiInETp+6C
	snotMt4OF3rZ5CCaWHmhFOoqUGV5mRuSNRXRYYowx2up61I4kKCIX6qEIaJKns17
	cGwgohVMNruLcBUZsAGrMp5V7XcMFaVp36JmEwqToD6NTShre7EHTBKCrxSDNNWX
	miNbQvd6Qmg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73FE441E02;
	Thu, 12 Sep 2013 18:30:58 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3E4341DE3;
	Thu, 12 Sep 2013 18:30:55 +0000 (UTC)
In-Reply-To: <c8915eaaf877abe0e69864ffdc6c50f@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Thu, 12 Sep 2013 07:15:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 77657CFE-1BD9-11E3-8270-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234668>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> So how about this patch instead...
>
> -- 8< --
> From: Thomas Rast <trast@inf.ethz.ch>
> Subject: urlmatch.c: recompute pointer after append_normalized_escapes
>
> When append_normalized_escapes is called, its internal strbuf_add* calls can
> cause the strbuf's buf to be reallocated changing the value of the buf pointer.
>
> Do not use the strbuf buf pointer from before any append_normalized_escapes
> calls afterwards.  Instead recompute the needed pointer.
>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  urlmatch.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/urlmatch.c b/urlmatch.c
> index 1db76c89..01c67467 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -281,8 +281,9 @@ char *url_normalize(const char *url, struct url_info *out_info)
>  		url_len--;
>  	}
>  	for (;;) {
> -		const char *seg_start = norm.buf + norm.len;
> +		const char *seg_start;
> +		size_t seg_start_off = norm.len;
>  		const char *next_slash = url + strcspn(url, "/?#");
>  		int skip_add_slash = 0;
>  		/*
>  		 * RFC 3689 indicates that any . or .. segments should be
> @@ -297,6 +298,8 @@ char *url_normalize(const char *url, struct url_info *out_info)
>  			strbuf_release(&norm);
>  			return NULL;
>  		}
> +		/* append_normalized_escapes can cause norm.buf to change */
> +		seg_start = norm.buf + seg_start_off;

The change looks good, but I find that this comment is not placed in
the right place.  It is good if the reader knows about an old bug to
put it here, but if the first thing a reader reads is this updated
version, the comment is better placed close to the place where the
start_ofs variable captures the original value (i.e. "because the
next call may relocate the buffer, we cannot grab seg_start upfront;
instead we need to record the start_ofs here, and that is what this
variable is about").

It is too minor a point for a reroll, so I'll try to tweak it
locally.  Something like this (but now I think about it, the comment
may not even be necessary).

 urlmatch.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/urlmatch.c b/urlmatch.c
index 01c6746..d1600e2 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -282,9 +282,17 @@ char *url_normalize(const char *url, struct url_info *out_info)
 	}
 	for (;;) {
 		const char *seg_start;
-		size_t seg_start_off = norm.len;
+		size_t seg_start_off;
 		const char *next_slash = url + strcspn(url, "/?#");
 		int skip_add_slash = 0;
+
+		/*
+		 * record the starting offset; appending escapes may
+		 * relocate the buffer, so we cannot capture seg_start
+		 * upfront and use it later.
+		 */
+		seg_start_off = norm.len;
+
 		/*
 		 * RFC 3689 indicates that any . or .. segments should be
 		 * unescaped before being checked for.
@@ -298,7 +306,7 @@ char *url_normalize(const char *url, struct url_info *out_info)
 			strbuf_release(&norm);
 			return NULL;
 		}
-		/* append_normalized_escapes can cause norm.buf to change */
+
 		seg_start = norm.buf + seg_start_off;
 		if (!strcmp(seg_start, ".")) {
 			/* ignore a . segment; be careful not to remove initial '/' */
