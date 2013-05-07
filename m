From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v6 4/7] git-clean: use a git-add-interactive compatible UI
Date: Tue, 7 May 2013 12:16:53 +0800
Message-ID: <CANYiYbEE90zvhoRp3utOzRWXnpVGTcaruWDuCCHE77FmGwB2_w@mail.gmail.com>
References: <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
	<6276dc8861b40e8377586f30b85c33e92c4e68fe.1367867498.git.worldhello.net@gmail.com>
	<CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
	<cover.1367867498.git.worldhello.net@gmail.com>
	<c77c33fe295bb8577336d5bb4fe0d8da32f69df3.1367867498.git.worldhello.net@gmail.com>
	<217e7618e9b9d50a50461959b38984ac8be88651.1367867498.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 07 06:17:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZKm-0003nr-D4
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512Ab3EGEQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:16:55 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34690 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab3EGEQy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:16:54 -0400
Received: by mail-wi0-f173.google.com with SMTP id ey16so3273335wid.12
        for <git@vger.kernel.org>; Mon, 06 May 2013 21:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=s2dpbXFx9c8W8IXzi03rnpD+wMZZ5gFIcGWqf3lY8RY=;
        b=Zxol3K4v+ZQevweOXa9w2AiyEq61JMSD60oAyB4SA9TT9tBbaqHCllmNZ3kgPSQ2ow
         Zo0SsaU3oYxDOyz/EUJibFF6A3/qxuD8i5teaki/UStdaGOh2Egr4QlOQIrfNDsRQBzQ
         IE/6Qv0GMQyi5TVkWHOEOrO8gCW0kr4L0Y7jhFXruCroeH5eSS+QX5R6S9iYySi4SIks
         N2F9yYAMrT+0QAhNlHEyg34mPY/TcWjP2HcSEElBNcNtbGTirruupHohWY+OSoNysYzf
         q4oztZT+UyX9TycUyBTd9UU4Av82De7ZlPVFgEE9/V86ZBTeu8aI2sEzTCAcw5XIC2Fi
         S8vQ==
X-Received: by 10.194.178.162 with SMTP id cz2mr376488wjc.27.1367900213329;
 Mon, 06 May 2013 21:16:53 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Mon, 6 May 2013 21:16:53 -0700 (PDT)
In-Reply-To: <217e7618e9b9d50a50461959b38984ac8be88651.1367867498.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223537>

