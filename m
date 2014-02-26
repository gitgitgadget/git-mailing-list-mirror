From: Jeff King <peff@peff.net>
Subject: Re: Cygwin + git log = no pager!
Date: Wed, 26 Feb 2014 04:26:10 -0500
Message-ID: <20140226092610.GB32537@sigill.intra.peff.net>
References: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>
 <53085434.4060106@gmail.com>
 <CAHd499AbsUwmA0HWu31jW2n8eUNnRtU7URKPfBU7EhU6-F48zg@mail.gmail.com>
 <530AFAFD.2060504@gmail.com>
 <20140224090618.GB10698@sigill.intra.peff.net>
 <CAHd499BDBgaAZFkoc=S9i9hG=NifAmqhaW86fqgkzjShZd07ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Packham <judge.packham@gmail.com>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 10:26:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIaku-00007i-8C
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 10:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbaBZJ0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 04:26:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:57216 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750799AbaBZJ0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 04:26:12 -0500
Received: (qmail 4509 invoked by uid 102); 26 Feb 2014 09:26:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 03:26:12 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 04:26:10 -0500
Content-Disposition: inline
In-Reply-To: <CAHd499BDBgaAZFkoc=S9i9hG=NifAmqhaW86fqgkzjShZd07ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242705>

On Mon, Feb 24, 2014 at 01:34:34PM -0600, Robert Dailey wrote:

> So I set GIT_PAGER to 'echo custom pager' as you instructed, and I
> noticed that wasn't being printed when I ran my git log alias. So what
> I did after that was set GIT_TRACE=1 and here is the output I see
> before my logs start printing:
> [...]
> Does using an alias have something to do with this?

The aliases shouldn't matter (and I constructed a scenario like the one
you showed and it starts the pager for me on Linux). It's more like git
is deciding not to show a pager at all (e.g., it thinks your stdout is
not a tty). Does running:

  git log

not use a pager, but:

  git -p log

does? In that case, I think that your stdout is not a tty for some
reason.

If that is the case, try:

  git -p lg

That _should_ turn on the pager, but I think it does not due to a bug
with setup_pager and aliases. Something like the patch below would make
it work (but if you are having to use "-p" manually, there is something
to fix in your cygwin environment, which does not think you are on a
terminal).

-Peff

---
diff --git a/cache.h b/cache.h
index dc040fb..ecc410e 100644
--- a/cache.h
+++ b/cache.h
@@ -1238,6 +1238,7 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
 
 /* pager.c */
 extern void setup_pager(void);
+extern void setup_pager_with_options(int stdout_is_tty);
 extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
diff --git a/git.c b/git.c
index 7cf2953..ad54891 100644
--- a/git.c
+++ b/git.c
@@ -27,7 +27,7 @@ static void commit_pager_choice(void) {
 		setenv("GIT_PAGER", "cat", 1);
 		break;
 	case 1:
-		setup_pager();
+		setup_pager_with_options(1);
 		break;
 	default:
 		break;
diff --git a/pager.c b/pager.c
index 0cc75a8..b28125d 100644
--- a/pager.c
+++ b/pager.c
@@ -62,7 +62,12 @@ const char *git_pager(int stdout_is_tty)
 
 void setup_pager(void)
 {
-	const char *pager = git_pager(isatty(1));
+	setup_pager_with_options(isatty(1));
+}
+
+void setup_pager_with_options(int stdout_is_tty)
+{
+	const char *pager = git_pager(stdout_is_tty);
 
 	if (!pager || pager_in_use())
 		return;
