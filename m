Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA261FE9
	for <git@vger.kernel.org>; Mon, 27 May 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832946; cv=none; b=cd+LrJA4TshMGbN+ewXc230nywqCalqNSGcbEPkaavN3eEYeix0ogrTMyYOOs6eZXFqn9EzCsEegJC+AshPEEXVYTaW8VwzbDB85ER83NO09NYNeDyw0FKdde1ddCURaVQfrwwLuFRkz2klZhRuodiSOPFBi22GuTbasj3Cv+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832946; c=relaxed/simple;
	bh=9qBjmrVn0cHvVDjGgeFePFIANmC0ZfT/FgV948C+LMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vh8O51qS35yr+BRc86ircBnymlhVdwzmwgQYCWy6PigZCejv53HkZdA+fL4sgsI07WPqwnqV0aN4yzYQ3CwegMu3+bWy8pckzUEcS6zAT6i+vWDHvxImdW+COdw9MZXCYByB5qrbNj1QIgINu/YLqiDhqwxKSbz5rEkOHIhAXdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rKVL3bB+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rKVL3bB+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 160BF3303B;
	Mon, 27 May 2024 14:02:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9qBjmrVn0cHvVDjGgeFePFIANmC0ZfT/FgV948
	C+LMA=; b=rKVL3bB+9a8vK1kmd16Ful4dIv0F185HcJClgeAqOa801bfxcqjlJZ
	CTasQGmfeEsOllfjZyNQFuUw6hCga5jIgU7uP3SR4S3yIy7mriXhTLHLAtSo7cZ0
	v2iICmXPwp5HO6d0XUzxErMrZ+//7wjGuNvV4+zEm11Lqw7Eg7pmk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D7BA3303A;
	Mon, 27 May 2024 14:02:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C23133039;
	Mon, 27 May 2024 14:02:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/21] Various memory leak fixes
In-Reply-To: <xmqqwmnf9mto.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	27 May 2024 10:38:59 -0700")
References: <cover.1716465556.git.ps@pks.im> <cover.1716541556.git.ps@pks.im>
	<xmqqwmniiqv2.fsf@gitster.g> <ZlQr11P_C-KyO2DF@tanuki>
	<xmqqwmnf9mto.fsf@gitster.g>
Date: Mon, 27 May 2024 11:02:22 -0700
Message-ID: <xmqq8qzv9lqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 44D7D13E-1C53-11EF-9164-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Indeed. The following diff fixes the leak:
>>
>>     diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>>     index 7d2a419230..e54be9c429 100644
>>     --- a/builtin/update-ref.c
>>     +++ b/builtin/update-ref.c
>>     @@ -130,6 +130,8 @@ static char *parse_next_arg(const char **next)
>>      
>>         if (arg.len)
>>             return strbuf_detach(&arg, NULL);
>>     +
>>     +	strbuf_release(&arg);
>>         return NULL;
>>      }
>>      
>>
>> Karthik is out of office this week, so you may want to add this as a
>> "SQUASH???" commit on top of his topic branch to make "seen" pass.
>
> Alright.  Thanks.

But I am curious.  How would this leak even be possible?  

arg.len==0 and arg.buf != strbuf_slopbuf would mean that somebody
who touched arg (either parse_arg() call or strbuf_addstr() call)
allocated arg.buf but ended up not adding any byte (or added some
bytes but at the end rewound with "arg.len = 0").

Ahh, strbuf_addstr() does an unconditional strbuf_grow().  I wonder
if the following patch is a good idea in general, then (not as a
replacement for your fix, but as a general code hygiene---unless
you know you need more memory, don't allocate).

I have a suspicion that this is optimizing for a wrong case, though,
so I'd probably refrain from committing it.  If the caller often has
an empty string, and if the caller feels like it is worth checking
to omit such an extra "opportunistic" allocation, the caller can do
so.

 strbuf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git c/strbuf.c w/strbuf.c
index 0d929e4e19..c0e58f5b95 100644
--- c/strbuf.c
+++ w/strbuf.c
@@ -308,6 +308,8 @@ void strbuf_remove(struct strbuf *sb, size_t pos, size_t len)
 
 void strbuf_add(struct strbuf *sb, const void *data, size_t len)
 {
+	if (!len)
+		return;
 	strbuf_grow(sb, len);
 	memcpy(sb->buf + sb->len, data, len);
 	strbuf_setlen(sb, sb->len + len);
@@ -315,6 +317,8 @@ void strbuf_add(struct strbuf *sb, const void *data, size_t len)
 
 void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
 {
+	if (!sb2->len)
+		return;
 	strbuf_grow(sb, sb2->len);
 	memcpy(sb->buf + sb->len, sb2->buf, sb2->len);
 	strbuf_setlen(sb, sb->len + sb2->len);
@@ -337,6 +341,8 @@ const char *strbuf_join_argv(struct strbuf *buf,
 
 void strbuf_addchars(struct strbuf *sb, int c, size_t n)
 {
+	if (!n)
+		return;
 	strbuf_grow(sb, n);
 	memset(sb->buf + sb->len, c, n);
 	strbuf_setlen(sb, sb->len + n);
@@ -805,6 +811,8 @@ void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
 static void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
 				 char_predicate allow_unencoded_fn)
 {
+	if (!len)
+		return;
 	strbuf_grow(sb, len);
 	while (len--) {
 		char ch = *s++;

