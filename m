From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Receive-pack: include entire SHA1 in nonce
Date: Thu, 25 Sep 2014 10:54:11 -0700
Message-ID: <xmqqa95nbn7g.fsf@gitster.dls.corp.google.com>
References: <1411657340-62950-1-git-send-email-brian@gernhardtsoftware.com>
	<xmqqk34rbqu0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 19:54:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXDFD-00017O-58
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 19:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbaIYRyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 13:54:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50763 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687AbaIYRyO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 13:54:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F9FA3CE86;
	Thu, 25 Sep 2014 13:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ekst5fmWBoppb24a+2DQL/S5Tow=; b=NZJXIP
	ivFYYIeQKOoR0j0q+3Rpc1VL8e/SF+LN1is+SoJg2d8AgYGYYdUtgzs3mPUETIID
	X77o2LfeM3EoKkuDZ3VXQ7wXKJx4cKpb8hnorQHiNtjuQezSqbyRrQ89xtODuEGT
	89NAqJ535efBaiBol0QMIfaIB+pw/xvCOmcMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VJcIaqk1AAOY3awy80cr8dRulYuhdQzt
	Qg7uDN62JEdhLe44MSM3MowJA6TD/eyHfSgWxp1/ARnIR1m75+o675IeqHld5IH1
	db0tuI/eUcgC50biBxEXVYj+mitwXFGVrzDfX/0pTvZnrJQp7lqlpJYEHvibeghN
	L9E4Q1NlMeY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9534C3CE85;
	Thu, 25 Sep 2014 13:54:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 15A8C3CE84;
	Thu, 25 Sep 2014 13:54:13 -0400 (EDT)
In-Reply-To: <xmqqk34rbqu0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Sep 2014 09:35:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F58AF6F4-44DC-11E4-B67B-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257484>

Junio C Hamano <gitster@pobox.com> writes:

> I am not happy with this version, either, though, because now we
> have an uninitialized piece of memory at the end of sha1[20] of the
> caller, which is given to sha1_to_hex() to produce garbage.  It is
> discarded by %.*s format so there is no negative net effect, but I
> suspect that the compiler would not see that through.

... and if we want to fix that, we would end up with a set of
changes, somewhat ugly like this.

Which might be an improvement, but let's start with your "sizeof(arg)
is the size of a pointer, even when the definition of arg[] is
spelled with bra-ket, a dummy maintainer!" fix.

I'd like to have your sign-off.  I'd also prefer to retitle it as
something like "hmac_sha1: copy the entire SHA-1 hash out", as it is
deliberate that we do not include the entire SHA-1 in nonce.
    
Thanks.

---


 builtin/receive-pack.c | 13 ++++++++-----
 cache.h                |  1 +
 hex.c                  | 24 ++++++++++++++----------
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index efb13b1..e0e7c75 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -287,8 +287,9 @@ static int copy_to_sideband(int in, int out, void *arg)
 }
 
 #define HMAC_BLOCK_SIZE 64
+#define HMAC_TRUNCATE 10 /* in bytes */
 
-static void hmac_sha1(unsigned char out[20],
+static void hmac_sha1(unsigned char *out,
 		      const char *key_in, size_t key_len,
 		      const char *text, size_t text_len)
 {
@@ -323,21 +324,23 @@ static void hmac_sha1(unsigned char out[20],
 	/* RFC 2104 2. (6) & (7) */
 	git_SHA1_Init(&ctx);
 	git_SHA1_Update(&ctx, k_opad, sizeof(k_opad));
-	git_SHA1_Update(&ctx, out, sizeof(out));
+	git_SHA1_Update(&ctx, out, HMAC_TRUNCATE);
 	git_SHA1_Final(out, &ctx);
 }
 
 static char *prepare_push_cert_nonce(const char *path, unsigned long stamp)
 {
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char sha1[20];
+	unsigned char hmac[HMAC_TRUNCATE];
+	char hmac_trunc[HMAC_TRUNCATE * 2 + 1];
 
 	strbuf_addf(&buf, "%s:%lu", path, stamp);
-	hmac_sha1(sha1, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));;
+	hmac_sha1(hmac, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));;
 	strbuf_release(&buf);
 
 	/* RFC 2104 5. HMAC-SHA1-80 */
-	strbuf_addf(&buf, "%lu-%.*s", stamp, 20, sha1_to_hex(sha1));
+	bin_to_hex(hmac, HMAC_TRUNCATE, hmac_trunc);
+	strbuf_addf(&buf, "%lu-%s", stamp, hmac_trunc);
 	return strbuf_detach(&buf, NULL);
 }
 
diff --git a/cache.h b/cache.h
index fcb511d..bf508a2 100644
--- a/cache.h
+++ b/cache.h
@@ -965,6 +965,7 @@ extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
  */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 
+extern void bin_to_hex(const unsigned char *bin, int, char *hexout);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref_full(const char *refname, unsigned char *sha1,
 			 int reading, int *flags);
diff --git a/hex.c b/hex.c
index 9ebc050..1b30e6e 100644
--- a/hex.c
+++ b/hex.c
@@ -56,20 +56,24 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 	return 0;
 }
 
-char *sha1_to_hex(const unsigned char *sha1)
+void bin_to_hex(const unsigned char *bin, int len, char *hexout)
 {
-	static int bufno;
-	static char hexbuffer[4][50];
 	static const char hex[] = "0123456789abcdef";
-	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
-	int i;
 
-	for (i = 0; i < 20; i++) {
-		unsigned int val = *sha1++;
-		*buf++ = hex[val >> 4];
-		*buf++ = hex[val & 0xf];
+	while (0 < len--) {
+		unsigned int val = *bin++;
+		*hexout++ = hex[val >> 4];
+		*hexout++ = hex[val & 0xf];
 	}
-	*buf = '\0';
+	*hexout = '\0';
+}
+
+char *sha1_to_hex(const unsigned char *sha1)
+{
+	static int bufno;
+	static char hexbuffer[4][50];
+	char *buffer = hexbuffer[3 & ++bufno];
 
+	bin_to_hex(sha1, 20, buffer);
 	return buffer;
 }
