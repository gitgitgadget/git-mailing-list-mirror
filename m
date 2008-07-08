From: Pierre Habouzit <madcoder@debian.org>
Subject: Migration of builtin-blame to parse-option
Date: Tue,  8 Jul 2008 11:55:58 +0200
Message-ID: <1215510964-16664-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 12:00:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG9wg-0003P0-8k
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 11:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbYGHJ4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 05:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbYGHJ4K
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 05:56:10 -0400
Received: from pan.madism.org ([88.191.52.104]:33898 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbYGHJ4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 05:56:09 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E6A7F3438A;
	Tue,  8 Jul 2008 11:56:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B0C5D29EDA1; Tue,  8 Jul 2008 11:56:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.352.g416a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87733>

This series is twofold. The first 4 patches refactor the revision
parsing machine so that it's easier to deal with from a parse-opt based
parser:

[PATCH 1/6] revisions: refactor init_revisions and setup_revisions.
21 files changed, 70 insertions(+), 54 deletions(-)

  This is the patch I sent before, revisited.

[PATCH 2/6] revisions: split the pure option parsing out from parse_rev=
isions.
2 files changed, 273 insertions(+), 308 deletions(-)

  This patch splits out the revisions _option_ parsing (as opposed to
  revisions arguments or pseudo arguments like --all, --not, ...) from
  the revision parser. The patch is huge, but quite straightforward.

[PATCH 3/6] revisions: parse_revisions refactor.
1 files changed, 38 insertions(+), 25 deletions(-)

  This patch reworks parse_revisions so that it works internally as if
  it was a parse-opt parser. It's equivalent to the previous code, but
  changes are tricky, and a separate commit is really worth it.

[PATCH 4/6] revisions: split handle_revision_args from parse_revisions.
2 files changed, 52 insertions(+), 46 deletions(-)

  This patch splits out the last bit of parse-revisions (from the
  previous commit) so that what parses revisions arguments (refs and
  pseudo arguments like --all/--not/...) can be called independently.

  The commit is straightforward but moves code around, hence the
  separate commit from patch 3 so that one isn't lost in the code moves
  while reviewing the tricky bits from patch 3.


The second part is the git-blame migration for real:

[PATCH 5/6] git-blame: migrate to incremental parse-option [1/2]
1 files changed, 118 insertions(+), 102 deletions(-)

  This bit is really alike the proof of concept I saw. Most of the code
  is stolen from Linus initial patch. It merely removes the git-blame
  own options and deal with them with a parse-opt parser, in an
  incremental way.

  All in all, it's a pretty straighforward patch.

[PATCH 6/6] git-blame: migrate to incremental parse-option [2/2]
1 files changed, 40 insertions(+), 92 deletions(-)

  This is by far the trickiest patch of the series, though it passes th=
e
  testsuite fine. This patch uses the function from patch 4 to process
  the revision arguments. We know the dashdash position from the
  incremental parse-opt, but we have to deal with the "old way" of
  passing arguments to git-blame.

  The new code is really less involved than before, because we deal wit=
h
  a filtered argv array where we only have the revisions arguments (no
  options anymore) and the <path>.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
