From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-fast-export issue?
Date: Thu, 11 Nov 2010 10:55:34 -0800
Message-ID: <AANLkTinpLGsRXdPwO4E7AB4yyt-G5eWBtCcWKrJy2A6n@mail.gmail.com>
References: <AANLkTikVVH6SP+bQhU9e2B0h4k0t9ma+2cNkzuNvCDgo@mail.gmail.com> <20101111080930.66e2fb21@atmarama.noip.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Hipp <drh@sqlite.org>, git <git@vger.kernel.org>
To: Gour <gour@atmarama.net>
X-From: git-owner@vger.kernel.org Thu Nov 11 19:56:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGcJa-0005z4-K7
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 19:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586Ab0KKS4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 13:56:00 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45041 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab0KKSz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 13:55:59 -0500
Received: by iwn10 with SMTP id 10so2487702iwn.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 10:55:58 -0800 (PST)
Received: by 10.231.10.132 with SMTP id p4mr1140840ibp.40.1289501756330; Thu,
 11 Nov 2010 10:55:56 -0800 (PST)
Received: by 10.231.162.65 with HTTP; Thu, 11 Nov 2010 10:55:34 -0800 (PST)
In-Reply-To: <20101111080930.66e2fb21@atmarama.noip.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161290>

+git mailing list

On Wed, Nov 10, 2010 at 11:09 PM, Gour <gour@atmarama.net> wrote:
> On Wed, 10 Nov 2010 20:53:31 -0500
>>>>>>> "Richard" =3D=3D Richard Hipp wrote:
>
> Richard> Gour: =A0The git fast-export manpage says that Shawn O. Pear=
ce,
> Richard> CCed on this email, is the author and maintainer of
> Richard> git-fast-export. =A0I'm including him in the conversation in=
 the
> Richard> hopes that he can shed some light on this issue.

I'm not actually the maintainer of git fast-export.  I don't know
where that came from.  Maybe its because I wrote and maintained git
fast-import for a few years?

> Richard> M 100644 :938 emacs/emacs-custom.el
=2E..
> Richard> M 100644 :1075 emacs/emacs.rc
> Richard> D emacs

This looks like a mistake by `git fast-export --all`.  The D emacs
needed to come *before* the M commands that put files into the
directory.  But it was emit afterwards.  I'm not sure why.

> Richard> According to my reading of the manpage at
> Richard> http://www.kernel.org/pub/software/scm/git/docs/git-fast-exp=
ort.html
> Richard> the "D emacs" line above should delete the "emacs" folder an=
d
> Richard> all of its contents. Clearly my understanding is wrong,
> Richard> though, since Git doesn't actually do that, and why would it
> Richard> change files in that directory prior to deleting them? =A0Bu=
t
> Richard> the "fossil import" command is currently coded to do what I
> Richard> understand the documentation says it should do - which is to
> Richard> delete the content of the "emacs" folder. =A0A subsequent co=
mmit
> Richard> adds the file emacs/emacs.rc which is why the folder still
> Richard> exists in the tip.
> Richard>
> Richard> I'm really perplexed about that D line.
>
> The above D line says, according to my understanding based on the
> actions I did on the repo, to remove emacs *file*.
>
> it was caused by one of the darcs features called 'rename' which darc=
s
> does quite good.
>
> Here is what I did.
>
> I've created emacs *folder* and put emacs-* files into it, renamed
> emacs into emacs.rc and moved into into emacs/emacs.rc.

OK.  In this case "D emacs, M emacs/emacs.rc" makes sense if you
renamed "emacs" to "emacs/emacs.rc".  Unfortunately git fast-export
wrote the commands in the wrong order.  The fast-import stream
language executes the file commands in the order they appear on the
stream, as though it was updating a real filesystem.  This can be
awkward to use sometimes when changing a file to become a directory.

Based on what you said above, the stream is broken, and you can't fix
it in the importer that is trying to read it.  git fast-export should
have put "D emacs" first in the stream, not last.

--=20
Shawn.
