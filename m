From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack: fix allocation of sorted_by_pos array
Date: Mon, 06 Jul 2015 16:23:46 -0700
Message-ID: <xmqqvbdwyinx.fsf@gitster.dls.corp.google.com>
References: <1429354025-24659-1-git-send-email-pclouds@gmail.com>
	<1429354025-24659-3-git-send-email-pclouds@gmail.com>
	<xmqqoajt5glu.fsf@gitster.dls.corp.google.com>
	<CACsJy8D872sj9WQec_FZrTxx=gqy++L1XLxJdEtEQNpGpFYr=Q@mail.gmail.com>
	<xmqqzj3c3efv.fsf_-_@gitster.dls.corp.google.com>
	<xmqqr3on369x.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 01:23:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCFju-00043r-4u
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 01:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbbGFXXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2015 19:23:50 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33502 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135AbbGFXXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 19:23:49 -0400
Received: by ieqy10 with SMTP id y10so123977873ieq.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=1sWZ7sO//USl81hNoA7ysm8kC6M30p4dt+tpgzUCZqI=;
        b=XMSq4aPtaOIIuHj14vvYSQ7JTUYQQoy12BY6DscbwdR8x+y4fNiC6Rkrq2h9nvxFht
         Gk1i2ELnfRMSm7h56QDMbjMoBu5UZokMowMLplAr3ybVknEgFBqIv19MQXXcf8VtEnOt
         pdjMCGYFMiJSi8c199Bhdo9GbioWYEwgTSNmNU/apVzysWg3FGC7kPzDO6Nrqsz1rPWn
         A0zPuDt4uc5WR0GAHQVtWcoagwcMSCsE23zu2aoRXzWe1bIlmpOYn9Q3vmG2uFDuMbxd
         8RU+3pF/6k0nPs10dhBoAfbVAYCgCwB2kmf4XTNzhua2eyFdhYh1fnVYsIvx8F4d8XgR
         X0ZA==
X-Received: by 10.107.129.230 with SMTP id l99mr1926013ioi.32.1436225028770;
        Mon, 06 Jul 2015 16:23:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id 137sm13424455ioo.29.2015.07.06.16.23.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 16:23:47 -0700 (PDT)
In-Reply-To: <xmqqr3on369x.fsf_-_@gitster.dls.corp.google.com> (Junio
	C. Hamano's message of "Sat, 04 Jul 2015 15:30:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273469>

Junio C Hamano <gitster@pobox.com> writes:

> When c6458e60 (index-pack: kill union delta_base to save memory,
> 2015-04-18) attempted to reduce the memory footprint of index-pack,
> one of the key thing it did was to keep track of ref-deltas and
> ofs-deltas separately.
>
> In fix_unresolved_deltas(), however it forgot that it now wants to
> look only at ref deltas in one place.  The code allocated an array
> for nr_unresolved, which is sum of number of ref- and ofs-deltas
> minus nr_resolved, which may be larger or smaller than the number
> ref-deltas.  Depending on nr_resolved, this was either under or over
> allocating.
>
> Also, the old code before this change had to use 'i' and 'n' because
> some of the things we see in the (old) deltas[] array we scanned
> with 'i' would not make it into the sorted_by_pos[] array in the old
> world order, but now because you have only ref delta in a separate
> ref_deltas[] array, they increment lock&step.  We no longer need
> separate variables.  And most importantly, we shouldn't pass the
> nr_unresolved parameter, as this number does not play a role in the
> working of this helper function.
>
> Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This time, correcting the analysis; the previous one claimed that
>    this was not a bug but just an overallocation. It indeed is a bug
>    that uses an unrelated value that may or may not be sufficiently
>    large to hold the whole thing, I think.

I think this one as a real "crash hotfix" must be in the upcoming
release (the obvious alternative is to revert the series with
c6458e60 which I really want to avoid).

As Eric's "worktree add" would need some more time to solidify,
let's delay the -rc2 and later by a few weeks.
