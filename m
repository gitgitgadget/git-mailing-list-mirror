From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/22] hardening allocations against integer overflow
Date: Mon, 22 Feb 2016 15:08:51 -0800
Message-ID: <xmqqbn784a2k.fsf@gitster.mtv.corp.google.com>
References: <20160215214516.GA4015@sigill.intra.peff.net>
	<20160219111941.GA31906@sigill.intra.peff.net>
	<20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 00:08:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzb8-0007FH-3U
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 00:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756265AbcBVXIy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 18:08:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755726AbcBVXIy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 18:08:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EE41475B7;
	Mon, 22 Feb 2016 18:08:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iZ49w3xNCdnk
	P7xz1p7cfYIlXVw=; b=lEIj+YavWq45LYE88HsQpMPPbXSAftMMC/KAr0F+HG5N
	ciFJG0rkzFII5dVlNJcu/Ss+l0W5AWyqmBUrbrI7B8vMYogZ98vJzbwVieZnxj+4
	UPg7FGdZPja9tbL5qyibbb8Ur6EVVdvE+swu3TJEogBaS4e9i0m3BfCHVGiGSSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D3K1yF
	/xQMp6rBUhFzSe6BLTA2IXKk6Mv1yTgb9ZJt9zvvMBjEEoWmKOxwWtrail7yXWZh
	DLFKBG+hN77GmfCOQSAZk0INdc7e+YuW3ihkF7+5JJw3h8K1CB5PxMtEHEhSG1+v
	cKp57YBdCjxTHEg7U/UWV+yL7OxRKy36RdNA0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 85F40475B6;
	Mon, 22 Feb 2016 18:08:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01F9E475B5;
	Mon, 22 Feb 2016 18:08:52 -0500 (EST)
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 22 Feb 2016 17:41:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3D9868C4-D9B9-11E5-8CCB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286999>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 19, 2016 at 06:19:41AM -0500, Jeff King wrote:
>
>> Here's a re-roll of jk/tighten-alloc series from:
>>=20
>>   http://thread.gmane.org/gmane.comp.version-control.git/286253
>
> And here's v3. The changes this time (and philosophical rationalizati=
on
> of changes I didn't make) are pretty small:
>
>   - flip the order of arguments to st_mult() in ALLOC_ARRAY, et al, t=
o
>     get a probably-irrelevant-but-so-easy-why-not optimization
>
>   - mark new global var in daemon.c as static
>
>   - add argv_array_detach (new patch 6) to avoid gross memory managem=
ent
>     when converting line-log to use argv_array in the subsequent patc=
h
>
> So I hope this one is ready for 'next'.  Thanks Ren=C3=A9, Ramsay, an=
d Eric
> for reviewing.
>
>   [01/22]: reflog_expire_cfg: NUL-terminate pattern field
>   [02/22]: add helpers for detecting size_t overflow
>   [03/22]: tree-diff: catch integer overflow in combine_diff_path all=
ocation
>   [04/22]: harden REALLOC_ARRAY and xcalloc against size_t overflow
>   [05/22]: add helpers for allocating flex-array structs
>   [06/22]: argv-array: add detach function
>   [07/22]: convert manual allocations to argv_array
>   [08/22]: convert trivial cases to ALLOC_ARRAY
>   [09/22]: use xmallocz to avoid size arithmetic
>   [10/22]: convert trivial cases to FLEX_ARRAY macros
>   [11/22]: use st_add and st_mult for allocation size computation
>   [12/22]: prepare_{git,shell}_cmd: use argv_array
>   [13/22]: write_untracked_extension: use FLEX_ALLOC helper
>   [14/22]: fast-import: simplify allocation in start_packfile
>   [15/22]: fetch-pack: simplify add_sought_entry
>   [16/22]: test-path-utils: fix normalize_path_copy output buffer siz=
e
>   [17/22]: sequencer: simplify memory allocation of get_message
>   [18/22]: git-compat-util: drop mempcpy compat code
>   [19/22]: transport_anonymize_url: use xstrfmt
>   [20/22]: diff_populate_gitlink: use a strbuf
>   [21/22]: convert ewah/bitmap code to use xmalloc
>   [22/22]: ewah: convert to REALLOC_ARRAY, etc

I admit that I only looked at tbdiff output, but what I saw looked
very sensible.

Thanks.
