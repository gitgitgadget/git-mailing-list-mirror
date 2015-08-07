From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 02/11] ref-filter: introduce ref_formatting_state
Date: Thu, 6 Aug 2015 20:19:00 -0400
Message-ID: <CAPig+cQftyjKFi0Qkg_ZVEJ9A+zGSAmFtHwQ-8hCnf8xtU_PEA@mail.gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
	<1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
	<1438692188-14367-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 02:19:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNVNL-0002xd-O4
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 02:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbbHGATC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 20:19:02 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33817 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbbHGATB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 20:19:01 -0400
Received: by ykax123 with SMTP id x123so77052475yka.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 17:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mp5FNbO102PEwFsbGkpMrdxNQoJT1jIt2bQ3AOoM6SE=;
        b=TYhwaRqAoykNVnSgCrFFzdKL1hsmj4jEVn9JsxhjvwBNJZIMXoJQ141b9iKZGOfgVk
         W85RyGc1BjKkL9B/ch14HRSrf5lM3VQyyXpQV3xaSMAFGTtSNJF+KwoxIlGbxz8cEbhU
         TipNhT2UjP0YLt3TnBYxYaCH+EY0ucXA0IMQ4XOS2y9a3S6HTIKLV17Xvw6lwjLYCqeb
         V3alWIKhV7o36y5hQf1NQM0+5uS7zOLzl6COqtgUdF+9iDl5z8aK0h15mOvG+filYasA
         HfgEZ9Hsk6IkOE2GQG0P4qgjvlkZ7zVCKP75sEQJjBLLpdzODKrNdMTVejzRvxx8V201
         Veuw==
X-Received: by 10.13.220.132 with SMTP id f126mr4862742ywe.39.1438906740532;
 Thu, 06 Aug 2015 17:19:00 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 17:19:00 -0700 (PDT)
In-Reply-To: <1438692188-14367-2-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: 75GMavEC7ZhvQoB-Swh8wBdjMQk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275453>

On Tue, Aug 4, 2015 at 8:42 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce a ref_formatting_state which will eventually hold the values
> of modifier atoms. Implement this within ref-filter.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> +static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *final)
> +{
> +       /* More formatting options to be evetually added */
> +       strbuf_addbuf(final, state->output);
> +       strbuf_release(state->output);

I guess the idea here is that you intend state->output to be re-used
and it is convenient to "clear" it here rather than making that the
responsibility of each caller. For re-use, it is more typical to use
strbuf_reset() than strbuf_release() (though Junio may disagree[1]).

[1]: http://article.gmane.org/gmane.comp.version-control.git/273094

> +}
> +
>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>  {
>         const char *cp, *sp, *ep;
> -       struct strbuf output = STRBUF_INIT;
> +       struct strbuf value = STRBUF_INIT;
> +       struct strbuf final_buf = STRBUF_INIT;
> +       struct ref_formatting_state state;
>         int i;
>
> +       memset(&state, 0, sizeof(state));
> +       state.quote_style = quote_style;
> +       state.output = &value;

It feels strange to assign a local variable reference to state.output,
and there's no obvious reason why you should need to do so. I would
have instead expected ref_format_state to be declared as:

    struct ref_formatting_state {
       int quote_style;
       struct strbuf output;
    };

and initialized as so:

    memset(&state, 0, sizeof(state));
    state.quote_style = quote_style;
    strbuf_init(&state.output, 0);

(In fact, the memset() isn't even necessary here since you're
initializing all fields explicitly, though perhaps you want the
memset() because a future patch adds more fields which are not
initialized explicitly?)

This still allows re-use via strbuf_reset() mentioned above.

And, of course, you'd want to strbuf_release() it at the end of this
function where you're already releasing final_buf.

>         for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
> -               struct atom_value *atomv;
> +               struct atom_value *atomv = NULL;

What is this change about?

>                 ep = strchr(sp, ')');
> -               if (cp < sp)
> -                       emit(cp, sp, &output);
> +               if (cp < sp) {
> +                       emit(cp, sp, &state);
> +                       apply_formatting_state(&state, &final_buf);
> +               }
>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
> -               print_value(atomv, quote_style, &output);
> +               process_formatting_state(atomv, &state);
> +               print_value(atomv, &state);
> +               apply_formatting_state(&state, &final_buf);
>         }
>         if (*cp) {
>                 sp = cp + strlen(cp);
> -               emit(cp, sp, &output);
> +               emit(cp, sp, &state);
> +               apply_formatting_state(&state, &final_buf);

I'm getting the feeling that these functions
(process_formatting_state, print_value, emit, apply_formatting_state)
are becoming misnamed (again) with the latest structural changes (but
perhaps I haven't read far enough into the series yet?).

process_formatting_state() is rather generic.

print_value() and emit() both imply outputting something, but neither
does so anymore.

apply_formatting_state() seems to be more about finalizing the
already-formatted output.
