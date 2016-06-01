From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 01 Jun 2016 12:45:11 -0700
Message-ID: <xmqqinxsy9q0.fsf@gitster.mtv.corp.google.com>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
	<xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
	<xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
	<20160601163747.GA10721@sigill.intra.peff.net>
	<20160601183100.GN1355@john.keeping.me.uk>
	<20160601190759.GB12496@sigill.intra.peff.net>
	<20160601191621.GO1355@john.keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:45:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8C5I-0008FS-1O
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 21:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbcFATpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 15:45:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750720AbcFATpP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 15:45:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A02DF1F973;
	Wed,  1 Jun 2016 15:45:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Up86bX2YyECQZE9TNg2b/qWjKu4=; b=svhAmt
	fh7U8cdVhxYZ4m9agGDf1hNv3Z3JTz02Doz6iWfM4arUqZAXVIeDh6wG2DI/QgCb
	MJ/fQz0e449w+gK2Eb/zJzwcbQIAc5ABCh5J/qQGVfeTy2y+BWuFQWyWyrWtVB9x
	ocmi0CJFPh7/33o88SN7R6fh+2xrsk9IgXGxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A8hfYoFdxgGCS3sTYxaVrlvLRCEPAX/9
	5GnRiMDIe7t4EfXhuaNg91oJGqYepCbY9x+117sveqCLLP3q3+t2yiTzIuKckHcV
	jfjCIAHP9xvLSkNTIMHLeazjBh3Prt9KfOl+Q/xUXU4Tp/gxFz/JhuQbJ8227MWn
	palXyjkq34c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 96E021F971;
	Wed,  1 Jun 2016 15:45:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 206C01F96D;
	Wed,  1 Jun 2016 15:45:13 -0400 (EDT)
In-Reply-To: <20160601191621.GO1355@john.keeping.me.uk> (John Keeping's
	message of "Wed, 1 Jun 2016 20:16:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B499020-2831-11E6-915D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296153>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Jun 01, 2016 at 03:07:59PM -0400, Jeff King wrote:
>> On Wed, Jun 01, 2016 at 07:31:00PM +0100, John Keeping wrote:
>> 
>> > > >  reset_submodule_urls () {
>> > > > -	local root
>> > > > -	root=$(pwd) &&
>> > > >  	(
>> > > > +		root=$(pwd) &&
>> > > >  		cd super-clone/submodule &&
>> > > >  		git config remote.origin.url "$root/submodule"
>> > > >  	) &&
>> > > >  	(
>> > > > +		root=$(pwd) &&
>> > > >  		cd super-clone/submodule/sub-submodule &&
>> > > >  		git config remote.origin.url "$root/submodule"
>> > [...]
>> > I wonder if it's relevant that the "local root" line isn't &&-chained?
>> > Is it possible that on some shells we ignore an error but everything
>> > still works?
>> 
>> I don't think so. We're inside a function, so we wouldn't affect any
>> outer &&-chaining in the function (and there isn't any in the caller
>> anyway). I think it's a reasonable custom not to bother &&-chaining
>> "local" lines, as they come at the top of a function and can't fail.
>
> Can't fail if the shell supports "local", but if we're in a shell that
> doesn't support it, then the lack of "&&" may allow us to just carry on.

True, but if "to just carry on" were a correct behaviour, then
wouldn't that mean that "local" was unnecessary, i.e. the variable
did not have to get localized because stomping on the global name
would not affect later reference to the same variable made by the
caller?

If the clobbering of a global variable breaks the behaviour of the
script, wouldn't we rather want to catch that fact?

So either way, I do not think "local variable names" that breaks
&&-chain can be justified.  Either the variable must be localized
for the script to work correctly, in which case we want local with
&&-chaining, or it does not have to, in which case we do not want to
have "local" that is not necessary, no?