2013/5/7 Jiang Xin <worldhello.net@gmail.com>:
> Rewrite menu using a new method `list_and_choose`, which is borrowed
> from `git-add--interactive.perl`. We can reused this method later for
> more actions.
>
> Please NOTE:
>
>  * Method `list_and_choose` return an array of integers, and
>  * it is up to you to free the allocated memory of the array.
>  * The array ends with EOF.
>  * If user pressed CTRL-D (i.e. EOF), no selection returned.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/clean.c | 410 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 367 insertions(+), 43 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 6bda3..3b9f3 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -16,6 +16,35 @@
>  #include "column.h"
>  #include "color.h"
>
> +#define MENU_OPTS_SINGLETON            01
> +#define MENU_OPTS_IMMEDIATE            02
> +#define MENU_OPTS_LIST_ONLY            04
> +
> +#define MENU_RETURN_NO_LOOP            10
> +
> +struct menu_opts {
> +       const char *header;
> +       const char *prompt;
> +       int flag;
> +};
> +
> +enum menu_stuff_type {
> +       MENU_STUFF_TYPE_STRING_LIST = 1,
> +       MENU_STUFF_TYPE_MENU_ITEM
> +};
> +
> +struct menu_stuff {
> +       enum menu_stuff_type type;
> +       int nr;
> +       void *stuff;
> +};
> +
> +struct menu_item {
> +       char hotkey;
> +       char *title;
> +       int (*fn)();
> +};
> +
>  static int force = -1; /* unset */
>  static int interactive;
>  static struct string_list del_list = STRING_LIST_INIT_DUP;
> @@ -240,12 +269,284 @@ void pretty_print_dels()
>         copts.indent = "  ";
>         copts.padding = 2;
>         print_columns(&list, colopts, &copts);
> -       putchar('\n');
>         strbuf_release(&buf);
>         string_list_clear(&list, 0);
>  }
>
> -void edit_by_patterns_cmd()
> +void pretty_print_menus(struct string_list *menu_list)
> +{
> +       struct strbuf buf = STRBUF_INIT;
unused buf should be deleted.

> +       unsigned int local_colopts = 0;
> +       struct column_options copts;
> +
> +       /*
> +        * always enable column display, we only consult column.*
> +        * about layout strategy and stuff
> +        */
remove the above comments.

> +       local_colopts = COL_ENABLED | COL_ROW;
> +       memset(&copts, 0, sizeof(copts));
> +       copts.indent = "  ";
> +       copts.padding = 2;
> +       print_columns(menu_list, local_colopts, &copts);
> +       strbuf_release(&buf);
remove strbuf_release of unused variable : buf.

> +}
> +
> +void prompt_help_cmd(int singleton)
> +{
> +       clean_print_color(CLEAN_COLOR_HELP);
> +       printf_ln(singleton ?
> +                 _("Prompt help:\n"
> +                   "1          - select a numbered item\n"
> +                   "foo        - select item based on unique prefix\n"
> +                   "           - (empty) select nothing") :
> +                 _("Prompt help:\n"
> +                   "1          - select a single item\n"
> +                   "3-5        - select a range of items\n"
> +                   "2-3,6-9    - select multiple ranges\n"
> +                   "foo        - select item based on unique prefix\n"
> +                   "-...       - unselect specified items\n"
> +                   "*          - choose all items\n"
> +                   "           - (empty) finish selecting"));
> +       clean_print_color(CLEAN_COLOR_RESET);
> +}
> +
> +/*
> + * Implement a git-add-interactive compatible UI, which is borrowed
> + * from git-add--interactive.perl.
> + *
> + * Return value:
> + *
> + *   - Return an array of integers
> + *   - , and it is up to you to free the allocated memory.
> + *   - The array ends with EOF.
> + *   - If user pressed CTRL-D (i.e. EOF), no selection returned.
> + */
> +int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
> +{
> +       static struct string_list menu_list = STRING_LIST_INIT_DUP;
> +       struct strbuf menu = STRBUF_INIT;
> +       struct strbuf choice = STRBUF_INIT;
> +       struct strbuf **choice_list;
> +       int *chosen, *result;
> +       char *p;
> +       int nr = 0;
> +       int i, j;
> +       int eof = 0;
> +
> +       chosen = xmalloc(sizeof(int) * stuff->nr);
> +       memset(chosen, 0, sizeof(int) * stuff->nr);
> +
> +       while (1) {
> +               int i = 0, j = 0;
> +               string_list_clear(&menu_list, 0);
> +
> +               if (opts->header) {
> +                       printf_ln("%s%s%s",
> +                                 clean_get_color(CLEAN_COLOR_HEADER),
> +                                 opts->header,
> +                                 clean_get_color(CLEAN_COLOR_RESET));
> +               }
> +
> +               /* highlight hotkey in menu */
> +               if (MENU_STUFF_TYPE_MENU_ITEM == stuff->type) {
> +                       struct menu_item *item;
> +
> +                       item = (struct menu_item *)stuff->stuff;
> +                       for (i = 0; i < stuff->nr; i++, item++) {
> +                               p = item->title;
> +                               strbuf_addf(&menu, "%s%2d: ", chosen[i] ? "*" : " ", i+1);
> +                               for (; *p; p++) {
> +                                       if (*p == item->hotkey) {
> +                                               strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_PROMPT));
> +                                               strbuf_addch(&menu, *p);
> +                                               strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_RESET));
> +                                       } else {
> +                                               strbuf_addch(&menu, *p);
> +                                       }
> +                               }
> +                               string_list_append(&menu_list, menu.buf);
> +                               strbuf_reset(&menu);
> +                       }
> +               } else if (MENU_STUFF_TYPE_STRING_LIST == stuff->type) {
> +                       struct string_list_item *item;
> +                       struct strbuf buf = STRBUF_INIT;
should call strbuf_release later

> +                       i = 0;
> +
> +                       for_each_string_list_item(item, (struct string_list *)stuff->stuff) {
> +                               const char *qname;
> +
> +                               qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
> +                               strbuf_addf(&menu, "%s%2d: %s", chosen[i] ? "*" : " ", ++i, qname);
> +                               string_list_append(&menu_list, menu.buf);
> +                               strbuf_reset(&menu);
> +                       }
+                       strbuf_release(&buf);

> +               }
> +
> +               pretty_print_menus(&menu_list);
> +
> +               if (opts->flag & MENU_OPTS_LIST_ONLY)
> +                       break;
> +
> +               if (opts->prompt) {
> +                       printf("%s%s%s%s",
> +                              clean_get_color(CLEAN_COLOR_PROMPT),
> +                              opts->prompt,
> +                              opts->flag & MENU_OPTS_SINGLETON ? "> " : ">> ",
> +                              clean_get_color(CLEAN_COLOR_RESET));
> +               }
> +
> +               if (strbuf_getline(&choice, stdin, '\n') != EOF) {
> +                       if (!(opts->flag & MENU_OPTS_SINGLETON)) {
> +                               char *p = choice.buf;
> +                               do {
> +                                       if (*p == ',')
> +                                               *p = ' ';
> +                               } while (*p++);
> +                       }
> +                       strbuf_trim(&choice);
> +               } else {
> +                       eof = 1;
> +                       break;
> +               }
> +
> +               /* help for prompt */
> +               if (!strcmp(choice.buf, "?")) {
> +                       prompt_help_cmd(opts->flag & MENU_OPTS_SINGLETON);
> +                       continue;
> +               }
> +
> +               if (!(opts->flag & MENU_OPTS_SINGLETON) && !choice.len)
> +                       break;
> +
> +               choice_list = strbuf_split_max(&choice, ' ', 0);
Should be freed later

