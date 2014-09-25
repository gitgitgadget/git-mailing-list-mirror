From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Receive-pack: include entire SHA1 in nonce
Date: Thu, 25 Sep 2014 09:35:51 -0700
Message-ID: <xmqqk34rbqu0.fsf@gitster.dls.corp.google.com>
References: <1411657340-62950-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 18:36:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXC1O-00078K-NY
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 18:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbaIYQfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 12:35:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60637 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072AbaIYQfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 12:35:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63DF73BCD2;
	Thu, 25 Sep 2014 12:35:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EdpR27AdNCSdMLckRP5JowJ2Oys=; b=HfuIZ4
	r9Lo2yD6iwPB8SXZLcE8JnB7sYNypX/qXC97u0iqd1vujzUTkjzs/5kdPoar+Rtn
	enc6/cnY36I0yDh+MS27UeiaOeVdphsPpsKdmaWyDeOVyTY8giCeB50e8t+IT1it
	21i1752nEp2ObIvq7XfLw9mo+7rY6eLRhG+Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eBaV0PgGYaEgonahwSHT+fzor+skGwb+
	fhA3rW/oDt3XaH6zLAsx0LLeCwjiXuAIfK095YK00VTQuszZ2FFSYBcqmYOnSYjP
	1qDWv0J58A63gLzGyj6ey7QICh/0T37aF9JCbWtm92Ho8a62hlb9gEQCp/zcgx6g
	WvIJ3Ozr8Qc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58D6D3BCD1;
	Thu, 25 Sep 2014 12:35:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D2E4D3BCCF;
	Thu, 25 Sep 2014 12:35:52 -0400 (EDT)
In-Reply-To: <1411657340-62950-1-git-send-email-brian@gernhardtsoftware.com>
	(Brian Gernhardt's message of "Thu, 25 Sep 2014 11:02:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03FDDCD4-44D2-11E4-9C90-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257482>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> clang gives the following warning:
>
> builtin/receive-pack.c:327:35: error: sizeof on array function
> parameter will return size of 'unsigned char *' instead of 'unsigned
> char [20]' [-Werror,-Wsizeof-array-argument]
>         git_SHA1_Update(&ctx, out, sizeof(out));
>                                          ^
> builtin/receive-pack.c:292:37: note: declared here
> static void hmac_sha1(unsigned char out[20],
>                                     ^
> ---
>
>  I dislike changing sizeof to a magic constant, but clang informs me that
>  sizeof is doing the wrong thing.  Perhaps there's an appropriate constant
>  #defined in the code somewhere?

By the way, the title is very misleading, as truncating the HMAC
when creating nonce is done deliberately and it sounds as if the
patch is breaking that part of the system.

We could pass "how many bytes of output do we want" as another
parameter to hmac_sha1() or define that as a constant, and copy out
only that many from here.

And then use the same constant when deciding to truncate the result
of sha1_to_hex() in the caller.

I am not happy with this version, either, though, because now we
have an uninitialized piece of memory at the end of sha1[20] of the
caller, which is given to sha1_to_hex() to produce garbage.  It is
discarded by %.*s format so there is no negative net effect, but I
suspect that the compiler would not see that through.


 builtin/receive-pack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index efb13b1..93fc39d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -287,8 +287,9 @@ static int copy_to_sideband(int in, int out, void *arg)
 }
 
 #define HMAC_BLOCK_SIZE 64
+#define HMAC_TRUNCATE 10 /* bytes */
 
-static void hmac_sha1(unsigned char out[20],
+static void hmac_sha1(unsigned char *out,
 		      const char *key_in, size_t key_len,
 		      const char *text, size_t text_len)
 {
@@ -323,7 +324,7 @@ static void hmac_sha1(unsigned char out[20],
 	/* RFC 2104 2. (6) & (7) */
 	git_SHA1_Init(&ctx);
 	git_SHA1_Update(&ctx, k_opad, sizeof(k_opad));
-	git_SHA1_Update(&ctx, out, sizeof(out));
+	git_SHA1_Update(&ctx, out, HMAC_TRUNCATE);
 	git_SHA1_Final(out, &ctx);
 }
 
@@ -337,7 +338,8 @@ static char *prepare_push_cert_nonce(const char *path, unsigned long stamp)
 	strbuf_release(&buf);
 
 	/* RFC 2104 5. HMAC-SHA1-80 */
-	strbuf_addf(&buf, "%lu-%.*s", stamp, 20, sha1_to_hex(sha1));
+	strbuf_addf(&buf, "%lu-%.*s", stamp,
+		    2 * HMAC_TRUNCATE, sha1_to_hex(sha1));
 	return strbuf_detach(&buf, NULL);
 }
 
