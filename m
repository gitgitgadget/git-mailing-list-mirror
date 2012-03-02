From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] build: avoid possible confusion between GNU/XPG4
 make on Solaris
Date: Fri, 02 Mar 2012 10:35:39 -0800
Message-ID: <7vhay6etqc.fsf@alter.siamese.dyndns.org>
References: <df98ed215324f521f3aaff7fa4ba41ba2a1894dc.1330679536.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 19:35:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3XKX-0004PO-FA
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 19:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758087Ab2CBSfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 13:35:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756754Ab2CBSfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 13:35:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0D41636A;
	Fri,  2 Mar 2012 13:35:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RgNkgz4OtN8JivMuB/QsqjaI3d4=; b=bUQD8p
	tvY8irpFDrRyc2sn7yJFRmSE8lQQ54QOUS4VvIYDTfBDmsFsU6wqpblpTN4eSkem
	ul3umUW7qEz8GHst+c+f8fS4azh20KmU67AqExZ0UBFfFwzMmZKsGtuLJO4mdPwL
	jjKXvLYjDPi1gOFY/A9j7tenovZAvlq1rrFDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SOdlX7DsdWvwS1t/wUHGagMTqwYIBXtV
	K63PoWiEro/Yqs14gzxHFf2G56xg83CsJ78ffM+/NbjvyuWlIGcLTumBiT5EEhch
	AJpu82X7gGTPc+gImfqCQJOVZZeHIVCaa4+CCEsFra/bcAQy9p9oVIeWPzf9A3dJ
	PQCkAV0WMkk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B90536369;
	Fri,  2 Mar 2012 13:35:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8E3F6368; Fri,  2 Mar 2012
 13:35:40 -0500 (EST)
In-Reply-To: <df98ed215324f521f3aaff7fa4ba41ba2a1894dc.1330679536.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Fri, 2 Mar 2012 10:13:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 834995B0-6496-11E1-9FAE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192056>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On a Solaris 10 system with Solaris XPG4 make installed as /usr/xpg4/bin/make,
> GNU make installed as /usr/local/bin/make, and with /usr/local/bin appearing
> in $PATH *before* /usr/xpg4/bin, I was seeing errors like this upon invoking
> "make all":

After reading this explanation, my first reaction is that the prefixing of
path _is_ what is wrong.  The prefixing is done to help a subset of
Solaris users who are unaware of /usr/xpg4/bin that are more POSIX than
what they have in /usr/bin, and that is what is hurting people like you
who know what you are doing and have suitable tools in other places, like
you do in /usr/local/bin.

And the real fix for your problem is _not_ an ugly override of $(MAKE)
like you do in this patch, I think.  After all, somebody else who have a
tool in /usr/local/bin that is saner than what is in /usr/xpg4/bin may
suffer from the same issue for commands other than "make".

So the real solution would probably be to let you override how the
BROKEN_PATH_FIX works, no?

Ah... and I think we already have such a solution in our Makefile.  Can't
you override SANE_TOOL_PATH in your config.mak instead?

> +# This Makefile will possibly sanitize PATH by prepending system-specific
> +# directories to it (e.g., /usr/xpg4/bin on Solaris).  This can become
> +# problematic for recursive make invocations, if one of those directories
> +# contains a "make" program and the user has called GNU make by simply
> +# invoking "make" (this can happen e.g. when GNU make has been installed
> +# as /usr/local/bin/make).  To avoid such issues, we redefine $(MAKE) to
> +# point to the absolute path of the originally-invoked make program.
> +# FIXME: this is ugly, and which(1) is quite unportable.  Find a better
> +# 	 way to obtain the same effect.
> +MAKE := $(shell set $(MAKE); m1=$$1; shift; \
> +                m2=`which $$m1 2>/dev/null` && test -n "$$m2" || m2=$$m1; \
> +                echo "$$m2 $$*")
> +
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>  
>  CFLAGS = -g -O2 -Wall
