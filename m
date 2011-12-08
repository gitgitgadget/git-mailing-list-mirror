From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Thu, 8 Dec 2011 08:39:32 +0700
Message-ID: <CACsJy8DiWWr7eo86gzb-XcqfDv4_ENkqWxswTNb-k84xO18c=A@mail.gmail.com>
References: <CACsJy8Dbd+v+8FzvQS9a4C8DQSxQGgqQNGaLhL1cHv-yMnaCJQ@mail.gmail.com>
 <CB051EFC.2C795%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Tomas Carnecky <tom@dbservice.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 02:40:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYSy4-0002iE-Cs
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 02:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149Ab1LHBkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 20:40:05 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35744 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597Ab1LHBkE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 20:40:04 -0500
Received: by bkbzv3 with SMTP id zv3so1129553bkb.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 17:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tT2Ssy7aD9WXLExWQp+0MKL3sUU4Jqiei9HHoVs/Ny4=;
        b=H6KGSMQHR4r1PNdBxMmbvlv9EL+rnjvi5PrOdjJUu6zTAxKosy0ARM0KvxoZIScurp
         0rwVAiaA3xiOY/fBbYX9iYKlD/CKZL37deW/tte4IwHS3E4ti8zPJpsS0a1BPOKP5A+v
         pmBV1Ub690KnAmIKUS1oETJBqYch50LwEDpxo=
Received: by 10.204.155.65 with SMTP id r1mr473813bkw.110.1323308403255; Wed,
 07 Dec 2011 17:40:03 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 7 Dec 2011 17:39:32 -0800 (PST)
In-Reply-To: <CB051EFC.2C795%joshua.redstone@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186525>

On Thu, Dec 8, 2011 at 5:48 AM, Joshua Redstone <joshua.redstone@fb.com=
> wrote:
> Hi Duy,
> Thanks for the documentation link.
>
> git ls-files shows 100k files, which matches # of files in the workin=
g
> tree ('find . -type f -print | wc -l').

Any chance you can split it into smaller repositories, or remove files
from working directory (e.g. if you store logs, you don't have to keep
logs from all time in working directory, they can be retrieved from
history).

> I added a 'git read-tree HEAD' before the git-add, and a 'git write-t=
ree'
> after the add. =C2=A0With that, the commit time slowed down to 8 seco=
nds per
> commit, plus 4 more seconds for the read-tree/add/write-tree ops. =C2=
=A0The
> read-tree/add/write-tree each took about a second.

read-tree destroys stat info in index, refreshing 100k entries in
index in this case may take some time. Try this to see if commit time
reduces and how much time update-index takes

read-tree HEAD
update-index --refresh
add ....
write-tree
commit -q

> As an experiment, I also tried removing the 'git read-tree' and just
> having the git-write-tree. =C2=A0That sped up commits to 0.6 seconds,=
 but the
> overall time for add/write-tree/commit was still 3 to 6 seconds.

overall time is not really important because we duplicate work here
(write-tree is done as part of commit again). What I'm trying to do is
to determine how much time each operation in commit may take.
--=20
Duy
