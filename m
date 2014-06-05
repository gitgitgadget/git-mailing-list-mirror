From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Submodules with feature branches
Date: Thu, 5 Jun 2014 10:57:17 -0500
Message-ID: <CAHd499Dc7_fob2-X1KZ77sdx20r+erQ_9JbDc7y4G0RUxG65eg@mail.gmail.com>
References: <CAHd499Bn7CCVy=vhFzpLYXCssxR0oGxm3Vdgou_Yk5zSt1gfmA@mail.gmail.com>
	<20140605151549.GQ21803@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jun 05 17:57:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsa2d-00031s-M6
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 17:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbaFEP5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2014 11:57:19 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:49214 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbaFEP5T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2014 11:57:19 -0400
Received: by mail-ve0-f175.google.com with SMTP id jw12so1448788veb.20
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=udRkbFVBROKOilg/OnkyPHy90SjLPk59omIXKyaN6/Q=;
        b=qwkE0P4uERifqs+ot65iBN8pVxQBKGFVqs65f1GcTMq6MeOadnVIQJSsm5ekdXX+al
         B1QHJTnE24GTS2GcN7NHe0BY5mAxLhsqLDOEfqfj5Qj5boi0OdHN/EpoSojpPYDRpLzP
         iV+HIn9dX360VtyYnLkK3B0Irtp04PLiJFrr2XLeGe/R5MJJQpBgmxL7ydXLV+Yg7d//
         3qEyT23Y64WodBgdH8Ci644jcCmggtif2PXTNJLO8ahnCfnPQaWejPyoT7WRkf603I68
         gnkZXhpQ9hshBvpQYhPSxt9BIu0yVQ3rbqPYgevWmr/Fx1L0COzPLuiOQthE2uRx5pf2
         5ZHg==
X-Received: by 10.52.35.46 with SMTP id e14mr1937982vdj.94.1401983838009; Thu,
 05 Jun 2014 08:57:18 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.204 with HTTP; Thu, 5 Jun 2014 08:57:17 -0700 (PDT)
In-Reply-To: <20140605151549.GQ21803@odin.tremily.us>
X-Google-Sender-Auth: w8D0U880zTwnAAWMYIuv-tdP8us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250848>

On Thu, Jun 5, 2014 at 10:15 AM, W. Trevor King <wking@tremily.us> wrot=
e:
> So you have:
>
>   On the trunk host:   On your public host:   Locally:
>   superproject         superproject           superproject
>   submodule            submodule              `-- submodule
>
> In that case, a corresponding feature branch to the submodule, and an
> update to submodule.<name>.url (and possibly submodule.<name>.branch)
> would be the way I'd go (at A in the figure below).  Once the trunk
> maintainers were happy with things, they could merge the submodule
> branch into trunk's submodule (at B in the figure below), and you
> could add a capping commit to your superproject branch that reverted
> the gitmodule changes (at C in the figure below):
>
>   -o---o---o---o-------o  trunk's superproject/master
>     \                 /
>      A---o---o---o---C    your superproject/feature
>
>   -o---o-----------B  trunk's submodule/master
>     \             /
>      o---o---o----    your submodule/feature
>
> An alternative is to use relative URLs in the trunk:
>
>   superproject$ cat .gitmodules
>   [submodule "bpl-subset"]
>     path =3D submod
>     url =3D ../submodule
>
> which makes it easier for folks who mirror/fork both the superproject
> and submodule (no need to change submodule.<name>.url).  However, it
> makes it harder for folks who just mirror/fork the superproject (and
> don't need to tweak the submodule), because they have to mirror/fork
> the submodule as well to support the relative URL (or edit
> submodule.<name>.url, which turns attempted mirrors into forks).
> Personally, I prefer relative URLs [1,2], but both external projects
> I've approached on this front have ended up with absolute URLs [3,4]
> ;).
>
> This is less of an issue for loosely-coupled submodules, since you'll
> can motivate your submodule changes to the submodule maintainers
> independent of the superproject (i.e. you can just say things like
> =E2=80=9CI'm extending the API so I can iterate over widgets.  This l=
ets you
> do things like frobbling whatsits in superproject=E2=80=9D without ha=
ving to
> present the associated superproject code).  Once you land the
> submodule changes upstream, your superproject branch will work withou=
t
> the need to tweak the URL (for absolute URLs) or publish a sibling
> mirror (for relative URLs).

Thanks, this is excellent information. Perhaps I should provide a
little more detail into what I'm doing. I know that having such
dependencies between superproject & submodule is bad and creates
complications like this, so maybe there is a different approach.

Right now our build system does not download third party dependencies.
We build on Windows & Android, so we maintain our own package binaries
& source code. Right now these are stored in 7zip files and checked
into the superproject. I was planning on creating a submodule for our
third party libs and store them extracted in there. That way, when we
switch branches, we don't have to delete & re-extract the third party
archives again (since between branches, libraries may change, be added
or removed). The submodule buys us an important thing, which is that
we won't have big binary blobs in our history. If we ever want to
remove them, all we're removing is a weak link to the submodule. The
binaries live with us forever since they're in history.

The only other thing I can think to do is incorporate logic into our
makefiles to copy down the 7zips from a permanent server, and we'd
adopt a naming format for the archives and download them based on that
information. This way, when we go back to an earlier tag, it will
always pull the correct version of the dependencies. We'd have to make
sure to never delete old libraries from the remote server or edit
existing ones.

I was exploring submodules to see if they would solve this problem.
However, because of the feature branch workflow, they do not seem
practical. I'm open to any other suggestions. Thanks!!
