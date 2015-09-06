From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v16 06/14] ref-filter: implement an `align` atom
Date: Sun, 6 Sep 2015 16:10:34 -0400
Message-ID: <CAPig+cS28v552BZ63PTKrchYc4M-GYMhhEyfcHXW89vqvYhcOQ@mail.gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
	<1441479135-5285-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 22:10:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYgGu-0007EX-36
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 22:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbbIFUKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 16:10:36 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34559 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbbIFUKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 16:10:35 -0400
Received: by ykdg206 with SMTP id g206so64407928ykd.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ppL+0zJjTS1f4HwSKFYBwC6+LpNgejkd+FiEx23p3n8=;
        b=wBtAlTtxQNxYiCSl/Vr99lKDAzTVuuw+c5R4AOjMNsC0zHC/HsmvDL7N3XlV5K8ren
         qNH+dYONOjAgnVIUaPxJe91IybXnt/SyrbseIQG9kvtgnJpERubYpQcitIIoOpKMIDM0
         8QK0ldMTWIX813prLeslGLulxY5vf46H/lMsK8hdWyU9MTALNiJwVyib3iFTCCakR+GL
         5UvqzJIY/hfgUidLhh+ybxLx4tmwvAK/hr8qIlTHEpqIGd3jou2Qs55FYcaNTWn/NPcX
         VVQ0i/q5CGHK56jlh5IRwT6dTWWB3bS4ZAisXrXH8RPrnsLRuO4OdB5ekHNiflqHEmhL
         XuRQ==
X-Received: by 10.129.134.3 with SMTP id w3mr16272996ywf.48.1441570234549;
 Sun, 06 Sep 2015 13:10:34 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 6 Sep 2015 13:10:34 -0700 (PDT)
In-Reply-To: <1441479135-5285-7-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: oW8xA43jPH_SE361TIep9theqwM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277438>

On Sat, Sep 5, 2015 at 2:52 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Implement an `align` atom which left-, middle-, or right-aligns the
> content between %(align:...) and %(end).
>
> It is followed by `:<width>,<position>`, where the `<position>` is
> either left, right or middle and `<width>` is the size of the area
> into which the content will be placed. If the content between
> %(align:...) and %(end) is more than the width then no alignment is
> performed. e.g. to align a refname atom to the middle with a total
> width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".
>
> We introduce an `at_end` function for each element of the stack which
> is to be called when the `end` atom is encountered. Using this we
> implement end_align_handler() for the `align` atom, this aligns the
> final strbuf by calling `strbuf_utf8_align()` from utf8.c.
>
> Ensure that quote formatting is performed on the whole of
> %(align:...)...%(end) rather than individual atoms inside. We skip
> quote formatting for individual atoms when the current stack element
> is handling an %(align:...) atom and perform quote formatting at the
> end when we encounter the %(end) atom of the second element of then
> stack.
>
> Add documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index e49d578..b23412d 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -127,6 +127,16 @@ color::
> +align::
> +       Left-, middle-, or right-align the content between %(align:...)
> +       and %(end). Followed by `:<width>,<position>`, where the
> +       `<position>` is either left, right or middle and `<width>` is
> +       the total length of the content with alignment. If the

This should mention that <position> is optional and default to "left"
if omitted.

> +       contents length is more than the width then no alignment is
> +       performed. If used with '--quote' everything in between
> +       %(align:...) and %(end) is quoted, but if nested then only the
> +       topmost level performs quoting.
> diff --git a/ref-filter.c b/ref-filter.c
> index e99c342..6c9ef08 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -773,6 +837,50 @@ static void populate_value(struct ref_array_item *ref)
>                         else
>                                 v->s = " ";
>                         continue;
> +               } else if (match_atom_name(name, "align", &valp)) {
> +                       struct align *align = &v->u.align;
> +                       struct strbuf **s;
> +
> +                       if (!valp)
> +                               die(_("expected format: %%(align:<width>, <position>)"));

I'm pretty sure this parsing code won't deal well with a space after
the comma, so the space should be dropped from the diagnostic message
advising the user of the correct format: s/, /,/

> +                       /*
> +                        * TODO: Implement a function similar to strbuf_split_str()
> +                        * which would strip the terminator at the end.

"...which would omit the separator from the end of each value."

> +                        */
> +                       s = strbuf_split_str(valp, ',', 0);
> +
> +                       /* If the position is given trim the ',' from the first strbuf */
> +                       if (s[1])
> +                               strbuf_setlen(s[0], s[0]->len - 1);
> +                       if (s[2])
> +                               die(_("align:<width>,<position> followed by garbage: %s"), s[2]->buf);

If <position> is omitted, strbuf_split_str("42", ...) will return the
array ["42", NULL] which won't have an element [2], which means this
code will access beyond end-of-array. (This is another good argument
for looping over s[] as Junio suggested rather than assuming these
fixed yet optional positions. It can be hard to get it right.)

> +                       if (strtoul_ui(s[0]->buf, 10, &align->width))
> +                               die(_("positive width expected align:%s"), s[0]->buf);
> +
> +                       /*
> +                        * TODO: Implement a more general check, so that the values
> +                        * do not always have to be in a specific order.
> +                        */
> +                       if (!s[1])
> +                               align->position = ALIGN_LEFT;
> +                       else if (!strcmp(s[1]->buf, "left"))
> +                               align->position = ALIGN_LEFT;
> +                       else if (!strcmp(s[1]->buf, "right"))
> +                               align->position = ALIGN_RIGHT;
> +                       else if (!strcmp(s[1]->buf, "middle"))
> +                               align->position = ALIGN_MIDDLE;
> +                       else
> +                               die(_("improper format entered align:%s"), s[1]->buf);
> +
> +                       strbuf_list_free(s);
> +
> +                       v->handler = align_atom_handler;
> +                       continue;
> +               } else if (!strcmp(name, "end")) {
> +                       v->handler = end_atom_handler;
> +                       continue;
>                 } else
>                         continue;
