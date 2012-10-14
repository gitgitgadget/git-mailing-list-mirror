From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] exclude: fix a bug in prefix comparison optimization
Date: Sun, 14 Oct 2012 10:36:06 -0700
Message-ID: <7v8vb9yn09.fsf@alter.siamese.dyndns.org>
References: <1350214522-3242-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 19:41:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNSBO-0005pT-5o
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 19:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab2JNRgK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 13:36:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578Ab2JNRgJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 13:36:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F3A59F4D;
	Sun, 14 Oct 2012 13:36:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3/V2l9BewRJp
	A7BAqC4T5lg18ZM=; b=C/+71q0PbinVWY8r6s7+tl96dWCBDDBpPbpKkRzIa87Y
	RplndP/hd+dT8eGJ/+e39bYM/CF8EHLlrlIPzi/+YQnP0uCMMdXT59SVM6Aev0j5
	KQ7C/A5Jy4tMJkOiIvI1r6yf0kMD/mIpordCeuGRzUYyR6eNLZaT+2AbZL5/Ju4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e5sBal
	fv4nSScoFGowv5wvDUhOGQ478kRNqm80qtmCoBGr/Yuuf23FGx7OjmSEJa/aFHyG
	xQRTmJRCN6xNtfhmesthqe8Lzd0mJ1uUSyd/kvW7xzbsSiv62PxLbQRMh8BjVATR
	byMxFccYC8KQLIOQVmapVBR1jymPTJQGBYCIQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A2469F4C;
	Sun, 14 Oct 2012 13:36:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C28E99F48; Sun, 14 Oct 2012
 13:36:07 -0400 (EDT)
In-Reply-To: <1350214522-3242-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 14 Oct
 2012 18:35:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2F41FFC-1625-11E2-85DB-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207678>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> When "namelen" becomes zero at this stage, we have matched the fixed
> part, but whether it actually matches the pattern still depends on th=
e
> pattern in "exclude". As demonstrated in t3001, path "three/a.3"
> exists and it matches the "three/a.3" part in pattern "three/a.3[abc]=
",
> but that does not mean a true match.
>
> Don't be too optimistic and let fnmatch() do the job.

Yeah, the existing code is correct _only_ if the pattern part can
match an empty string (e.g. "three/a.3*") and this is a correct fix.

With your "teach attr.c match the same optimization as dir.c"
series, you would need something like this

diff --git i/attr.c w/attr.c
index 6d39406..528e935 100644
--- i/attr.c
+++ w/attr.c
@@ -710,7 +710,7 @@ static int path_matches(const char *pathname, int p=
athlen,
 	 * if the non-wildcard part is longer than the remaining
 	 * pathname, surely it cannot match.
 	 */
-	if (!namelen || prefix > namelen)
+	if (prefix > namelen)
 		return 0;
 	if (baselen !=3D 0)
 		baselen++;

Comparing the corresponding code in dir.c, there is no "compare the
literal prefix part with strcmp() before doing the fnmatch()"
optimization.  Intended?

(warning: I haven't had my caffeine yet)
