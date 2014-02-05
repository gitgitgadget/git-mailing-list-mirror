From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/13] Makefile: add c-quote helper function
Date: Wed, 05 Feb 2014 11:13:24 -0800
Message-ID: <xmqqmwi54bl7.fsf@gitster.dls.corp.google.com>
References: <20140205174823.GA15070@sigill.intra.peff.net>
	<20140205175809.GI15218@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 20:13:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB7um-0005XS-50
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 20:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbaBETNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 14:13:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbaBETNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 14:13:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1988269E74;
	Wed,  5 Feb 2014 14:13:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o6X4fhjzqAWFlU5D+iUIU/bqZ+w=; b=vfXyRA
	ABYiHdgjmtxDxJ+pJQEc0AMroKRMTMu5u0+17tqb7Hq7qFoYhFb+HIj4lUfzBCh6
	rSwhJOOMl1Th87qs6pwpCdtq2Pwm01S0Q5nTSd8q4cJ8Gee4sT53YI3X5zOjIgNe
	qNH/9KFpfrbWJ8oXpH9g+SY2p0naTQ5IcPXp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uQHbQaGtRKrameCEAFIHX+2W17E9Ei+K
	YxYIACa+lMPhpM0K6ByP9vg8liuEy7O0cH/FG+g1Ao7uiH2uVDTvcXup78Tq74d6
	d1xHSp4UT7bghqiTHAn+wnH6nNW4lZIN+RmvsMGV0x0FtQM6eZgqwjmpZWgF1ob5
	B9zRqiKyCMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7A7669E72;
	Wed,  5 Feb 2014 14:13:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0561269E5E;
	Wed,  5 Feb 2014 14:13:25 -0500 (EST)
In-Reply-To: <20140205175809.GI15218@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 12:58:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 96ACF8B6-8E99-11E3-99D6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241639>

Jeff King <peff@peff.net> writes:

> We have to c-quote strings coming from Makefile variables
> when we pass them to the compiler via "-D". Now that we can
> use $(call) in our Makefile, we can factor out the quoting
> to make things easier to read. We can also apply it more
> consistently, as there were many spots that should have been
> C-quoting but did not. For example:
>
>   make prefix='foo\bar'
>
> would produce an exec_cmd.o with a broken prefix.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile | 58 +++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 868872f..b1c3fb4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1568,6 +1568,17 @@ endif
>  sqi = $(subst ','\'',$1)
>  sq = '$(call sqi,$1)'
>  
> +# usage: $(call cq,CONTENTS)
> +#
> +# Quote the value as appropriate for a C string literal.
> +cq = "$(subst ",\",$(subst \,\\,$1))"
> +
> +# usage: $(call scq,CONTENTS)
> +#
> +# Quote the value as C string inside a shell string. Good for passing strings
> +# on the command line via "-DFOO=$(call # scq,$(FOO))".

"call # scq"???

