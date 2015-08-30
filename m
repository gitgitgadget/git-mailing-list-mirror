From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 07/13] ref-filter: add support for %(contents:lines=X)
Date: Sun, 30 Aug 2015 18:13:35 -0400
Message-ID: <CAPig+cTYQmrFnf7p6zxNh9w6AKXth99nRu40chQtUYAkWVss=w@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-8-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 00:13:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWAr7-0006fI-4c
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 00:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbbH3WNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 18:13:36 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36103 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbH3WNg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 18:13:36 -0400
Received: by ykey204 with SMTP id y204so29896942yke.3
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ployW3Y4T0Hq/eAE6YDp1O50vt8QvKHzvlJ0FMNr908=;
        b=qbnU8q8i/PIvXLNk969Zda0Lw//kO8x5xP32yJR/e49yqVPA693z9y+Mr3vlY0Pq4T
         Zqi9fieSBMAPMuiVdx7LWvZkf+3GHwH6188PK1zBr3c5uO3dqbscg78lxBkCiz2QcXEx
         coFKb6njjmIE6oAtLWhgSrBGv1o8Wcqijhz9l82aVH5GUvOg1O7YdIJIhRSRS4hHXUhH
         sDiye29bB+XzzvuuCNZel0q6qMK/VHu4BmfRY0urng1IFS6qxeb+21K/VDTIGyn1o2DJ
         mOSwNoq8fLiSrRn0HyvegxOvKvuqTbZcaqJzhc07CRXyf6fVj4iBn7chufN3f1OfCHcZ
         XcyA==
X-Received: by 10.129.83.136 with SMTP id h130mr19336438ywb.95.1440972815670;
 Sun, 30 Aug 2015 15:13:35 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 30 Aug 2015 15:13:35 -0700 (PDT)
In-Reply-To: <1440857537-13968-8-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: _xuGcqtcrQu_ROLsFTvp5SolVlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276842>

On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> In 'tag.c' we can print N lines from the annotation of the tag using
> the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
> modify it to support appending of N lines from the annotation of tags
> to the given strbuf.
>
> Implement %(contents:lines=X) where X lines of the given object are
> obtained.
>
> Add documentation and test for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> @@ -608,6 +672,15 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>                         v->s = xmemdupz(sigpos, siglen);
>                 else if (!strcmp(name, "contents"))
>                         v->s = xstrdup(subpos);
> +               else if (skip_prefix(name, "contents:lines=", &valp)) {
> +                       struct contents *contents = xmalloc(sizeof(struct contents));
> +
> +                       if (strtoul_ui(valp, 10, &contents->lines))
> +                               die(_("positive width expected align:%s"), valp);

I forgot to mention this when I reviewed the patch earlier[1], but you
copied this error message a bit too literally from the %(align:) atom.

[1]: http://article.gmane.org/gmane.comp.version-control.git/276807

> +                       hashcpy(contents->oid.hash, obj->sha1);
> +                       v->handler = contents_lines_handler;
> +                       v->contents = contents;
> +               }
>         }
>  }
