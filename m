From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 05/11] Don't advertise HEAD from ReceivePack
Date: Tue, 21 Jul 2009 17:22:09 +0200
Message-ID: <200907211722.09631.robin.rosenberg.lists@dewire.com>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org> <1247343566-19025-5-git-send-email-spearce@spearce.org> <1247343566-19025-6-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:22:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTHAd-00084Z-4u
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbZGUPWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2009 11:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbZGUPWM
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:22:12 -0400
Received: from mail.dewire.com ([83.140.172.130]:3352 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbZGUPWM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 11:22:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 61C741481DB3;
	Tue, 21 Jul 2009 17:22:11 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ncElmTStc4HL; Tue, 21 Jul 2009 17:22:10 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id DDE061481DB2;
	Tue, 21 Jul 2009 17:22:10 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1247343566-19025-6-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123664>

l=F6rdag 11 juli 2009 22:19:20 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
> The HEAD ref cannot be pushed to by a client, if it is a detached HEA=
D
> the client shouldn't be permitted to change it, if it is a symref to
> another ref then the client should update the destination ref and not
> the symref.  Instead offer the HEAD ref as a ".have" line, which is a=
n
> invalid ref that the client can't update but still lets the client kn=
ow
> we have its target object reachable.
>=20
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../org/spearce/jgit/transport/ReceivePack.java    |    5 ++++-
>  .../org/spearce/jgit/transport/RefAdvertiser.java  |   15 ++++++++++=
+++++
>  2 files changed, 19 insertions(+), 1 deletions(-)
>=20
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceiveP=
ack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.=
java
> index fd8aa86..1c490af 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.jav=
a
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.jav=
a
> @@ -509,8 +509,11 @@ private void sendAdvertisedRefs() throws IOExcep=
tion {
>  		adv.advertiseCapability(CAPABILITY_REPORT_STATUS);
>  		if (allowOfsDelta)
>  			adv.advertiseCapability(CAPABILITY_OFS_DELTA);
> -		refs =3D db.getAllRefs();
> +		refs =3D new HashMap<String, Ref>(db.getAllRefs());
> +		final Ref head =3D refs.remove(Constants.HEAD);
>  		adv.send(refs.values());
> +		if (head !=3D null && head.getName() =3D=3D head.getOrigName())
> +			adv.advertiseHave(head.getObjectId());

This relies on an implicit guarantee that =3D=3D works here. Would equa=
ls cost
too much? Or perhaps we should document this guarantee as part of the
interface.

-- robin
