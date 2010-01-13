From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: show interesting ident information in
 summary
Date: Wed, 13 Jan 2010 15:17:08 -0500
Message-ID: <20100113201708.GA23018@coredump.intra.peff.net>
References: <20100112153656.GA24840@coredump.intra.peff.net>
 <20100112154631.GC24957@coredump.intra.peff.net>
 <7v3a2asda8.fsf@alter.siamese.dyndns.org>
 <20100113173050.GB21318@coredump.intra.peff.net>
 <7vbpgxn5ui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:17:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9ef-0007xO-Ld
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab0AMURT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755767Ab0AMURS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:17:18 -0500
Received: from peff.net ([208.65.91.99]:46380 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755731Ab0AMURS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:17:18 -0500
Received: (qmail 26610 invoked by uid 107); 13 Jan 2010 20:22:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 Jan 2010 15:22:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2010 15:17:08 -0500
Content-Disposition: inline
In-Reply-To: <7vbpgxn5ui.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136874>

On Wed, Jan 13, 2010 at 11:48:53AM -0800, Junio C Hamano wrote:

> In olden days, `whoami`@`hostname`, at least on systems that were
> competently maintained, gave a reasonable mail address for most people,
> but I think it stopped being adequate more than 10 years ago, and it is
> not useful anymore to majority of people, especially the ones who work on
> Open Source projects as individuals, whose desired public identities are
> often tied to their email account at their ISPs or mailbox providers (like
> gmail).  There is no way for us to guess, when `whoami`@`hostname -f` is
> the only thing we can go by without explicit user configuration.

Even outside of competent maintenance or individuals being served by
ISPs, I think it is really that it is no longer the case that the
machines we get our mail on and the machines we do our work on are less
and less the same. Even as an individual, I can afford a Linux
workstation on my desk _and_ one to serve my mail. But I don't advertise
peff@workstation.peff.net as my email.

Which isn't to say there aren't people in the separate situation, like:

> Inside corporate environments, `whoami`@`hostname -f` might still be a
> reasonable and usable default, though.
> 
> So I think the safest thing to do would be to give a big advice but make
> it squelch-able with advice.howToSetYourIdentity or something.

I think that is a good idea. Administrators of competent shared
environments can turn off the advice via /etc/gitconfig if they want,
and everyone else needs to opt into it consciously, which should help
reduce errors. I'm sure there will still be somebody, somewhere, who
complains about having to set the config, but that minority is hopefully
small enough to justify the errors saved by new git users.

Can you apply the patch below to my series as 4/3?

-- >8 --
Subject: [PATCH] commit: allow suppression of implicit identity advice

We now nag the user with a giant warning when their identity
was pulled from the username, hostname, and gecos
information, in case it is not correct. Most users will
suppress this by simply setting up their information
correctly.

However, there may be some users who consciously want to use
that information, because having the value change from host
to host contains useful information. These users can now set
advice.implicitidentity to false to suppress the message.

Signed-off-by: Jeff King <peff@peff.net>
---
Pretty straightforward. The biggest question is whether to suppress the
"Committer: XXX <YYY@ZZZ>" line, too. I kind of think it is useful if
you are intentionally using this feature; by definition if you are using
it intentionally then the information is of some interest to you.

 Documentation/config.txt |    4 ++++
 advice.c                 |    2 ++
 advice.h                 |    1 +
 builtin-commit.c         |    6 ++++--
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9f40955..905076f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -130,6 +130,10 @@ advice.*::
 		Advice shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwritting local changes.
 		Default: true.
+	implicitIdentity::
+		Advice on how to set your identity configuration when
+		your information is guessed from the system username and
+		domain name. Default: true.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index cb666ac..8f7de0e 100644
--- a/advice.c
+++ b/advice.c
@@ -3,6 +3,7 @@
 int advice_push_nonfastforward = 1;
 int advice_status_hints = 1;
 int advice_commit_before_merge = 1;
+int advice_implicit_identity = 1;
 
 static struct {
 	const char *name;
@@ -11,6 +12,7 @@ static struct {
 	{ "pushnonfastforward", &advice_push_nonfastforward },
 	{ "statushints", &advice_status_hints },
 	{ "commitbeforemerge", &advice_commit_before_merge },
+	{ "implicitidentity", &advice_implicit_identity },
 };
 
 int git_default_advice_config(const char *var, const char *value)
diff --git a/advice.h b/advice.h
index 3de5000..728ab90 100644
--- a/advice.h
+++ b/advice.h
@@ -4,6 +4,7 @@
 extern int advice_push_nonfastforward;
 extern int advice_status_hints;
 extern int advice_commit_before_merge;
+extern int advice_implicit_identity;
 
 int git_default_advice_config(const char *var, const char *value);
 
diff --git a/builtin-commit.c b/builtin-commit.c
index 3fa9b39..d687cf1 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1082,8 +1082,10 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	if (!user_ident_explicitly_given) {
 		strbuf_addstr(&format, "\n Committer: ");
 		strbuf_addbuf_percentquote(&format, &committer_ident);
-		strbuf_addch(&format, '\n');
-		strbuf_addstr(&format, implicit_ident_advice);
+		if (advice_implicit_identity) {
+			strbuf_addch(&format, '\n');
+			strbuf_addstr(&format, implicit_ident_advice);
+		}
 	}
 	strbuf_release(&author_ident);
 	strbuf_release(&committer_ident);
-- 
1.6.6.146.gdaab9.dirty
