From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: do not reuse packfiles without --delta-base-offset
Date: Mon, 07 Apr 2014 10:15:43 -0700
Message-ID: <xmqqvbulm56o.fsf@gitster.dls.corp.google.com>
References: <20140402063916.GA1437@sigill.intra.peff.net>
	<xmqqfvlvvdfi.fsf@gitster.dls.corp.google.com>
	<20140404214848.GA23666@sigill.intra.peff.net>
	<xmqqsipsohjz.fsf@gitster.dls.corp.google.com>
	<20140404231301.GA2528@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 19:15:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXD9F-0007n8-DW
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 19:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbaDGRPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 13:15:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38706 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755552AbaDGRPr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 13:15:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B1297AF31;
	Mon,  7 Apr 2014 13:15:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IkgjF9FuxS0hjiBWDo2f/t+zh24=; b=DQt+h+
	S1t8jI+j0q+2IFKzxl4N7lo8myEqK51GwAaKs6NvrzBbvQv7vl1mM/kQFWbY26Ob
	LC7FB1Vyxph3MH/cF7tt3OSs1AmWzu9/fj3XImP2V7Jq7Ozvg4+IshY81z51aQ8+
	aEY0ME7poAfC9qpY0KGzdjP1Bu4DALEowwJGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kc4Bq7IM+PFpaYTKsXUjnSJF//TY1yMf
	uur2ESDpdHJv1anC0GKyo7HKrtQYR5R2urXgDkxhz+nOJsAQn1gJ3i098dhr7n6M
	GO6lIMirYm/XDkvhqbvBrtlu1H+gxg/xeDrmHsNuCYoTo1Bn5r+4aGZM74G00ELn
	8zkZkPDDrss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88C177AF2F;
	Mon,  7 Apr 2014 13:15:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B6637AF29;
	Mon,  7 Apr 2014 13:15:45 -0400 (EDT)
In-Reply-To: <20140404231301.GA2528@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 4 Apr 2014 19:13:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 417A9A06-BE78-11E3-9E00-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245868>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 04, 2014 at 03:28:48PM -0700, Junio C Hamano wrote:
> ...
>> OK, together with the fact that only ancient versions of fetcher
>> would trigger this "do not reuse" codepath, I agree that we should
>> go the simplest route this patch takes.
>
> By the way, we may want to revisit this if we grow more features that do
> not allow straight byte-for-byte reuse. 

True.

> I am thinking specifically if we
> grow a packv4-like representation for an object, and we plan to convert
> on-the-fly to existing packv2 clients. But I think the sensible steps
> for that are:
>
>   1. If we have v4 on disk and are outputting v2, add this case to the
>      "can_reuse" function I just added. I.e., start out correct, and
>      turn off the optimization.
>
>   2. Experiment with on-the-fly conversion. It may be that the
>      conversion is so expensive that the reuse optimization gets lost in
>      the noise. Or maybe we can reclaim most of the advantage of the
>      reuse code path, and it is worth going object-by-object and
>      converting. But we won't know until we can measure.

Yeah; I think these are sensible steps in the future direction.

Thanks.
