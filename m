From: Jeff King <peff@peff.net>
Subject: Re: git commit -v does not removes the patch
Date: Tue, 11 Nov 2008 05:29:15 -0500
Message-ID: <20081111102914.GA30330@coredump.intra.peff.net>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com> <20081110181023.GA22753@coredump.intra.peff.net> <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com> <7vej1j40x5.fsf@gitster.siamese.dyndns.org> <20081111000706.GA26223@coredump.intra.peff.net> <adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 11:30:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzqW5-00042t-8B
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 11:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876AbYKKK3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2008 05:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755865AbYKKK3U
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 05:29:20 -0500
Received: from peff.net ([208.65.91.99]:4489 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755724AbYKKK3S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 05:29:18 -0500
Received: (qmail 11884 invoked by uid 111); 11 Nov 2008 10:29:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 11 Nov 2008 05:29:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Nov 2008 05:29:15 -0500
Content-Disposition: inline
In-Reply-To: <adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100635>

On Tue, Nov 11, 2008 at 08:56:34AM +0100, Santi B=C3=A9jar wrote:

> Almost! I have diff.mnemonicprefix=3Dtrue, if I unset it everything w=
orks.

Ah, indeed. The obvious fix is just loosening our match a little bit:

diff --git a/builtin-commit.c b/builtin-commit.c
index 93ca496..a721990 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1015,7 +1015,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	}
=20
 	/* Truncate the message just before the diff, if any. */
-	p =3D strstr(sb.buf, "\ndiff --git a/");
+	p =3D strstr(sb.buf, "\ndiff --git ");
 	if (p !=3D NULL)
 		strbuf_setlen(&sb, p - sb.buf + 1);
=20

But I have to wonder if there is some more robust solution. It seems
like this can have false positives if you include diff output in your
commit message, and a potential false negative if you delete the newlin=
e
(e.g., delete everything up to "diff --git", making it the first line).

But I guess we haven't seen a lot of complaints, so maybe those
conditions aren't worth worrying about.

-Peff
