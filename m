From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Mon, 2 Mar 2009 07:54:19 -0500
Message-ID: <76718490903020454j5b787094j1f904a72178a9024@mail.gmail.com>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 13:56:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le7h5-0003F8-Tk
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 13:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbZCBMyW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 07:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbZCBMyV
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 07:54:21 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:52146 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZCBMyV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 07:54:21 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2256367rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 04:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=srVmtdCXvpXKyLDdBjFBZz57nvhlJpOOhcIathEELpk=;
        b=Q3+qaqLmUjRPquuPLz3B3kOmyeyzN3RgQ9oov6ACpYzz+bkg5VNKrYquPMLCsFXtef
         SB5YqlVbYtptNudx1/vJT0cvKM3ii2+47pQcD36+6GEZOCxNeEoW70pbuS3Ak/eqF868
         9AA1fJUH5zucDvQ6J0Ao1H7Kp0DrA3PfgktJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oFifKdS/DPeLiHKM2dsbb0eQaujEDmmasRrpSkHjVfy2kr1Ykh8zUKxGr7xJ/REtzz
         QHd/gZwpYFtPQbprL/v8IrNtLJVIskEsqgV2Ls2uATB+wLnoOPurr4sNUcfQ0XQJiRrS
         tKcVDE9iLue8djLRvhbQJpmQSRflUj3xryk9U=
Received: by 10.140.201.8 with SMTP id y8mr2908955rvf.208.1235998459292; Mon, 
	02 Mar 2009 04:54:19 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111935>

On Sun, Mar 1, 2009 at 6:42 PM, Daniel Barkalow <barkalow@iabervon.org>=
 wrote:
> I've got an annoying repository where all of the branches upstream[*]=
 have
> names, for a project "my-proj" like:
>
> some/constant/stuff/$VERSION/junk/my-proj
>
> I'd like to be able to use refspecs like:
>
> =C2=A0fetch =3D some/constant/stuff/*/junk/my-proj:refs/remotes/origi=
n/*
>
> I've written an implementation (which mainly involved having only one
> place do the matching and replacement for pattern refspecs, and then
> making that one place a little more clever), so that's not hard. But =
we
> currently prohibit refspecs like this, and I think we may want to pro=
hibit
> some patterns of this general form, in order to keep typos from doing
> surprising things.
>
> My use case is actually, more precisely:
>
> some/constant/stuff/$PROJ-$NUMBER/junk/my-proj
>
> Where $NUMBER is the version number, and $PROJ is usually, but not qu=
ite
> always "my-proj"; the exception being that it might be effectively a
> superproject. So I'd like to have:
>
> =C2=A0fetch =3D some/constant/stuff/my-proj-*/junk/my-proj:refs/remot=
es/origin/*
>
> But I can live with remote branches like "my-proj-2.4" instead of "2.=
4".
>
> I think it would make sense, and limit typo damage, to say that the *=
 can
> only expand to something with a '/' in it if the star has a slash or =
the
> end of the string on each side.

That seems more confusing that just saying: '*' matches everything but
the path separator ('/'), and whatever it matches on the LHS of the
':' is what it expands to on the RHS. I'm not sure how a typo would
damage anything, but this could always be enabled with
core.refspec.glob_anywhere or some such.

I think regex support is too much:

  fetch =3D some/constant/stuff/(my-proj-[^/]*)/junk/my-proj:refs/remot=
es/origin/\1

(Which in a git config, I think may need a double-backslash, but I
forget what the config parser does.)

j.
