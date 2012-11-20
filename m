From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pickaxe: use textconv for -S counting
Date: Mon, 19 Nov 2012 16:31:12 -0800
Message-ID: <7v3905uncf.fsf@alter.siamese.dyndns.org>
References: <20121028124540.GF11434@sigill.intra.peff.net>
 <20121028124701.GB24548@sigill.intra.peff.net>
 <7vk3tpcd0w.fsf@alter.siamese.dyndns.org>
 <20121115012131.GA17894@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 01:31:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TabkQ-0008Q8-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 01:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab2KTAbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 19:31:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab2KTAbP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 19:31:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 274F67A72;
	Mon, 19 Nov 2012 19:31:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=syUaTYxB6Ab05gmPHLhHUXfRgv8=; b=HpRe/t
	MXaolZeHpZq84lQvUjK55QCllnj2LZfZcf5MHvFjU9SoriX+8WFMziJ8zvI5nCjL
	R5G7bkZkMrSiy0/QO/qbEW/WnbynXKOCMwzXvcp4BxfmSvmGqw0VQCN9nTxQI8Ob
	OgNl/at+TSDT2cDHKOa0XtGEPdhXNWqqoe2Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nDmn3D3SspCZJoVsURGcWWnEMay6y/Uq
	fgA3JlSv0aE+BRzaqEXWrPLy6RgOj29IMdJ6LU4l0PMgHrjHVrCAjGxVbajIfVI5
	yH/cHSogaAf0E73upKa8y3B4WnjjVENqLK+u1mIIJw5nV1Fh/bKFZXeUu1mLDbjx
	q/O2byArUE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15ED67A71;
	Mon, 19 Nov 2012 19:31:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 699E77A6F; Mon, 19 Nov 2012
 19:31:14 -0500 (EST)
In-Reply-To: <20121115012131.GA17894@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Nov 2012 17:21:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97562492-32A9-11E2-9EE0-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210070>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 13, 2012 at 03:13:19PM -0800, Junio C Hamano wrote:
>
>> >  static int has_changes(struct diff_filepair *p, struct diff_options *o,
>> >  		       regex_t *regexp, kwset_t kws)
>> >  {
>> > +	struct userdiff_driver *textconv_one = get_textconv(p->one);
>> > +	struct userdiff_driver *textconv_two = get_textconv(p->two);
>> > +	mmfile_t mf1, mf2;
>> > +	int ret;
>> > +
>> >  	if (!o->pickaxe[0])
>> >  		return 0;
>> >  
>> > -	if (!DIFF_FILE_VALID(p->one)) {
>> > -		if (!DIFF_FILE_VALID(p->two))
>> > -			return 0; /* ignore unmerged */
>> 
>> What happened to this part that avoids showing nonsense for unmerged
>> paths?
>
> It's moved down. fill_one will return an empty mmfile if
> !DIFF_FILE_VALID, so we end up here:
>
>         fill_one(p->one, &mf1, &textconv_one);
>         fill_one(p->two, &mf2, &textconv_two);
>
>         if (!mf1.ptr) {
>                 if (!mf2.ptr)
>                         ret = 0; /* ignore unmerged */
>
> Prior to this change, we didn't use fill_one, so we had to check manually.
>
>> > +	/*
>> > +	 * If we have an unmodified pair, we know that the count will be the
>> > +	 * same and don't even have to load the blobs. Unless textconv is in
>> > +	 * play, _and_ we are using two different textconv filters (e.g.,
>> > +	 * because a pair is an exact rename with different textconv attributes
>> > +	 * for each side, which might generate different content).
>> > +	 */
>> > +	if (textconv_one == textconv_two && diff_unmodified_pair(p))
>> > +		return 0;
>> 
>> I am not sure about this part that cares about the textconv.
>> 
>> Wouldn't the normal "git diff A B" skip the filepair that are
>> unmodified in the first place at the object name level without even
>> looking at the contents (see e.g. diff_flush_patch())?
>
> Hmph. The point was to find the case when the paths are different (e.g.,
> in a rename), and therefore the textconvs might be different. But I
> think I missed the fact that diff_unmodified_pair will note the
> difference in paths. So just calling diff_unmodified_pair would be
> sufficient, as the code prior to my patch does.
>
> I thought the point was an optimization to avoid comparing contains() on
> the same data (which we can know will match without looking at it).

Yes.

> Exact renames are the obvious one, but they are not handled here.

That is half true.  Before this change, we will find the same number
of needles and this function would have said "no differences" in a
very inefficient way.  After this change, we may apply different
textconv filters and this function will say "there is a difference",
even though we wouldn't see such a difference at the content level
if there wasn't any rename.
