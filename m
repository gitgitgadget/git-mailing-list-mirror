From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] bundle: keep around names passed to
 add_pending_object()
Date: Thu, 01 Mar 2012 14:05:13 -0800
Message-ID: <7vehtckmee.fsf@alter.siamese.dyndns.org>
References: <cover.1330637923.git.trast@student.ethz.ch>
 <6fba13f255f76481dc9098b5e8fbb33bd10735cb.1330637923.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3E7o-0005gz-Ru
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 23:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915Ab2CAWFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 17:05:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528Ab2CAWFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 17:05:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48B137E1D;
	Thu,  1 Mar 2012 17:05:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rnCQ2yeC9mX6sDkyWmGEEyaEoR0=; b=QIt85M
	ZlseNkbtV6BULlVAGH4YaH0jlBqRAP78XRfe8Cw/DpQTDaW4vRWgWfpk2CbjzKyV
	qlTqpWsCPbvRsNPpH7O/XbEwfmF1eVNFKOGT3NWlPQVio+xqJlEQq1TVZWxDRPEi
	GiKVKpPdv35X9VPceedpwT5o0ISCL9vEoIhxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=THNpK9rl9r3gsrxL3cubVLtBcu497Ziq
	TlZ/aDNswsuZ+NwW0MFM0VSqdd28xUdiDWNTl66srTKmtM86qftuNtAvyWXmoO3S
	iKRsQSTr8G8GTOzzFp4stOV53tKQHfYOSiBhR9n1496J1t5Fep22QKXtBD2opgLb
	cEzk3wT986E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3690D7E1B;
	Thu,  1 Mar 2012 17:05:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EA287E18; Thu,  1 Mar 2012
 17:05:14 -0500 (EST)
In-Reply-To: <6fba13f255f76481dc9098b5e8fbb33bd10735cb.1330637923.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 1 Mar 2012 22:40:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F6B8F16-63EA-11E1-A497-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191981>

Thomas Rast <trast@student.ethz.ch> writes:

> The 'name' field passed to add_pending_object() is used to later
> deduplicate in object_array_remove_duplicates().
>
> git-bundle had a bug in this area since 18449ab (git-bundle: avoid
> packing objects which are in the prerequisites, 2007-03-08): it passed
> the name of each boundary object in a static buffer.  In other words,
> all that object_array_remove_duplicates() saw was the name of the
> *last* added boundary object.

Ouch.

> diff --git a/bundle.c b/bundle.c
> index 7a760db..d9cfd90 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -273,7 +273,7 @@ int create_bundle(struct bundle_header *header, const char *path,
>  			if (!get_sha1_hex(buf.buf + 1, sha1)) {
>  				struct object *object = parse_object(sha1);
>  				object->flags |= UNINTERESTING;
> -				add_pending_object(&revs, object, buf.buf);
> +				add_pending_object(&revs, object, xstrdup(buf.buf));

We'll release &buf after the loop but the elements in the pending object
array will keep their own copies, so now we would be safe.

Thanks for fixing this.
