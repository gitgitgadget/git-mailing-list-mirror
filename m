From: James Pickens <jepicken@gmail.com>
Subject: Re: Bug? Bad permissions in $PATH breaks Git aliases
Date: Tue, 27 Mar 2012 00:25:24 -0700
Message-ID: <CAJMEqRCMJ6pEi3=HHyHA5v_+UBgmi8Qa9-XiMasnXC64UtEoYw@mail.gmail.com>
References: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
 <20120327031953.GA17338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 09:25:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCQmt-000342-QG
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 09:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab2C0HZr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 03:25:47 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53819 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab2C0HZr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 03:25:47 -0400
Received: by wgbdr13 with SMTP id dr13so4581346wgb.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Dwqtr2D7AA3tjeFUJBqZZ59vj9vYQcjRs8z72K+mk88=;
        b=VBFO3ppWaFvD4klrTjPTxldHjVdvGD4ZEkCJTRKrm7kAdvPFOVL1+LyWbBTtGRMZs4
         TXPnpnmg3z2x49P4DiLeCkFyNu6b5ONA8sL+JQE0xsWoYj22V9sy7OSu7nui7YHJhyhu
         ALOwLZ4Z3yi3EnbOprVkmvz4t1RBLfOBI8YeHqCRVsBwWMazQ/tWrKCrJAeor/mGwBYh
         cGRgBI+OsAqEWy4zkZI79dgBWnHkWPALDN/hgs0Aqpd93z8kXPxfJGNguBnPEh1DBB3d
         DaekEvVSZ8kqkaPvV8Fp3FhY+A9w10oGdWT1Rjboehrs4GeiM6R4pwu8WLTtuBztdc5I
         ACoQ==
Received: by 10.180.95.74 with SMTP id di10mr28801882wib.1.1332833144451; Tue,
 27 Mar 2012 00:25:44 -0700 (PDT)
Received: by 10.223.154.205 with HTTP; Tue, 27 Mar 2012 00:25:24 -0700 (PDT)
In-Reply-To: <20120327031953.GA17338@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194029>

On Mon, Mar 26, 2012 at 8:19 PM, Jeff King <peff@peff.net> wrote:
> This seems to come up about once a year. The short of it is that exec=
ve
> will return EACCESS whether the file exists is not actually executabl=
e
> by you, or if you have an inaccessible element in your PATH. execvp w=
ill
> continue the search if it sees EACCESS, but will return EACCESS if it
> finds nothing. =C2=A0So git just sees the EACCESS and doesn't know if=
 you
> have bogus entries in your PATH or if there is a permissions problem
> with your executable files.
>
> For something like a shell, it's not that big a deal; either way, you
> couldn't execute the command in question. For git, it matters more
> because we first try to exec an external command, and then fall back =
to
> an alias (because externals take precedence over aliases).
>
> So basically our options are:
>
> =C2=A01. Start treating EACCESS silently as ENOENT. The downside is t=
hat we
> =C2=A0 =C2=A0 fail to report the proper error when the file really do=
es have
> =C2=A0 =C2=A0 permissions problems (we would say "command not found",=
 but that is
> =C2=A0 =C2=A0 misleading).
>
> =C2=A02. Implement our own execvp, differentiating between "path not
> =C2=A0 =C2=A0 available for looking in" and "we found the command, bu=
t there was
> =C2=A0 =C2=A0 a permissions problem". I think somebody was working on=
 this a few
> =C2=A0 =C2=A0 months ago (search for "add exeecvp failure diagnostics=
") but it
> =C2=A0 =C2=A0 seems to have fizzled.
>
> =C2=A03. If we get an EACCESS, remember it, try to do the alias looku=
p, and
> =C2=A0 =C2=A0 then if that fails, report the "Permission denied" erro=
r (not
> =C2=A0 =C2=A0 "command not found"). That is following the spirit of w=
hat execvp
> =C2=A0 =C2=A0 does (it will find later entries in the PATH if they ar=
e there, but
> =C2=A0 =C2=A0 otherwise will remember the EACCESS error).

Thanks for the detailed explanation!

> I think the general feeling last time this came up was "why not just
> remove the cruft from your PATH?"

Because I didn't know there was cruft in my path.  The cruft was put
there by a sloppily written project setup script that is not under my
control, and it may be difficult to get the owner of that script to
fix it.  Even after the script is fixed, we're certain to run into
other sloppy scripts in the future.

It took me quite a while to figure out the real problem the first
couple of times this happened, and I'm sure many of my colleagues who
use the same project setup script would not have figured it out at
all, so if there's anything Git can do to make it easier for them, I
think it's worth doing.  BTW repairing the crufty PATH is not easy,
because the project setup script will have added many unfamiliar
things to PATH, so you have to check them one by one to figure out
which ones are bad.

> But I would personally be OK with
> option (3) above, and it is probably not that hard to implement.

I would be happy with option (3).  This is the part where I sheepishly
confess that I probably can't find time to work on this myself, but if
option (3) is also acceptable to Junio, I may be able to find a
coworker to do it.  So Junio, do you have any objection to (3)?

James
