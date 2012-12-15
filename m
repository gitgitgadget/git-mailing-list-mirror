From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: detect when PYTHON_PATH changes
Date: Sat, 15 Dec 2012 09:29:48 -0800
Message-ID: <7vehirustv.fsf@alter.siamese.dyndns.org>
References: <20121215140719.2409.27365.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 18:30:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjvYv-0005at-NU
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 18:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab2LOR3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 12:29:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab2LOR3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 12:29:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A803E942E;
	Sat, 15 Dec 2012 12:29:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g2vauAts0XaiadER93ZQ+flxTsI=; b=Au2cn8
	7KCsR2Z+rHUBvf1jlqrthCBeWk+rONV4gfyZtdE/z/MwJ3RFmM9mYvYunJcQyEGm
	r2N1VtYSeV5jwC7Ip3UAA5BmqekPNcVCw6vUaT98JwGnrh7B1B5OP4MZvb19tEjh
	3DJ0XR35Ir9RHyEHMJGtfhBIR+WNKhSyP2M/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DWMId0rGpvpKY4GGYImBMl7WQI5qrR8E
	bm3eo0DmYsfsxDM7gB0efGa/FEooC52TJM062R6PnWM9njQM3Ho17wMrPZOBOtFU
	hkqm7lpD+jB8ppOKngxANnS+gAI7H065dCJyxN1My9sa0cU0R4x6QnFSlbHZYwgu
	+8QgGDnxyrU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 913C4942D;
	Sat, 15 Dec 2012 12:29:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2226942B; Sat, 15 Dec 2012
 12:29:49 -0500 (EST)
In-Reply-To: <20121215140719.2409.27365.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat, 15 Dec 2012 15:07:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 076028D6-46DD-11E2-98C2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211535>

Christian Couder <chriscool@tuxfamily.org> writes:

> @@ -2636,6 +2636,18 @@ GIT-GUI-VARS: FORCE
>              fi
>  endif
>  
> +### Detect Python interpreter path changes
> +ifndef NO_PYTHON
> +TRACK_VARS = $(subst ','\'',-DPYTHON_PATH='$(PYTHON_PATH_SQ)')
> +
> +GIT-PYTHON-VARS: FORCE
> +	@VARS='$(TRACK_VARS)'; \
> +	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
> +		echo 1>&2 "    * new Python interpreter location"; \
> +		echo "$$VARS" >$@; \
> +            fi
> +endif

Do we have the same issue when you decide to use /usr/local/bin/sh
after building with /bin/sh set to SHELL_PATH?

 - If yes, I presume that there will be follow-up patches to this
   one, for SHELL_PATH, PERL_PATH, and TCLTK_PATH (there may be
   other languages but I didn't bother to check).  How would the use
   of language agnostic looking TRACK_VARS variable in this patch
   affect such follow-up patches?

 - If no (in other words, if we rebuild shell-scripted porcelains
   when SHELL_PATH changes), wouldn't it be better to see how it is
   done and hook into the same mechanism?

 - If no, and if the approach taken in this patch is better than the
   one used to rebuild shell scripts (it may limit the scope of
   rebuilding when path changes, or something, but again, I didn't
   bother to check), then again follow-up patches to this one to
   describe dependencies to build scripts in other languages in a
   similar way to this patch would come in the future.  The same
   question regarding TRACK_VARS applies in this case.

By the way, "1>&2" is easier to read if written as just ">&2", I
think.

Thanks.
