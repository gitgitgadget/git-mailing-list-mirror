From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v9 0/9] interactive git-clean
Date: Tue, 14 May 2013 16:45:14 +0800
Message-ID: <cover.1368518327.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 14 10:46:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcArv-0002nm-E2
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 10:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923Ab3ENIpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 04:45:53 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:45362 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756917Ab3ENIpr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 04:45:47 -0400
Received: by mail-da0-f41.google.com with SMTP id y19so179436dan.0
        for <git@vger.kernel.org>; Tue, 14 May 2013 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=5OmbgbOfTH2pwxf+xf18cK9VCSB+bAuqRSsJy3bJA+E=;
        b=pllHSKiNlFbXo4LF5MWO+h5dk5wJjnP3P4SVJ2mYq9HmFNNDhSx8+YMySh9L2saGTP
         GG/GnyEPuOTiqCLZQ4pJTrySPeaA2fVajhFCerid1cwPwvrhWr8vMrGsjBd4seh8fRwo
         DPIDp3TvTCuW/eoN3MI4QZ3dfzfwvlOdtLSiDBzenyOADWXPUBTGj+0iqOlfYGaTFnSE
         dXZ18EeSsFcp420A3/Sp5+QA+FTT+0x6ZWKA9P0QuFeuzChFyAUlwMZiwcgk2LOUFSOt
         El+KjpcL+waCLcF5/JmWMxnQ/5unlSPiP9/+ykQ4qs5lHDNQIsfE6euBYRZeT7WXe/E3
         ZCDQ==
X-Received: by 10.66.163.99 with SMTP id yh3mr33194928pab.22.1368521147326;
        Tue, 14 May 2013 01:45:47 -0700 (PDT)
Received: from localhost.localdomain ([114.248.141.128])
        by mx.google.com with ESMTPSA id wt5sm17356069pbc.38.2013.05.14.01.45.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 01:45:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.401.gfc9adf8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224285>

