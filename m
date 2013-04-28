From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Add support for -i/--interactive to git-clean
Date: Sat, 27 Apr 2013 22:03:26 -0400
Message-ID: <CAPig+cTRqB7pGcxmW_m=AGT_nRWxgR+X8z6FR3PgONJ-0kG2fA@mail.gmail.com>
References: <7vmwslw1py.fsf@alter.siamese.dyndns.org>
	<2a68239bfd3e6b9ea1842dd8e468ee3d3217af5b.1367079089.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 04:03:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWGxh-0004v6-Fx
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 04:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368Ab3D1CD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 22:03:29 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:64804 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325Ab3D1CD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 22:03:28 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so4669441lbd.24
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 19:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=rAHWNIRPWjedyzqUdToeKm8WEblY6QwBNSnizCf663E=;
        b=0+IZ0p5anouikkE+69HElflFoaNEIqdceo9TGhjUFDxU3ETaAqC5splUus1vYgOunH
         UB4juT9+QzW0Fugb88jS+UaK5iSXDtv/CHDIvnMOSZXpLlhIZUroYWpvrkRIvLOtOaWj
         PxkgRlQPIl0nX/EdFoXec7fj6Y0dKrVFOcnMAo1PnNrimFD/HD4VdPOza6n7236z8UKW
         0tdAVX9ocWTcJ+KfLCfZFYrGMOtexjFwuw/kRq6ITU5hXKHtbFdiLfkRZWK5o40bVBgZ
         ao9CqnMG2/BuQmY9e4SikuIrygpDXagbjtmDqbDcK9D8koyow2wEm6hLKxCRdcn2xm6Y
         EjcQ==
X-Received: by 10.112.130.196 with SMTP id og4mr655988lbb.52.1367114606667;
 Sat, 27 Apr 2013 19:03:26 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Sat, 27 Apr 2013 19:03:26 -0700 (PDT)
In-Reply-To: <2a68239bfd3e6b9ea1842dd8e468ee3d3217af5b.1367079089.git.worldhello.net@gmail.com>
X-Google-Sender-Auth: SLTcQ-7ELg72RVVmoB7Yiqh2hW8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222724>

On Sat, Apr 27, 2013 at 12:13 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -257,26 +261,92 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>                 }
>
>                 if (S_ISDIR(st.st_mode)) {
> -                       strbuf_addstr(&directory, ent->name);
>                         if (remove_directories || (matches == MATCHED_EXACTLY)) {
> -                               if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
> -                                       errors++;
> -                               if (gone && !quiet) {
> -                                       qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
> -                                       printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
> -                               }
> +                               string_list_append(&dels, ent->name);
>                         }
> -                       strbuf_reset(&directory);
>                 } else {
>                         if (pathspec && !matches)
>                                 continue;
> -                       res = dry_run ? 0 : unlink(ent->name);
> +                       string_list_append(&dels, ent->name);
> +               }
> +       }
> +
> +       if (interactive && dels.nr > 0 && !dry_run && isatty(0) && isatty(1)) {
> +               struct strbuf confirm = STRBUF_INIT;
> +
> +               while (1) {
> +                       struct strbuf **prefix_list, **prefix_list_head;
> +
> +                       /* dels list may become empty when we run string_list_remove_empty_items latter */

s/latter/later/

> +                       if (!dels.nr)
> +                               break;
> +
> +                       for_each_string_list_item(item, &dels) {
> +                               qname = quote_path_relative(item->string, -1, &buf, prefix);
> +                               printf(_(msg_would_remove), qname);
> +                       }
> +
> +                       printf(_("Remove (press enter to confirm or input items you want to keep)? "));
> +                       strbuf_getline(&confirm, stdin, '\n');
> +                       strbuf_trim(&confirm);
> +
> +                       if (!confirm.len)
> +                               break;
> +
> +                       printf("\n");
> +
> +                       prefix_list_head = strbuf_split_buf(confirm.buf, confirm.len, ' ', 0);
> +                       for (prefix_list = prefix_list_head; *prefix_list; *prefix_list++)
> +                       {
> +                               int prefix_matched = 0;
> +
> +                               strbuf_trim(*prefix_list);
> +                               if (!(*prefix_list)->len)
> +                                       continue;
> +
> +                               for_each_string_list_item(item, &dels) {
> +                                       if (!strncasecmp(item->string, (*prefix_list)->buf, (*prefix_list)->len)) {
> +                                               *item->string = '\0';
> +                                               prefix_matched++;
> +                                       }
> +                               }
> +                               if (!prefix_matched) {
> +                                       warning(_("Cannot find items start with the given prefix: %s"), (*prefix_list)->buf);

s/start/starting/
[...or...]
s/items start with the given prefix/items prefixed by/

> +                                       printf("\n");
> +                               } else {
> +                                       string_list_remove_empty_items(&dels, 0);
> +                               }
> +                       }
> +
> +                       strbuf_reset(&confirm);
> +                       strbuf_list_free(prefix_list_head);
> +               }
> +               strbuf_release(&confirm);
> +       }
> +
> +       for_each_string_list_item(item, &dels) {
> +               struct stat st;
> +
> +               if (lstat(item->string, &st))
> +                       continue;
> +
> +               if (S_ISDIR(st.st_mode)) {
> +                       strbuf_addstr(&directory, item->string);
> +                       if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
> +                               errors++;
> +                       if (gone && !quiet) {
> +                               qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
> +                               printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
> +                       }
> +                       strbuf_reset(&directory);
> +               } else {
> +                       res = dry_run ? 0 : unlink(item->string);
>                         if (res) {
> -                               qname = quote_path_relative(ent->name, -1, &buf, prefix);
> +                               qname = quote_path_relative(item->string, -1, &buf, prefix);
>                                 warning(_(msg_warn_remove_failed), qname);
>                                 errors++;
>                         } else if (!quiet) {
> -                               qname = quote_path_relative(ent->name, -1, &buf, prefix);
> +                               qname = quote_path_relative(item->string, -1, &buf, prefix);
>                                 printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
>                         }
>                 }
