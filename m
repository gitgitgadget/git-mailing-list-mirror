From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
Date: Mon, 06 Jun 2016 13:42:19 -0700
Message-ID: <xmqqtwh6uk0k.fsf@gitster.mtv.corp.google.com>
References: <20160606111643.7122-1-pclouds@gmail.com>
	<20160606111643.7122-3-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, thomas.braun@virtuell-zuhause.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 22:42:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA1Lv-00061w-VF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 22:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbcFFUmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 16:42:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbcFFUmX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 16:42:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E9DBF222C3;
	Mon,  6 Jun 2016 16:42:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QK7v9aA/eFl8
	X2q/OoU7Y59sM5g=; b=KmIywu8+jgkI+wRfpqca2uk1S59is0scTHbvbY5rmmtj
	mSUKVur0VsrrjdLzqM/c0ZjFO1OOsffEw5hDyXRyUVeMr3Eo6V+ef9yab1HqcT0U
	kFqjdUIXlW+B3hj84FBdwMSkyXgMTclwMW9l7KisVrYr7rzjAmKnM/YI9+zes7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l8YtyW
	BLWs5gOKIAYoGVbssHNHprExMfb3XQ1jKq03KvYlWG6wvbAWV6EUkaN5ox0i/DxR
	LkLU5bykipLehkEM5RjMS1PFdhBf7Gfz8+kPOn8IrELuVTwW1K+IlAHo++LOo2F0
	+P+IKAFig41H9Xu5Mwxt+uqOcXSCU1j/8V6mk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E1439222C2;
	Mon,  6 Jun 2016 16:42:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 675B3222C1;
	Mon,  6 Jun 2016 16:42:21 -0400 (EDT)
In-Reply-To: <20160606111643.7122-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
	Duy"'s message of "Mon, 6 Jun 2016 18:16:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2AC60E3E-2C27-11E6-B279-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296565>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +--shift-ita::
> +	By default entries added by "git add -N" appear as an existing
> +	empty file in "git diff" and a new file in "git diff --cached".
> +	This option makes the entry appear as a new file in "git diff"
> +	and non-existent in "git diff --cached".

I do not think this should exist at the UI level, even though the
use of it in wt-status.c (below) makes a very good sense at least
as a temporary band-aid.

At the philosophical level, I however think this "I-T-A does not
logically exist in the index (yet)" is a mistake, and "an option
controls if I-T-A does or does not exist depending on who calls it"
is even worse; it is a road to insanity.

=46or example, because I-T-A does not logically exist in the index,
"git reset --hard" should not remove it but make it untracked again
(but I do not think it does).  After "git add -N foo", because "foo"
does not exist in the index, "git clean" should remove it for the
definition of what's in the index to be logically consistent, but
the whole intent of "add -N" is that the user meant it is worth
checking into sometime in the future, which contradicts with its
removal upon "clean".

So, I dunno.
