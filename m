From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Breaking up Git's color emission for i18n
Date: Thu, 3 May 2012 00:56:24 +0200
Message-ID: <CACBZZX7fE0CT5xV+QKPZ4BnkqdU0Lmd8LQU+45kjt+RM0meuEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch, stimming@tuhh.de
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 03 00:56:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPiTe-0003as-8X
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 00:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab2EBW4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 18:56:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37124 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927Ab2EBW4s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 18:56:48 -0400
Received: by eaaq12 with SMTP id q12so341748eaa.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=or5a/uMvOiNtX5R+e/aKHkWEnSQTwTFewHb5IhyEMGg=;
        b=fYVNt3xMheNg5qH23WED1meZ2d/XSKtzDsLJAxd7Sy9fqLlPLF8czqHiCCTdsT6XSa
         dHFj6TLBt3AXctKW+wMYpcFaHZrA7KScJMK9WwELtyTLKH2UxFKNwgPBM/0Fqz21MJuQ
         6vtVwyrIYPCxOwuOzKd/kofFBRP5FtsIBbsmpcvVUGSDbAu4/m4tSkoYMb+s+gL3CPis
         yuaPlXmwpBk1zsrgTCpSkHjZRBXPQTDJHvzqiYUaYE5cciAvDwQgTfHgFOkbmQE5GfrT
         +KUwrv8jFiK83GbYIYtLHZuyHrfHviMV6ZnTDiufL8pVvyDxiYxkdr4/VLGMtTk0yWFu
         D0PQ==
Received: by 10.213.3.15 with SMTP id 15mr26243ebl.51.1335999404675; Wed, 02
 May 2012 15:56:44 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Wed, 2 May 2012 15:56:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196869>

2012/5/2 Ralf Thielow <ralf.thielow@googlemail.com>:
> =C2=A0#: wt-status.c:905
> =C2=A0msgid "behind "
> -msgstr "hinter "
> +msgstr "hinterher: "
>
> =C2=A0#: wt-status.c:908 wt-status.c:911
> =C2=A0msgid "ahead "
> -msgstr "weiter: "
> +msgstr "voraus: "

Isn't this an artifact of you rather wanting to have:

    3 hinterher, 2 voraus

But because the code imposes the word order you're going for:

    hinterher: 3, voraus: 2

Whether that's the case or not I wonder how we could handle all these
lego translations in wt-status.c.

Currently we have stuff like this:

    color_fprintf(s->fp, header_color, _("ahead "));
    color_fprintf(s->fp, branch_color_local, "%d", num_ours);
    color_fprintf(s->fp, header_color, _(", behind "));
    color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);

That could be something clever like this:

    color_fprintf("<color header>ahead</color> <color
local>%d</color>, <color header>behind</color> <color
local>%d/<color>", ...);

We have some code in color_parse() in color.c for parsing colors, but
I haven't spotted if it can parse embedded things like that.

But I think an easier option is:

    color_fprintf(%sahead%s %s%d%s, %sbehind%s %s%d%s",
                  header_color_begin,
                  color_reset,
                  branch_color_begin,
                  num_ours,
                  color_reset,
                  ...
    );

Which we already use in e.g. branch.c:

    strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
            maxwidth, name.buf,
            branch_get_color(BRANCH_COLOR_RESET));

That would result in lots of arguments and fairly unintelligible
format strings, but at least we wouldn't have to create some custom
parser and the msgfmt --check option would check that we have all the
formats there.

We could also expose this as an internal command to do coloring for
our shellscript libraries.
