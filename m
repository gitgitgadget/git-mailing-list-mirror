From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache: avoid memcpy in expand_name_field in index
 v4
Date: Mon, 18 Mar 2013 10:50:50 -0700
Message-ID: <7vboagoav9.fsf@alter.siamese.dyndns.org>
References: <1363611482-1015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 18:51:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHeDT-00068i-E1
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 18:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab3CRRuy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 13:50:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211Ab3CRRux convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Mar 2013 13:50:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44337A0AD;
	Mon, 18 Mar 2013 13:50:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RbzIA9K7mQMf
	UpsJXiDkiPLNEGE=; b=v6qWPI+d5SRmhg8Gd1M2Xs6ZE6poOh8ZLQTQ2jwoRCY0
	UTNn5MmoVeOd/9nNv5wsyHkgrUuO3PM9XbN+lXBZxZ3LLEYkiE+gUw3oN6cQKS7z
	bKv7acwZerWNBTrAHIvSjtSbFTICEoBebNfxYCuWxLy+vc6S4BAL9MCXoWqZ8c4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=v4u38u
	q58+K0TD3Tln52rrTqdHvuiVEtagRUKArAiFFUX7CH9YfQF3WlSe8GUNjj8wdBxX
	SuTRyG/ujwiVxHPPoAPACq9fQ6gENqN69/bHspkZAlOZtcrhyxgJ1StXSjUEnr4s
	b0GKEGVy2TahZ/xXZLe2+XVHr+FviPu+fPmJM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 393EBA0AB;
	Mon, 18 Mar 2013 13:50:52 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93DE6A0A7; Mon, 18 Mar 2013
 13:50:51 -0400 (EDT)
In-Reply-To: <1363611482-1015-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 18 Mar
 2013 19:58:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FC6045E-8FF4-11E2-A119-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218433>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> perf reports memcpy at the the 6th position [1] in "git status -uno"
> using index v4, and strbuf_remove() in expand_name_field() accounts
> for 25% of that. What we need here is a simple string cut and a
> cheaper strbuf_setlen() should be enough.

While it is true that strbuf_remove(&sb, sb.len - trim, trim) is
equivalent to strbuf_setlen(&sb, sb.len - trim), I wonder why we see
any memcpy() in the first place.

strbuf_remove(&sb, sb.len - trim, trim) is turned into
strbuf_splice(&sb, sb.len - trim, trim, NULL, 0) and then in turn it
does these two:

	memmove(sb.buf + (sb.len - trim) + 0,
                sb.buf + sb.len, 0);
	memcpy(sb.buf + (sb.len - trim), NULL, 0);

both of which should be a no-op, no?

There also is this call that has the same "trim at the right end":

    pretty.c:       strbuf_remove(sb, sb->len - trimlen, trimlen);

It almost makes me suggest that it may be a better solution to make
strbuf_remove() more intelligent about such a call pattern _if_
these empty memmove/memcpy are so expensive, perhaps like the
attached.  It could be that strbuf_splice() should be the one that
ought to be more intelligent, but I'll leave it up to you to
benchmark to find out where the best place to optimize is.

 strbuf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 05d0693..12db700 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -179,7 +179,10 @@ void strbuf_insert(struct strbuf *sb, size_t pos, =
const void *data, size_t len)
=20
 void strbuf_remove(struct strbuf *sb, size_t pos, size_t len)
 {
-	strbuf_splice(sb, pos, len, NULL, 0);
+	if (pos + len =3D=3D sb->len)
+		strbuf_setlen(sb, pos);
+	else
+		strbuf_splice(sb, pos, len, NULL, 0);
 }
=20
 void strbuf_add(struct strbuf *sb, const void *data, size_t len)
