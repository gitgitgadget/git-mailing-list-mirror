From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Fix termination issues for remote svn connections
Date: Thu, 05 Sep 2013 16:14:52 -0700
Message-ID: <xmqqk3iug8sz.fsf@gitster.dls.corp.google.com>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106>
	<xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
	<20130905190249.GA1532@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uli Heller <uli.heller@daemons-point.com>, git@vger.kernel.org,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 06 01:15:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHilT-0001WE-Jm
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 01:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022Ab3IEXO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 19:14:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61836 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029Ab3IEXO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 19:14:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5BA93FF84;
	Thu,  5 Sep 2013 23:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EYhvmIf0xCV7FCgNd4A0UmL7068=; b=mljcdC
	/YK2gDuvF8l+AH91Qo57uQAmXNN6HOmF/u9O7K58ei+Cp5nunH69VC6bY6tRlI5+
	Iy8E9t2/u2J7DOXosYHT8gyoUVyaKAogzqbQ8/TTTyacMpe98li6EOQW/xrTuTPe
	e9SOMgb+YkSAKvzjg2ACS5r5rELAZQga9Bi+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s+nMNMdQkbAVHxWpvZZnMNerHbDiPuw9
	TEmXC+tuw4D5LXng1WrDrVlMI/MX45S0K03SlZiZDSeSOa9CHxtQFKyLLR84hSQl
	AdFlCE5beJd4wl0md8xObe81lWqpWY+fSL2B02nQ7QasUccFfTgpHDymtOo8843O
	Fa307M+LHcg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ABBE3FF83;
	Thu,  5 Sep 2013 23:14:57 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E7913FF75;
	Thu,  5 Sep 2013 23:14:55 +0000 (UTC)
In-Reply-To: <20130905190249.GA1532@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 5 Sep 2013 19:02:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9E9DF48-1680-11E3-A6E5-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234002>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Uli Heller" <uli.heller@daemons-point.com> writes:
>> > Nevertheless, I think it makes sense to fix the issue within the
>> > git perl module Ra.pm, too. The change frees the private copy of
>> > the remote access object on termination which prevents the error
>> > from happening.
>
>> Thanks.  Please sign-off your patch.
>> 
>> I am Cc'ing Kyle McKay who apparently had some experience working
>> with git-svn with newer svn that can only use serf, hoping that we
>> can get an independent opinion/test just to be sure.  Also Cc'ed is
>> Eric Wong who has been the official git-svn area expert, but I
>> understand that Eric hasn't needed to use git-svn for quite a while,
>> so it is perfectly fine if he does not have any comment on this one.
>> 
>> We may want to find a volunteer to move "git svn" forward as a new
>> area expert (aka subsystem maintainer), by the way.
>
> Correct, git-svn has the effect of being self-obsoleting.
>
> I agree with adding a workaround for broken things, however
> I suggest a code comment explaining why it is necessary.
> The commit message is important, too, but might get harder to track
> down if there's code movement/refactoring in the future.

Thanks for a good suggestion.  I agree that this addition is a good
example where in-code comment would really help the future readers.

>
>> > +END {
>> > +	$RA = undef;
>> > +	$ra_invalid = 1;
>> > +}
