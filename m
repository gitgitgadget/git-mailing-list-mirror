From: Jeff King <peff@peff.net>
Subject: Re: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 06:40:50 -0500
Message-ID: <20080211114050.GC6344@coredump.intra.peff.net>
References: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de> <20080211074817.GA18898@sigill.intra.peff.net> <8c5c35580802110241i72169620s693a31f9a098f596@mail.gmail.com> <20080211110816.GA6344@coredump.intra.peff.net> <8aa486160802110320h78f7228fg84ae2c4986f67372@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Hjemli <hjemli@gmail.com>, Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 12:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOX2O-0003m7-UZ
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 12:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbYBKLkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 06:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbYBKLkx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 06:40:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2387 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbYBKLkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 06:40:53 -0500
Received: (qmail 8623 invoked by uid 111); 11 Feb 2008 11:40:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 11 Feb 2008 06:40:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2008 06:40:50 -0500
Content-Disposition: inline
In-Reply-To: <8aa486160802110320h78f7228fg84ae2c4986f67372@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73521>

On Mon, Feb 11, 2008 at 12:20:37PM +0100, Santi B=C3=A9jar wrote:

> Additionally git could warn if the limit is reached in the merge.

I think that is reasonable. It feels a little wrong, though, to be
spewing user messages from such a deep library-ish function (and those
messages will probably be lost for commands with a pager). But somethin=
g
like this?

---
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3d37725..31941bc 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -468,10 +468,11 @@ void diffcore_rename(struct diff_options *options=
)
 	 */
 	if (rename_limit <=3D 0 || rename_limit > 32767)
 		rename_limit =3D 32767;
-	if (num_create > rename_limit && num_src > rename_limit)
-		goto cleanup;
-	if (num_create * num_src > rename_limit * rename_limit)
+	if ((num_create > rename_limit && num_src > rename_limit) ||
+	    (num_create * num_src > rename_limit * rename_limit)) {
+		warning("too many files, skipping inexact rename detection");
 		goto cleanup;
+	}
=20
 	mx =3D xmalloc(sizeof(*mx) * num_create * num_src);
 	for (dst_cnt =3D i =3D 0; i < rename_dst_nr; i++) {
