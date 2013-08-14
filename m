From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git bug. "make [all]" does not use USE_LIBPCRE when "configure --with-libpcre" was previously run
Date: Wed, 14 Aug 2013 09:09:29 -0700
Message-ID: <7v38qcuudi.fsf@alter.siamese.dyndns.org>
References: <20130814124849.GA8234@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 18:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9ddh-00032o-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 18:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759554Ab3HNQJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 12:09:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757295Ab3HNQJc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 12:09:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD163363F4;
	Wed, 14 Aug 2013 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=If4uPIvYK6tkqUEGVlOjwQCP8Xc=; b=F1F05p
	/DC2uZnwXORZab27aoBJ7L38lJJEHxw7VDz1VGDYKZ8mc5Dr8ifOB/rElGM16EIK
	PgKVzTPZNYBywNGWxxhlQP1bGZr8lAnpw7U4Awu7f0Sj5fCyCWsbYTKBsuGPVnm/
	3bO3/iTflxUFuCN4/FOaQngJBIGPx+E76ngd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NsVY0KnBZddZxHjmPuvL7XqdRr1x9YE9
	+6k8iG6Od7YWjtnSOvSkk5SuXcTnPPSZLeH+V1S+0NYOvrc8j8VLYeYbqsdpZh5C
	5i1M/M7L/gMfBQTEsNIV7PpH8okt2TiUlZam8xrU3i0mzkuuBVRW8H+PVLmg76UF
	/UpHpxe4ce4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE648363F3;
	Wed, 14 Aug 2013 16:09:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4F5D363F0;
	Wed, 14 Aug 2013 16:09:30 +0000 (UTC)
In-Reply-To: <20130814124849.GA8234@ashu.dyn1.rarus.ru> (Alexey Shumkin's
	message of "Wed, 14 Aug 2013 16:48:49 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6F69F0C-04FB-11E3-BD62-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232290>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

>>From time to time, I use `git grep -P` to search text in sources using PCRE.
> Today I was suprised when that command gave me the error
>     "fatal: cannot use Perl-compatible regexes when not compiled with
>     USE_LIBPCRE"
>
> As far as I always use
>     ./configure --with-libpcre 
>     make all
> to build my Cygwin version of Git that was a VERY sudden error for me.
> (but this is not a Cygwin-specific error, I've reproduced it on my Linux
> box).
>
> I've found out that `make` "does not know" anymore about USE_LIBPCRE=YesPlease
> even `./configure --with-libpcre` was run before it.
> ...
> and `git bisect run` to find out where Git was broken.
> That gave me:
>
> ---8<---
> 40bfbde9da5c6cbc85f49a755f27162dc966fd89 is the first bad commit
> commit 40bfbde9da5c6cbc85f49a755f27162dc966fd89
> Author: Stefano Lattarini <stefano.lattarini@gmail.com>
> Date:   Tue Sep 11 17:45:30 2012 +0200
>
>     build: don't duplicate substitution of make variables
>     
>     Thanks to our 'GIT_CONF_SUBST' layer in configure.ac, a make variable 'VAR'
>     can be defined to a value 'VAL' at ./configure runtime in our build system
>     simply by using "GIT_CONF_SUBST([VAR], [VAL])" in configure.ac, rather than
>     having both to call "AC_SUBST([VAR], [VAL])" in configure.ac and adding the
>     'VAR = @VAR@' definition in config.mak.in.  Less duplication, less margin
>     for error, less possibility of confusion.
>     
>     While at it, fix some formatting issues in configure.ac that unnecessarily
>     obscured the code flow.
>     
>     Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> :100644 100644 802d34223a2859ee1341d94ee722d7939b7276aa 69d48382fe69b8699eb350949fff04975db923f8 M      config.mak.in
> :100644 100644 450bbe7f1020711b4af2ad6ea52d717651c30b0b da1f41f58871b2102a9ed5eaeff7df3c9623f4bd M      configure.ac
> bisect run success
>
> ---8<---
>
> I'm not a C programmer to fix that, so I ask you to.

Yikes and thanks for reporting.

This does not have anything to do with C, but is a breakage in our
autoconf script.  It appears that anything that is meant to be
appended at end via $config_appended_defs mechanism is missing from
the end result.

In fact, symbols whose explicit substitution the above patch
removes, e.g. CC_LD_DYNPATH, TCLTK_PATH, NEEDS_SSL_WITH_CRYPTO,
etc. are all missing.