> +scq = $(call sq,$(call cq,$1))
> +
>  # usage: $(eval $(call make-var,FN,DESC,CONTENTS))
>  #
>  # Create a rule to write $CONTENTS (which should come from a make variable)
> @@ -1617,28 +1628,17 @@ LIB_OBJS += $(COMPAT_OBJS)
>  # Quote for C
>  
>  ifdef DEFAULT_EDITOR
> -DEFAULT_EDITOR_CQ = "$(subst ",\",$(subst \,\\,$(DEFAULT_EDITOR)))"
> -DEFAULT_EDITOR_CQ_SQ = $(subst ','\'',$(DEFAULT_EDITOR_CQ))
> -
> -BASIC_CFLAGS += -DDEFAULT_EDITOR='$(DEFAULT_EDITOR_CQ_SQ)'
> +BASIC_CFLAGS += -DDEFAULT_EDITOR=$(call scq,$(DEFAULT_EDITOR))
>  endif
>  
>  ifdef DEFAULT_PAGER
> -DEFAULT_PAGER_CQ = "$(subst ",\",$(subst \,\\,$(DEFAULT_PAGER)))"
> -DEFAULT_PAGER_CQ_SQ = $(subst ','\'',$(DEFAULT_PAGER_CQ))
> -
> -BASIC_CFLAGS += -DDEFAULT_PAGER='$(DEFAULT_PAGER_CQ_SQ)'
> +BASIC_CFLAGS += -DDEFAULT_PAGER=$(call scq,$(DEFAULT_PAGER))
>  endif
>  
>  ifdef SHELL_PATH
> -SHELL_PATH_CQ = "$(subst ",\",$(subst \,\\,$(SHELL_PATH)))"
> -SHELL_PATH_CQ_SQ = $(subst ','\'',$(SHELL_PATH_CQ))
> -
> -BASIC_CFLAGS += -DSHELL_PATH='$(SHELL_PATH_CQ_SQ)'
> +BASIC_CFLAGS += -DSHELL_PATH=$(call scq,$(SHELL_PATH))
>  endif
>  
> -GIT_USER_AGENT_CQ = "$(subst ",\",$(subst \,\\,$(GIT_USER_AGENT)))"
> -GIT_USER_AGENT_CQ_SQ = $(subst ','\'',$(GIT_USER_AGENT_CQ))
>  $(eval $(call make-var,USER-AGENT,user agent string,$(GIT_USER_AGENT)))
>  
>  ifdef DEFAULT_HELP_FORMAT
> @@ -1723,9 +1723,9 @@ strip: $(PROGRAMS) git$X
>  
>  git.sp git.s git.o: MAKE/PREFIX
>  git.sp git.s git.o: EXTRA_CPPFLAGS = \
> -	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
> -	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
> -	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
> +	-DGIT_HTML_PATH=$(call scq,$(htmldir_relative)) \
> +	-DGIT_MAN_PATH=$(call scq,$(mandir_relative)) \
> +	-DGIT_INFO_PATH=$(call scq,$(infodir_relative))
>  
>  git$X: git.o MAKE/LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
> @@ -1735,14 +1735,14 @@ help.sp help.s help.o: common-cmds.h
>  
>  builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h MAKE/PREFIX
>  builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
> -	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
> -	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
> -	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
> +	-DGIT_HTML_PATH=$(call scq,$(htmldir_relative)) \
> +	-DGIT_MAN_PATH=$(call scq,$(mandir_relative)) \
> +	-DGIT_INFO_PATH=$(call scq,$(infodir_relative))
>  
>  version.sp version.s version.o: GIT-VERSION-FILE MAKE/USER-AGENT
>  version.sp version.s version.o: EXTRA_CPPFLAGS = \
> -	'-DGIT_VERSION="$(GIT_VERSION)"' \
> -	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)'
> +	-DGIT_VERSION=$(call scq,$(GIT_VERSION)) \
> +	-DGIT_USER_AGENT=$(call scq,$(GIT_USER_AGENT))
>  
>  $(BUILT_INS): git$X
>  	$(QUIET_BUILT_IN)$(RM) $@ && \
> @@ -2020,25 +2020,25 @@ endif
>  
>  exec_cmd.sp exec_cmd.s exec_cmd.o: MAKE/PREFIX
>  exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
> -	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
> -	'-DBINDIR="$(bindir_relative_SQ)"' \
> -	'-DPREFIX="$(prefix_SQ)"'
> +	-DGIT_EXEC_PATH=$(call scq,$(gitexecdir)) \
> +	-DBINDIR=$(call scq,$(bindir_relative)) \
> +	-DPREFIX=$(call scq,$(prefix))
>  
>  builtin/init-db.sp builtin/init-db.s builtin/init-db.o: MAKE/PREFIX
>  builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
> -	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
> +	-DDEFAULT_GIT_TEMPLATE_DIR=$(call scq,$(template_dir))
>  
>  config.sp config.s config.o: MAKE/PREFIX
>  config.sp config.s config.o: EXTRA_CPPFLAGS = \
> -	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
> +	-DETC_GITCONFIG=$(call scq,$(ETC_GITCONFIG))
>  
>  attr.sp attr.s attr.o: MAKE/PREFIX
>  attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
> -	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
> +	-DETC_GITATTRIBUTES=$(call scq,$(ETC_GITATTRIBUTES))
>  
>  gettext.sp gettext.s gettext.o: MAKE/PREFIX
>  gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
> -	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
> +	-DGIT_LOCALE_PATH=$(call scq,$(localedir))
>  
>  http-push.sp http.sp http-walker.sp remote-curl.sp: SPARSE_FLAGS += \
>  	-DCURL_DISABLE_TYPECHECK