Updates since v8:

 * Run interactive git-clean even if in dry_run mode. 

       -	if (interactive && !dry_run && del_list.nr > 0)
       +	if (interactive && del_list.nr > 0)
        		interactive_main_loop();
 
 * Variable menu_list is not static.
   (copy from global del_list, and forget to remove static)

        static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
        {
       -	static struct string_list menu_list = STRING_LIST_INIT_DUP;
       +	struct string_list menu_list = STRING_LIST_INIT_DUP;
        	struct strbuf menu = STRBUF_INIT;
        	int i;

 * i18n:

       @@ -567,21 +567,21 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
        		if (opts->header) {
        			printf_ln("%s%s%s",
        				  clean_get_color(CLEAN_COLOR_HEADER),
       -				  opts->header,
       +				  _(opts->header),
        				  clean_get_color(CLEAN_COLOR_RESET));
        		}
        
       ... 
       
        		if (opts->prompt) {
        			printf("%s%s%s%s",
        			       clean_get_color(CLEAN_COLOR_PROMPT),
       -			       opts->prompt,
       -			       opts->flag & MENU_OPTS_SINGLETON ? "> " : ">> ",
       +			       _(opts->prompt),
       +			       opts->flags & MENU_OPTS_SINGLETON ? "> " : ">> ",
        			       clean_get_color(CLEAN_COLOR_RESET));
        		}


       @@ -721,8 +724,8 @@ static int select_by_numbers_cmd(void)
        	int i, j;
        
       -	menu_opts.prompt = "Select items to delete";
       +	menu_opts.prompt = N_("Select items to delete");

       -		menu_opts.header = _("*** Commands ***");
       -		menu_opts.prompt = "What now";
       +		menu_opts.header = N_("*** Commands ***");
       +		menu_opts.prompt = N_("What now");
  

 * Update documentation for "color.interactive" and "color.interactive.<slot>",
   because `git clean --interactive` reuses these variables from
   `git-add--interactive`.

        color.interactive::
        	When set to `always`, always use colors for interactive prompts
       -	and displays (such as those used by "git-add --interactive").
       -	When false (or `never`), never.  When set to `true` or `auto`, use
       -	colors only when the output is to the terminal. Defaults to false.
       +	and displays (such as those used by "git-add --interactive" and
       +	"git-clean --interactive"). When false (or `never`), never.
       +	When set to `true` or `auto`, use colors only when the output is
       +	to the terminal. Defaults to false.
        
        color.interactive.<slot>::
       -	Use customized color for 'git add --interactive'
       -	output. `<slot>` may be `prompt`, `header`, `help` or `error`, for
       -	four distinct types of normal output from interactive
       -	commands.  The values of these variables may be specified as
       -	in color.branch.<slot>.
       +	Use customized color for 'git add --interactive' and 'git clean
       +	--interactive' output. `<slot>` may be `prompt`, `header`, `help`
       +	or `error`, for four distinct types of normal output from
       +	interactive commands.  The values of these variables may be
       +	specified as in color.branch.<slot>.
 
 * Update documentation for "column.clean", because we only use layout settings.

        column.clean::
       -	Specify whether to output cleaning files in `git clean -i` in columns.
       -	See `column.ui` for details.
       +	Specify the layout when list items in `git clean -i`, which always
       +	shows files and directories in columns. See `column.ui` for details.

 * Refactor: change variables' names, such as:

       @@ -57,7 +57,7 @@ enum color_clean {
        struct menu_opts {
        	const char *header;
        	const char *prompt;
       -	int flag;
       +	int flags;
        };
 

       @@ -428,7 +428,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
        			struct strbuf input,
        			int **chosen)
        {
       -	struct strbuf **choice_list, **choice_p;
       +	struct strbuf **choice_list, **ptr;
        	int nr = 0;
        	int i;

 * Refactor parse_clean_color_slot:

       @@ -80,19 +80,19 @@ struct menu_stuff {
        	void *stuff;
        };
        
       -static int parse_clean_color_slot(const char *var, int ofs)
       +static int parse_clean_color_slot(const char *var)
        {
       -	if (!strcasecmp(var+ofs, "reset"))
       +	if (!strcasecmp(var, "reset"))
        		return CLEAN_COLOR_RESET;
       -	if (!strcasecmp(var+ofs, "plain"))
       +	if (!strcasecmp(var, "plain"))
        		return CLEAN_COLOR_PLAIN;
       -	if (!strcasecmp(var+ofs, "prompt"))
       +	if (!strcasecmp(var, "prompt"))
        		return CLEAN_COLOR_PROMPT;
       -	if (!strcasecmp(var+ofs, "header"))
       +	if (!strcasecmp(var, "header"))
        		return CLEAN_COLOR_HEADER;
       -	if (!strcasecmp(var+ofs, "help"))
       +	if (!strcasecmp(var, "help"))
        		return CLEAN_COLOR_HELP;
       -	if (!strcasecmp(var+ofs, "error"))
       +	if (!strcasecmp(var, "error"))
        		return CLEAN_COLOR_ERROR;
        	return -1;
        }
       @@ -109,7 +109,8 @@ static int git_clean_config(const char *var, const char *value, void *cb)
        		return 0;
        	}
        	if (!prefixcmp(var, "color.interactive.")) {
       -		int slot = parse_clean_color_slot(var, 18);
       +		int slot = parse_clean_color_slot(var +
       +						  strlen("color.interactive."));
        		if (slot < 0)
        			return 0;
        		if (!value)

 * Withdraw PATCH v8 10/12, 11/12 and 12/12.

   - git-clean refactor: save some options in clean_flags
   - git-clean refactor: add wrapper scan_clean_candidates
   - git-clean: add toggle flags interactive action

Usage:

See: [PATCH v9 9/9] git-clean: add documentation for interactive git-clean


Jiang Xin (9):
  git-clean: refactor git-clean into two phases
  git-clean: add support for -i/--interactive
  git-clean: show items of del_list in columns
  git-clean: add colors to interactive git-clean
  git-clean: use a git-add-interactive compatible UI
  git-clean: add filter by pattern interactive action
  git-clean: add select by numbers interactive action
  git-clean: add ask each interactive action
  git-clean: add documentation for interactive git-clean

 Documentation/config.txt    |  21 +-
 Documentation/git-clean.txt |  71 +++-
 builtin/clean.c             | 802 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 860 insertions(+), 34 deletions(-)

-- 
1.8.3.rc1.404.gb9fcf3e
