From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC/WIP PATCH] implement reading of submodule .gitmodules
 configuration into cache
Date: Thu, 12 Dec 2013 14:03:07 +0100
Message-ID: <20131212130307.GA6183@t2784.greatnet.de>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
 <5294BB97.7010707@web.de>
 <xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
 <9AB10474-6DEF-4FFD-B6B3-ED2AB21424AC@mac.com>
 <xmqqzjopsk9b.fsf@gitster.dls.corp.google.com>
 <20131129223845.GA31636@sandbox-ub>
 <3C71BC83-4DD0-43F8-9E36-88594CA63FC5@mac.com>
 <20131203183301.GB4629@sandbox-ub>
 <20131209205501.GC9606@sandbox-ub>
 <xmqqppp5vbn5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Townsend <nick.townsend@mac.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 14:03:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vr5vV-0001oH-1m
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 14:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab3LLNDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 08:03:33 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:48884 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab3LLNDc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 08:03:32 -0500
Received: from [83.133.105.219] (helo=t2784.greatnet.de)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vr5v6-0003pO-Fh; Thu, 12 Dec 2013 14:03:12 +0100
Content-Disposition: inline
In-Reply-To: <xmqqppp5vbn5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239226>

On Mon, Dec 09, 2013 at 03:37:50PM -0800, Junio C Hamano wrote:
> > +void submodule_config_cache_free(struct submodule_config_cache *cache)
> > +{
> > +	/* NOTE: its important to iterate over the name hash here
> > +	 * since paths might have multiple entries */
> 
> Style (multi-line comments).

Will fix.

> This is interesting.  I wonder what the practical consequence is to
> have a single submodule bound to the top-level tree more than once.
> Updating from one of the working tree will make the other working
> tree out of sync because the ultimate location of the submodule
> directory pointed at by the two .git gitdirs can only have a single
> HEAD, be it detached or on a branch, and a single index.

To clarify, when writing this comment I was not thinking about the same
submodule with multiple paths in the same tree but rather with the same
name under different paths in different commits.

> Not that the decision to enforce that names are unique in the
> top-level .gitmodules, and follow that decision in this part of the
> code to be defensive (not rely on the "one submodule can be bound
> only once to a top-level tree"), but shouldn't such a configuration
> to have a single submodule bound to more than one place in the
> top-level tree be forbidden?

Yes IMO, that should be forbidden currently. I do not think we actually
prevent the user from doing so but it can not happen by accident since
we derive the initial name from the local path. Maybe we should be more
strict about that and put more guards in place to avoid such
configurations from entering the database.

> > +	for_each_hash(&cache->for_name, free_one_submodule_config, NULL);
> > +	free_hash(&cache->for_path);
> > +	free_hash(&cache->for_name);
> > +}
> > +
> > +static unsigned int hash_sha1_string(const unsigned char *sha1, const char *string)
> > +{
> > +	int c;
> > +	unsigned int hash, string_hash = 5381;
> > +	memcpy(&hash, sha1, sizeof(hash));
> > +
> > +	/* djb2 hash */
> > +	while ((c = *string++))
> > +		string_hash = ((string_hash << 5) + hash) + c; /* hash * 33 + c */
> 
> Hmm, the comment and the code does not seem to match in math here...

Yeah sorry that was a leftover from the code I started with. In the
beginning it was a pure string hash. Will remove both comments (since
its also not a pure djb2 hash anymore).

Cheers Heiko
