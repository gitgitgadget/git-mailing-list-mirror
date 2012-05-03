From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Breaking up Git's color emission for i18n
Date: Thu, 3 May 2012 20:35:16 +0700
Message-ID: <CACsJy8DO6OqjowV32V9S2ehaXHLD+F1UdCmE_JBY3wyM5RasKw@mail.gmail.com>
References: <CACBZZX7fE0CT5xV+QKPZ4BnkqdU0Lmd8LQU+45kjt+RM0meuEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, stimming@tuhh.de
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 15:35:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPwCH-0002sz-UG
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 15:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab2ECNft convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 09:35:49 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55910 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab2ECNfs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 09:35:48 -0400
Received: by wgbdr13 with SMTP id dr13so1761417wgb.1
        for <git@vger.kernel.org>; Thu, 03 May 2012 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=REFssEHVpC4Ry6JnDqXgDN5/podCcf3mjVh51V0iN7A=;
        b=flfy2J9NtFmM9peK+wl9NAC6mrorvznyeU/jfSFpggpFj10szIbA3ExpzlLbRRyUG4
         bwJ8K6+r1jpiCb8zqLiTOIsgu2wD+8bZyOW7oSzdSLd6t2iP0+ToVaJtPyOKvS5CEmmq
         QZ6yYF4RQmQlZ7QzagXHlrX9GQ1F2iY0MLhfPNtRxThDIBHr6pV6uBPxddbjIiYISX7x
         Cxti6XtPdoPES/3/T4mbDqtCaYFfExeLqOx+GgBz0fRmdjy8EK0QDCuiD/AzO/yqfDX1
         Vipezvnfhh17GYKoM0TZ2itSqvylrINo6ae/iiT/GZVwAeH0bLdLMs6QQ3JEauv3cyNp
         vIvg==
Received: by 10.180.78.105 with SMTP id a9mr3386517wix.20.1336052147638; Thu,
 03 May 2012 06:35:47 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Thu, 3 May 2012 06:35:16 -0700 (PDT)
In-Reply-To: <CACBZZX7fE0CT5xV+QKPZ4BnkqdU0Lmd8LQU+45kjt+RM0meuEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196908>

On Thu, May 3, 2012 at 5:56 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Whether that's the case or not I wonder how we could handle all these
> lego translations in wt-status.c.
>
> Currently we have stuff like this:
>
> =C2=A0 =C2=A0color_fprintf(s->fp, header_color, _("ahead "));
> =C2=A0 =C2=A0color_fprintf(s->fp, branch_color_local, "%d", num_ours)=
;
> =C2=A0 =C2=A0color_fprintf(s->fp, header_color, _(", behind "));
> =C2=A0 =C2=A0color_fprintf(s->fp, branch_color_remote, "%d", num_thei=
rs);
>
> That could be something clever like this:
>
> =C2=A0 =C2=A0color_fprintf("<color header>ahead</color> <color
> local>%d</color>, <color header>behind</color> <color
> local>%d/<color>", ...);

I am thinking of something more like "<color>ahead</color>
<ours>%d</ours>, <color>behind</color> <theirs>%d</theirs>". It gives
more context to translators.

Then we could do a simple search/replace:

struct tag_subst colors[] =3D {
    { "color", WT_STATUS_HEADER, GIT_COLOR_RESET },
    { "ours", WT_STATUS_LOCAL_BRANCH, GIT_COLOR_RESET },
    { "theirs", WT_STATUS_REMOTE_BRANCH, GIT_COLOR_RESET },
    { NULL, NULL, NULL }
};

strbuf_substitute_tags(buf, colors, "<color>ahead</color>
<ours>%d</ours>, <color>behind</color> <theirs>%d</theirs>", ours,
theirs);

It'd be even more great if strbuf_substitute_tags() can flatten nested
tags, so "<foo>abc<bar>def</bar>ghi</foo>" becomes
"<foo>abc</foo><bar>def</bar><foo>ghi</foo>".

The drawback is msgfmt does not catch malformed tags. But that already
happens for plenty other projects. Maybe msgfmt will learn that soon.

> We have some code in color_parse() in color.c for parsing colors, but
> I haven't spotted if it can parse embedded things like that.
>
> But I think an easier option is:
>
> =C2=A0 =C2=A0color_fprintf(%sahead%s %s%d%s, %sbehind%s %s%d%s",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0header_=
color_begin,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0color_r=
eset,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0branch_=
color_begin,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_our=
s,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0color_r=
eset,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0);
>
> Which we already use in e.g. branch.c:
>
> =C2=A0 =C2=A0strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(col=
or),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0maxwidth, name.buf,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0branch_get_color(BRANCH_COLO=
R_RESET));
>
> That would result in lots of arguments and fairly unintelligible
> format strings, but at least we wouldn't have to create some custom
> parser and the msgfmt --check option would check that we have all the
> formats there.
>
> We could also expose this as an internal command to do coloring for
> our shellscript libraries.
--=20
Duy
