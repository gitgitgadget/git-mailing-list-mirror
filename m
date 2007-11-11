From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] Use the best available exec path only
Date: Sun, 11 Nov 2007 21:33:18 +0100
Message-ID: <20071111203318.GA32671@atjola.homenet>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com> <Pine.LNX.4.64.0711111557370.4362@racer.site> <FCFF59B3-D3F1-4BEB-B3C3-D07DD5D5D8EF@silverinsanity.com> <7v3avcefg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 21:33:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrJUw-0006S5-Ft
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 21:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336AbXKKUdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 15:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757273AbXKKUdX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 15:33:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:47950 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756177AbXKKUdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 15:33:22 -0500
Received: (qmail invoked by alias); 11 Nov 2007 20:33:20 -0000
Received: from i577B84F1.versanet.de (EHLO localhost) [87.123.132.241]
  by mail.gmx.net (mp034) with SMTP; 11 Nov 2007 21:33:20 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+v09YlL8avAwsDe1Xeb1Od3WKct6SUe9oTzSjtal
	l5XY2EiwweKIem
Content-Disposition: inline
In-Reply-To: <7v3avcefg9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64508>

On 2007.11.11 11:43:02 -0800, Junio C Hamano wrote:
> Brian Gernhardt <benji@silverinsanity.com> writes:
>=20
> > I'm sorry, I should have been more clear.  I was referring to the
> > GIT_EXEC_PATH build variable, not the environment variable.  The gi=
t
> > wrapper always adds the path determined during build to the front o=
f
> > PATH.  When I was changing my build script, this got set to "/usr/
> > local/bin" (I usually use /usr/local/stow/git, instead).  Since I h=
ave
> > a /usr/local/bin/vim, PATH for git-commit.sh during the test was:
> >
> > - my git build directory
> > - /usr/local/bin (containing a symlink vi -> vim)
> > - the t/trash directory, added by the test via `PATH=3D".:$PATH"`
> > (containing the test vi script)
> > - my normal path
>=20
> Maybe that is what is broken.  t/test-lib.sh makes the
> environment variable point at the build directory, and that
> should override the path that is compiled in, shouldn't it?

Maybe you prefer this patch then? "make test" survived up to 9101/25,
but that fails with the current master anyway and I didn't bother to ru=
n
the remaining tests manually, so it seems to be fine. Might break some
weird setups that rely on being able to set multiple additional paths
though (not that I think that that is a good idea to begin with).

Bj=F6rn
---
Instead of adding all possible exec paths to PATH, only add the best
one, following the same rules that --exec-path, without arguments, uses
to figure out which path to display.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
diff --git a/exec_cmd.c b/exec_cmd.c
index 2d0a758..9c376ad 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -48,9 +48,7 @@ void setup_path(const char *cmd_path)
=20
 	strbuf_init(&new_path, 0);
=20
-	add_path(&new_path, argv_exec_path);
-	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
-	add_path(&new_path, builtin_exec_path);
+	add_path(&new_path, git_exec_path());
 	add_path(&new_path, cmd_path);
=20
 	if (old_path)
