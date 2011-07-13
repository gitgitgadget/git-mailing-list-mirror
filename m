From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2 2/6] add metadata-cache infrastructure
Date: Wed, 13 Jul 2011 12:33:24 -0700
Message-ID: <7vipr66kmz.fsf@alter.siamese.dyndns.org>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070405.GB18566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 21:33:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh5Bd-0005Uv-EV
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 21:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072Ab1GMTd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 15:33:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab1GMTd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 15:33:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EF585E7E;
	Wed, 13 Jul 2011 15:33:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BppFyLfRBF/4UiwOrw6LFVV755c=; b=LDAzDM
	pmp4sMOcMRttDR6+GWcEVqtUNUzi6qegO+0p3kLmWKXrPVsy2iljsmrxuTz7lfOC
	eLfZO1E+/Zhn0mPu51l1gCutsIikNamqzXX9T2kLSTEG/8dHu12oq/R/t4b1x6qN
	3LOqPrPsChrnfIKRgd4tw+WSg3pM6vCac5vws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f3TNrftgo9U8BFrTuhgoiXadfhPfXK7Y
	fHtgYpqvMRBA2pvJMwJVHjNtKdFtdnyCPBmkux7McKVoRGGm2z00FxLTnaVX53NJ
	JGoUqS6zdISLlzI3JtDWqh7PV/4Souz/EdYT1gIW2/FpWtSJJ35I9ixfnC/e5Bs6
	2hT/qUM6hl8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26EEB5E7D;
	Wed, 13 Jul 2011 15:33:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5D74F5E7C; Wed, 13 Jul 2011
 15:33:26 -0400 (EDT)
In-Reply-To: <20110713070405.GB18566@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 13 Jul 2011 03:04:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAB27DF0-AD86-11E0-BA47-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177071>

Jeff King <peff@peff.net> writes:

> +`metadata_cache_lookup_uint32`::
> +`metadata_cache_add_uint32`::

I think these are "uint31" functions, as you cannot signal missing entry
by returning a value with the MSB set if higher-end of uint32 range can be
a valid value.

> +	if (c->validity_fun) {
> +		c->validity_fun(validity);
> +		if (hashcmp(validity, p))
> +			return NULL;
> +	}

Two comments.

 - I would have expected that c->validity_check() would be a way for a
   caller to implement a boolean function to check the validity of the
   cache, with another hook c->validity_token() to generate/update the
   token. I could then use the 20-byte space to store a timestamp and
   check can say "It was still 3-days ago? fresh enough", or something
   like that. But this is not a complaint--such a scheme I wrote in the
   above four lines may be _too_ flexible to be useful.

 - I wonder if validity_fn() callback wants a callback parameter (the
   pointer "c" itself, after adding an extra field to metadata_cache that
   stores the callback parameter pointer of type "void *" and adding a
   parameter to METADATA_CACHE_INIT() macro to initialize it).

Other than that, this is looking fun ;-)
