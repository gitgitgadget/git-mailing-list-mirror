From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Wed, 28 May 2014 14:24:07 -0700
Message-ID: <xmqq38ftd2bs.fsf@gitster.dls.corp.google.com>
References: <1401307055-11603-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 28 23:24:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WplKb-00082s-E3
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 23:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbaE1VYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 17:24:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53292 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbaE1VYN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 17:24:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B0BF91BB66;
	Wed, 28 May 2014 17:24:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cexx3KxGQ3Pd1quj3QItgX3PQX4=; b=QBtZ1l
	PYlfYfCWQj7+EAdBPRAAQhdhjIRp6mcwuQQg5t+zqyj73yEEtVOR8k1PQ08UYHw3
	sLUWr634zOlefTQc6vCib4+AA99Xvj2lCZaZ6AoTIYnLOnEnFuETV3lrBVH+c/ul
	UG93yyrgBhdxNENXphAs2U2WPd2HMknSDuycQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TcPhqpgd2CoTBfZgEJkJhX3lvrIe9QxX
	FKBXf6RALPSJUWef90+OxmoXuSJ9U6JxsHnXBGgLluRKJ6QOc3clnVSHORFVqIEZ
	c2mpSXBUjyLF3vwtP/GRgRPnCNgSsR1pWjyPaFEoDDZF7U2yynMt5tCouS0krIZF
	USug/AYyuDY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A55DE1BB63;
	Wed, 28 May 2014 17:24:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 561841BB56;
	Wed, 28 May 2014 17:24:09 -0400 (EDT)
In-Reply-To: <1401307055-11603-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Wed, 28 May 2014 15:57:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 67EEB34E-E6AE-11E3-BF1F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250331>

David Turner <dturner@twopensource.com> writes:

> In a repository with tens of thousands of refs, the command
> ~/git/git-diff-index --cached --quiet --ignore-submodules [revision]
> is a bit slow.  check_refname_component is a major contributor to the
> runtime.  Provide two optimized versions of this function: one for
> machines with SSE4.2, and one for machines without.  The speedup for
> this command on one particular repo (with about 60k refs) is about 12%
> for the SSE version and 8% for the non-SSE version.
>
> Signed-off-by: David Turner <dturner@twitter.com>

Just a few quick impressions (I do not have time today to look at
new patches).

 - The title seems a bit strange.
   Perhaps "refs.c: optimize check_refname_component()" or something?

 - "~/git/git-diff-index" looks doubly strange in that the issue you
   are addressing would not depend on your compiled Git being
   installed in your $HOME/git at all.  For that matter, from the
   command line and the patch, I am not sure if this is specific to
   "git diff-index", or the same issue exists for anything that
   takes revs and pathspecs from the command line.





> ---
>  Makefile           |   6 +++
>  configure.ac       |   6 +++
>  refs.c             | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  t/t5511-refspec.sh |  13 +++++
>  4 files changed, 163 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a53f3a8..123e2fc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1326,6 +1326,11 @@ else
>  		COMPAT_OBJS += compat/win32mmap.o
>  	endif
>  endif
> +ifdef NO_SSE
> +	BASIC_CFLAGS += -DNO_SSE
> +else
> +	BASIC_CFLAGS += -msse4
> +endif
>  ifdef OBJECT_CREATION_USES_RENAMES
>  	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
>  endif
> @@ -2199,6 +2204,7 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
>  	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
>  	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
> +	@echo NO_SSE=\''$(subst ','\'',$(subst ','\'',$(NO_SSE)))'\' >>$@
>  ifdef TEST_OUTPUT_DIRECTORY
>  	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@
>  endif
> diff --git a/configure.ac b/configure.ac
> index b711254..71a9429 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -382,6 +382,11 @@ AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),
>  GIT_PARSE_WITH(tcltk))
>  #
>  
> +# Declare the with-sse/without-sse options.
> +AC_ARG_WITH(sse,
> +AS_HELP_STRING([--with-sse],[use SSE instructions (default is YES)]),
> +GIT_PARSE_WITH(sse))
> +
>  
>  ## Checks for programs.
>  AC_MSG_NOTICE([CHECKS for programs])
> @@ -449,6 +454,7 @@ else
>    fi
>  fi
>  GIT_CONF_SUBST([TCLTK_PATH])
> +GIT_CONF_SUBST([NO_SSE])
>  AC_CHECK_PROGS(ASCIIDOC, [asciidoc])
>  if test -n "$ASCIIDOC"; then
>  	AC_MSG_CHECKING([for asciidoc version])
> diff --git a/refs.c b/refs.c
> index 28d5eca..8ca124c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -5,6 +5,8 @@
>  #include "dir.h"
>  #include "string-list.h"
>  
> +#include <nmmintrin.h>
> +

We would prefer not to add inclusion of any system header files in
random *.c files, as there often are system dependencies (order of
inclusion, definition of feature macros, etc.) we would rather want
to encapsulate in one place, that is git-compat-util.h.

>  /*
>   * Make sure "ref" is something reasonable to have under ".git/refs/";
>   * We do not like it if:
> @@ -29,30 +31,160 @@ static inline int bad_ref_char(int ch)
>  	return 0;
>  }
>  
> +char refname_disposition[] = {
> +       1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> ...
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
> +};
> +

Does this array need to be extern?

Is this table designed to take both positive and negative values?
If the answer is "I expect we add only positive", then please make
it explicitly "unsigned char".

What do these magic numbers in the array mean?

How were the values derived?  What are you doing in this commit to
help others who later need to debug, fix and enhance this table?
