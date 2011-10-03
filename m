From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Support ERR in remote archive like in fetch/push
Date: Mon, 3 Oct 2011 06:26:50 -0500
Message-ID: <20111003112649.GA12874@elie>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111003074250.GB9455@sigill.intra.peff.net>
 <20111003110159.GA13064@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Oct 03 13:27:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAgfv-0002iP-5P
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 13:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab1JCL1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 07:27:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34172 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab1JCL1E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 07:27:04 -0400
Received: by iaqq3 with SMTP id q3so4904583iaq.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3aeoYfcjDxt7X9pjVIAe9GUDBqeFCdP1h7F4N+KkYgM=;
        b=cxpydLQp2OHO6yXNT27y6aZpT8T8x4S4VjfW576gMfdUtKJmK+GwVrN6bAe64WDpuV
         ZTSFtQq7MaP3mvu3v5FemP8MK1Uu/Idx08DNAL+/qjODISEvJvtiNlmlt2k5+dD4ftVG
         u8gbMthpyhS47o5+rY/vBTgFjGXIaSMUSPhck=
Received: by 10.42.132.10 with SMTP id b10mr7583049ict.76.1317641224245;
        Mon, 03 Oct 2011 04:27:04 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id ek22sm28971698ibb.12.2011.10.03.04.27.03
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 04:27:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111003110159.GA13064@LK-Perkele-VI.localdomain>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182654>

Ilari Liusvaara wrote:

> Oh, and adding interpretation of ERR packets to git archive is easy
> (and I even happen to have git:// server that can send those to
> test against):
>
> $ git archive --remote=3Dgit://localhost/foobar HEAD
> fatal: remote error: R access for foobar DENIED to anonymous
>
> (I also tested that remote snapshotting of repository that should be
> readable succeeds, it does).

Sounds like a good idea to me.  Let's see what Ren=C3=A9 thinks; also
changing the subject line to attract other reviewers.

> --- >8 ----
> From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> Date: Mon, 3 Oct 2011 13:55:37 +0300
> Subject: [PATCH] Support ERR in remote archive like in fetch/push
>=20
> Make ERR as first packet of remote snapshot reply work like it does i=
n
> fetch/push. Lets servers decline remote snapshot with message the sam=
e
> way as declining fetch/push with a message.
>=20
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> ---
>  builtin/archive.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/builtin/archive.c b/builtin/archive.c
> index 883c009..931956d 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -61,6 +61,8 @@ static int run_remote_archiver(int argc, const char=
 **argv,
>  	if (strcmp(buf, "ACK")) {
>  		if (len > 5 && !prefixcmp(buf, "NACK "))
>  			die(_("git archive: NACK %s"), buf + 5);
> +		if (len > 4 && !prefixcmp(buf, "ERR "))
> +			die(_("remote error: %s"), buf + 4);
>  		die(_("git archive: protocol error"));
>  	}
> =20
> --=20
> 1.7.7.3.g2791de.dirty
>=20
