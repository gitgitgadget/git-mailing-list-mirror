From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 14:54:25 -0700
Message-ID: <xmqqmwcf36jy.fsf@gitster.dls.corp.google.com>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
	<1405099447-27555-3-git-send-email-jacob.e.keller@intel.com>
	<20140711174628.GC7856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:54:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5im5-0004lJ-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 23:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbaGKVye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 17:54:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57921 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbaGKVyd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 17:54:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF54427AAD;
	Fri, 11 Jul 2014 17:54:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vjJWVt1M6gJcHh5WyZaOVgooPmI=; b=mA9D4Z
	FEnexm6xoihKmOBNNDCE2TDDXAe4MFLXq95ZZGFK/gnztkOcM9Alzf3OfM7BAF/f
	xrQ6lv/no0u79aO7DrTk70gFwq4xrGK3J1JkImObfr1w/iSuHdoYkC2pg1qytqBH
	giAJ9iUdFImz1skVhgb6kDvElXAzkwQSOD6kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BcFlkhN1/Qnn7btMa+VKF4RxkgOXeM8L
	B7i3XGZf+5cvy4DOSjxcCrQYhpHracdM8IViUn7/v+CRYPzhVfuyE7cfQb9RVVWp
	JfYLpTcghobvFcsTHLmPi8YgTv1Pb/ufRc/feDE6E2kBdu5WmcfC3D2oan1yNxZL
	RH/0QVWEuhk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E655227AAC;
	Fri, 11 Jul 2014 17:54:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7606E27AA2;
	Fri, 11 Jul 2014 17:54:11 -0400 (EDT)
In-Reply-To: <20140711174628.GC7856@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 11 Jul 2014 13:46:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E4431A98-0945-11E4-8083-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253331>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 11, 2014 at 10:24:07AM -0700, Jacob Keller wrote:
>
>> Updated to include changes due to Junio's feedback. This has not resolved
>> whether we should fail on a configuration error or simply warn. It appears that
>> we actually seem to error out more than warn, so I am unsure what the correct
>> action is here.
>
> Yeah, we're quite inconsistent there. In some cases we silently ignore
> something unknown (e.g., a color.diff.* slot that we do not understand),
> but in most cases if it is a config key we understand but a value we do
> not, we complain and die.

Hm, that's bad---we've become less and less careful over time,
perhaps?

As we want to be able to enhance semantics of existing configuration
variables without having to introduce new but similar ones, we would
really want to make sure that those who share the same .git/config
or $HOME/.gitconfig across different versions of Git would not have
to suffer too much (i.e. forcing them to "config --unset" when using
their older Git is not nice).

> It's probably user-unfriendly to be silent for those cases, though. The
> user gets no feedback on why their config value is doing nothing.
>
> I tend to think that warning is not much better than erroring out. It is
> helpful if you are running a single-shot of an old version (which is
> something that I do a lot when testing old versions), but would quickly
> become irritating if you were actually using an old version of git
> day-to-day.
>
> I dunno. Maybe it is worth making life easier for people in the former
> category.

... "former cat" meaning "less irritating for single-shot use"?  I
dunno...

>> +static int parse_sort_string(const char *arg, int *sort)
>> +{
>> +	int type = 0, flags = 0;
>> +
>> +	if (skip_prefix(arg, "-", &arg))
>> +		flags |= REVERSE_SORT;
>> +
>> +	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
>> +		type = VERCMP_SORT;
>> +	else
>> +		type = STRCMP_SORT;
>> +
>> +	if (strcmp(arg, "refname"))
>> +		return error(_("unsupported sort specification %s"), arg);
>> +
>> +	*sort = (type | flags);
>> +
>> +	return 0;
>> +}
>
> Regardless of how we handle the error, I think this version that
> assembles the final bitfield at the end is easier to read than the
> original.

Yes, this part really is nicely done, I agree.
