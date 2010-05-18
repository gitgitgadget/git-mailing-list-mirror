From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] WIP: begin to translate git with gettext
Date: Tue, 18 May 2010 09:40:23 +0200
Message-ID: <4BF24467.7000204@drmicha.warpmail.net>
References: <20100517160503.GA12717@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	Thomas Rast <trast@student.ethz.ch>,
	Marc Weber <marco-oweber@gmx.de>
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Tue May 18 09:40:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEHQ1-0002d9-GB
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 09:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722Ab0ERHkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 03:40:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47482 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753296Ab0ERHkm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 03:40:42 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3F274F77A7;
	Tue, 18 May 2010 03:40:16 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 18 May 2010 03:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+WcdEhh8/DFpN1lmSWEnOWSVu9A=; b=LlYj22+11cnL0wA5BX8wRL8yTHnbpRgQru9H9V5zvkwKLXTG+NOfeJgmsGjuwK/ogJ7iyccR+meu4EGtanSC/DUrgMFISa4nH1YIJSADz42C+toYt3DKoJVRyVVduq9aTY1cN+kyrJkvOO3QLuOZ/Yw/jbPM8wbfhxebAQF68lM=
X-Sasl-enc: YU5ufyIhAGM7rXmDnjkI8yODqKwOiuyKdKk6DBlr+fQi 1274168416
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 80EEE56757;
	Tue, 18 May 2010 03:40:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100517160503.GA12717@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147274>

