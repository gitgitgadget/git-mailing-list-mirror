From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Tue, 29 May 2012 20:43:52 +0700
Message-ID: <CACsJy8C1j6MT9ho2TRUKBG0bpB+hg8rhiAE4QEsf-_X-55c59A@mail.gmail.com>
References: <20120523122135.GA58204@tgummerer.unibz.it> <CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
 <20120525201547.GB86874@tgummerer> <CACsJy8BRWmqz+2_A5_=1S9_sxOQa9GXnPQ7J1Y6id0_vh2-=+Q@mail.gmail.com>
 <20120527090407.GD86874@tgummerer> <7vbolaotwj.fsf@alter.siamese.dyndns.org>
 <CACsJy8D+WgEr4i2H-1oiBLY5oLurM0aNxGovbVEZDvr7OGgknw@mail.gmail.com> <87vcjfi09m.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 29 15:44:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZMj8-0001qk-E7
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 15:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab2E2Nom convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 09:44:42 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41765 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab2E2Nol convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 09:44:41 -0400
Received: by wibhj8 with SMTP id hj8so2703674wib.1
        for <git@vger.kernel.org>; Tue, 29 May 2012 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=M3q1+UIBF3GSsrytOC2lRj//1ftIgdolYAVB30Eyhxo=;
        b=CSEhJyq5nqfYkIjYxH71Zp2r4H5kfBu/ZOGbY5xgA5jnhRjjtCm7OtdWA0ZM+KeqJc
         I8L2M6iy4k8glBM9z8KFu+9n8e68zcHfibXUWphgeUCg6Xnoc0ayrJnKTdwegbhCRI3P
         uCg0BTl0xlxy3VMaXe6Up3KZywvzbTBssrdPReq4YRR74cbm7MfFlDODXe2wIrqfWxuR
         +fbM5BouL1OB2zGU8L+9IAP40vtvbnBcJgYJe2PEEYSiqufB0c8i6/kQb0sONBrB1mGq
         NKsq3Ya+KSjiZwdfliCGWjI1YH0zHVsNOxS0z/PHUtamSms23MTiIItqHaHH3Lvb90Nv
         pAVg==
Received: by 10.216.194.196 with SMTP id m46mr7102642wen.197.1338299062951;
 Tue, 29 May 2012 06:44:22 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Tue, 29 May 2012 06:43:52 -0700 (PDT)
In-Reply-To: <87vcjfi09m.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198740>

On Tue, May 29, 2012 at 8:29 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> I envision an index API that more strictly controls access to the ind=
ex.
> Right now the API consists largely of read_index, write_index and the
> flat the_index->cache array of entries. =C2=A0Eventually it will have=
 to be a
> family of calls that support the v5 format, and boil down to suitable
> wrappers for older ones. =C2=A0For example (just tossing up ideas):
>
> =C2=A0index_open(struct index_state *index, int fd):
> =C2=A0 =C2=A0initialization, checking, leaves the "real" data fields =
empty
>
> =C2=A0index_load_filtered(..., const char **pathspec):
> =C2=A0 =C2=A0load everything needed to satisfy queries filtered by 'p=
athspec'
>
> =C2=A0index_for_each_entry(..., void (*callback)(struct cache_entry *=
ent)):
> =C2=A0 =C2=A0like the current hand-rolled looping
>
> =C2=A0index_for_each_entry_filtered(..., void (*callback)(struct cach=
e_entry *ent), char **pathspec):
> =C2=A0 =C2=A0ditto but for a pathspec lookup
>
> etc.

I'm towards readdir interface with filter flags (e.g. staged entries
only, unmerged only, all...) for serial access and something like
stat() for one-file check. That may be enough for ls-files conversion.
With readdir-like interface where entries are sorted, I can help add
pathspec support to tree_entry_interesting(). This function can be
used by new ls-files to filter pathspec instead of the list-based
pathspec_matches().

One thing to consider is, will this new API work with old versions too
(i.e. can conversion be hidden behind the scene without significant
performance loss)? If it does, great we only have to maintain one API,
the future is bright. Otherwise, I don't know..

> Actually converting the rest of the git code base to such an API is t=
oo
> big an undertaking for the summer, so please don't stray on that path=
=2E

Agreed.
--=20
Duy
