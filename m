From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH] implement reading of submodule .gitmodules configuration into cache
Date: Mon, 09 Dec 2013 15:37:50 -0800
Message-ID: <xmqqppp5vbn5.fsf@gitster.dls.corp.google.com>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
	<5294BB97.7010707@web.de>
	<xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
	<9AB10474-6DEF-4FFD-B6B3-ED2AB21424AC@mac.com>
	<xmqqzjopsk9b.fsf@gitster.dls.corp.google.com>
	<20131129223845.GA31636@sandbox-ub>
	<3C71BC83-4DD0-43F8-9E36-88594CA63FC5@mac.com>
	<20131203183301.GB4629@sandbox-ub> <20131209205501.GC9606@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Townsend <nick.townsend@mac.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Dec 10 00:38:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqAOn-0007qt-Ow
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 00:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004Ab3LIXh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 18:37:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab3LIXh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 18:37:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8EF059064;
	Mon,  9 Dec 2013 18:37:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+HEhyDVDamFK4yilwZapSGuSBww=; b=m3xv/F
	riRb3zW7Cl8p2Ammgg/DsZGMuQJJb1viN4wLTY5mAQ72e8/geLhSnyhUFqvRvsID
	CKb/5rdrSL2fccWr0fX5+DLUkOmuapsBKJw0UCVbKNNEYoeUT/xH0khXp2QaxqHs
	4Mg07Ky5CwflYJexLwwwAsJI+rTq5W0ZFnSrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=moocoeLjCHbP7YG3SPigG+LESoN/CEgy
	wsqPN16tI0TA1K1RbhSfhGA0c4NHzKg8GoW1qrPCVOtF3bUfgXZVza3NTWCEuz3c
	3WIRUk+6kfPVwqaLlTNxO4Epw5RSf2S15/j9xtJwr8DMQERSygRQ+APXnfnilctu
	R3BDk8UkAfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EA5C59063;
	Mon,  9 Dec 2013 18:37:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C427C5905F;
	Mon,  9 Dec 2013 18:37:54 -0500 (EST)
In-Reply-To: <20131209205501.GC9606@sandbox-ub> (Heiko Voigt's message of
	"Mon, 9 Dec 2013 21:55:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED3FD35C-612A-11E3-B48E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239121>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> This submodule configuration cache allows us to lazily read .gitmodules
> configurations by commit into a runtime cache which can then be used to
> easily lookup values from it. Currently only the values for path or name
> are stored but it can be extended for any value needed.
> ...

Thanks.

> diff --git a/submodule-config-cache.c b/submodule-config-cache.c
> new file mode 100644
> index 0000000..7253fad
> --- /dev/null
> +++ b/submodule-config-cache.c
> @@ -0,0 +1,96 @@
> +#include "cache.h"
> +#include "submodule-config-cache.h"
> +#include "strbuf.h"
> +#include "hash.h"
> +
> +void submodule_config_cache_init(struct submodule_config_cache *cache)
> +{
> +	init_hash(&cache->for_name);
> +	init_hash(&cache->for_path);
> +}
> +
> +static int free_one_submodule_config(void *ptr, void *data)
> +{
> +	struct submodule_config *entry = ptr;
> +
> +	strbuf_release(&entry->path);
> +	strbuf_release(&entry->name);
> +	free(entry);
> +
> +	return 0;
> +}
> +
> +void submodule_config_cache_free(struct submodule_config_cache *cache)
> +{
> +	/* NOTE: its important to iterate over the name hash here
> +	 * since paths might have multiple entries */

Style (multi-line comments).

This is interesting.  I wonder what the practical consequence is to
have a single submodule bound to the top-level tree more than once.
Updating from one of the working tree will make the other working
tree out of sync because the ultimate location of the submodule
directory pointed at by the two .git gitdirs can only have a single
HEAD, be it detached or on a branch, and a single index.

Not that the decision to enforce that names are unique in the
top-level .gitmodules, and follow that decision in this part of the
code to be defensive (not rely on the "one submodule can be bound
only once to a top-level tree"), but shouldn't such a configuration
to have a single submodule bound to more than one place in the
top-level tree be forbidden?

> +	for_each_hash(&cache->for_name, free_one_submodule_config, NULL);
> +	free_hash(&cache->for_path);
> +	free_hash(&cache->for_name);
> +}
> +
> +static unsigned int hash_sha1_string(const unsigned char *sha1, const char *string)
> +{
> +	int c;
> +	unsigned int hash, string_hash = 5381;
> +	memcpy(&hash, sha1, sizeof(hash));
> +
> +	/* djb2 hash */
> +	while ((c = *string++))
> +		string_hash = ((string_hash << 5) + hash) + c; /* hash * 33 + c */

Hmm, the comment and the code does not seem to match in math here...
