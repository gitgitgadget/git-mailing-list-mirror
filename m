From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] strbuf_split: add a max parameter
Date: Mon, 13 Jun 2011 10:30:07 -0700
Message-ID: <7voc21od0g.fsf@alter.siamese.dyndns.org>
References: <20110609155001.GA14969@sigill.intra.peff.net>
 <20110609155121.GA25507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Claire Fousse <claire.fousse@ensimag.imag.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 13 19:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWAy3-0006T7-SG
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 19:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1FMRaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 13:30:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab1FMRaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 13:30:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4FD735CF9;
	Mon, 13 Jun 2011 13:32:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=uunQHTexkphTBNIhyjmtnOZYvv0=; b=IGU+96pl+72/NtzkOyvE
	0imR/R5ummYSY5nq6VYnI64fJWFm7vByqV1K70Zg2mDakCPgdJpVB6bhDRDoSfmf
	hhLhpogXEi0/q+aaW+WMNhM2HeZJHr6LtP4MJl5GG3+gG6PGp9nEYZ5ps7Syr2R9
	pCwVMDfCpcp/0OCPhVLKFW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ZZb3wrD8R9xTzqZ2FcA166HP9DgMVd7/cPTZQOnltgRU1P
	8HE63mi7BrP5LzvUko8Wos4mXjo6uGuAsKYRt65M3g4D+7wJAzXsOHxt4pYX8EAs
	2GWLyuI5UA8FTim4hnA65/PnwE6DzM1EQnkLPFE7PG3r09skCzOALgvVKWQwI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED8AB5CEB;
	Mon, 13 Jun 2011 13:32:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC0345CE0; Mon, 13 Jun 2011
 13:32:18 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AAC6A6E-95E3-11E0-B01F-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175722>

Jeff King <peff@peff.net> writes:

> I am tempted to just call this new one strbuf_split and update all
> callers. There aren't that many.

Yes, that is indeed tempting, and because we have a new parameter the
compiler will catch any new callers that pop up in a mismerge so that
would be perfectly safe.

> -struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
> +struct strbuf **strbuf_split_max(const struct strbuf *sb, int delim, int max)
>  {
>  	int alloc = 2, pos = 0;
>  	char *n, *p;
> @@ -114,7 +114,10 @@ struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
>  	p = n = sb->buf;
>  	while (n < sb->buf + sb->len) {
>  		int len;
> -		n = memchr(n, delim, sb->len - (n - sb->buf));
> +		if (max <= 0 || pos + 1 < max)
> +			n = memchr(n, delim, sb->len - (n - sb->buf));
> +		else
> +			n = NULL;
>  		if (pos + 1 >= alloc) {
>  			alloc = alloc * 2;
>  			ret = xrealloc(ret, sizeof(struct strbuf *) * alloc);

Hmm, even when we know the value of max, we go exponential, and even do so
by hand without using ALLOC_GROW(). Somewhat sad.

Also do we currently rely on the bug that strbuf_split() returns (NULL,)
instead of ("", NULL) when given an empty string?  If not, perhaps...

 strbuf.c |   50 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 09c43ae..7a8ee3a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -103,31 +103,43 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
-struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
+struct strbuf **strbuf_split_max(const struct strbuf *sb, int delim, int max)
 {
-	int alloc = 2, pos = 0;
 	char *n, *p;
-	struct strbuf **ret;
+	struct strbuf **ret = NULL;
 	struct strbuf *t;
-
-	ret = xcalloc(alloc, sizeof(struct strbuf *));
-	p = n = sb->buf;
-	while (n < sb->buf + sb->len) {
-		int len;
-		n = memchr(n, delim, sb->len - (n - sb->buf));
-		if (pos + 1 >= alloc) {
-			alloc = alloc * 2;
-			ret = xrealloc(ret, sizeof(struct strbuf *) * alloc);
+	int pass, count = 0;
+
+	for (pass = 0; pass < 2; pass++) {
+		/* First pass counts, second pass allocates and fills */
+		if (pass)
+			ret = xcalloc(count + 1 + !count, sizeof(struct strbuf *));
+		count = 0;
+		n = sb->buf;
+		while (n < sb->buf + sb->len) {
+			p = n;
+			if (max <= 0 || count + 1 < max)
+				n = memchr(n, delim, sb->len - (n - sb->buf));
+			else
+				n = NULL;
+			if (!n)
+				n = sb->buf + sb->len - 1;
+
+			if (pass) {
+				int len = n - p + 1;
+				t = xmalloc(sizeof(struct strbuf));
+				strbuf_init(t, len);
+				strbuf_add(t, p, len);
+				ret[count] = t;
+			}
+			count++;
+			n++;
 		}
-		if (!n)
-			n = sb->buf + sb->len - 1;
-		len = n - p + 1;
+	}
+	if (!count) {
 		t = xmalloc(sizeof(struct strbuf));
-		strbuf_init(t, len);
-		strbuf_add(t, p, len);
-		ret[pos] = t;
-		ret[++pos] = NULL;
-		p = ++n;
+		strbuf_init(t, 0);
+		ret[0] = t;
 	}
 	return ret;
 }
