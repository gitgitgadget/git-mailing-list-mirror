From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 3 Oct 2011 14:01:59 +0300
Message-ID: <20111003110159.GA13064@LK-Perkele-VI.localdomain>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111003074250.GB9455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 13:02:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAgHj-00032Y-DL
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 13:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461Ab1JCLCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 07:02:07 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:47464 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab1JCLCF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 07:02:05 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id E60918BF92;
	Mon,  3 Oct 2011 14:02:02 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A037F9E1C48; Mon, 03 Oct 2011 14:02:02 +0300
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 7AB0A1C6385;
	Mon,  3 Oct 2011 14:01:59 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20111003074250.GB9455@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182652>

On Mon, Oct 03, 2011 at 03:42:51AM -0400, Jeff King wrote:
> On Sat, Oct 01, 2011 at 11:26:55AM +1000, Nguyen Thai Ngoc Duy wrote:
>=20
> The real problem here seems to be that instead of communicating "no, =
we
> don't support that", git-daemon just hangs up. It would be a much nic=
er
> fix if we could change that. I'm not sure it's possible, though. Ther=
e's
> not much room in the beginning of the room to make that communication=
 in
> a way that's backwards compatible.

Oh, sure it is possible (except for remote snapshot):

$ /usr/bin/git fetch git://localhost/foobar
fatal: remote error: R access for foobar DENIED to anonymous
$=C2=A0/usr/bin/git push git://localhost/foobar
fatal: remote error: W access for foobar DENIED to anonymous
$ /usr/bin/git archive --remote=3Dgit://localhost/foobar HEAD
fatal: git archive: protocol error
$ /usr/bin/git --version
git version 1.7.6.3

Supported for fetch and push since 1.6.1-rc1 (And 1.6.1 was over
2.5 years ago). Oh, and even before that, but with slightly more
ugly error message.

Oh, and adding interpretation of ERR packets to git archive is easy
(and I even happen to have git:// server that can send those to
test against):

$ git archive --remote=3Dgit://localhost/foobar HEAD
fatal: remote error: R access for foobar DENIED to anonymous

(I also tested that remote snapshotting of repository that should be
readable succeeds, it does).

--- >8 ----
=46rom ce3a402e4fa72cf603f92801d6f021ff89d3ac35 Mon Sep 17 00:00:00 200=
1
=46rom: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Date: Mon, 3 Oct 2011 13:55:37 +0300
Subject: [PATCH] Support ERR in remote archive like in fetch/push

Make ERR as first packet of remote snapshot reply work like it does in
fetch/push. Lets servers decline remote snapshot with message the same
way as declining fetch/push with a message.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 builtin/archive.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 883c009..931956d 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -61,6 +61,8 @@ static int run_remote_archiver(int argc, const char *=
*argv,
 	if (strcmp(buf, "ACK")) {
 		if (len > 5 && !prefixcmp(buf, "NACK "))
 			die(_("git archive: NACK %s"), buf + 5);
+		if (len > 4 && !prefixcmp(buf, "ERR "))
+			die(_("remote error: %s"), buf + 4);
 		die(_("git archive: protocol error"));
 	}
=20
--=20
1.7.7.3.g2791de.dirty


-Ilari
