From: Jeff King <peff@peff.net>
Subject: Re: possible bug in autocompletion
Date: Tue, 17 Jul 2012 08:12:32 -0400
Message-ID: <20120717121232.GA32571@sigill.intra.peff.net>
References: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeroen Meijer <jjgmeijer@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 14:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr6dz-0001yK-Js
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 14:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab2GQMMm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jul 2012 08:12:42 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36000
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab2GQMMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 08:12:40 -0400
Received: (qmail 5939 invoked by uid 107); 17 Jul 2012 12:12:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jul 2012 08:12:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2012 08:12:32 -0400
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201601>

On Tue, Jul 17, 2012 at 11:10:39AM +0200, Jeroen Meijer wrote:

> We have a tag name with some special characters. The tag name is
> 'Build%20V%20${bamboo.custom.jiraversion.name}%20Build%20721'. In
> somecases where autocompletion is used an error is given, such as
> 'bash: Build%20V%20${bamboo.custom.jiraversion.name}%20Build%20721:
> bad substitution'. This can be invoked by typing 'git checkout B' and
> then pressing tab.

Hrm. Weird. It is the "${}" in your tag name that causes the problem,
and it all boils down to bash trying to do parameter expansion on the
contents of "compgen -W". You can see it in a much simpler example:

  $ echo '${foo.bar}' ;# no expansion, works
  ${foo.bar}

  $ echo "${foo.bar}" ;# expansion, bash rightfully complains
  bash: ${foo.bar}: bad substitution

  $ compgen -W '${foo.bar}' f
  bash: ${foo.bar}: bad substitution

In the final command, we use single-quotes so there is no expansion
before the command execution. So it happens internally to compgen.
documentation for compgen says:

  -W wordlist
          The  wordlist is split using the characters in the IFS specia=
l vari=E2=80=90
          able as delimiters, and each resultant word is expanded.  The=
 possi=E2=80=90
          ble  completions  are  the members of the resultant list whic=
h match
          the word being completed.

Which seems kind of crazy to me. It means that we need to be quoting
everything we feed to compgen to avoid accidental expansion. But I gues=
s
bash is not likely to change anytime soon, so we probably need to work
around it.

> Of course; the tag is useless but still I guess this is a bug in the
> autocompletion of git.

Yeah, that tag is crazy. But this can happen anywhere that we feed
arbitrary data to compgen. Try this:

  echo content >'${foo.bar}' &&
  git add . &&
  git commit

  git show HEAD:<tab>

which generates the same error. Or even a file named "foo$bar", which i=
s
much more likely; that will not generate an error, but it will expand
$bar and produce erroneous results. I think we also have issues with
files with single and double quotes in them.

Something like this seems to fix it for me:

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index ffedce7..2d20824 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -261,7 +261,12 @@ __gitcomp ()
 __gitcomp_nl ()
 {
 	local IFS=3D$'\n'
-	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}")=
)
+	local words=3D$1
+	words=3D${words//\\/\\\\}
+	words=3D${words//\$/\\\$}
+	words=3D${words//\'/\\\'}
+	words=3D${words//\"/\\\"}
+	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cu=
r}"))
 }
=20
 __git_heads ()

but it is awfully ugly. Maybe completion experts can offer a better
solution.

-Peff
