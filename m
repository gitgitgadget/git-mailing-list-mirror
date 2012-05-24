From: Jeff King <peff@peff.net>
Subject: Re: t4014 broken by 43ae9f47ab: format-patch: use default email for
 generating message ids
Date: Thu, 24 May 2012 13:16:40 -0400
Message-ID: <20120524171640.GB3161@sigill.intra.peff.net>
References: <4FBE2335.2090903@jpk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <haggerty@jpk.com>
X-From: git-owner@vger.kernel.org Thu May 24 19:16:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXbeb-0001Hc-DY
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 19:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933670Ab2EXRQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 13:16:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53727
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754966Ab2EXRQo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 13:16:44 -0400
Received: (qmail 29484 invoked by uid 107); 24 May 2012 17:17:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 13:17:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 13:16:40 -0400
Content-Disposition: inline
In-Reply-To: <4FBE2335.2090903@jpk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198394>

On Thu, May 24, 2012 at 02:01:57PM +0200, Michael Haggerty wrote:

> On my setup, the above commit causes 12 tests in t4014 to fail.  For
> example, test 25:
> 
> >-Message-Id: <0>
> >+Message-Id: <1135adfeed86678c55e1aad7c568046ee8215660.1337860646.git.mhagger@michael.(none)>

Thanks for the report. I know exactly what the issue is, as it came up
in the discussion of the original series. 43ae9f47ab stopped using
git_committer_info (which looks at $GIT_COMMITTER_EMAIL) for the end of
the message-id and started using the default-generated email directly.

Nobody should care, because either:

  1. The defaults set up a reasonable hostname for your machine.

  2. They do not, but you adjust it by setting user.email. Otherwise,
     your author ident would have this bogus email in it.

The only setup that _would_ care is if the generated default is bogus
and you set $GIT_COMMITTER_EMAIL in the environment and relied on that
to get a sane value. Which is exactly what the test environment does.

The question is, is what it is doing sane and something we should care
about? Or is the test broken (it fails to parse the message-id that
contains ".(none)", but I am not even sure that is intentional and not
simply lazy regex writing in the test).

I suspect that is not especially sane, but at the same time, it is not
hard to support. The patch below (on top of jk/ident-gecos-strbuf)
should fix it.

-- >8 --
Subject: format-patch: use GIT_COMMITTER_EMAIL when making message ids

Before commit 43ae9f4, we generated the tail of a message id
by calling git_committer_info and parsing the email out of
the result. 43ae9f4 changed to use ident_default_email
directly, so we didn't have to bother with parsing. As a
side effect, it meant we no longer used GIT_COMMITTER_EMAIL
at all.

In general, this is probably reasonable behavior. Either the
default email is sane on your system, or you are using
user.email to provide something sane. The exception is if
you rely on GIT_COMMITTER_EMAIL being set all the time to
override the bogus generated email.

This is unlikely to match anybody's real-life setup, but we
do use it in the test environment. And furthermore, it's
what we have always done, and the change in 43ae9f4 was
about cleaning up, not fixing any bug; we should be
conservative and keep the behavior identical.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that we check the environment outside of the usual strbuf_trim that
happens to the default email. And outside of fmt_ident, which trims
whitespace, as well. So compared to the state before this series,
something like:

  GIT_COMMITTER_EMAIL="$(printf 'foo@bar\n')" git format-patch ...

is now broken. It also strikes me as a little ugly that this code path
needs to care about $GIT_COMMITTER_EMAIL at all. I can rework the ident
interface to provide a more sanitized broken-down version of the ident
if we care.

 builtin/log.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8010a40..3f1883c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -739,8 +739,11 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
 static void gen_message_id(struct rev_info *info, char *base)
 {
 	struct strbuf buf = STRBUF_INIT;
+	const char *email = getenv("GIT_COMMITTER_EMAIL");
+	if (!email)
+		email = ident_default_email();
 	strbuf_addf(&buf, "%s.%lu.git.%s", base,
-		    (unsigned long) time(NULL), ident_default_email());
+		    (unsigned long) time(NULL), email);
 	info->message_id = strbuf_detach(&buf, NULL);
 }
 
-- 
1.7.10.1.25.g7031a0f
