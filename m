From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [POC PATCH 5/5] completion: avoid compgen to fix expansion
 issues in __gitcomp_nl()
Date: Fri, 28 Sep 2012 17:08:52 +0200
Message-ID: <20120928150852.GA13081@goldbirke>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
 <1348826975-2225-5-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 17:09:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THcBo-0001dh-Vv
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 17:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758417Ab2I1PJG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 11:09:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64653 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758415Ab2I1PJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 11:09:05 -0400
Received: from localhost6.localdomain6 (goldbirke.fzi.de [141.21.50.31])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Luphl-1TQ2EP46OP-00zcIG; Fri, 28 Sep 2012 17:08:53 +0200
Content-Disposition: inline
In-Reply-To: <1348826975-2225-5-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:2Snf8/lNKrVRrNRDsuCOEWxoPrOhRf7Jvz+SDNPnU1m
 RJVQWQ2CiQvEad1RJ5CRssSBQ+sODeD6ZV2ycDZwLgaQvEDvm+
 oThEwUtPPHAEl1ij1e1G9R7zdkdXnzuLtqpfWB9K4R9PnL1Fcu
 nmiOQAjxEE7wAzdrFDCDkKwI8zwGQc89RiLk1ZMXOh6gFyzNhB
 oJVJAGmIVL/2kdbBMUhGQZvyNdvKkYZwk0oRSX1GhOkfytod1a
 E07dSwOeLV6FLwKtargsXPX36E26JXgd6/FS5Mxqi0bV6pLZBB
 NkjnPer0v2XOS+qYclFDg8YzcWMWVBpWpUdIZiEmmm/jruiu7D
 lTYRKaI9gPD4Pxn2tuWg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206583>

On Fri, Sep 28, 2012 at 12:09:35PM +0200, SZEDER G=E1bor wrote:
>  __gitcomp_nl ()
>  {
>  	local IFS=3D$'\n'
> -	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}=
"))
> +	COMPREPLY=3D($(echo "$1" |sed -n "/^${3-$cur}/ {

$cur can be a path, so it can contain /, which then breaks this sed
expression.  Here's a fixup:


diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2df865fd..d30f376f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -260,8 +260,8 @@ __gitcomp ()
 #    appended.
 __gitcomp_nl ()
 {
-	local IFS=3D$'\n'
-	COMPREPLY=3D($(echo "$1" |sed -n "/^${3-$cur}/ {
+	local IFS=3D$'\n' cur_=3D${3-$cur}
+	COMPREPLY=3D($(echo "$1" |sed -n "/^${cur_//\//\\/}/ {
 		s/^/${2-}/
 		s/$/${4- }/
 		p
--=20
1.7.12.1.490.g14283db
