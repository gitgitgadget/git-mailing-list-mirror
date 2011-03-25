From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] setup: return correct prefix if worktree is '/'
Date: Fri, 25 Mar 2011 15:17:19 +0100
Message-ID: <4D8CA3EF.3010403@drmicha.warpmail.net>
References: <20110325100254.GH30350@login.drsnuggles.stderr.nl> <1301060989-7246-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 15:21:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q37ss-0005Ig-Ib
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 15:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab1CYOU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 10:20:57 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43976 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753124Ab1CYOUz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 10:20:55 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3C2F520C5E;
	Fri, 25 Mar 2011 10:20:55 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 25 Mar 2011 10:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=FUs17+NG3CR85iEdVIOH2I2SivA=; b=qly4oPH75yB7lzLWjnKsdfFo6ug4x02yAEcZ+Ctw97OiCIbeETUdipcswDyIaSenp2JRSNvbmskbofcNZJU/Nq93MDKGOhF5q2lt8e6yD/PbLswxTrfuz2e+bHwtPDck6sTAVZksCiOgyrnVoqLFRj4ONe106xO2asvrSl+Vd/E=
X-Sasl-enc: 6BdjlSnYeYg7/dhsy1mWnkwxEj+LYx5msq4o6n0v3Qdj 1301062854
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5FCEF440509;
	Fri, 25 Mar 2011 10:20:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1301060989-7246-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169987>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 25.03.201=
1 14:49:
> The same old problem reappears after setup code is reworked. We tend
> to assume there is at least one path component in a path and forget
> that path can be simply '/'.
>=20
> Reported-by: Matthijs Kooijman <matthijs@stdin.nl>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  cache.h |    2 ++
>  path.c  |   35 +++++++++++++++++++++++++++++++++++
>  setup.c |    5 ++---
>  3 files changed, 39 insertions(+), 3 deletions(-)
>=20

Wait wait, the bug bisects to

490544b (get_cwd_relative(): do not misinterpret suffix as subdirectory=
,
2010-05-22)

for me, using

git bisect run sh -c "make || exit 125; cd /etc; GIT_DIR=3D/tmp/a/.git
~/src/git/git-add fstab || exit 1"

and a repo in /tmp/a/.git with core.worktree set to "/".

The issue is that in get_relative_cwd() of dir.c, "dir" (and maybe
("cwd") may or may not end in "/", so even with dir=3D"/etc/" and
cwd=3D"/etc" we would not recognize we are within the repo. Patch for t=
hat
is coming.

Note that by doing something like the above, we can test / without bein=
g
root as long as we have files there which we can rely on being readable=
,
or can rely on /tmp being there.

Michael
