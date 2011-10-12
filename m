From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: update [section.subsection] to reflect
 what git does
Date: Wed, 12 Oct 2011 12:29:39 -0400
Message-ID: <20111012162939.GA3055@sigill.intra.peff.net>
References: <1318434726-5556-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Oct 12 18:29:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE1gm-0001Af-C3
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 18:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394Ab1JLQ3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 12:29:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58552
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab1JLQ3l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 12:29:41 -0400
Received: (qmail 12344 invoked by uid 107); 12 Oct 2011 16:29:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 12:29:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 12:29:39 -0400
Content-Disposition: inline
In-Reply-To: <1318434726-5556-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183374>

On Wed, Oct 12, 2011 at 05:52:06PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> -There is also a case insensitive alternative `[section.subsection]` =
syntax.
> -In this syntax, subsection names follow the same restrictions as for=
 section
> -names.
> +There is also a deprecated `[section.subsection]` syntax. With this
> +syntax, the subsection name is converted to lower-case and is also
> +compared case sensitively. These subsection names follow the same
> +restrictions as section names.

Hmm. While technically more correct, I think it is a little more
confusing to read. The lower-case canonicalization thing is actually
used for the other case-insensitive parts, too. So maybe it makes sense
to describe that in detail, and then just note that
"[section.subsection]" uses the same mechanism.

The patch below does this, and then the original text in the section yo=
u
tweaked above hopefully makes more sense in the new context.

The explanation matches what we do now, but it did end up a bit longer
than I had hoped. We could make it a lot shorter by:

  1. Canonicalizing the section and key names that the caller gives to
     git-config.

  2. Not mentioning the "section.foo" syntax. We can't canonicalize the
     subsection in (1) because of this syntax. But we can at least glos=
s
     over the detail, and then maybe just mention it much later in the
     file format. Or even deprecate it.

-- >8 --
Subject: [PATCH] docs/config: explain case-insensitive matching

We generally think of key matching as case-insensitive, but
it's not exactly. It's about canonicalizing one side, and
comparing it byte-wise with the canonical key name given to
git-config.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-config.txt |   50 ++++++++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.tx=
t
index e7ecf5d..e92aee9 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -28,7 +28,7 @@ DESCRIPTION
 -----------
 You can query/set/replace/unset options with this command. The name is
 actually the section and the key separated by a dot, and the value wil=
l be
-escaped.
+escaped. See the section on name matching below.
=20
 Multiple lines can be added to an option by using the '--add' option.
 If you want to update or unset an option which can occur on multiple
@@ -178,6 +178,54 @@ See also <<FILES>>.
 	Opens an editor to modify the specified config file; either
 	'--system', '--global', or repository (default).
=20
+
+NAME MATCHING
+-------------
+
+Configuration key names are matched using an algorithm that allows for
+partial case sensitivity. Section and key names are read from the conf=
ig
+files, canonicalized according to the rules below, and then compared
+case-sensitively with the input given to git-config. Therefore any
+callers to git-config should request the canonicalized version of the
+name. This typically means lowercasing the section and key names, and
+leaving the subsection (if any) intact. For example, ask for
+`git config core.eol`, not `git config CoRe.EOL`.
+
+The canonicalization rules are:
+
+1. Lowercase the section and key names.
+
+2. If a literal subsection (like `[section "foo"]`) is used, leave it
+   intact.
+
+3. If a non-literal subsection (like `[section.foo]`) is used, lowerca=
se
+   the subsection.
+
+4. Concatenate the resulting section, subsection, and key, separated b=
y
+   a dot ('.').
+
+For example, this configuration file:
+
+-----------------------------------------------
+[CORE]
+eol =3D true
+
+[branch "Foo"]
+REMOTE =3D origin
+
+[color.DIFF]
+new =3D blue
+-----------------------------------------------
+
+would yield the following three canonicalized names:
+
+-----------------------------------------------
+core.eol
+branch.Foo.remote
+color.diff.new
+-----------------------------------------------
+
+
 [[FILES]]
 FILES
 -----
--=20
1.7.7.rc2.21.gb9948
