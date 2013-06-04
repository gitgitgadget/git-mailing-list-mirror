From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can `git blame` show the date that each line was merged?
Date: Tue, 04 Jun 2013 10:28:06 -0700
Message-ID: <7vfvwx9461.fsf@alter.siamese.dyndns.org>
References: <CAJELnLEiK1C9PeimSwDoJoy=wFbFF0+KoK3jhXSAV4b2DsBKqw@mail.gmail.com>
	<20130604155605.GA15953@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McClure <matthewlmcclure@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 04 19:28:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujv1t-0006ue-TA
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 19:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799Ab3FDR2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 13:28:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab3FDR2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 13:28:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2386C2591B;
	Tue,  4 Jun 2013 17:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D+5j6jl0ffUum3/oVpRADoGFAoE=; b=yEGh2o
	AQgEGpFxU2RMZrwl5VKS8FZGrch7NlPLTcP9n4a8mBOHUXKcR56nKIXiCI1xXDNf
	BN+xiDXhTks6f/9GyIO5Z5LrQpb/4bWCdFUrnXS+xVIwWiDenL5yKnpG2sGIsbLY
	xez+63m5rjXbfxn/ELcLeXvowOzEo/yhevHX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cQ2xSEf7/edCHOoX1O0t/5cZ1pNXm46U
	dV4fI2libujYzw8TJNnMMsf+jQYSFUnZz0RRwG21/MRRclDhCVZpLQJeZ0crPLWv
	ddqzZ0fYRDqlZmdidTkGnvGmnB9+QdqknEeiTmxc4Wk8YpgEqA7JMxnrbk0ZiWYh
	P87mIFFSB60=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDDEF25917;
	Tue,  4 Jun 2013 17:28:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B00025910;
	Tue,  4 Jun 2013 17:28:09 +0000 (UTC)
In-Reply-To: <20130604155605.GA15953@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 4 Jun 2013 11:56:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2024F17C-CD3C-11E2-9CCC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226382>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 57a487e..0fb67af 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1199,6 +1199,8 @@ static int num_scapegoats(struct rev_info *revs, struct commit *commit)
>  {
>  	int cnt;
>  	struct commit_list *l = first_scapegoat(revs, commit);
> +	if (revs->first_parent_only)
> +		return l ? 1 : 0;
>  	for (cnt = 0; l; l = l->next)
>  		cnt++;
>  	return cnt;
>
> (though I suspect it would interact oddly with the "--reverse" option,
> and we would want to either declare them mutually exclusive or figure
> out some sane semantics).

It is entirely unclear who the first child is, so I tend to think
that they have to be mutually exclusive.

>> Aside: in some trial and error I notice this oddity:
>> 
>>     $ git blame --merges
>>     usage: git blame [options] [rev-opts] [rev] [--] file
>> 
>>         [rev-opts] are documented in git-rev-list(1)
>>     ...
>
> Your problem is not the presence of "--merges" here, but that you forgot
> the necessary "file" argument. Try "git blame --merges foo.c".
>
> However, this suffers from the same problem as --first-parent, in that
> it is accepted but not respected. Doing so would not be impossible, but
> it is a little more than the two-liner above.

What the command does when it "respects" it is unclear to me.
In a history like this:

---A---B---C
    \       \
     E---F---G---H

and starting at H, pretend everything that happened in, B, C, E and
F since A was done by G?  Who gets the blame for what A or H did?
