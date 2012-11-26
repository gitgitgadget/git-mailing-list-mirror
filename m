From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] makefile: hide stderr of curl-config test
Date: Mon, 26 Nov 2012 10:30:17 -0800
Message-ID: <7vsj7wrzd2.fsf@alter.siamese.dyndns.org>
References: <1353554397-27162-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 19:30:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td3S2-0006Fs-2i
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 19:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab2KZSaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 13:30:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323Ab2KZSaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 13:30:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F7DE93CE;
	Mon, 26 Nov 2012 13:30:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9zX0BcUIyuoeddeI4kZVqkr5ba8=; b=CDhuht
	KTPX/jPRZrPXYZcwQaI3jz6lAv/yGWm5FHUfL1UNWYOtdGfxd5UWHJ1Z5qOcyy71
	/MegnvRhwzVB+j1LTSr9dSgKWMEQwfJpMkVGd8bL/YK11Nx1uw6ck5+t7VGITjmI
	oorLc8q5I0qKovjV97HgH7jELKIXODYnMTCJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iZJ9HpSSvSHjBBWyneuf2QxySUtH5c+6
	KtksTC3/J8Dhr/QSeKINFupF5iELLJlw8uIwu6b7joDdHMWDKM++/FWJCIK1PgrY
	bJAZ/lVLBxihBYKop/yHC73PKKprRzudrmTMpcItyxgoO5KInTct0WB969HKIanO
	QW9ODsvaXrA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED65F93CD;
	Mon, 26 Nov 2012 13:30:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51AC493CC; Mon, 26 Nov 2012
 13:30:19 -0500 (EST)
In-Reply-To: <1353554397-27162-1-git-send-email-paul.gortmaker@windriver.com>
 (Paul Gortmaker's message of "Wed, 21 Nov 2012 22:19:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54C89B66-37F7-11E2-BBD3-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210466>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> Currently, if you don't have curl installed, you will get
>
>     $ make distclean 2>&1 | grep curl
>     /bin/sh: curl-config: not found
>     /bin/sh: curl-config: not found
>     /bin/sh: curl-config: not found
>     /bin/sh: curl-config: not found
>     /bin/sh: curl-config: not found
>     $
>
> The intent is not to alarm the user, but just to test if there is
> a new enough curl installed.  However, if you look at search engine
> suggested completions, the above "error" messages are confusing
> people into thinking curl is a hard requirement.

Good observation and identification of an issue to tackle.  But why
isn't the patch like this?

 	PROGRAMS += $(REMOTE_CURL_NAMES)
-	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
+	curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"

Removal of the "reject old libcURL" is logically a separate thing
regardless of the "alarming output from make", and it probably is
better done as a separate step in a two-patch series.  Doing things
that way, when somebody objects to this:

> It wants to ensure curl is newer than 070908.  The oldest
> machine I could find (RHEL 4.6) is 2007 vintage according
> to /proc/version data, and it has curl 070C01.

saying that their installation still cares about older libcURL, we
can still keep the "remove alarming output from make" bit.

>
> The failure here is to mask stderr in the test.  However, since
> the chance of curl being installed, but too old is essentially
> nil, lets just check for existence and drop the ancient version
> threshold check, if for no other reason, than to simplifly the
> parsing of what the makefile is trying to do by humans.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> diff --git a/Makefile b/Makefile
> index 9bc5e40..56f55f6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1573,8 +1573,8 @@ else
>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>  	PROGRAM_OBJS += http-fetch.o
>  	PROGRAMS += $(REMOTE_CURL_NAMES)
> -	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
> -	ifeq "$(curl_check)" "070908"
> +	curl_check := $(shell curl-config --vernum 2>/dev/null)
> +	ifneq "$(curl_check)" ""
>  		ifndef NO_EXPAT
>  			PROGRAM_OBJS += http-push.o
>  		endif
