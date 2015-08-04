From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] clone: simplify string handling in guess_dir_name()
Date: Tue, 4 Aug 2015 18:42:46 -0400
Message-ID: <20150804224246.GA29051@sigill.intra.peff.net>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
 <0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
 <20150804043401.4494.43725@typhoon>
 <CAHGBnuMXkqhFUhen9tPfEsfFAHhbqMeFUxvePS_6A-TtMfZpzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 00:42:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMkvA-0004fN-O4
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 00:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbbHDWmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 18:42:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:40867 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752831AbbHDWmv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 18:42:51 -0400
Received: (qmail 2841 invoked by uid 102); 4 Aug 2015 22:42:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Aug 2015 17:42:51 -0500
Received: (qmail 24442 invoked by uid 107); 4 Aug 2015 22:42:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Aug 2015 18:42:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Aug 2015 18:42:46 -0400
Content-Disposition: inline
In-Reply-To: <CAHGBnuMXkqhFUhen9tPfEsfFAHhbqMeFUxvePS_6A-TtMfZpzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275344>

On Tue, Aug 04, 2015 at 09:31:18AM +0200, Sebastian Schuberth wrote:

> On Tue, Aug 4, 2015 at 6:34 AM, Lukas Fleischer <lfleischer@lfos.de> wrote:
> 
> > I am currently on vacation and cannot bisect or debug this but I am
> > pretty confident that this patch changes the behaviour of directory name
> > guessing. With Git 2.4.6, cloning http://foo.bar/foo.git/ results in a
> > directory named foo and with Git 2.5.0, the resulting directory is
> > called foo.git.
> >
> > Note how the end variable is decreased when the repository name ends
> > with a slash but that isn't taken into account when simply using
> > strip_suffix() later...
> >
> > Is this intended?
> 
> I did not intend this change in behavior, and I can confirm that
> reverting my patch restores the original behavior. Thanks for bringing
> this to my attention, I'll work on a patch.

I think this regression is in v2.4.8, as well. We should be able to use
a running "len" instead of the "end" pointer in the earlier part, and
then use strip_suffix_mem later (to strip from our already-reduced
length, rather than the full NUL-terminated string). Like this:

diff --git a/builtin/clone.c b/builtin/clone.c
index 303a3a7..4b61e4c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -146,20 +146,19 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 
 static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 {
-	const char *end = repo + strlen(repo), *start;
-	size_t len;
+	const char *start;
+	size_t len = strlen(repo);
 	char *dir;
 
 	/*
 	 * Strip trailing spaces, slashes and /.git
 	 */
-	while (repo < end && (is_dir_sep(end[-1]) || isspace(end[-1])))
-		end--;
-	if (end - repo > 5 && is_dir_sep(end[-5]) &&
-	    !strncmp(end - 4, ".git", 4)) {
-		end -= 5;
-		while (repo < end && is_dir_sep(end[-1]))
-			end--;
+	while (len > 0 && (is_dir_sep(repo[len-1]) || isspace(repo[len-1])))
+		len--;
+	if (len > 5 && is_dir_sep(repo[len-5]) &&
+	    strip_suffix_mem(repo, &len, ".git")) {
+		while (len > 0 && is_dir_sep(repo[len-1]))
+			len--;
 	}
 
 	/*
@@ -167,14 +166,14 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	 * the form  "remote.example.com:foo.git", i.e. no slash
 	 * in the directory part.
 	 */
-	start = end;
+	start = repo + len;
 	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
 		start--;
 
 	/*
 	 * Strip .{bundle,git}.
 	 */
-	strip_suffix(start, is_bundle ? ".bundle" : ".git" , &len);
+	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");
 
 	if (is_bare)
 		dir = xstrfmt("%.*s.git", (int)len, start);
@@ -187,6 +186,7 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	if (*dir) {
 		char *out = dir;
 		int prev_space = 1 /* strip leading whitespace */;
+		const char *end;
 		for (end = dir; *end; ++end) {
 			char ch = *end;
 			if ((unsigned char)ch < '\x20')

Sadly we cannot just `strip_suffix_mem(repo, &len, "/.git"))` in the
earlier code, as we have to account for multiple directory separators. I
believe the above code does the right thing, though. I haven't looked at
how badly it interacts with the other guess_dir_name work from Patrick
Steinhardt that has been going on, though.

-Peff
