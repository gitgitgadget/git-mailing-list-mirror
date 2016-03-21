From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git master describe segfault
Date: Mon, 21 Mar 2016 12:31:16 -0700
Message-ID: <xmqqzitrljaz.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1603211025330.20859@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:31:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5Y5-0000cX-Ec
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbcCUTbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:31:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932559AbcCUTbT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:31:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 207044E369;
	Mon, 21 Mar 2016 15:31:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EGDWTuB4s8jmCueXEbBLWqF5f5g=; b=bMtyPx
	bGM1ubi/T0j5s/M2HOJ91O7Et0Pa/HGGP+8sgXa5Ri5AFtTsiQgBna+OSHWUtnMu
	ErS0zs/tVwZ8hKTNx27WGeNVu0kaOulvRyk+nYM9lXYV7MVudnYmlcwbrfju7uEy
	/cGP64lzO/+dyubcpHlnrhlYwVORvjQRST7uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nHeo+6beGaq4CvpcdRgi8QvTbX8DjPDA
	hnUH8B+NNns0hoty+Z3LwQMrpuHWiEAsBuUTMrWzZjnNtQm4hknvs+68RNqB7fEE
	1GAvUZvh6OnYX+VcqShMzdqIYWefPvx/J3BEENilwLcTYTYMqVzlJGornx8fjiFs
	uwCyEZQFGYM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16D1B4E368;
	Mon, 21 Mar 2016 15:31:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 813354E367;
	Mon, 21 Mar 2016 15:31:17 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1603211025330.20859@tvnag.unkk.fr> (Daniel
	Stenberg's message of "Mon, 21 Mar 2016 10:35:05 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7B7D607A-EF9B-11E5-857D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289442>

Daniel Stenberg <daniel@haxx.se> writes:

> 0. I'm on a Linux box: a reasonably updated Debian unstable.
>
> 1. I'm up to date with the latest git master branch of gecko-dev:
> https://github.com/mozilla/gecko-dev (counting a little over 467K
> commits)
>
> 2. I built the current git off the master branch (v2.8.0-rc3-12-g047057b)
>
> 3. In the gecko-dev dir, I run 'git describe --contains f495d0cc2'
>
> The outcome is what looks like a fine stack smash due to very very
> extensive recursion:
>
> $ gdb --args ../git/git describe --contains f495d0cc2
> (gdb) run
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7bccf73 in ?? () from /lib/x86_64-linux-gnu/libz.so.1
> ...
> #12 0x0000000000464662 in name_rev (commit=0x170df20,
> tip_name=0x8e9170 "B2G_1_0_0_20130115070201", generation=87254,
> distance=87254, deref=0) at builtin/name-rev.c:30
> #13 0x00000000004647de in name_rev (commit=0x170dee0,
> tip_name=0x8e9170 "B2G_1_0_0_20130115070201", generation=87253,
> distance=87253, deref=0) at builtin/name-rev.c:72
> #14 0x00000000004647de in name_rev (commit=0x170dea0,
> tip_name=0x8e9170 "B2G_1_0_0_20130115070201", generation=87252,
> distance=87252, deref=0) at builtin/name-rev.c:72
> #15 0x00000000004647de in name_rev (commit=0x170de60,
> tip_name=0x8e9170 "B2G_1_0_0_20130115070201", generation=87251,
> distance=87251, deref=0) at builtin/name-rev.c:72
> #16 0x00000000004647de in name_rev (commit=0x170de20,
> tip_name=0x8e9170 "B2G_1_0_0_20130115070201", generation=87250,
> distance=87250, deref=0) at builtin/name-rev.c:72
> #17 0x00000000004647de in name_rev (commit=0x170dde0,
> tip_name=0x8e9170 "B2G_1_0_0_20130115070201", generation=87249,
> distance=87249, deref=0) at builtin/name-rev.c:72

It does look bad.  name_rev() naively recurses quite a lot and
easily runs out of stack space, it seems (rewriting the recursion
to iterative implementation may help).  I haven't looked at this
code carefully for quite a while, but I suspect piece of memory
pointed at by new_name variable may also be leaking.
 
