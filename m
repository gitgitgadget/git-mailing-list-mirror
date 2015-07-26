From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 02/10] ref-filter: make the 'color' use ref_formatting_state
Date: Sun, 26 Jul 2015 00:12:39 -0400
Message-ID: <CAPig+cQEKrjePskjSacrf3SbLZR7_ADxTLwcV7vBPcjUxBLiEg@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 06:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJDIr-00075h-9e
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 06:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbbGZEMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 00:12:40 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33418 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbbGZEMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 00:12:39 -0400
Received: by ykfw194 with SMTP id w194so47120724ykf.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 21:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=M7VOyhn2oiub/WyO17bt2yQVNUp4agbjtJ6fyMtBDDE=;
        b=x0rEEnFXJmriEmf0r4dIdqPc2Njk2oSesQ9QSRriLH3e/4D8MaQProfgtpB1FW7/CS
         LfzLTwqCzdb+hh3NW4EuzaH9A/KuviUNCuGATzOL5X03pIWvXeTyPlJcsrEl66CX8esG
         1xnVuimVC4nqDZ9AjScfeSSm0xXxeeBwC7w25fFwsDtg+seVDXqML8gJhHsBzGUAZZvl
         DCuXb3RaQ1GRvfsq2MkFllpN69HfCfzdutqpb2fMueQHFiCk2+cgcuDHmgmP5GhyAoFw
         kbceKUaU1UeBnnuCS7JB1NFM2oLXgdbQbP9fqMlpEh6LYSt+rQtnKXmlxXqsnQ8qYzz5
         97WQ==
X-Received: by 10.129.91.87 with SMTP id p84mr23942299ywb.95.1437883959190;
 Sat, 25 Jul 2015 21:12:39 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 25 Jul 2015 21:12:39 -0700 (PDT)
In-Reply-To: <1437764685-8633-3-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: 3DW_SKDp1aORMgZ4gSJOygojXgk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274626>

On Fri, Jul 24, 2015 at 3:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Make color which was considered as an atom, to use
> ref_formatting_state and act as a pseudo atom. This allows
> interchangeability between 'align' and 'color'.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 3c90ffc..fd13a23 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -663,7 +663,8 @@ static void populate_value(struct ref_formatting_state *state,
> -                       v->s = xstrdup(color);
> +                       state->color = xstrdup(color);
> +                       v->pseudo_atom = 1;
> @@ -1217,6 +1218,11 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
> +       if (state->color) {
> +               strbuf_addstr(value, state->color);
> +               free((void *)state->color);
> +               state->color = NULL;
> +       }
> @@ -1326,7 +1333,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
> -               resetv.s = color;
> +               resetv.s = "";
> +               state.color = xstrdup(color);
> diff --git a/ref-filter.h b/ref-filter.h
> index ea2d0e6..bacbb23 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -31,6 +31,7 @@ struct ref_sorting {
>  struct ref_formatting_state {
>         unsigned int pad_to_right; /*pad atoms to the right*/
>         int quote_style;
> +       const char *color;
>  };

Should 'color' should be declared 'char *' rather than 'const char *'?
It's always assigned via xstrdup(), and if declared 'char *', you
wouldn't have to cast away the 'const' when freeing it.
