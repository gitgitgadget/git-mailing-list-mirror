From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/19] tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
Date: Mon, 07 Apr 2014 11:07:47 -0700
Message-ID: <xmqqmwfxm2rw.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<7b307610fe214f47643a46b3e815487558db244e.1393257006.git.kirr@mns.spb.ru>
	<20140327142354.GD17333@mini.zxlink>
	<xmqqppkxos0w.fsf@gitster.dls.corp.google.com>
	<20140406214626.GA3843@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:07:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXDxd-0002cL-BX
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbaDGSHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2014 14:07:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbaDGSHv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 14:07:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48AB57A9A0;
	Mon,  7 Apr 2014 14:07:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wnY65ZT9a6ZX
	KSI3+DBw7PldLso=; b=v26tYVfpbvus6RgffPSjTa+7/jSBux+M5ptMEvF7DHdV
	/Uop9rkzEsNF9i4cC1wRQm2YbRpp02fgYCToNgoOPvmHYcH1X+mw4Yg6Mt3qJTBY
	k8Y+aYSvFLFXeRltxVxHe7zclBpesaISqafYEOO9ZpMKOATCRU96w5X3pxBxpbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PTsXIf
	P6NvRpB0JCeZueUy0u6aCQJnV5kD5cAnLsn5pd1i9xOOyVSRVBwr1pulYwxq7Xrg
	QC//k0RFIsJ3PA/iTR1U5XWn8I73r5AgiurELwyf+lLFvJtf2362bm8IfbSKroyJ
	/lFgBmRj2AX9jGHpRzRafTjWUeGNPFTtGe+P8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38C2D7A99F;
	Mon,  7 Apr 2014 14:07:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3125D7A99E;
	Mon,  7 Apr 2014 14:07:49 -0400 (EDT)
In-Reply-To: <20140406214626.GA3843@mini.zxlink> (Kirill Smelkov's message of
	"Mon, 7 Apr 2014 01:46:26 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 87593008-BE7F-11E3-8B5F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245870>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

>> > +			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
>> > +				for (i =3D 0; i < nparent; ++i)
>> > +					if (tp[i].entry.mode & S_IFXMIN_NEQ)
>> > +						goto skip_emit_tp;
>> > +			}
>> > +
>> > +			p =3D emit_path(p, base, opt, nparent,
>> > +					/*t=3D*/NULL, tp, imin);
>> > +
>> > +		skip_emit_tp:
>> > +			/* =E2=88=80 xk=3Dximin  xk=E2=86=93 */
>> > +			update_tp_entries(tp, nparent);
>>=20
>> There are parents whose path sort earlier than what is in 't'
>> (i.e. they were lost in the result---we would want to show
>> removal).  What makes us jump to the skip label?
>>=20
>>     We are looking at path in 't', and some parents have paths that
>>     sort earlier than that path.  We will not go to skip label if
>>     any one of the parent's entry sorts after some other parent (or
>>     the parent in question has ran out its entries), which means we
>>     show the entry from the parents only when all the parents have
>>     that same path, which is missing from 't'.
>>=20
>> I am not sure if I am reading this correctly, though.
>>=20
>> For the two-way diff, the above degenerates to "show all parent
>> entries that come before the first entry in 't'", which is correct.
>> For the combined diff, the current intersect_paths() makes sure that
>> each path appears in all the pair-wise diff between t and tp[],
>> which again means that the above logic match the current behaviour.
>
> Yes, correct (modulo we *will* go to skip label if any one of the
> parent's entry sorts after some other parent). By definition of combi=
ned
> diff we show a path only if it shows in every diff D(T,Pi), and if=20
>
>     2.1) =E2=88=83j: pj > p[imin]  ->  "-p[imin]" =E2=88=89 D(T,Pj)  =
->  D +=3D =C3=B8;  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
>
> some pj sorts after p[imin] that would mean that Pj does not have
> p[imin] and since t > p[imin] (which means T does not have p[imin]
> either) diff D(T,Pj) does not have p[imin]. And because of that we kn=
ow
> the whole combined-diff will not have p[imin] as, by definition,
> combined diff is sets intersection and one of the sets does not have
> that path.
>
>   ( In usual words p[imin] is not changed between Pj..T - it was
>     e.g. removed in Pj~, so merging parents to T does not bring any n=
ew
>     information wrt path p[imin] and that is why we do not want to sh=
ow
>     p[imin] in combined-diff output - no new change about that path )
>
> So nothing to append to the output, and update minimum tree entries,
> preparing for the next step.

That's all in line with the current and traditional definition of
combined diff.

This is a tangent that is outside the scope of this current topic,
but I wonder if you found it disturbing that we treat the result 't'
that has a path and the result 't' that does not have a path with
respect to a parent that does not have the path in a somewhat
assymmetric way.

With a merge M between commits A and B, where they all have the same
path with different contents, we obviously show that path in the
combined diff format.  A merge N that records exactly the same tree
as M that merges the same commits A and B plus another commit C that
does not have that path still shows the combined diff, with one
extra column to express "everything in the result N has been added
with respect to C which did not have the path at all".

However, a merge O between the same commits A and B, where A and B
have a path and O loses it, shows the path in the combined format.
A merge P among the same A, B and an extra parent C that does not
have that path ceases to show it (this is the assymmetry).

It is a natural extension of "Do not show the path when the result
matches one of the parent" rule, and in this case the result P takes
contents, "the path does not exist", from one parent "C", so it is
internally consistent, and I originally designed it that way on
purpose, but somehow it feels a bit strange.
