From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] diff.c: take "prefix" argument in diff_opt_parse()
Date: Wed, 20 Jan 2016 13:49:21 -0800
Message-ID: <xmqqh9i753by.fsf@gitster.mtv.corp.google.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
	<1453287968-26000-3-git-send-email-pclouds@gmail.com>
	<xmqqr3hc57at.fsf@gitster.mtv.corp.google.com>
	<20160120202946.GA6092@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:49:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM0d7-0006kl-9W
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 22:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbcATVtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 16:49:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753223AbcATVtY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 16:49:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D68B3C642;
	Wed, 20 Jan 2016 16:49:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f1dxhgy4m/VN
	hG/9MSvZvLL/36g=; b=AXhk05S80xTNT5tTkqAAC383jQMuf+4NeMeaazL5lXo8
	/O8naX4lbiAViaduP66pMBK2JCVuPoXONEEW3LMRW8shdZBfOER2/2f6DZgJSXqq
	TMDNj3xbGJZQE7C74Xkc+g/virJzl0T4X3IWi8nteJK6FJMXDqNEgLLzDPiaoHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o8hwQP
	6PCPdzlEDeRSpK77lSRidiZTahbparUPw/z76ZeQwo5rzEaA1vA0fWsiEMr6yFmk
	XEQ5R+TYvtYpMoR1m/5GG5xFADE/kn49r+/5ncd48s0nyeXGMTZt6Bvhay+NpGz0
	tu1Zde6WnTrF55yGKYeGiJOAXR4g6a3uk1NIw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9596B3C641;
	Wed, 20 Jan 2016 16:49:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 120773C640;
	Wed, 20 Jan 2016 16:49:23 -0500 (EST)
In-Reply-To: <20160120202946.GA6092@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 20 Jan 2016 15:29:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AADC0058-BFBF-11E5-8AB9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284474>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 20, 2016 at 12:23:38PM -0800, Junio C Hamano wrote:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>=20
>> > This will be important later when diff_opt_parse() accepts paths a=
s
>> > arguments. Paths must be prefixed before access because setup code
>> > moves cwd but does not (and cannot) update command line options.
>>=20
>> The above sounds like a sensible thing to do (note: I didn't read
>> the patch or remainder of the series), but makes me wonder how the
>> existing --orderfile option works without this support.  Perhaps it
>> is not working and needs to be updated to take advantage of this
>> change, too?
>
> Yeah, I think it simply does not work.
>
>   $ >main-order
>   $ mkdir subdir && >subdir/sub-order
>   $ cd subdir
>   $ git show -Osub-order
>   fatal: failed to read orderfile 'sub-order': No such file or direct=
ory
>   $ git show -Omain-order
>   [shows diff]

Good.

Then 2/7 can be rerolled and advertised as "make -O to work from
subdirectories", and can gradulate regardless of the remainder of
the series.  Even if the rest needs rerolls to get it right (or
takes until 2019 to mature ;-), we will have one less change to
re-review in the process as we can push these early and obviously
correct part out separately.
