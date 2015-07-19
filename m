From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Sun, 19 Jul 2015 19:49:36 -0400
Message-ID: <CAPig+cRXsmi=UxRr-3rnt919d86jD6uMuTqdDxCComYLXk1TYw@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 01:54:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGyPq-0002yc-LO
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 01:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbbGSXth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 19:49:37 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36088 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbbGSXtg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 19:49:36 -0400
Received: by ykay190 with SMTP id y190so127745538yka.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 16:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ooe4Z58Xgj+T0WMPN0fGV1HqVqoP8+KtW1O6Ku1d1PQ=;
        b=OYl1TJhBcMAM6wPBDbCZz6580svKwj6l7vwcMIIUS5YDrv/cayHX/vkjtGqNan8BN4
         35hk2W8DgUi2nS1hKkAyXeyuIwpz5AWDouAwTVzmunu1K4Krphq23LzxOH765ALSjuOl
         h7XcAw3Geci9fGVDIlZdl++4UC/Eo4N/ncdcBDbHO6Eq8ryJXgyCYcU1mK9L+276QsCi
         kDk5sXyAKcQqFNGWyKCYi5dVBry2a0F64hCpMd76uMuIEPl4bRfdlNu9QK1Kp9rn5wLz
         xehR4sWF1T4xBaaxnbdmtp5fezmxLCZyiApI+dl++kW0/Q5ZsYo+Pv6mvXvo+e+vMA/A
         tjBQ==
X-Received: by 10.170.112.72 with SMTP id e69mr4252444ykb.69.1437349776113;
 Sun, 19 Jul 2015 16:49:36 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 19 Jul 2015 16:49:36 -0700 (PDT)
In-Reply-To: <1437246749-14423-2-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: MRhZdms8ODlOoopWLG-IsQe5wTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274299>

On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add a new atom "align" and support %(align:X) where X is a number.
> This will align the preceeding atom value to the left followed by
> spaces for a total length of X characters. If X is less than the item
> size, the entire atom value is printed.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 7561727..b81a08d 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -53,6 +55,7 @@ static struct {
>         { "flag" },
>         { "HEAD" },
>         { "color" },
> +       { "align" },

Not a new issue, but some compilers (Solaris?) complain about the
trailing comma.

>  };
>
>  /*
> @@ -687,6 +690,17 @@ static void populate_value(struct ref_array_item *ref)
>                         else
>                                 v->s = " ";
>                         continue;
> +               } else if (starts_with(name, "align:")) {
> +                       const char *valp = NULL;
> +
> +                       skip_prefix(name, "align:", &valp);
> +                       if (!valp[0])
> +                               die(_("No value given with 'align='"));

The parser expects "align:", but the error message talks about
"align=". Also, current trend is to drop capitalization from the error
message.

> +                       strtoul_ui(valp, 10, &ref->align_value);
> +                       if (ref->align_value < 1)
> +                               die(_("Value should be greater than zero"));

Drop capitalization. Also, the user seeing this message won't
necessarily know to which value this refers. Better would be to
provide context ("'align:' value should be..."), and even better would
be to show the actual value at fault:

    die(_("value should be greater than zero: align:%u\n",
        ref_align_value);

or something.

> +                       v->s = "";
> +                       continue;
>                 } else
>                         continue;
>
> @@ -1254,17 +1268,38 @@ static void emit(const char *cp, const char *ep)
>         }
>  }
>
> +static void assign_formating(struct ref_array_item *ref, int parsed_atom, struct atom_value *v)
> +{
> +       if (v->s[0] && ref->align_value) {

Mental note: v->s[0] is not NUL ('\0').

Also, in this code base, this is typically written *v->s rather than v->s[0].

> +               unsigned int len = 0;
> +               len = utf8_strwidth(v->s);

You initialize 'len' to 0 but then immediately re-assign it.

> +               if (ref->align_value > len) {
> +                       struct strbuf buf = STRBUF_INIT;
> +                       strbuf_addstr(&buf, v->s);
> +                       if (!v->s[0])
> +                               free((char *)v->s);

We know from the "mental note" above that v->s[0] is not NUL ('\0'),
so this 'if' statement can never be true, thus is dead code.

> +                       strbuf_addchars(&buf, ' ', ref->align_value - len);
> +                       v->s = strbuf_detach(&buf, NULL);
> +               }
> +               ref->align_value = 0;
> +       }
> +}
