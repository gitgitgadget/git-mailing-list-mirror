From: Junio C Hamano <gitster@pobox.com>
Subject: Re: revision: propagate flag bits from tags to pointees
Date: Wed, 15 Jan 2014 14:25:22 -0800
Message-ID: <xmqqk3e0288d.fsf@gitster.dls.corp.google.com>
References: <52CFF27C.1090108@gmail.com>
	<20140115094945.GD14335@sigill.intra.peff.net>
	<xmqq1u092f2k.fsf@gitster.dls.corp.google.com>
	<xmqqwqi10z6i.fsf_-_@gitster.dls.corp.google.com>
	<20140115215641.GB16401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 23:25:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Yu0-0006r5-9H
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 23:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbaAOWZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 17:25:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677AbaAOWZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 17:25:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9BA364EA8;
	Wed, 15 Jan 2014 17:25:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vWxshdIEUHp2fq/KFZKPVVDZ5xo=; b=Pd4+Ku
	dNsVFlbeCPsAITnIOuL6y50DKwYDzs7YTYcTjjE09zZWV/tMo5gjQGZ8/X2JzvnP
	XJd7XNJ9CFndU/205msowazMljiSMjrVlluiL16SkRT/lE9947jUybVmQHNDh3Ev
	7H0SH+X9F6q8oNpYTMOfbZRhfFVh1kCEbSJdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AjUdvwloM+OKHMu5/X2AYFAcc/ZcieVU
	vYqWNXnnjWygXFVhQdVCHPktSQ5YVICAiU0xLncv5Z96mdyc+d8hPaLCQn+1sGZX
	7ADrfqibEFCfae5S49865Q965RwdxEQ+FKztg4g5kdgDtwu4SoQGSMwUbDTzK7mN
	9+1pFK/uKOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D976A64EA7;
	Wed, 15 Jan 2014 17:25:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A85164EA6;
	Wed, 15 Jan 2014 17:25:25 -0500 (EST)
In-Reply-To: <20140115215641.GB16401@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2014 16:56:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EDF36996-7E33-11E3-A2F8-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240484>

Jeff King <peff@peff.net> writes:

> Looks good to me. As per my previous mail, I _think_ you could squash
> in:
>
> diff --git a/revision.c b/revision.c
> index f786b51..2db906c 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -316,13 +316,10 @@ static struct commit *handle_commit(struct rev_info *revs,
>  	 * Blob object? You know the drill by now..
>  	 */
>  	if (object->type == OBJ_BLOB) {
> -		struct blob *blob = (struct blob *)object;
>  		if (!revs->blob_objects)
>  			return NULL;
> -		if (flags & UNINTERESTING) {
> -			mark_blob_uninteresting(blob);
> +		if (flags & UNINTERESTING)
>  			return NULL;
> -		}
>  		add_pending_object(revs, object, "");
>  		return NULL;
>  	}
>
> but that is not very much code reduction (and mark_blob_uninteresting is
> very cheap). So it may not be worth the risk that my analysis is wrong.
> :)

Your analysis is correct, but I think the pros-and-cons of the your
squashable change boils down to the choice between:

 - leaving it in will keep similarity between tree and blob
   codepaths (both have mark_X_uninteresting(); and

 - reducing cycles by taking advantage of the explicit knowledge
   that mark_X_uninteresting() recurses for a tree while it does not
   for a blob.

But I have a suspicion that my patch may break if any codepath looks
at the current flag on the object and decides "ah, it already is
marked" and punts.

It indeed looks like mark_tree_uninteresting() does have that
property.  When an uninteresting tag directly points at a tree, if
we propagate the UNINTERESTING bit to the pointee while peeling,
wouldn't we end up calling mark_tree_uninteresting() on a tree,
whose flags already have UNINTERESTING bit set, causing it not to
recurse?
