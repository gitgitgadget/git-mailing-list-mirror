From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 14/26] shallow.c: implement a generic shallow boundary
 finder based on rev-list
Date: Fri, 27 May 2016 00:00:03 -0400
Message-ID: <CAPig+cQ3SEZ6WCpHvq-HukgjauYtSqrz5Z2fwkYxoptnKtYLfg@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
	<1460552110-5554-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 06:00:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b68wW-0004EZ-61
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 06:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbcE0EAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 00:00:06 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38603 "EHLO
	mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbcE0EAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2016 00:00:05 -0400
Received: by mail-it0-f53.google.com with SMTP id l63so66050183ita.1
        for <git@vger.kernel.org>; Thu, 26 May 2016 21:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=X61mYYRTIJl2768791hO5SX5zR6OWghnuL3j33jdK6E=;
        b=TgJKs4UeGa7YdRQnLbaA/xKqi6Jr9zE+0//AO8V+1euNT4DWoHDJQSXVUG9eNqWZbE
         0Isan2GbC7SILbiBblYCnPIO8FzA2EaSk8SIMPSA5S8vqAvdNkZUZ7C/EwX5wRgP/sk6
         ZPcZ/Lb2eFwknKNSQje4Y7bSKSgxEN2NTC2IWghyS18FSk6AWwQPmX2QBfhKwZkh3A+w
         7XwJA2sUOgkmvbl5hysp8xy/kTHcHVe42CC1Rmh76VWKRM6UpVzxaMqLQBUhB6Nv02BW
         0oK2oRMc6mVB4VBlBeFqdoKH9C8LdWFlSMIS6Inopwy1VjfN7Th/oUVebue09E3GrLdX
         E2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=X61mYYRTIJl2768791hO5SX5zR6OWghnuL3j33jdK6E=;
        b=bE0W9rzSCJumbE+lgwrC+dUggOKzxVdAjCibk7B2hE92uvWfhzao5hVGCVX5Y+x6SW
         IQu7YI/8a3G4n07s3wy0AJ3DdPBOkgmHfEbtRo90NAL3FDvF8HIETZq0Dn4kAgUpFTRP
         KVgyQXgORc4jSlbXE0c4SIFyjqRMYfHiI1SJLKdEuucc6BTs1MY2CuVZbgzrsmQhfOpd
         KxCsInQJ9KNcUsGWwcFQvcj6qc+nxHDo7gxDCWBuMslrVnn7rVY0bkxYjg70dlKG703S
         Jsp520/tjrix6TUHQ3uOscEXJMmCBWKpoLBXM6nxd+fBrDtz1FSbLqOkLYsVvVoceZz0
         obzA==
X-Gm-Message-State: ALyK8tINiAEcZY7efaruPCLp1GHmSlLuqqkU2XXhvD4iqZslexd14LJZkZRNFmhmapDVu3rI24Y73/5l/I3jkg==
X-Received: by 10.36.55.141 with SMTP id r135mr6354302itr.73.1464321603997;
 Thu, 26 May 2016 21:00:03 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Thu, 26 May 2016 21:00:03 -0700 (PDT)
In-Reply-To: <1460552110-5554-15-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: _cSCnM6quGiTuaz0NCxqspuTOUU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295725>

On Wed, Apr 13, 2016 at 8:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Instead of a custom commit walker like get_shallow_commits(), this ne=
w
> function uses rev-list to mark NOT_SHALLOW to all reachable commits,
> except borders. The definition of reachable is to be defined by the
> protocol later. This makes it more flexible to define shallow boundar=
y.
>
> The way we find find border is paint all reachable commits NOT_SHALLO=
W.

Grammo: "find find"

> Any of them that "touches" commits without NOT_SHALLOW flag are
> considered shallow (e.g. zero parents via grafting mechanism). Shallo=
w
> commits and their true parents are all marked SHALLOW. Then NOT_SHALL=
OW
> is removed from shallow commits at the end.
>
> There is an interesting observation. With a generic walker, we can
> produce all kinds of shallow cutting. In the following graph, every
> commit but "x" is reachable. "b" is a parent of "a".
>
>            x -- a -- o
>           /    /
>     x -- c -- b -- o
>
> After this function is run, "a" and "c" are both considered shallow
> commits. After grafting occurs at the client side, what we see is
>
>                 a -- o
>                     /
>          c -- b -- o
>
> Notice that because of grafting, "a" has zero parents, so "b" is no
> longer a parent of "a".
>
> This is unfortunate and may be solved in two ways. The first is chang=
e
> the way shallow grafting works and keep "a -- b" connection if "b"
> exists and always ends at shallow commits (iow, no loose ends). This =
is
> hard to detect, or at least not cheap to do.
>
> The second way is mark one "x" as shallow commit instead of "a" and
> produce this graph at client side:
>
>            x -- a -- o
>                /    /
>          c -- b -- o
>
> More commits, but simpler grafting rules.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
