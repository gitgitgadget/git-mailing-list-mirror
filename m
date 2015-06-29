From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Mon, 29 Jun 2015 18:22:47 -0400
Message-ID: <20150629222247.GA31607@flurp.local>
References: <20150625165341.GA21949@peff.net>
 <20150625165545.GC23503@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 00:23:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9hSX-0006Uk-TG
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 00:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbbF2WWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 18:22:55 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38143 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbbF2WWy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 18:22:54 -0400
Received: by igrv9 with SMTP id v9so466704igr.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=u2vBFqT7gFytFmEoa303MjHT8DLd2w4QPZ16VLCh8Bg=;
        b=QP1yZVHxUHuZzr4HL9+dYDLNPffC5X6mxiG8nXvrfeF6eSlvveQmtzwvgIsOtVFakn
         TeEJQejmyoqce+noJIZik6GAJnsXXLF5pKqdje7tTEny+ryyvMR4HdtrLUd7TkH85Bem
         nk52EX5do5OJLkshUSujw/Km7fw9+R1pqQjEiQJ7a49VlWbiTu988LiOznVdH5RNLI6s
         2o/X5luR4YR7obB9uLlD/FCQe3SW5LF5mNVleOhxMI+BAgv0/U9FYbfYLzKDate/7mtg
         yA5dXu/khAkRvDxLW1L9P74mg8VB8b/qfm05OvslLTkysXAHE5ZgrtC7lKEZmyFGUFLE
         sORw==
X-Received: by 10.43.10.194 with SMTP id pb2mr22595888icb.31.1435616573392;
        Mon, 29 Jun 2015 15:22:53 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g81sm4344260ioi.20.2015.06.29.15.22.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 15:22:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150625165545.GC23503@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273026>

On Thu, Jun 25, 2015 at 12:55:45PM -0400, Jeff King wrote:
> This feeds the format directly to strftime. Besides being a
> little more flexible, the main advantage is that your system
> strftime may know more about your locale's preferred format
> (e.g., how to spell the days of the week).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/strbuf.c b/strbuf.c
> index 0d4f4e5..a7ba028 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -709,3 +709,32 @@ char *xstrfmt(const char *fmt, ...)
> +void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
> +{
> +	size_t len;
> +
> +	/*
> +	 * strftime reports "0" if it could not fit the result in the buffer.
> +	 * Unfortunately, it also reports "0" if the requested time string
> +	 * takes 0 bytes. So if we were to probe and grow, we have to choose
> +	 * some arbitrary cap beyond which we guess that the format probably
> +	 * just results in a 0-length output. Since we have to choose some
> +	 * reasonable cap anyway, and since it is not that big, we may
> +	 * as well just grow to their in the first place.
> +	 */
> +	strbuf_grow(sb, 128);
> +	len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
> +
> +	if (!len) {
> +		/*
> +		 * Either we failed, or the format actually produces a 0-length
> +		 * output. There's not much we can do, so we leave it blank.
> +		 * However, the output array is left in an undefined state, so
> +		 * we must re-assert our NUL terminator.
> +		 */
> +		sb->buf[sb->len] = '\0';
> +	} else {
> +		sb->len += len;
> +	}
> +}

Clients of strbuf rightly expect the buffer to grow as needed in
order to complete the requested operation. It is, therefore, both
weird and expectation-breaking for strbuf_addftime() to lack this
behavior. Worse, it doesn't even signal when the format has failed
due to insufficient buffer space.

How about taking this approach (or something similar), instead, which
grows the strbuf as needed?

--- 8< ---
void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
{
	size_t len;
	struct strbuf f = STRBUF_INIT;

	/*
	 * This is a bit tricky since strftime returns 0 if the result did not
	 * fit in the supplied buffer, as well as when the formatted time has
	 * zero length. In the former case, we need to grow the buffer and try
	 * again. To distinguish between the two cases, we supply strftime with
	 * a format string one character longer than what the client supplied,
	 * which ensures that a successful format will have non-zero length,
	 * and then drop the extra character from the formatted time before
	 * returning.
	 */
	strbuf_addf(&f, "%s ", fmt);

	do {
		strbuf_grow(sb, 128);
		len = strftime(sb->buf + sb->len, sb->alloc - sb->len,
			       f.buf, tm);
	} while (!len);
	strbuf_setlen(sb, sb->len + len - 1);

	strbuf_release(&f);
}
--- 8< ---

If this is performance critical code, then the augmented format
string can be constructed with less expensive functions than
strbuf_addf().