> +               for (i = 0; choice_list[i]; i++) {
> +                       int choose = 1;
> +                       int bottom = 0, top = 0;
> +                       char *p;
> +                       int is_range = 0;
> +                       int is_number = 1;
> +
> +                       strbuf_trim(choice_list[i]);
> +                       if (!choice_list[i]->len)
> +                               continue;
> +
> +                       /* Input that begins with '-'; unchoose */
> +                       if (*choice_list[i]->buf == '-') {
> +                               choose = 0;
> +                               strbuf_remove(choice_list[i], 0, 1);
> +                       }
> +
> +                       p = choice_list[i]->buf;
> +                       for(; *p; p++) {
> +                               if ('-' == *p) {
> +                                       if (!is_range) {
> +                                               is_range = 1;
> +                                               is_number = 0;
> +                                       } else {
> +                                               is_number = 0;
> +                                               is_range = 0;
> +                                               break;
> +                                       }
> +                               } else if (!isdigit(*p)) {
> +                                       is_number = 0;
> +                                       is_range = 0;
> +                                       break;
> +                               }
> +                       }
> +
> +                       if (is_number) {
> +                               bottom = atoi(choice_list[i]->buf);
> +                               top = bottom;
> +                       } else if (is_range) {
> +                               bottom = atoi(choice_list[i]->buf);
> +                               if (!*(strchr(choice_list[i]->buf, '-') + 1)) {
> +                                       top = stuff->nr - 1;
> +                               } else {
> +                                       top = atoi(strchr(choice_list[i]->buf, '-') + 1);
> +                               }
> +                       } else if (!strcmp(choice_list[i]->buf, "*")) {
> +                               bottom = 1;
> +                               top = stuff->nr;
> +                       } else {
> +                               if (MENU_STUFF_TYPE_MENU_ITEM == stuff->type) {
> +                                       struct menu_item *item;
> +
> +                                       item = (struct menu_item *)stuff->stuff;
> +                                       for (j = 0; j < stuff->nr; j++, item++) {
> +                                               if ((choice_list[i]->len == 1 &&
> +                                                    *choice_list[i]->buf == item->hotkey) ||
> +                                                   !strcasecmp(choice_list[i]->buf, item->title)) {
> +                                                       bottom = j + 1;
> +                                                       top = bottom;
> +                                                       break;
> +                                               }
> +                                       }
> +                               } else if (MENU_STUFF_TYPE_STRING_LIST == stuff->type) {
> +                                       struct string_list_item *item;
> +
> +                                       item = ((struct string_list *)stuff->stuff)->items;
> +                                       for (j = 0; j < stuff->nr; j++, item++) {
> +                                               if (!strcasecmp(choice_list[i]->buf, item->string)) {
> +                                                       bottom = j + 1;
> +                                                       top = bottom;
> +                                                       break;
> +                                               }
> +                                       }
> +                               }
> +                       }
> +
> +                       if (top <= 0 || bottom <= 0 || top > stuff-> nr || bottom > top ||
> +                           (opts->flag & MENU_OPTS_SINGLETON && bottom != top)) {
> +                               printf_ln("%sHuh (%s)?%s",
> +                                         clean_get_color(CLEAN_COLOR_ERROR),
> +                                         choice_list[i]->buf,
> +                                         clean_get_color(CLEAN_COLOR_RESET));
> +                               continue;
> +                       }
> +
> +                       /* A range can be specified like 5-7 or 5-. */
> +                       for (j = bottom; j <= top; j++) {
> +                               chosen[j-1] = choose;
> +                               nr++;
> +                       }
> +               }

+               strbuf_list_free(choice_list);

> +
> +               if (opts->flag & MENU_OPTS_SINGLETON) {
> +                       if (nr)
> +                               break;
> +               } else if (opts->flag & MENU_OPTS_IMMEDIATE) {
> +                       break;
> +               }
> +       }
> +
> +
> +       if (eof) {
> +               result = xmalloc(sizeof(int) * 2);
> +               result[0] = EOF;
> +               result[1] = 0;
Allocate one element is OK, like:

+               result = xmalloc(sizeof(int));
+               *result = EOF;

> +       } else {
> +               result = xmalloc(sizeof(int) * (nr + 1));
> +               memset(result, 0, sizeof(int) * (nr + 1));

Add initial for j here:

+               j = 0;

> +               for (i = 0, j = 0; i < stuff->nr && j < nr; i++) {
> +                       if (chosen[i])
> +                               result[j++] = i;
> +               }
> +               result[j] = EOF;
> +       }
> +
> +       free(chosen);
> +       string_list_clear(&menu_list, 0);
> +       strbuf_release(&menu);
> +       strbuf_release(&choice);
> +       return result;
> +}


-- 
Jiang Xin
