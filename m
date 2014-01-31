From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 03/17] trailer: read and process config information
Date: Fri, 31 Jan 2014 10:43:47 -0500
Message-ID: <CAPig+cSZhZXXDvrAQfsL5FYrSUro89mLa=DXvFGtCnemeM4oSg@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.3711.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 31 16:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9GG3-0004Gz-3i
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 16:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbaAaPnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 10:43:50 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34690 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170AbaAaPns (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 10:43:48 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so24471315ykr.9
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 07:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=R+lnHyESyeMibhE32wl9Ijrs+gH+5utRZgNerc76uJI=;
        b=n8v5w6cHVrjPMvIzWj6kYQg1iisHjht5OsGcC9zeAoJZT4JDRZfJn5/QzQHB5/MtQx
         eqbSQeOOSuU0yH4FlcDyCy5xFiTxjPBPAw2nnPs3XAX4v6yTlvpOwMeTPIt0gKLf7wsP
         LXfpTY7vyE+FsUwH4yTb3m1nSI+izP7N8inZQI76P6LhFCX4OWe/HTP2HTbGyr7+xAK+
         JLz3RZHRshOKkevrZrhCpG3tFIPb7A5P4g9D6pGpqJPWoKFiUcZEjClz/qy+2Z+MJY1h
         FP9/bVXiEXq643xiB1ag9d0xvxtuvI5ttMizqfSeoaawWmf0DnNj43Fcuh7Y8FUmOD+m
         Pi2Q==
X-Received: by 10.236.168.166 with SMTP id k26mr2221185yhl.64.1391183027984;
 Fri, 31 Jan 2014 07:43:47 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Fri, 31 Jan 2014 07:43:47 -0800 (PST)
In-Reply-To: <20140130064921.7504.3711.chriscool@tuxfamily.org>
X-Google-Sender-Auth: lwHqBi2B0gTfOjMuODIQJRH_tT4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241299>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This patch implements reading the configuration
> to get trailer information, and then processing
> it and storing it in a doubly linked list.
>
> The config information is stored in the list
> whose first item is pointed to by:
>
> static struct trailer_item *first_conf_item;
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/trailer.c b/trailer.c
> index e9ccfa5..d979a0f 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -235,3 +237,128 @@ static void process_trailers_lists(struct trailer_item **infile_tok_first,
> +static struct trailer_item *get_conf_item(char *name)

Should this be 'const char *'?

> +{
> +       struct trailer_item *item;
> +       struct trailer_item *previous;
> +
> +       /* Look up item with same name */
> +       for (previous = NULL, item = first_conf_item;
> +            item;
> +            previous = item, item = item->next) {
> +               if (!strcasecmp(item->conf->name, name))
> +                       return item;
> +       }
> +
> +       /* Item does not already exists, create it */
> +       item = xcalloc(sizeof(struct trailer_item), 1);
> +       item->conf = xcalloc(sizeof(struct conf_info), 1);
> +       item->conf->name = xstrdup(name);
> +
> +       if (!previous)
> +               first_conf_item = item;
> +       else {
> +               previous->next = item;
> +               item->previous = previous;
> +       }
> +
> +       return item;
> +}
> +
> +static int git_trailer_config(const char *conf_key, const char *value, void *cb)
> +{
> +       if (starts_with(conf_key, "trailer.")) {
> +               const char *orig_conf_key = conf_key;
> +               struct trailer_item *item;
> +               struct conf_info *conf;
> +               char *name;
> +               enum trailer_info_type type;
> +
> +               conf_key += 8;
> +               if (!set_name_and_type(conf_key, ".key", TRAILER_VALUE, &name, &type) &&
> +                   !set_name_and_type(conf_key, ".command", TRAILER_COMMAND, &name, &type) &&
> +                   !set_name_and_type(conf_key, ".where", TRAILER_WHERE, &name, &type) &&
> +                   !set_name_and_type(conf_key, ".ifexist", TRAILER_IF_EXIST, &name, &type) &&
> +                   !set_name_and_type(conf_key, ".ifmissing", TRAILER_IF_MISSING, &name, &type))
> +                       return 0;
> +
> +               item = get_conf_item(name);
> +               conf = item->conf;
> +
> +               if (type == TRAILER_VALUE) {
> +                       if (conf->key)
> +                               warning(_("more than one %s"), orig_conf_key);
> +                       conf->key = xstrdup(value);
> +               } else if (type == TRAILER_COMMAND) {
> +                       if (conf->command)
> +                               warning(_("more than one %s"), orig_conf_key);
> +                       conf->command = xstrdup(value);
> +               } else if (type == TRAILER_WHERE) {
> +                       if (set_where(conf, value))
> +                               warning(_("unknown value '%s' for key '%s'"), value, orig_conf_key);
> +               } else if (type == TRAILER_IF_EXIST) {
> +                       if (set_if_exist(conf, value))
> +                               warning(_("unknown value '%s' for key '%s'"), value, orig_conf_key);
> +               } else if (type == TRAILER_IF_MISSING) {
> +                       if (set_if_missing(conf, value))
> +                               warning(_("unknown value '%s' for key '%s'"), value, orig_conf_key);
> +               } else
> +                       die("internal bug in trailer.c");

A 'switch' statement might be more idiomatic and easier to read.

> +       }
> +       return 0;
> +}
> --
> 1.8.5.2.201.gacc5987
