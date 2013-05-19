From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH/WIP 0/9] for-each-ref format improvements
Date: Sun, 19 May 2013 16:41:03 +0530
Message-ID: <CALkWK0=7z91A54jSzc2yZU3g50u8H_f8su1Y+i=D+KxYtqor5g@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:11:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1Wm-0008D1-67
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab3ESLLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:11:44 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35677 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab3ESLLn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:11:43 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so12161044iec.15
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=rX3vJ3L7BavwIiP5v4L97oh6MUjVUNHPKW8HKX0FETM=;
        b=g98yAmpOdY/bnEUTUOiy8BlUqSpNBB9fZfD12FAzKuFyfsUw/XqzziFBFKPxjBmLn0
         oEMcjW3fKlM2bRY/IPQxrY6EQgliGNyhlvw18GPGfkc+pYyiSF/tsVNG0qVxa0yf2v1D
         /hUWtn3WGQLRWEaptj/0HUBTgEKV2TF8qeQWCAmtQrLONas3UXsOwxiDfXspCE9P8IRJ
         XLh8H8e9NGnVXj9gm70ufmrxQ1oWPcM3D6fpcTxnnTAAYq4ZIbRztD9Jco6vR2EuvA2c
         +zyLmG3IRbMw7jUHjcTxYNqwzprrUKy0KCfxoBcPcU2NKSRLnxgK1Gt9o+5Y4RveiNNA
         FTtg==
X-Received: by 10.50.73.65 with SMTP id j1mr2846208igv.49.1368961903171; Sun,
 19 May 2013 04:11:43 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 04:11:03 -0700 (PDT)
In-Reply-To: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224848>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> The purpose of this series is to make "for-each-ref --format" powerfu=
l
> enough to display what "branch -v" and "branch -vv" do so that we
> could get rid of those display code and use for-each-ref code instead=
=2E

Damn, you beat me to it.  I just introduced color, and was working on
alignment.  See $gmane/224692.

Yes, I think this is the direction we should be taking.  Poorly
thought-out stuff like -v and -vv should be deprecated.

> This series introduces:
>
>  - %(current), which either shows "*" if the ref is pointed by HEAD
>    or a space. Junio called it %(headness). I don't like that.
>    I don't like %(current) either but we have to start somewhere.
>    Name suggestion? %(marker)??

How about %(HEAD)?

>  - %(tracking[:upstream]) gives us the exact output that branch -v[v]
>    does. %(upstream) does not include []. We can't change its
>    semantics.

There's already an atom called "upstream", and "upstream:short" works.
 Why not introduce "upstream:diff" for "[ahead x, behind y]" and
"upstream:shortdiff" for "<>" (like in the prompt)?

>  - %(color:...) is pretty much the same as %C family in pretty code.
>    I haven't added code for %(color:foo) =3D=3D %C(foo) yet. There's =
a
>    potential ambiguity here: %C(red) =3D=3D %Cred or %C(red)??

I'd vote for dropping %C<name> altogether and just go with %C(<name>).
 Why do we need %(color:<name>) at all?

>  - %(...:aligned) to do left aligning. I'm not entirely sure about
>    this. We might be able to share code with %>, %< and %>< from
>    pretty.c. But we need improvements there too because in
>    for-each-ref case, we could calculate column width but %< would
>    require the user to specify the width.

Yeah, I think we should go with the %> and %< you introduced in
pretty.c.  Yes, I want to be able to specify width.

>    Do people expect fancy layout with for-each-ref (and branch)? If s=
o
>    we might need to have %(align) or something instead of the simple
>    left alignment case in %(...:aligned)

Why should we deviate from the pretty case?  What is different here?

>  - We may need an equivalent of the space following % in pretty
>    format. If the specifier produces something, then prepend a space,
>    otherwise produce nothing. Do it like %C( tracking) vs
>    %C(tracking)??

Yeah, sounds good.

> You can try this after applying the series, which should give you the
> about close to 'branch -v'. %(tracking) coloring does not work though=
=2E

Why doesn't %(tracking) coloring work?

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):

I'll have a look at this.

Also, I think it'll help to have a --pretty=3D"format:<string>"
equivalent to --format=3D"<string>" so that we can introduce pretty
names like oneline, short, medium, full.  We can eventually deprecate
--format for consistency.
