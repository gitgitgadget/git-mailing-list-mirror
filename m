From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Find out on which branch a commit was originally made
Date: Sun, 19 Sep 2010 16:08:13 +0200
Message-ID: <1jp2pkw.1s4r5br1xvl05eM%lists@haller-berlin.de>
References: <1jp2d5s.1q4xl2w1f5ufljM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=),
	git@vger.kernel.org
To: art.08.09@gmail.com (Artur Skawina)
X-From: git-owner@vger.kernel.org Sun Sep 19 16:08:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxKZ4-0002Lg-Te
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 16:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab0ISOIR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 10:08:17 -0400
Received: from mail.ableton.net ([62.96.12.115]:56665 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547Ab0ISOIR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 10:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=0IsDV6bMWTyCGufgED85+31C4V5yDMaFdbDmA5a9AH8=;
	b=pRVsXMARZNNc4Hx/FAACkvcjP3QdZPjk+yD87EUt5DzIQyt+K3GZnQSNF97Ji4gOFddMwQmIB89xQm1gHT/FbYqBau/SQs8NOvOKS410M2TKCabKhJOgS2TkLUiPLuf2XGL9tdqTjU9z6VoyZ9EbBY8J4SUWyXxXZmZ7LzGkP4M=;
Received: from dslb-088-073-104-214.pools.arcor-ip.net ([88.73.104.214] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OxKYQ-0003hS-Me; Sun, 19 Sep 2010 16:07:42 +0200
In-Reply-To: <1jp2d5s.1q4xl2w1f5ufljM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156498>

Stefan Haller <lists@haller-berlin.de> wrote:

> Artur Skawina <art.08.09@gmail.com> wrote:
>=20
> > On 09/18/10 17:26, Stefan Haller wrote:
> > > =C6var Arnfj=F6r? Bjarmason <avarab@gmail.com> wrote:
> > >>                      A---B---C topic
> > >>                     /         \
> > >>                D---E---F---G---H master
> >=20
> > > The question is the same though: if I hit commit B while blaming,=
 how do
> > > I know what topic it was a part of?  For that, I need to find com=
mit H
> > > which will tell me, right?  How do I do that?
> >=20
> > git rev-list --ancestry-path --merges --reverse B..master --format=3D=
oneline
>=20
> Thanks, this is helpful.  (However, my co-workers will probably laugh=
 at
> me if I suggest they remember a command such as this for what they th=
ink
> should be a very simple operation.)
>=20
> There's a problem though for commits that are far back in history:
>=20
>                A---B---C topic
>               /         \
>          D---E---F---G---H---I---J---K---L---M---N master
>                                   \         /
>                                    O---P---Q another-topic
>=20
> Your command also shows M, which is not interesting at all in this
> context.  Ideally it should stop at the first command that's common t=
o
> topic and master.

No, that's not what I need either.  After thinking about it more, I
think what I want is "of all merges in the ancestry path from B to
master, show only those whose first parent can't reach B."  The result
is the list of all merges that were involved in bringing B to master.

Here's what I came up with:

#!/bin/sh

git rev-list --ancestry-path --merges --reverse "$1".."${2-master}" \
  | while read ref
do
  if [ -z "$(git rev-list --ancestry-path "$1".."$ref"^)" ]
  then
    git --no-pager log -1 --pretty=3Doneline "$ref"
  fi
done

It's pretty inefficient, but seems to get the job done. Is there a
smarter way to achieve the same?

-Stefan


--=20
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
