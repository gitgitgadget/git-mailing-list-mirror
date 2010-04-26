From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Alter parent ID of existing commit object
Date: Mon, 26 Apr 2010 05:38:02 -0500
Message-ID: <20100426103637.GA8896@progeny.tock>
References: <n2xa1138db31004260313jcd22b2ebw403ca2bd547e784b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Paul Richards <paul.richards@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 12:37:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Lgw-0002WE-Cc
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 12:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab0DZKhN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 06:37:13 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62383 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264Ab0DZKhM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 06:37:12 -0400
Received: by pvg2 with SMTP id 2so84892pvg.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=j5ix8LMRZDE3ns0+zTxvy4xWk4qYEjm76lgtZuO4YSg=;
        b=H0LeA4XqXMsW4AlRaPXDigCtjX7eMe5muh9k/2/wFBis5MxJJHsOsHG13Hj2xmwSCU
         B8qXHtZ/TdtvnDoXuBWOF8/ILNFY8CIAnbyvqwiBjlxGUolhze1kCklGjXMlN67fi/7Q
         s4PnTWOjMjIEL8nbeOgBnvCaiRZGh3rzxLYRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hoiXTtj51iOiipRM6pvfTNCVJbJxUZAWq38LIoWGzTNz5a+vlJ13UKGTgzykunexOD
         MskYoXETnGY0EkPry3CCwxCHXqM9RZEUU1zIx1x5Aoag1aPibqat3HESbS/+W7ZvpZ9J
         j12gkxAMWj1Tr5vTvNcmty07piWcAWpy8Tpqo=
Received: by 10.114.253.34 with SMTP id a34mr3900395wai.43.1272278231660;
        Mon, 26 Apr 2010 03:37:11 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3041793iwn.12.2010.04.26.03.37.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 03:37:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <n2xa1138db31004260313jcd22b2ebw403ca2bd547e784b@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145811>

Hi Paul,

Paul Richards wrote:

> Is it possible to edit an old commit object and only alter the ID of
> the parent commit but otherwise leave all the other information intac=
t
> (tree, message, authors, date, etc).
>=20
> I'd expect such a command to return the new hash of the modified comm=
it.

The standard answer to this question is to say =E2=80=9Cuse grafts and
filter-branch=E2=80=9D.  The git-filter-branch(1) man page explains thi=
s
approach.  It is very powerful, but sometimes I do not want to have
that much power.

So I will tell a secret: in the scenarios when I wanted something like
this (actually, what I have occasionally wanted is to transform a
single-parent commit into a merge), I did something like the following:

  $ git cat-file commit $rev
  tree dcd2cc4b76f8756423f5c1ab7d2c62d458a8b15f
  parent 5f1e6d9ce35e212708f9adc55e6b9a7e0d296df4
  author Will Palmer <wmpalmer@gmail.com> 1272275407 -0500
  committer Jonathan Nieder <jrnieder@gmail.com> 1272275443 -0500
 =20
  pretty: Respect --abbrev option
 =20
  Prior to this, the output of git log -1 --format=3D%h was always 7
  characters long, without regard to whether --abbrev had been passed.
 =20
  Signed-off-by: Will Palmer <wmpalmer@gmail.com>
  Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
  $ git cat-file commit $rev >tmp
  $ sed -i -e "s/parent .*/parent $(git rev-parse othercommit)/" tmp
  $ git hash-object -t commit -w tmp
  ca55c560685284ac6d121939b2cd881f426e7074

Easy.  Still, I would be happy to see this packaged in a command, so I
could recommend it in combination with =E2=80=98git replace=E2=80=99 to=
 people who are
scared of sed.

Thanks for bringing it up.
Jonathan
