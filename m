From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] transport-helper: barf when user tries --dry-run
Date: Mon, 20 May 2013 20:31:49 -0500
Message-ID: <CAMP44s0z1iuo+1gWU5dtp1vL1bneK72HrKWY91+ivavRHirgGg@mail.gmail.com>
References: <1369098554-11591-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 03:31:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UebQh-0006W9-Jg
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 03:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070Ab3EUBbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 21:31:51 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:39136 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab3EUBbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 21:31:51 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so83515lab.13
        for <git@vger.kernel.org>; Mon, 20 May 2013 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hEmurhALZzNsNLyalroRJ6udX/sZbg8AwoHMhqt6hpg=;
        b=kXz+0Yx0KhoBcCB7fIXt+3wVyddbVA9OgxxvxM7xwu67xYLelg9/RA1LMmQqMTflJS
         1o7hodShp8XKFgoZQWuJ9yDSgzBOIrI9rJOvVhGwFT4OWo8dqpoKsaI0uTktVir7LXCi
         KtrKPFQ21CI4VbSSL9fOf5rZzJK+xpezebji4SPk65tGg7CHvIuDrN97/q8VnwFpkzEW
         ibz0peP3bp2+GnjLvFEwJZJ7xH1iJ8T4t/mona2bUIwrhRH1dIP3oS7yHw+op1kQsnDy
         F+cxv7eO8N68dzbXrslJ1fQG143ZAVFKRS6LJofeuUwr4Vq7qZQ8VAA9wnGSw7OnI+uB
         p6hw==
X-Received: by 10.112.135.70 with SMTP id pq6mr311181lbb.82.1369099909695;
 Mon, 20 May 2013 18:31:49 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 20 May 2013 18:31:49 -0700 (PDT)
In-Reply-To: <1369098554-11591-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225011>

On Mon, May 20, 2013 at 8:09 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Certain remote-helpers (the ones with 'export') would try to push
> regardless.
>
> Obviously this is not what the user wants.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  transport-helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 522d791..daebdd9 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -789,6 +789,9 @@ static int push_refs_with_export(struct transport *transport,
>         struct string_list revlist_args = STRING_LIST_INIT_NODUP;
>         struct strbuf buf = STRBUF_INIT;
>
> +       if (flags & TRANSPORT_PUSH_DRY_RUN)
> +               die("helper %s does not support dry-run", data->name);
> +
>         helper = get_helper(transport);
>
>         write_constant(helper->in, "export\n");
> --

Actually, looking to the future, there's nothing that prevents
remote-helpers with 'export' to support dry-run, except this patch,
so:

--- a/transport-helper.c
+++ b/transport-helper.c
@@ -789,6 +789,11 @@ static int push_refs_with_export(struct transport
*transport,
        struct string_list revlist_args = STRING_LIST_INIT_NODUP;
        struct strbuf buf = STRBUF_INIT;

+       if (flags & TRANSPORT_PUSH_DRY_RUN) {
+               if (set_helper_option(transport, "dry-run", "true") != 0)
+                       die("helper %s does not support dry-run", data->name);
+       }
+
        helper = get_helper(transport);

        write_constant(helper->in, "export\n");

-- 
Felipe Contreras
