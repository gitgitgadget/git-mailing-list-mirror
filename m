From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH] revision-walking: allow iterating revisions multiple
 times
Date: Wed, 24 Aug 2011 14:44:38 -0700
Message-ID: <7vhb56o56h.fsf@alter.siamese.dyndns.org>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-2-git-send-email-iveqy@iveqy.com>
 <7vwre9yodc.fsf@alter.siamese.dyndns.org>
 <7vippszj70.fsf@alter.siamese.dyndns.org>
 <7vmxf3xnsf.fsf@alter.siamese.dyndns.org> <20110822194728.GA11745@sandbox-rc>
 <7vd3fxulw8.fsf@alter.siamese.dyndns.org>
 <20110824211431.GH45292@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 23:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwLFh-0004uL-KM
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 23:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab1HXVoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 17:44:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab1HXVon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 17:44:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A03C4E2E;
	Wed, 24 Aug 2011 17:44:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3TqIcqq2xBWkyXzdrRlDPJWUodc=; b=YKlTdO
	ZGufDSNUHzNYOiUPSxLdCe8vCON7UD2RyA8QG2GoF+Yo6lfi9Nuiic5RG+dc9ZoY
	eQi/YREpAzoWeWI3fwu4CnU9wraT9dwm9IckdYEwCEWcVRra3CGEArjzU+y+R8yP
	nxqQ6rTJcFnIwSUbb6MLFG51s+JvQ3duzdx/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=via8w9NZrF1NRyjHeLdJWLBDIVxqITmv
	/NRbdiJPZ3UK39xA27yrTss0v8rBFm9Co1/2hoUHMgAFoehGXXhEL+tsC8fsH+qE
	PLii950m3Xywopk21dg7Lhpchmbz8jOc4ksFPii/lvc5Bs6zy1YuaZmTDwWivWMd
	SK0ePj0Zgwo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 410FB4E2C;
	Wed, 24 Aug 2011 17:44:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97C764E29; Wed, 24 Aug 2011
 17:44:40 -0400 (EDT)
In-Reply-To: <20110824211431.GH45292@book.hvoigt.net> (Heiko Voigt's message
 of "Wed, 24 Aug 2011 23:14:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 456F5DAC-CE9A-11E0-8B13-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180046>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> +void reset_revision_walk(struct rev_info *revs)
> +{
> +	int nr = revs->walked.nr;
> +	struct object_array_entry *e = revs->walked.objects;
> +
> +	/* reset the seen flags set by prepare_revision_walk */
> +	while (--nr >= 0) {
> +		struct object *o = e->item;
> +		o->flags &= ~(ALL_REV_FLAGS);
> +		e++;
> +	}
> +	free(revs->walked.objects);
> +	revs->walked.nr = 0;
> +	revs->walked.alloc = 0;
> +	revs->walked.objects = NULL;
> +}

I am afraid that this is not good enough for general purpose.  The object
you walk in the middle of doing something may have been marked for reasons
other than your extra walking before you started your walk. Imagine

 * The command takes arguments like rev-list does;

 * It calls setup_revisions(), which marks commits given from the command
   line with marks like UNINTERESTING, and then prepare_revision_walk();

 * It walks the commit graph and does interesting things on commits that
   it discovers, by repeatedly calling get_revision(), e.g.:

   	while ((commit = get_revision()) != NULL) {
		do_something_interesting(commit);
        }

Now, you add a new caller that walks the commit graph for a different
reason from the primary revision walking done by the command somewhere
down in the callchain of do_something_interesting()---obviously you cannot
use the above reset_revision_walk() to clean things up, as it will break
the outer revision walk.

If on the other hand you will _never_ have more than one revision walk
going on, it may amount to the same thing to iterate over the object array
and clear all the flags.

Traditionally the way to do nested revision walk that can potentially be
done more than once (but never having such a sub-walk in parallel) was to
remember the start points of the subwalk, use private marks that are not
used in the outer walk during the subwalk, and call clear_commit_marks()
on these start points when a subwalk is done to clear only the marks the
subwalk used.
