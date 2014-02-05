From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/13] Makefile: teach scripts to include make variables
Date: Wed, 05 Feb 2014 11:26:58 -0800
Message-ID: <xmqqa9e54ayl.fsf@gitster.dls.corp.google.com>
References: <20140205174823.GA15070@sigill.intra.peff.net>
	<20140205180547.GL15218@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 20:27:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB87p-0005QK-3W
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 20:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbaBET1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 14:27:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbaBET1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 14:27:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F331367753;
	Wed,  5 Feb 2014 14:27:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AEDm1w/hDOy39sbA7SgwvM/V9AM=; b=wA2nov
	/8P/W21G/gB1PNZ5xz4NrSd6y1JH3B0uQ3sOA9kQ9lFiegobyfhwYVKW2Bog33yj
	RLjYbpgnwm/EGHnPUWh96w8QGpoK6yb42KzPlv4OZUwXPOWhdfGpFagUNlFdnCji
	gKcM0VIAY3I5a+ODmX/u0ZDjMQWnu4zLYP3HE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A5QBUS+C4fxV2SyxA/vdKafzAXmH3x0A
	n/bx4am69gN6YxP+O4jCiUA3eVsLLehoq/45z23umiFxd24/+mkTW8S/VK7tsV5T
	+mMwhQyxBL/2LBM3pYTEXQnSkWRStYY5TtHyEDCfSP8bhoGbifrKeYI/TACiaXF/
	URbpGa2PCPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A55E167751;
	Wed,  5 Feb 2014 14:27:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 654916774B;
	Wed,  5 Feb 2014 14:27:00 -0500 (EST)
In-Reply-To: <20140205180547.GL15218@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 13:05:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7C1794F0-8E9B-11E3-9DE4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241646>

Jeff King <peff@peff.net> writes:

>  define cmd_munge_script
>  $(RM) $@ $@+ && \
> +{ \
> +includes="$(filter MAKE/%.sh,$^)"; \
> +if ! test -z "$$includes"; then \
> +	cat $$includes; \
> +fi && \
>  sed -e '1s|#!.*/sh|#!$(call sqi,$(SHELL_PATH))|' \
>      -e 's|@SHELL_PATH@|$(call sqi,$(SHELL_PATH))|' \
> -    -e 's|@@DIFF@@|$(call sqi,$(DIFF))|' \
>      -e 's|@@LOCALEDIR@@|$(call sqi,$(localedir))|g' \
>      -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
>      -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
>      -e $(BROKEN_PATH_FIX) \
>      -e 's|@@GITWEBDIR@@|$(call sqi,$(gitwebdir))|g' \
>      -e 's|@@PERL@@|$(call sqi,$(PERL_PATH))|g' \
> -    $@.sh >$@+
> +    $@.sh; \
> +} >$@+
>  endef

Sorry, but I am not quite sure what is going on here.

 - if $includes does not exist, cat $includes will barf but that is
   OK;

 - if $includes is empty, there is no point running cat so that is
   OK;

 - if $includes is not empty, we want to cat.

And then after emitting that piece, we start processing the *.sh
source file, replacing she-bang line?

> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index fffa3c7..627d289 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -285,7 +285,7 @@ clear_local_git_env() {
>  # remove lines from $1 that are not in $2, leaving only common lines.
>  create_virtual_base() {
>  	sz0=$(wc -c <"$1")
> -	@@DIFF@@ -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
> +	$MAKE_DIFF -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
>  	sz1=$(wc -c <"$1")

This would mean that after this mechanism is extensively employed
throughout our codebase, any random environment variable the user
has whose name happens to begin with "MAKE_" will interfere with us
(rather, we will override such a variable while we run).  Having to
carve out our own namespace in such a way is OK, but we would want
to see that namespace somewhat related to the name of our project,
not to the name of somebody else's like "make", no?

>  
>  	# If we do not have enough common material, it is not
> diff --git a/script/mksh b/script/mksh
> new file mode 100644
> index 0000000..d41e77a
> --- /dev/null
> +++ b/script/mksh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +
> +name=$1; shift
> +printf "MAKE_%s='%s'\n" "$name" "$(sed "s/'/'\\''/g")"
