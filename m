From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Have a filter_start/filter_end API.
Date: Sat, 6 Oct 2007 11:06:21 +0200
Message-ID: <20071006090621.GB2711@steel.home>
References: <1191615571-15946-1-git-send-email-madcoder@debian.org> <1191615571-15946-2-git-send-email-madcoder@debian.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Oct 06 11:06:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ie5cI-0003s9-Mv
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 11:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbXJFJG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 05:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbXJFJGZ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 05:06:25 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:57477 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbXJFJGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 05:06:24 -0400
Received: from tigra.home (Fae62.f.strato-dslnet.de [195.4.174.98])
	by post.webmailer.de (fruni mo48) (RZmta 13.4)
	with ESMTP id R02e0fj9652qK0 ; Sat, 6 Oct 2007 11:06:22 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id F418C277AE;
	Sat,  6 Oct 2007 11:06:21 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D4044C776; Sat,  6 Oct 2007 11:06:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1191615571-15946-2-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3BTaA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60144>

Pierre Habouzit, Fri, Oct 05, 2007 22:19:30 +0200:
> Those are helpers to build functions that transform a buffer into a
> strbuf, allowing the "buffer" to be taken from the destination buffer.

They are horrible. And very specialized for these "filter" routines.
To the point where I would move them into the file where they are used
(convert.c only, isn't it?)

If you continue to insist the code is generic enough to justify its
residence in strbuf.c, continue reading.

First off, what was wrong with dumb

    void strbuf_make_room(struct strbuf *, size_t newsize);

again?

> +void *strbuf_start_filter(struct strbuf *sb, const char *src, ssize_t hint)
> +{
> +	if (src < sb->buf || src >= sb->buf + sb->alloc) {
> +		if (hint > 0 && (size_t)hint >= sb->alloc)
> +			strbuf_grow(sb, hint - sb->len);
> +		return NULL;
> +	}
> +
> +	if (hint < 0)
> +		return strbuf_detach(sb, NULL);

what is that for? Why can't the caller just use strbuf_detach? (He
already has to pass negative hint somehow, which should be a concious
action).

> +		

trailing space (two HTs)

> +	if ((size_t)hint >= sb->alloc) {
> +		void *tmp = strbuf_detach(sb, NULL);
> +		strbuf_grow(sb, hint);
> +		return tmp;
> +	}
> +
> +	return NULL;
> +}

How can one know when it sb is safe to use after strbuf_end_filter?
It is for the first "if", for example. free() wont free the buf in sb.
Oh, right, one can check if returned pointer !NULL. Which just adds
more code to handle your API.

What actually happens to sb? Is it detached? Is it reallocated?
When it is detached and when it is reallocated?

Why is the returned pointer useful only for giving it to
strbuf_end_filter?

Take for example your change in crlf_to_git:
@@ -85,6 +85,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 {
 	struct text_stat stats;
 	char *dst;
+	void *tmp;
 
 	if ((action == CRLF_BINARY) || !auto_crlf || !len)
 		return 0;
@@ -110,9 +111,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			return 0;
 	}
 
-	/* only grow if not in place */
-	if (strbuf_avail(buf) + buf->len < len)
-		strbuf_grow(buf, len - buf->len);
+	tmp = strbuf_start_filter(buf, src, len);
 	dst = buf->buf;
 	if (action == CRLF_GUESS) {
 		/*
@@ -133,13 +132,14 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		} while (--len);
 	}
 	strbuf_setlen(buf, dst - buf->buf);
+	strbuf_end_filter(tmp);
 	return 1;
 }

And try to rewrite it with the strbuf_make_room:

@@ -110,9 +111,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			return 0;
 	}
 
-	/* only grow if not in place */
-	if (strbuf_avail(buf) + buf->len < len)
-		strbuf_grow(buf, len - buf->len);
+	strbuf_make_room(buf, len);
 	dst = buf->buf;
 	if (action == CRLF_GUESS) {
 		/*

The change looks rather simple

> +/*----- filter API -----*/
> +extern void *strbuf_start_filter(struct strbuf *, const char *, ssize_t);
> +extern void strbuf_end_filter(void *p);

I find the naming very confusing: what filtering takes place where?
If strbuf_end_filter is just free, why is it needed at all? For the
sake of wrapping free()?
