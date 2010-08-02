From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] require_work_tree: Look for top-level instead of is-inside-work-tree
Date: Mon, 02 Aug 2010 16:37:51 +0200
Message-ID: <4C56D83F.3050507@drmicha.warpmail.net>
References: <1280335624-90132-1-git-send-email-tor.arne.vestbo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?VG9yIEFybmUgVmVzdGLDuA==?= <tor.arne.vestbo@nokia.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 16:37:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofw9E-00076Z-9T
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 16:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab0HBOhm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 10:37:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40771 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751077Ab0HBOhm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 10:37:42 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 82B6C182220;
	Mon,  2 Aug 2010 10:37:41 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 02 Aug 2010 10:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=0/IO6bkHWkVBVMWkZB6DG9dx0FE=; b=o0UR11hwlG6zpp2T1Wv+NpHbSsxHyqM9RJUX4eGwP874qFtlGW5HHyux4G4gBIMdXQbVaOtt1lm17RU6OcfKEEa2X7HheX9Hytm2fVw2DhqJUKEfIx4ykiaETMCWhgC6fmnVqZTMhhUcL9PyPbjpo571AUKCCrvjW9wejERzHRU=
X-Sasl-enc: CT3Cz12S41jDoIw8UZ4IdE8t1WMNvBUkWHnCVIgazupt 1280759861
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E6F6A4E2F85;
	Mon,  2 Aug 2010 10:37:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100714 Lightning/1.0b2pre Lanikai/3.1.2pre
In-Reply-To: <1280335624-90132-1-git-send-email-tor.arne.vestbo@nokia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152411>

Tor Arne Vestb=C3=B8 venit, vidit, dixit 28.07.2010 18:47:
> The documentation describes require_work_tree as guarding against
> bare repositories, and that's also the way it's used from porcelain
> such as git-rebase. When implemented using --is-inside-work-tree
> the samantics change, causing git-rebase to fail if run from outside
> GIT_WORK_TREE, even if GIT_WORK_TREE is valid.
>=20
> Signed-off-by: Tor Arne Vestb=C3=B8 <tor.arne.vestbo@nokia.com>
> ---
>  git-sh-setup.sh     |    2 +-
>  t/t1501-worktree.sh |    9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 6131670..f8e4428 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -141,7 +141,7 @@ cd_to_toplevel () {
>  }
> =20
>  require_work_tree () {
> -	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" =3D true =
||
> +	test -n "$(git rev-parse --show-toplevel 2>/dev/null)" ||
>  	die "fatal: $0 cannot be used without a working tree."
>  }
> =20

An alternative which does not change the established behavior of
require_work_tree would be changing the order of require_work_tree and
cd_to_top_level in the callers where possible along the lines of

http://mid.gmane.org/96abf622ca2cf92998ce4ed393ccaa75d95dd9a8.127911202=
5.git.git@drmicha.warpmail.net

which got lost somehow. (The other callers, as mentioned by Junio, woul=
d
need to be changed differently, e.g. by moving cd_to... earlier.)

Another problem I noticed back then (I was away since) was that a
relative GIT_WORK_TREE is left in place after a cd_to_top_level and
messes things up completely - it does not seem to be relative to
GIT_DIR. So, there seems to be more to fix in this area.

Cheers,
Michael
