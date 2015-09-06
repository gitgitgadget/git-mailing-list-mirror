From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] am: match --signoff to the original scripted version
Date: Sun, 6 Sep 2015 22:21:09 +0800
Message-ID: <CACRoPnQvNowZGbqvRLuhS8cC1EaTQX3vsyaESSQVXpuRToWLOQ@mail.gmail.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 16:21:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYapN-0006BV-AW
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 16:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbbIFOVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 10:21:40 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35758 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbbIFOVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 10:21:11 -0400
Received: by lbpo4 with SMTP id o4so28947943lbp.2
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5Ej08DgDdKVKRwhGm95lHcN9rVJDMmEYQ23IbWRbq7o=;
        b=ZLQV1D7HKL0muQOo8nl4bXm8ip45JIG0HrhuyCsjprQKVl55KOlde/7zzAqys9x016
         sDduH+lieatS15pOObXvSM+Xt1yRIZK/jBotWTlDS/A/eCw9BIt7torqCTQrLQhjvMJC
         CtZI79IPI305o+uZxcU2jZk6mNQ/vX9i78bMyqyrIhsL2m3pUER+ScGMgRZXZZlB5kJd
         Ik06pgbB14aXcg0ypSUBXZMwoWThlqutKeTnEnHRm+AZ9E6Bm7UKVy7nwvo60NjqZ7s4
         VJBS3g6c1IoK1JiEjHapdAARHAa64TftdT3WHvi4Q1lKglUqHFTCltLQEqis2hWDISeX
         TCgg==
X-Received: by 10.112.170.103 with SMTP id al7mr12774363lbc.66.1441549270042;
 Sun, 06 Sep 2015 07:21:10 -0700 (PDT)
Received: by 10.112.181.71 with HTTP; Sun, 6 Sep 2015 07:21:09 -0700 (PDT)
In-Reply-To: <xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277426>

On Sun, Sep 6, 2015 at 12:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> diff --git a/builtin/am.c b/builtin/am.c
> index 634f7a7..e7828e5 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1191,6 +1191,33 @@ static void NORETURN die_user_resolve(const struct am_state *state)
>         exit(128);
>  }
>
> +static void am_signoff(struct strbuf *sb)
> +{
> +       char *cp;
> +       struct strbuf mine = STRBUF_INIT;
> +
> +       /* Does it end with our own sign-off? */
> +       strbuf_addf(&mine, "\n%s%s\n",
> +                   sign_off_header,
> +                   fmt_name(getenv("GIT_COMMITTER_NAME"),
> +                            getenv("GIT_COMMITTER_EMAIL")));
> +       if (mine.len < sb->len &&
> +           !strcmp(mine.buf, sb->buf + sb->len - mine.len))
> +               goto exit; /* no need to duplicate */
> +
> +       /* Does it have any Signed-off-by: in the text */
> +       for (cp = sb->buf;
> +            cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
> +            cp = strchr(cp, '\n')) {
> +               if (sb->buf == cp || cp[-1] == '\n')
> +                       break;
> +       }
> +
> +       strbuf_addstr(sb, mine.buf + !!cp);

To add on, I wonder if the above "add a blank line if there is no
Signed-off-by: at the beginning of a line" logic could be expressed
more succinctly like this:

    if (!starts_with(sb->buf, "Signed-off-by: ") &&
        !strstr(sb->buf, "\nSigned-off-by: "))
        strbuf_addch(sb, '\n');

    strbuf_addstr(sb, mine.buf + 1);

> +exit:
> +       strbuf_release(&mine);
> +}
> +
>  /**
>   * Appends signoff to the "msg" field of the am_state.
>   */

Regards,
Paul
