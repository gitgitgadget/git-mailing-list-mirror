Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD45736134
	for <git@vger.kernel.org>; Tue, 21 May 2024 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716333620; cv=none; b=DY/UTN5mFyNHQflssiaJYh6DgZsXbZ4SbV0iHc8DvSwQ8Vn88mOk4UobgD1LqJVFFl3W6MANUKI2wQ5wPr8SDYJc5Gn4iOghuBcB9s1BgVsLRjCd8vvSTqSxitJrK4QD0vO19JRj0TqsD0oArhgyfRoC6yOFDm2ZEc8AGRlSiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716333620; c=relaxed/simple;
	bh=nCFtAGw+S3Ch225HdqAEETOi7OUPqJTKMK35iITizrU=;
	h=From:To:Cc:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=GynnRskkjbP7E1mwynVKNSfjPRUYEtkH9lK37pWGwAa8TW+Cka3vj2gNEkTc8vU/HSpzL0gvlqgJD1bTEu9AmtT54WPBcxDhhzZIgugRwucl3QX397NkX3IRuHaZFa5BHhbSW5JgNtY80kN2OMXOf6EWyzQXTMVEfC8ks4DBsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=a2omboFr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a2omboFr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BAC56237C0;
	Tue, 21 May 2024 19:20:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=nCFtAGw+S3Ch225HdqAEETOi7OUPqJTKMK35iITizrU=; b=a2om
	boFrc6DugktO0hXLAnQR+1U4Mle9m1Mjbo1PQ3Qy6jhNFzLcDc0xctsLMYWy8Mmo
	0KiWBiJbrdON0x/hh6shnCMd4xg89yuDrla3zqwBoXwgjSpZYrFmt8dId9XOGfao
	MidP3oJj4Yl2MzTu5+evwCm2Wt8Lt0OGfuy9nTk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B3BF8237BF;
	Tue, 21 May 2024 19:20:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FE3A237BE;
	Tue, 21 May 2024 19:20:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] add-patch: enforce only one-letter response to prompts
References: <xmqqr0dvb1sh.fsf_-_@gitster.g>
Date: Tue, 21 May 2024 16:20:16 -0700
Message-ID: <xmqqh6eqiwgf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AF2A515E-17C8-11EF-A247-25B3960A682E-77302942!pb-smtp2.pobox.com

In an "git add -p" session, especially when we are not using the
single-char mode, we may see 'qa' as a response to a prompt

  (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?

and then just do the 'q' thing (i.e. quit the session), ignoring
everything other than the first byte.

If 'q' and 'a' are next to each other on the user's keyboard, there
is a plausible chance that we see 'qa' when the user who wanted to
say 'a' fat-fingered and we ended up doing the 'q' thing instead.

As we didn't think of a good reason during the review discussion why
we want to accept excess letters only to ignore them, it appears to
be a safe change to simply reject input that is longer than just one
byte.

The two exceptions are the 'g' command that takes a hunk number, and
the '/' command that takes a regular expression.  They has to be
accompanied by their operands (this makes me wonder how users who
set the interactive.singlekey configuration feed these operands---it
turns out that we notice there is no operand and give them another
chance to type the operand separately, without using single key
input this time), so we accept a string that is more than one byte
long.

Keep the "use only the first byte, downcased" behaviour when we ask
yes/no question, though.  Neither on Qwerty or on Dvorak, 'y' and
'n' are not close to each other.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This version fixes the breakage in t3701 where we exercise the
   '/' command.  Further code inspection reveals that 'g' also needs
   to be special cased.

   The previous iteration was <xmqqr0dvb1sh.fsf_-_@gitster.g>.

 add-patch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/add-patch.c b/add-patch.c
index 79eda168eb..a6c3367d59 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1228,6 +1228,7 @@ static int prompt_yesno(struct add_p_state *s, const char *prompt)
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			return -1;
+		/* do not limit to 1-byte input to allow 'no' etc. */
 		switch (tolower(s->answer.buf[0])) {
 		case 'n': return 0;
 		case 'y': return 1;
@@ -1506,6 +1507,12 @@ static int patch_update_file(struct add_p_state *s,
 		if (!s->answer.len)
 			continue;
 		ch = tolower(s->answer.buf[0]);
+
+		/* 'g' takes a hunk number, '/' takes a regexp */
+		if (1 < s->answer.len && (ch != 'g' && ch != '/')) {
+			error(_("only one letter is expected, got '%s'"), s->answer.buf);
+			continue;
+		}
 		if (ch == 'y') {
 			hunk->use = USE_HUNK;
 soft_increment:
-- 
2.45.1-216-g4365c6fcf9

