From: Jeff King <peff@peff.net>
Subject: Re: git log --quiet bug?
Date: Tue, 8 Nov 2011 16:29:30 -0500
Message-ID: <20111108212930.GA18529@sigill.intra.peff.net>
References: <1320762978.3614.YahooMailNeo@web84005.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Prasad Deshpande <prasadgdeshpande@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 22:29:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNtEf-0005o4-Qs
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 22:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157Ab1KHV3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 16:29:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37165
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab1KHV3c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 16:29:32 -0500
Received: (qmail 8242 invoked by uid 107); 8 Nov 2011 21:29:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 16:29:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 16:29:30 -0500
Content-Disposition: inline
In-Reply-To: <1320762978.3614.YahooMailNeo@web84005.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185112>

On Tue, Nov 08, 2011 at 06:36:18AM -0800, Prasad Deshpande wrote:

> =C2=A0 I am seeing a bug with git log --quiet. It=C2=A0doesn't=C2=A0s=
eem to be quiet
> :-). Also I have seen cases where the exit status returned is not
> correct i.e. its 0 even if there is some output (although I cant seem
> to reproduce that problem at present).

I think the description of "--quiet" in the git-log manpage is
accidentally inherited by including the diff options. In "git diff", it
stops output and makes the exit code useful for determining whether
there were changes. But what does the exit code even mean in the contex=
t
of "git log"?

It does look like there is code in "git log" to handle --quiet, and
convert it to "no diff output" (i.e., like "-s"). But it doesn't seem t=
o
do anything. If I manually specify a format like "git log -p --quiet", =
I
still get output. And if I don't say "-p", then I wouldn't get diff
output anyway. It does seem to have an impact on other log variants tha=
t
have output by default (e.g., "git whatchanged --quiet" won't show the
usual raw diffs).

I think we should probably just excise it from the git-log manpage, lik=
e
this:

-- >8 --
Subject: [PATCH] docs: don't mention --quiet or --exit-code in git-log(=
1)

These are diff-options, but they don't actually make sense
in the context of log.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/diff-options.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 08b581f..9f7cba2 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -412,15 +412,17 @@ endif::git-format-patch[]
 --function-context::
 	Show whole surrounding functions of changes.
=20
 ifndef::git-format-patch[]
+ifndef::git-log[]
 --exit-code::
 	Make the program exit with codes similar to diff(1).
 	That is, it exits with 1 if there were differences and
 	0 means no differences.
=20
 --quiet::
 	Disable all output of the program. Implies `--exit-code`.
+endif::git-log[]
 endif::git-format-patch[]
=20
 --ext-diff::
 	Allow an external diff helper to be executed. If you set an
--=20
1.7.7.2.7.g9f96f
