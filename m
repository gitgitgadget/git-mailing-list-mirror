From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 00:05:22 -0700
Message-ID: <7vfxpq3559.fsf@gitster.siamese.dyndns.org>
References: <20080730093903.GA14330@cuci.nl>
 <20080730150123.GB9758@atjola.homenet>
 <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com>
 <20080731064814.GA32431@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sverre@rabbelier.nl,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 31 09:07:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOSFY-0004f6-0u
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 09:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbYGaHFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 03:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbYGaHFe
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 03:05:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYGaHFd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 03:05:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 64E0C4480C;
	Thu, 31 Jul 2008 03:05:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DF5DE4480A; Thu, 31 Jul 2008 03:05:25 -0400 (EDT)
In-Reply-To: <20080731064814.GA32431@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 31 Jul 2008 02:48:15 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10CC1B3C-5ECF-11DD-B0D7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90901>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 30, 2008 at 05:43:52PM +0200, Sverre Rabbelier wrote:
>
>> On Wed, Jul 30, 2008 at 17:01, Bj=C3=B6rn Steinbrink <B.Steinbrink@g=
mx.de> wrote:
>> > git blame doesn't know --find-copies-harder, it's -C -C for blame.
>>=20
>> Shouldn't it have died with "don't know option --find-copies-harder"=
 then?
>
> Unfortunately, it _does_ know --find-copies-harder, because unknown
> options get sent to the revision option parser, which chains to the d=
iff
> option parser. So it recognizes --find-copies-harder, but just sets a
> flag that doesn't do what we expect.
>
> I'm not sure if there is a simple fix. Does blame actually need the d=
iff
> option parsing? If not, then we might be able to pass a flag to
> parse_revision_opt that says "don't do diff options, too".

Sigh...

We can probably pick up the result revision parser parsed out of
revs.diffopt, and then tweak "opt" with it, perhaps like this.

 builtin-blame.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 8b6b09b..4ea3431 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2346,6 +2346,10 @@ int cmd_blame(int argc, const char **argv, const=
 char *prefix)
 parse_done:
 	argc =3D parse_options_end(&ctx);
=20
+	if (DIFF_OPT_TST(&revs.diffopt, FIND_COPIES_HARDER))
+		opt |=3D (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
+			PICKAXE_BLAME_COPY_HARDER);
+
 	if (!blame_move_score)
 		blame_move_score =3D BLAME_DEFAULT_MOVE_SCORE;
 	if (!blame_copy_score)
