From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-tree does not use alternate objects for submodules
Date: Wed, 09 May 2012 15:19:01 -0700
Message-ID: <7v1umtq9pm.fsf@alter.siamese.dyndns.org>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com>
 <7v1umuznuj.fsf@alter.siamese.dyndns.org>
 <20120509215815.GC74366@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu May 10 00:19:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSFE4-0005RD-BL
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 00:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562Ab2EIWTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 18:19:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932536Ab2EIWTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 18:19:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 758897E5D;
	Wed,  9 May 2012 18:19:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mCkJ3q3tsSHrsb9EY+pEN6oqiMU=; b=hcVT/s
	2cAJAx0rrajiSo+vXeMmLdrsbWZROu85WwRPuk8ADeetTcMYjBbwASpNs3O7AnXg
	G0UgAHYlsB6ac33ExyB1gI5BqbJV3M93eOLA2aa+NFfZ95XUjmopNmz89XB94QQh
	c00st42nDdFUghTvHJaRilS4CianmoRp1vGik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MC4Ogdc0+w1mAMVX7oyn5Ir2ENHc4lHe
	1OF9xKC8tmw3k8hYZvCi158F1M3K+RMcQzB7uGFNxToN4X9YB6atEBqRE4BMWV/L
	sq0Phy/2kHiTQ9BaABH6T4VbhjNOaHkniBBLDJ+0qJoTg7Wniz+JgsLcCuGmkUWS
	8lqwUzzXZgA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D84B7E5C;
	Wed,  9 May 2012 18:19:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 857F67E59; Wed,  9 May 2012
 18:19:02 -0400 (EDT)
In-Reply-To: <20120509215815.GC74366@book.hvoigt.net> (Heiko Voigt's message
 of "Wed, 9 May 2012 23:58:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB6EE3E2-9A24-11E1-A313-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197525>

Heiko Voigt <hvoigt@hvoigt.net> writes:
> On Tue, May 08, 2012 at 08:36:36AM -0700, Junio C Hamano wrote:
> ...
>> ... The code attempts to link the object store
>> of the submodule repository into the in-core representation of the object
>> store of the superproject (in submodule.c::add_submodule_odb()), but does
>> not do a good job of it.  It does not take alternates into account, and
>> who knows what else is missing.  Sigh...
>> 
>> The right approach to implement this feature would have been to fork a
>> child process and perform the submodule operation inside the child, which
>> will chdir into the submodule and treat as if it is a freestanding git
>> repository, without contaminating the superproject process.
>
> I will have a look if I can come up with something that reads the
> submodules alternate config and uses it. Do you have other config
> related things in mind that might be missing?

No, I do not, and that is exactly the point.

Making the process that works in the top-level superproject to imitate
what would happen if the processing happened inside the submodule is what
invited a bug like this.  Who knows what other discrepancies remain there.

If we forked a separate process, and made it to chdir to the submodule
tree, and had it do its usual thing there, we do not have to worry about
how good the imitation is, exactly because there won't be any imitation.
There will only be a git processing happening in the usual way inside the
submodule directory, as if the end user cd'ed there and typed the "git
status" command to see if the HEAD matches the given commit or if the
working tree is dirty.
