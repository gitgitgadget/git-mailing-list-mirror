From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack: reduce memory footprint a bit
Date: Mon, 09 Feb 2015 11:27:21 -0800
Message-ID: <xmqqfvaec2cm.fsf@gitster.dls.corp.google.com>
References: <CACsJy8A=6m5sWnDhPPMNrWbZ=fOMXPxO_1GVh-WpHycf5gm+rg@mail.gmail.com>
	<1423487929-28019-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msporleder@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:27:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtzV-0000Gz-MO
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 20:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933806AbbBIT1Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2015 14:27:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933771AbbBIT1Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 14:27:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 752C8358ED;
	Mon,  9 Feb 2015 14:27:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T4R3Rwj8TzxS
	EG9vgYRYe8Ph+GA=; b=nFqcR/4ZBGz4XO4VEPfsGqV2A33XBBi6vNWKz1PFBCMt
	KL9l3n0xlV1ibgNq/AOgRkr+zivJvAVOWTL3eKNCI+NtoyJq5hfl6l2t46zXuDv0
	efdzacSGS/yAzA+p0uiFVLROBdW1rfELL1DO56BlJ7AGxa5pZLHQOpxblwuG+yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pAOLRz
	YgOYGNKgC+dG9/dRamUuKTFsPjo45lYBM+/u80eiF3M5AOTvw/H8vItcWyWPopux
	LqiF4VWiBp2E5E7G7pMqKgqYjAUH5ehZX5r7ivnj+w75qhND5mFLTranU5qNyYlj
	Rh+Zgt8xNf5QMW1U6oaYaxIo1/wClqGIaRaIA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BD3B358EC;
	Mon,  9 Feb 2015 14:27:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D59E4358EA;
	Mon,  9 Feb 2015 14:27:22 -0500 (EST)
In-Reply-To: <1423487929-28019-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Feb
 2015 20:18:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ABE858EA-B091-11E4-AE31-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263588>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> For each object in the input pack, we need one struct object_entry. O=
n
> x86-64, this struct is 64 bytes long. Although:
>
>  - The 8 bytes for delta_depth and base_object_no are only useful whe=
n
>    show_stat is set. And it's never set unless someone is debugging.
>
>  - The three fields hdr_size, type and real_type take 4 bytes each
>    even though they never use more than 4 bits.
>
> By moving delta_depth and base_object_no out of struct object_entry
> and make the other 3 fields one byte long instead of 4, we shrink 25%
> of this struct.
>
> On a 3.4M object repo that's about 53MB. The saving is less impressiv=
e
> compared to index-pack total memory use (about 400MB before delta
> resolving, so the saving is just 13%)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I'm not sure if this patch is worth pursuing. It makes the code a
>  little bit harder to read. I was just wondering how much memory coul=
d
>  be saved..

I would say 13% is already impressive ;-).

I do not find the result all that harder to read.  I however think
that the change would make it a lot harder to maintain, especially
because the name "object-entry-extra" does not have any direct link
to "show-stat" to hint us that this must be allocated when show-stat
is in use and must never be looked at when show-stat is not in use.

Also it makes me wonder if the compilers are smart enough to notice
that the codepaths that access objects_extra[] are OK because they
are all inside "if (show_stat)".
