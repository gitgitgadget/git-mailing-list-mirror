From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] [RFC] subvert sorted-array to replace binary-search
 in unpack-objects.
Date: Fri, 10 Dec 2010 15:00:40 -0800
Message-ID: <7vmxodb5d3.fsf@alter.siamese.dyndns.org>
References: <1291848695-24601-1-git-send-email-ydirson@altern.org>
 <1291848695-24601-7-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Dec 11 00:01:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRBxS-00048L-Gx
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 00:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab0LJXAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 18:00:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab0LJXAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 18:00:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2B4A3772;
	Fri, 10 Dec 2010 18:01:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zmcgIwpjknhnV/pWT2MJ2JdbeeA=; b=v+7CFk
	FnXXNTDseo0OTkJX1+pege2hmTOz6T/kDag31Zj6n7IS3SFCkjOL8B7rkdZCvGAC
	Kz3ZxqXbCtoiHEtYRFON9/5LbMJiOJvtH1qDNwYwHsg/f3KCGrF+Fi+OxeZ1w0oP
	aJYlSbWbHjBf+tI0HM6bdvsFvYQBmwPF1e7qY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iGwstfQmLVPvlQSVMqzMXFB46BpeHGp8
	I0DCXQAZa7sJiJfm/Fp5fq4Qa5Fb5gdlonq1ijGuFWSIcEjM2XLGmTV/cneoTdjo
	kDBzw+EKq/6Szg/exwbpe8sXi9vlPldBzLFvBOeAx+FbZJA77iTkKQ421PrHhW3J
	qkvPPZKRzKg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0BA1376E;
	Fri, 10 Dec 2010 18:01:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CDA9D376D; Fri, 10 Dec 2010
 18:01:06 -0500 (EST)
In-Reply-To: <1291848695-24601-7-git-send-email-ydirson@altern.org> (Yann
 Dirson's message of "Wed\,  8 Dec 2010 23\:51\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 60A37C24-04B1-11E0-81A3-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163445>

Yann Dirson <ydirson@altern.org> writes:

> Signed-off-by: Yann Dirson <ydirson@altern.org>
> ---
>  builtin/unpack-objects.c |   40 +++++++++++++++++++++++++---------------
>  1 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index f63973c..6d7d113 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -157,7 +158,24 @@ struct obj_info {
>  #define FLAG_OPEN (1u<<20)
>  #define FLAG_WRITTEN (1u<<21)
>  
> -static struct obj_info *obj_list;
> +/*
> + * FIXME: obj_info is a sorted array, but we read it as a whole, we
> + * don't need insertion features.  This allows us to abuse unused
> + * obj_info_nr later as a means of specifying an upper bound for
> + * binary search.  obj_info_alloc shall be eliminated by the compiler
> + * as unused.
> + */

I was scratching my head when I read "subvert" on your Subject line and
FIXME above for the first time, but after thinking about it, I think I got
it, and more importantly, I think you realized and shared with me the "too
rigid and brittle" I mentioned in my response to [1/6] earlier, if not
"overengineered" part.

As pack stream is read in, obj_list is built into an array that is sorted
by its "offset" field up to "nr"-th element.  And assigning the current
number of elements in the array to obj_list_nr is not a "kludge to bound
the search" as you said in the comment, but is the right thing to do given
the structure of your API.  "nr" is "up to this index the array is filled
and used", "alloc" is "this many is allocated", and at the point of that
assignment, "nr" is indeed what it is.

The only reason it might seem kludgy is because the API is not designed to
anticipate that there is a way to add new elements at the end by feeding
elements in the already sorted order, and that facility does so without
calling the functions your API autogenerates.

I think the most bothersome repetition with the current codebase around
binary searchable tables is the binary search loops.  Perhaps introducing
a macro that lets us write them in a more structured way, without trying
to build an elaborate top-level declarations that do everything (and
failing to do so), may give you a better payback?
