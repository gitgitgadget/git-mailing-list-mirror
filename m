From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git 1.7.6: Sparse checkouts do not work with directory exclusions
Date: Tue, 20 Sep 2011 20:09:42 +1000
Message-ID: <CACsJy8CDtswtPJVt-T911_1y0WqShonvcCbXhFtWu2zjEqLa4A@mail.gmail.com>
References: <4E77BC36.7060005@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 12:10:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5xHa-0006Mv-Ft
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 12:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab1ITKKZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 06:10:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57486 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab1ITKKZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 06:10:25 -0400
Received: by bkbzt4 with SMTP id zt4so310202bkb.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SsaOA1plRuX+fHeCo8t7IQLiKfPFruywofntlGyGItA=;
        b=l8KsDPBVvo0QLaPay7IknPK/CoTH+FNb8myOJFRT+rilBL9D7dn5WBIzHRA3E9v6TZ
         8VGkuVXhYXX73U36iHmzKBUSOHJeFr6QRmf3c3mEm70K3/sXcI8mHHm7A4iTIZ3LTHu3
         D8L+0WeqwNAyAo89Q19KbwFzbhXBR9y3D0Z64=
Received: by 10.204.133.193 with SMTP id g1mr410789bkt.131.1316513412155; Tue,
 20 Sep 2011 03:10:12 -0700 (PDT)
Received: by 10.204.7.1 with HTTP; Tue, 20 Sep 2011 03:09:42 -0700 (PDT)
In-Reply-To: <4E77BC36.7060005@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181747>

On Tue, Sep 20, 2011 at 8:03 AM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> Sometime after Git 1.7.3.2, sparse checkouts stopped working for me. =
=C2=A0My
> sparse-checkout file looks something like:
>
> *
> !DirA/
> !DirB/
> DirC/
>
> I have restored some lines of code that were removed in November 2010=
=2E =C2=A0This
> resolves the sparse checkout issue for me, but my guess is the soluti=
on is
> not implemented properly.
>
> Can anyone confirm the issue

Confirmed. It got me wonder why the negated pattern tests did not
catch this. Turns out this works:

/*
!DirA/
!DirB/
DirC

This is my theory why yours does not work: negated patterns !DirA and
!DirB excludes both directories, but git still descends in them
because you may have other patterns that re-include parts of
DirA/DirB, for example:

DirA/DirD
!DirA

When it's in DirA/DirB, "*" tells git to match everything (equivalent
"DirA/*" and "DirB/*"), so it matches all entries in DirA/DirB again,
essentially reverting "!DirA" and "!DirB" effects.

By using "/*" instead of "*", we tell git to just match entries at top
level, not all levels.

I think it makes sense, but it's a bit tricky.

> and describe why those lines were removed?

Quotes from 9e08273: "The commit provided a workaround for matching
directories in index. But it is no longer needed."
--=20
Duy