Jeff Epler venit, vidit, dixit 17.05.2010 18:05:
> Signed-off-by: Jeff Epler <jepler@unpythonic.net>
> ---
> [resent with Cc to list and thread participants]
> 
> While I'm certain that there are a lot of things to object to in this
> patch, it shows 90% of what is needed to use gettext to translate
> the portions of git written in c, without involving undesired gnu
> infrastructure such as automake.
> 
> Makefile adds necessary rules for generating git.pot and for building
> and installing compiled message catalogs (.mo) from text message
> catalogs (.po).  It also adds a gettext support header and source file.
> 
> Minimal changes are made to git to use the requested LC_CTYPE and
> LC_MESSAGES, and some messages for 'git status' are marked for
> translation.
> 
> When I provided a gibberish translation of a message:
> #: wt-status.c:87
> msgid "# Changed but not updated:"
> msgstr "# Changes not blah blah blah"
> 
> running 'git status' used the translation:
> $ git status
> # On branch master
> # Your branch is ahead of 'origin/master' by 1 commit.
> #
> # Changes not blah blah blah
> ...
> 
> I ran with 'make install' and prefix set in config.mak.  It didn't seem
> to work when running from the source directory, and it may or may not
> work with runtime prefix.
> 
> 
>  Makefile    |   26 +++++++++++++
>  gettext.c   |   17 +++++++++
>  gettext.h   |   15 ++++++++
>  git.c       |    3 ++
>  wt-status.c |  117 ++++++++++++++++++++++++++++++-----------------------------
>  5 files changed, 120 insertions(+), 58 deletions(-)
>  create mode 100644 gettext.c
>  create mode 100644 gettext.h
> 
> diff --git a/Makefile b/Makefile
> index 4f7224a..c02ca18 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -294,6 +294,8 @@ RPMBUILD = rpmbuild
>  TCL_PATH = tclsh
>  TCLTK_PATH = wish
>  PTHREAD_LIBS = -lpthread
> +XGETTEXT = xgettext
> +MSGFMT = msgfmt
>  
>  export TCL_PATH TCLTK_PATH
>  
> @@ -518,6 +520,7 @@ LIB_H += userdiff.h
>  LIB_H += utf8.h
>  LIB_H += xdiff-interface.h
>  LIB_H += xdiff/xdiff.h
> +LIB_H += gettext.h
>  
>  LIB_OBJS += abspath.o
>  LIB_OBJS += advice.o
> @@ -559,6 +562,7 @@ LIB_OBJS += entry.o
>  LIB_OBJS += environment.o
>  LIB_OBJS += exec_cmd.o
>  LIB_OBJS += fsck.o
> +LIB_OBJS += gettext.o
>  LIB_OBJS += graph.o
>  LIB_OBJS += grep.o
>  LIB_OBJS += hash.o
> @@ -1371,6 +1375,12 @@ ifdef USE_NED_ALLOCATOR
>         COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
>  endif
>  
> +ifdef NO_GETTEXT
> +	COMPAT_CFLAGS += -DNO_GETTEXT
> +else
> +	LIBINTL = -lintl
> +endif
> +
>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK=NoThanks
>  endif
> @@ -1400,6 +1410,7 @@ ifndef V
>  	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
>  	QUIET_GEN      = @echo '   ' GEN $@;
>  	QUIET_LNCP     = @echo '   ' LN/CP $@;
> +	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
>  	QUIET_SUBDIR0  = +@subdir=
>  	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
>  			 $(MAKE) $(PRINT_DIR) -C $$subdir
> @@ -1427,6 +1438,7 @@ gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
>  template_dir_SQ = $(subst ','\'',$(template_dir))
>  htmldir_SQ = $(subst ','\'',$(htmldir))
>  prefix_SQ = $(subst ','\'',$(prefix))
> +sharedir_SQ = $(subst ','\'',$(sharedir))
>  
>  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
>  PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
> @@ -1858,6 +1870,17 @@ cscope:
>  	$(RM) cscope*
>  	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
>  
> +pot:
> +	$(XGETTEXT) -k_ -o po/git.pot $(C_OBJ:o=c)
> +
> +POFILES := $(wildcard po/*.po)
> +MOFILES := $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(POFILES))
> +MODIRS := $(patsubst po/%.po,share/locale/%/LC_MESSAGES/,$(POFILES))
> +all:: $(MOFILES)
> +share/locale/%/LC_MESSAGES/git.mo: po/%.po
> +	@mkdir -p $(dir $@)
> +	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
> +
>  ### Detect prefix changes
>  TRACK_CFLAGS = $(subst ','\'',$(ALL_CFLAGS)):\
>               $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ)
> @@ -1970,6 +1993,9 @@ install: all
>  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sharedir_SQ)/locale'
> +	(cd share && tar cf - locale) | \
> +		(cd '$(DESTDIR_SQ)$(sharedir_SQ)' && umask 022 && tar xof -)
>  	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
>  ifndef NO_PERL
>  	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
> diff --git a/gettext.c b/gettext.c
> new file mode 100644
> index 0000000..aadce19
> --- /dev/null
> +++ b/gettext.c
> @@ -0,0 +1,17 @@
> +#ifdef NO_GETTEXT
> +void git_setup_gettext() {}
> +#else
> +#include "exec_cmd.h"
> +#include <libintl.h>
> +#include <stdlib.h>
> +
> +void git_setup_gettext() {
> +    const char *podir = system_path("share/locale");
> +    if(!podir) return;
> +    char *ret = bindtextdomain("git", podir);
> +    free((void*)podir);
> +    ret = setlocale(LC_MESSAGES, "");
> +    ret = setlocale(LC_CTYPE, "");
> +    ret = textdomain("git");
> +}
> +#endif
> diff --git a/gettext.h b/gettext.h
> new file mode 100644
> index 0000000..8b221b4
> --- /dev/null
> +++ b/gettext.h
> @@ -0,0 +1,15 @@
> +#ifndef GETTEXT_H
> +#define GETTEXT_H
> +
> +void git_setup_gettext();
> +
> +#ifdef NO_GETTEXT
> +#define _(s) (s)
> +#define N_(s) (s)
> +#else
> +#include <libintl.h>
> +#define _(s) gettext(s)
> +#define N_(s) (s)
> +#endif
> +
> +#endif
> diff --git a/git.c b/git.c
> index 6bae305..5e7aedd 100644
> --- a/git.c
> +++ b/git.c
> @@ -3,6 +3,7 @@
>  #include "cache.h"
>  #include "quote.h"
>  #include "run-command.h"
> +#include "gettext.h"
>  
>  const char git_usage_string[] =
>  	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]\n"
> @@ -481,6 +482,8 @@ int main(int argc, const char **argv)
>  	if (!cmd)
>  		cmd = "git-help";
>  
> +	git_setup_gettext();
> +
>  	/*
>  	 * "git-xxxx" is the same as "git xxxx", but we obviously:
>  	 *
> diff --git a/wt-status.c b/wt-status.c
> index 8ca59a2..a31cbc6 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -9,6 +9,7 @@
>  #include "quote.h"
>  #include "run-command.h"
>  #include "remote.h"
> +#include "gettext.h"
>  
>  static char default_wt_status_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
> @@ -48,33 +49,33 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
>  {
>  	const char *c = color(WT_STATUS_HEADER, s);
>  
> -	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
> +	color_fprintf_ln(s->fp, c, _("# Unmerged paths:"));
>  	if (!advice_status_hints)
>  		return;
>  	if (s->in_merge)
>  		;
>  	else if (!s->is_initial)
> -		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
> +		color_fprintf_ln(s->fp, c, _("#   (use \"git reset %s <file>...\" to unstage)"), s->reference);
>  	else
> -		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" to unstage)");
> -	color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" as appropriate to mark resolution)");
> -	color_fprintf_ln(s->fp, c, "#");
> +		color_fprintf_ln(s->fp, c, _("#   (use \"git rm --cached <file>...\" to unstage)"));
> +	color_fprintf_ln(s->fp, c, _("#   (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
> +	color_fprintf_ln(s->fp, c, _("#"));
>  }
>  
>  static void wt_status_print_cached_header(struct wt_status *s)
>  {
>  	const char *c = color(WT_STATUS_HEADER, s);
>  
> -	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
> +	color_fprintf_ln(s->fp, c, _("# Changes to be committed:"));
>  	if (!advice_status_hints)
>  		return;
>  	if (s->in_merge)
>  		; /* NEEDSWORK: use "git reset --unresolve"??? */
>  	else if (!s->is_initial)
> -		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
> +		color_fprintf_ln(s->fp, c, _("#   (use \"git reset %s <file>...\" to unstage)"), s->reference);
>  	else
> -		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" to unstage)");
> -	color_fprintf_ln(s->fp, c, "#");
> +		color_fprintf_ln(s->fp, c, _("#   (use \"git rm --cached <file>...\" to unstage)"));
> +	color_fprintf_ln(s->fp, c, _("#"));
>  }
>  
>  static void wt_status_print_dirty_header(struct wt_status *s,
> @@ -83,32 +84,32 @@ static void wt_status_print_dirty_header(struct wt_status *s,
>  {
>  	const char *c = color(WT_STATUS_HEADER, s);
>  
> -	color_fprintf_ln(s->fp, c, "# Changed but not updated:");
> +	color_fprintf_ln(s->fp, c, _("# Changed but not updated:"));
>  	if (!advice_status_hints)
>  		return;
>  	if (!has_deleted)
> -		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update what will be committed)");
> +		color_fprintf_ln(s->fp, c, _("#   (use \"git add <file>...\" to update what will be committed)"));
>  	else
> -		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to update what will be committed)");
> -	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to discard changes in working directory)");
> +		color_fprintf_ln(s->fp, c, _("#   (use \"git add/rm <file>...\" to update what will be committed)"));
> +	color_fprintf_ln(s->fp, c, _("#   (use \"git checkout -- <file>...\" to discard changes in working directory)"));
>  	if (has_dirty_submodules)
> -		color_fprintf_ln(s->fp, c, "#   (commit or discard the untracked or modified content in submodules)");
> -	color_fprintf_ln(s->fp, c, "#");
> +		color_fprintf_ln(s->fp, c, _("#   (commit or discard the untracked or modified content in submodules)"));
> +	color_fprintf_ln(s->fp, c, _("#"));
>  }
>  
>  static void wt_status_print_untracked_header(struct wt_status *s)
>  {
>  	const char *c = color(WT_STATUS_HEADER, s);
> -	color_fprintf_ln(s->fp, c, "# Untracked files:");
> +	color_fprintf_ln(s->fp, c, _("# Untracked files:"));
>  	if (!advice_status_hints)
>  		return;
> -	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to include in what will be committed)");
> -	color_fprintf_ln(s->fp, c, "#");
> +	color_fprintf_ln(s->fp, c, _("#   (use \"git add <file>...\" to include in what will be committed)"));
> +	color_fprintf_ln(s->fp, c, _("#"));
>  }
>  
>  static void wt_status_print_trailer(struct wt_status *s)
>  {
> -	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
> +	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("#"));
>  }
>  
>  #define quote_path quote_path_relative
> @@ -119,20 +120,20 @@ static void wt_status_print_unmerged_data(struct wt_status *s,
>  	const char *c = color(WT_STATUS_UNMERGED, s);
>  	struct wt_status_change_data *d = it->util;
>  	struct strbuf onebuf = STRBUF_INIT;
> -	const char *one, *how = "bug";
> +	const char *one, *how = _("bug");
>  
>  	one = quote_path(it->string, -1, &onebuf, s->prefix);
> -	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
> +	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), _("#\t"));
>  	switch (d->stagemask) {
> -	case 1: how = "both deleted:"; break;
> -	case 2: how = "added by us:"; break;
> -	case 3: how = "deleted by them:"; break;
> -	case 4: how = "added by them:"; break;
> -	case 5: how = "deleted by us:"; break;
> -	case 6: how = "both added:"; break;
> -	case 7: how = "both modified:"; break;
> +	case 1: how = _("both deleted:"); break;
> +	case 2: how = _("added by us:"); break;
> +	case 3: how = _("deleted by them:"); break;
> +	case 4: how = _("added by them:"); break;
> +	case 5: how = _("deleted by us:"); break;
> +	case 6: how = _("both added:"); break;
> +	case 7: how = _("both modified:"); break;
>  	}
> -	color_fprintf(s->fp, c, "%-20s%s\n", how, one);
> +	color_fprintf(s->fp, c, _("%-20s%s\n"), how, one);
>  	strbuf_release(&onebuf);
>  }
>  
> @@ -158,13 +159,13 @@ static void wt_status_print_change_data(struct wt_status *s,
>  		break;
>  	case WT_STATUS_CHANGED:
>  		if (d->new_submodule_commits || d->dirty_submodule) {
> -			strbuf_addstr(&extra, " (");
> +			strbuf_addstr(&extra, _(" ("));
>  			if (d->new_submodule_commits)
> -				strbuf_addf(&extra, "new commits, ");
> +				strbuf_addf(&extra, _("new commits, "));
>  			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
> -				strbuf_addf(&extra, "modified content, ");
> +				strbuf_addf(&extra, _("modified content, "));
>  			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> -				strbuf_addf(&extra, "untracked content, ");
> +				strbuf_addf(&extra, _("untracked content, "));
>  			strbuf_setlen(&extra, extra.len - 2);
>  			strbuf_addch(&extra, ')');
>  		}
> @@ -175,40 +176,40 @@ static void wt_status_print_change_data(struct wt_status *s,
>  	one = quote_path(one_name, -1, &onebuf, s->prefix);
>  	two = quote_path(two_name, -1, &twobuf, s->prefix);
>  
> -	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
> +	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), _("#\t"));
>  	switch (status) {
>  	case DIFF_STATUS_ADDED:
> -		color_fprintf(s->fp, c, "new file:   %s", one);
> +		color_fprintf(s->fp, c, _("new file:   %s"), one);
>  		break;
>  	case DIFF_STATUS_COPIED:
> -		color_fprintf(s->fp, c, "copied:     %s -> %s", one, two);
> +		color_fprintf(s->fp, c, _("copied:     %s -> %s"), one, two);
>  		break;
>  	case DIFF_STATUS_DELETED:
> -		color_fprintf(s->fp, c, "deleted:    %s", one);
> +		color_fprintf(s->fp, c, _("deleted:    %s"), one);
>  		break;
>  	case DIFF_STATUS_MODIFIED:
> -		color_fprintf(s->fp, c, "modified:   %s", one);
> +		color_fprintf(s->fp, c, _("modified:   %s"), one);
>  		break;
>  	case DIFF_STATUS_RENAMED:
> -		color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
> +		color_fprintf(s->fp, c, _("renamed:    %s -> %s"), one, two);
>  		break;
>  	case DIFF_STATUS_TYPE_CHANGED:
> -		color_fprintf(s->fp, c, "typechange: %s", one);
> +		color_fprintf(s->fp, c, _("typechange: %s"), one);
>  		break;
>  	case DIFF_STATUS_UNKNOWN:
> -		color_fprintf(s->fp, c, "unknown:    %s", one);
> +		color_fprintf(s->fp, c, _("unknown:    %s"), one);
>  		break;
>  	case DIFF_STATUS_UNMERGED:
> -		color_fprintf(s->fp, c, "unmerged:   %s", one);
> +		color_fprintf(s->fp, c, _("unmerged:   %s"), one);

I have no experience whatsover with gettext, but it looks quite
dangerous to me to have printf format specifiers as part of the
localized text. It means that our programs can crash depending on the
LANG setting at run time if localisers mess up. We'll never catch this
unless we run all tests in all languages!

Also, the basic structure of the output should probably be independent
of the language, preferring consistent structure across languages over
linguistically consistent structure  within a language.

That means we'll have to do a lot of strcat's (the _() things are not
compile time constants, are they?) rather than those mechanical
replacements above. Are you prepared to do that?

>  		break;
>  	default:
> -		die("bug: unhandled diff status %c", status);
> +		die(_("bug: unhandled diff status %c"), status);
>  	}
>  	if (extra.len) {
> -		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "%s", extra.buf);
> +		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), _("%s"), extra.buf);

