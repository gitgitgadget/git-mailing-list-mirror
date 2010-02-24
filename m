From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] apply: Allow blank context lines to match beyond
 EOF
Date: Wed, 24 Feb 2010 12:56:47 -0800
Message-ID: <7vaauyfj3k.fsf@alter.siamese.dyndns.org>
References: <4B857CE4.4000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 21:57:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkOIA-0006uy-6J
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 21:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099Ab0BXU45 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 15:56:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041Ab0BXU44 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 15:56:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 310229C388;
	Wed, 24 Feb 2010 15:56:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gVN+SePy7qwJ
	8Jyr6kLQMTAsS4g=; b=VfPtSXga1zlaryRUS3p3wIrf/zk/yyG31Sn8gRVlFFxB
	g8gaIpgJ8Zddn9zTjrBLcCaghlP5Kvu6QEqUGF+tXk5UypvmB1Ad1rVNWKI4V5QN
	pyhdDSK/Ji2tka/8gmB2gpP9gFPsqV8/ByW871bKccLud3vPv2aCGTSMi+pwBt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Naf4Ho
	Bb8QAJZSW0cNQqqNTZEyCCCfPNd8Wwjal9JQMRXzDdRiRdJbhEN+E5pqF/B6owkT
	Smzi1G8oCGplOWckgNQyxM8vRs9mqfkIa7Bu96ZyRn9hkwdAsoTnbkW5jwo80eYh
	xgPtYdGTHjFe4dAMbqQeiMYbuHL+uZjr3nkPM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F22B9C387;
	Wed, 24 Feb 2010 15:56:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C6B49C386; Wed, 24 Feb
 2010 15:56:49 -0500 (EST)
In-Reply-To: <4B857CE4.4000201@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Wed\, 24 Feb 2010 20\:24\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2212590C-2187-11DF-B401-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140988>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> "git apply --whitespace=3Dfix" will not always succeed when used
> on a series of patches in the following circumstances:

Very nicely done.

I wanted to explain to myself what "limit" and "preimage_limit" variabl=
es
mean.  preimage-limit has a very clear definition: this many lines from
the beginning of preimage must match img, and the remainder of the
preimage must be all blank (the remainder can exist only when we are
trying to match at the end).

On the other hand "limit" does not have such a good definition, other t=
han
as a work around to bypass line-number check when we are trying to matc=
h
at the end.  It might be cleaner to read if we move the problematic "li=
ne
numbers must match" logic and eliminate this variable, like the attache=
d
patch does on top of this one.

I couldn't figure out how this would interact with the ignore_ws_change
codepath, though.  That one shows a clear sign of being bolted on as an
afterthought (once you fall into that "if()" statement you will not com=
e
back).

 builtin-apply.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 4374d33..ae4452c 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1854,26 +1854,24 @@ static int match_fragment(struct image *img,
 {
 	int i;
 	char *fixed_buf, *buf, *orig, *target;
-	int limit;
 	int preimage_limit;
=20
 	if (preimage->nr + try_lno <=3D img->nr) {
 		/*
 		 * The hunk falls within the boundaries of img.
 		 */
-		limit =3D img->nr;
 		preimage_limit =3D preimage->nr;
+		if (match_end && (preimage->nr + try_lno !=3D img->nr))
+			return 0;
 	} else if (ws_error_action =3D=3D correct_ws_error &&
 		   (ws_rule & WS_BLANK_AT_EOF) && match_end) {
 		/*
 		 * This hunk that matches at the end extends beyond
 		 * the end of img, and we are removing blank lines
-		 * at the end of the file. Set up the limits so that
-		 * tests below will pass and the quick hash test
-		 * will only test the lines up to the last line
-		 * in img.
+		 * at the end of the file.  This many lines from the
+		 * beginning of the preimage must match with img, and
+		 * the remainder of the preimage must be blank.
 		 */
-		limit =3D try_lno + preimage->nr;
 		preimage_limit =3D img->nr - try_lno;
 	} else {
 		/*
@@ -1887,9 +1885,6 @@ static int match_fragment(struct image *img,
 	if (match_beginning && try_lno)
 		return 0;
=20
-	if (match_end && preimage->nr + try_lno !=3D limit)
-		return 0;
-
 	/* Quick hash check */
 	for (i =3D 0; i < preimage_limit; i++)
 		if (preimage->line[i].hash !=3D img->line[try_lno + i].hash)
