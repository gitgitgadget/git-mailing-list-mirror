From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/13] ident: don't write fallback username into
 git_default_name
Date: Mon, 21 May 2012 02:31:45 -0400
Message-ID: <20120521063145.GB2077@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
 <20120518231933.GH30031@sigill.intra.peff.net>
 <7v7gw69rbz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 08:31:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWM9o-0006AO-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 08:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293Ab2EUGbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 02:31:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50622
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856Ab2EUGbr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 02:31:47 -0400
Received: (qmail 31081 invoked by uid 107); 21 May 2012 06:32:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 02:32:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 02:31:45 -0400
Content-Disposition: inline
In-Reply-To: <7v7gw69rbz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198084>

On Sun, May 20, 2012 at 07:54:24PM -0700, Junio C Hamano wrote:

> This step seems to break t/t4014-format-patch.sh; the last output when the
> test is run with "-i -v" indicates that Message-Id: and In-Reply-To: lines
> have "<long-hexdigits.long-decimal.git.name@host" without matching closing
> ">" on it.

I found the issue. The test failure is actually introduced by patch
06/13 (format-patch: use default email for generating message ids). But
then it later gets fixed in 09/13 (drop length limitations on
gecos-derived names and emails).

The problems turns out to be a latent bug hidden in add_mailname_host.
It uses fgets to read from /etc/mailname, but never trims the trailing
newline. So git_default_email ends up set to something like
"peff@peff.net\n". Most of the time, this bug gets covered up by the
normalization that happens in fmt_ident (where we remove cruft
characters like newline). But in patch 6, we start using it directly
instead of re-parsing the output of fmt_ident, introducing a noticeable
bug.

I suspect there is also a bug in http-push.c, which directly uses
git_default_email as part of the xml in the dav request. I don't know if
it actually matters there or not.  And of course this triggers only on
systems with /etc/mailname, and only when you don't have user.email set.
So it may just be that the combination of that and the fact that hardly
anybody uses dumb http push has caused it to remain hidden.

The bug later ends up fixed in patch 9, because we replace fgets with
strbuf_getline, which trims the newline for us. Placing the patch below
anywhere before patch 6 fixes the issue (and then patch 9 would need to
later remove the code).

It does raise a subtle issue, though: should we be trimming whitespace
and other undesirable characters from git_default_email (or
git_default_name)? We don't currently, and it ends up OK because the
result typically is fed through fmt_ident, which cleans it up. But:

  1. We do look at the git_default_* variables for things like deciding
     whether the name is blank. So if your gecos field was " ", I think
     that would fool git into thinking it had something useful, and skip
     the IDENT_ERROR_ON_NO_NAME check, even though fmt_ident would
     produce an empty name.

  2. We don't always feed it through fmt_ident (the http-push.c callsite
     I mentioned above, and now patch 6 adds another one).

So I think my preference would be:

  - apply the patch below as 5.5/13

  - tweak patch 9 to remove the extra trimming

  - add a patch 14 to call strbuf_trim on the name and email buffers
    after reading them from system files.

-- >8 --
Subject: [PATCH] ident: trim trailing whitespace from /etc/mailname

Otherwise we will typically end up with an extra newline in
our git_default_email. Most of the time this doesn't matter,
as fmt_ident will skip it as cruft, but there is one code
path that accesses it directly (in http-push.c:lock_remote).

Let's trim any trailing space or line termination when we
read from /etc/mailname.

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ident.c b/ident.c
index af92b2c..e797e36 100644
--- a/ident.c
+++ b/ident.c
@@ -57,6 +57,7 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 static int add_mailname_host(char *buf, size_t len)
 {
 	FILE *mailname;
+	char *p;
 
 	mailname = fopen("/etc/mailname", "r");
 	if (!mailname) {
@@ -74,6 +75,8 @@ static int add_mailname_host(char *buf, size_t len)
 	}
 	/* success! */
 	fclose(mailname);
+	for (p = buf + strlen(buf) - 1; p >= buf && isspace(*p); p--)
+		*p = '\0';
 	return 0;
 }
 
-- 
1.7.10.1.19.g711d603
