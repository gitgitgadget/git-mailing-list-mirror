From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 05/13] ref-filter: implement an `align` atom
Date: Thu, 20 Aug 2015 16:23:57 -0400
Message-ID: <CAPig+cRB86+1D_CrVjoLxopgf-Rd221Q49UP75hTsZSPdN6QrQ@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 22:24:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSWNX-0001xg-G7
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 22:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbbHTUX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 16:23:59 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34695 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbbHTUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 16:23:58 -0400
Received: by ykdt205 with SMTP id t205so50477539ykd.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=V5AvETanXIv+HCSdDrDK6qXaGLw5pcwZ/yzcO4Mjkcs=;
        b=b3Ifw1HnvvYlxWs6pB/tw3pFW9Afshp4HUvUbxnQ/+I+k6cHAO4haUi4ogZnZmtU1e
         BeYr1Q/O+wXswO/LgzxCDPW+bSTXT+znwK+hfPbK4AW9LJWY5L2T6z3CAtVTM+JRmsWe
         otC+dalIzVTpMILj5lbuY4GVae0Ll0h1md7ydqKb1BWSgGxiM3SGpHiHIKDYZXW0stmm
         gT/aWxSRrEyGCfalhzo5s9OXxqQoewqhaBSUy+WsWLzHna8kcg6DrCwPFhdub6phX3gG
         RXlJdadVCdH9iGREpcGtjvP2zBq02GjQx4o18hZR5r29ql9a2oNEtTs695zPxuO1is/C
         iESg==
X-Received: by 10.129.134.3 with SMTP id w3mr6457680ywf.48.1440102238041; Thu,
 20 Aug 2015 13:23:58 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 20 Aug 2015 13:23:57 -0700 (PDT)
In-Reply-To: <1439923052-7373-6-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: e4Zp8-Lf1Lgm5uNNfv4dv_TWWuY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276264>

On Tue, Aug 18, 2015 at 2:37 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Implement an `align` atom which left-, middle-, or right-aligns the
> content between %(align:..) and %(end).
>
> It is followed by `:<width>,<position>`, where the `<position>` is
> either left, right or middle and `<width>` is the size of the area
> into which the content will be placed. If the content between
> %(align:) and %(end) is more than the width then no alignment is
> performed. e.g. to align a refname atom to the middle with a total
> width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".
>
> We now have a `handler()` for each atom_value which will be called
> when that atom_value is being parsed, and similarly an `at_end`
> function for each state which is to be called when the `end` atom is
> encountered. Using this implement the `align` atom which aligns the
> given strbuf by calling `strbuf_utf8_align()` from utf8.c
>
> This is done by assigning a 'handler' function to each atom_value and
> a related 'at_end' function for each state. The align_handler()
> defined uses strbuf_utf8_align() from utf8.c to perform the alignment.
>
> Add documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 74532d3..ecbcc5a 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -626,6 +638,36 @@ static inline char *copy_advance(char *dst, const char *src)
>         return dst;
>  }
>
> +static void align_handler(struct ref_formatting_state *state)
> +{
> +       struct align *align = (struct align *)state->cb_data;
> +       struct strbuf s = STRBUF_INIT;
> +
> +       strbuf_utf8_align(&s, align->position, align->width, state->output.buf);
> +       strbuf_reset(&state->output);
> +       strbuf_addbuf(&state->output, &s);
> +       free(align);
> +}

Leaking 'strbuf s' here.

Also, this operation can be expressed more concisely as:

    strbuf_utf8_align(&s, ...);
    strbuf_swap(&state->output, &s);
    strbuf_release(&s);

Seeing this is also making me question my earlier suggestion of making
pop_state() responsible for appending the current state's output to
the previous state's output. The reason is that if align_handler() is
responsible for appending to the previous state's output, then all the
above string handling collapses to the one line:

    strbuf_utf8_align(&state->prev->output, ..., state->output.buf);

which is even simpler, and doesn't involve a temporary strbuf or
swapping of strbuf contents.

On the other hand, it won't always be the case that all handlers can
get by with such simple code, and they might end up creating temporary
strbuf(s) and such anyhow, so I don't feel too strongly about it, and
it can always be changed at a later date (by someone) if that approach
ends up being better.
