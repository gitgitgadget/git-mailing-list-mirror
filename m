From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] Rewrite strbuf.c:strbuf_cmp() replace memcmp() with starts_with()
Date: Sat, 22 Mar 2014 22:58:45 +0100
Message-ID: <87fvm928ve.fsf@fencepost.gnu.org>
References: <1395523516-10181-1-git-send-email-mustafaorkunacar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: Mustafa Orkun Acar <mustafaorkunacar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 22:59:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRTwW-0002VS-RZ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 22:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbaCVV7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 17:59:00 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:36536 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaCVV67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 17:58:59 -0400
Received: from localhost ([127.0.0.1]:35577 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WRTwQ-0001vm-ML; Sat, 22 Mar 2014 17:58:58 -0400
Received: by lola (Postfix, from userid 1000)
	id 7BCB4E09FD; Sat, 22 Mar 2014 22:58:45 +0100 (CET)
In-Reply-To: <1395523516-10181-1-git-send-email-mustafaorkunacar@gmail.com>
	(Mustafa Orkun Acar's message of "Sat, 22 Mar 2014 23:25:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244785>

Mustafa Orkun Acar <mustafaorkunacar@gmail.com> writes:

> I reviewed all functions using memcmp(). It generally makes code more understandable. But here it might be used for the sake of simplicity.
>
> Signed-off-by: Mustafa Orkun Acar <mustafaorkunacar@gmail.com>
> ---
> I applied to GSoC 2014. I expect your feedbacks and comments!
>  strbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index ee96dcf..50d0875 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -147,7 +147,7 @@ void strbuf_list_free(struct strbuf **sbs)
>  int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
>  {
>  	int len = a->len < b->len ? a->len: b->len;
> -	int cmp = memcmp(a->buf, b->buf, len);
> +	int cmp = !starts_with(a->buf, b->buf);
>  	if (cmp)
>  		return cmp;
>  	return a->len < b->len ? -1: a->len != b->len;

Not correct.  The original code clearly takes care to return a signed
result with the same definition of signedness as memcmp.  While this
intent has not been written down in a comment or description in either
strbuf.c or strbuf.h, the code does not make sense without it.

rerere.c contains the following lines:

                        if (strbuf_cmp(&one, &two) > 0)
                                strbuf_swap(&one, &two);

and that only makes sense when there is an actual meaning to the sign of
the result.

Your version would return 1 when either comparing "1" with "2" OR "2"
with "1".  It requires NUL-terminated strings: if that was a valid
constraint for strbuf, this function would be using strcmp in the first
place.

-- 
David Kastrup