Seriously?

>  		strbuf_release(&extra);
>  	}
> -	fprintf(s->fp, "\n");
> +	fprintf(s->fp, _("\n"));
>  	strbuf_release(&onebuf);
>  	strbuf_release(&twobuf);
>  }
> @@ -535,7 +536,7 @@ static void wt_status_print_untracked(struct wt_status *s)
>  	for (i = 0; i < s->untracked.nr; i++) {
>  		struct string_list_item *it;
>  		it = &(s->untracked.items[i]);
> -		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
> +		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), _("#\t"));

?

>  		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED, s), "%s",
>  				 quote_path(it->string, strlen(it->string),
>  					    &buf, s->prefix));
> @@ -594,14 +595,14 @@ void wt_status_print(struct wt_status *s)
>  	const char *branch_color = color(WT_STATUS_HEADER, s);
>  
>  	if (s->branch) {
> -		const char *on_what = "On branch ";
> +		const char *on_what = _("On branch ");
>  		const char *branch_name = s->branch;
>  		if (!prefixcmp(branch_name, "refs/heads/"))
>  			branch_name += 11;
>  		else if (!strcmp(branch_name, "HEAD")) {
>  			branch_name = "";
>  			branch_color = color(WT_STATUS_NOBRANCH, s);
> -			on_what = "Not currently on any branch.";
> +			on_what = _("Not currently on any branch.");
>  		}
>  		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
>  		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
> @@ -610,9 +611,9 @@ void wt_status_print(struct wt_status *s)
>  	}
>  
>  	if (s->is_initial) {
> -		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
> -		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "# Initial commit");
> -		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
> +		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("#"));
> +		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("# Initial commit"));
> +		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("#"));
>  	}
>  
>  	wt_status_print_updated(s);
> @@ -625,25 +626,25 @@ void wt_status_print(struct wt_status *s)
>  	if (s->show_untracked_files)
>  		wt_status_print_untracked(s);
>  	else if (s->commitable)
> -		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
> +		 fprintf(s->fp, _("# Untracked files not listed (use -u option to show untracked files)\n"));
>  
>  	if (s->verbose)
>  		wt_status_print_verbose(s);
>  	if (!s->commitable) {
>  		if (s->amend)
> -			fprintf(s->fp, "# No changes\n");
> +			fprintf(s->fp, _("# No changes\n"));
>  		else if (s->nowarn)
>  			; /* nothing */
>  		else if (s->workdir_dirty)
> -			printf("no changes added to commit (use \"git add\" and/or \"git commit -a\")\n");
> +			printf(_("no changes added to commit (use \"git add\" and/or \"git commit -a\")\n"));
>  		else if (s->untracked.nr)
> -			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
> +			printf(_("nothing added to commit but untracked files present (use \"git add\" to track)\n"));
>  		else if (s->is_initial)
> -			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
> +			printf(_("nothing to commit (create/copy files and use \"git add\" to track)\n"));
>  		else if (!s->show_untracked_files)
> -			printf("nothing to commit (use -u to show untracked files)\n");
> +			printf(_("nothing to commit (use -u to show untracked files)\n"));
>  		else
> -			printf("nothing to commit (working directory clean)\n");
> +			printf(_("nothing to commit (working directory clean)\n"));
>  	}
>  }
>  
