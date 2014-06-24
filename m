From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 06/10] setup_git_env: use git_pathdup instead of
 xmalloc + sprintf
Date: Tue, 24 Jun 2014 16:58:15 -0400
Message-ID: <20140624205815.GA28724@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
 <20140619212800.GF28474@sigill.intra.peff.net>
 <CACsJy8B-zQUH++U_RKq16_M+6FF5bmHXA100xM3uO42TUj3kJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:58:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzXnK-0006qk-2W
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 22:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbaFXU6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 16:58:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:50492 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754817AbaFXU6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 16:58:17 -0400
Received: (qmail 20097 invoked by uid 102); 24 Jun 2014 20:58:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jun 2014 15:58:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2014 16:58:15 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8B-zQUH++U_RKq16_M+6FF5bmHXA100xM3uO42TUj3kJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252420>

On Tue, Jun 24, 2014 at 08:30:26PM +0700, Duy Nguyen wrote:

> On Fri, Jun 20, 2014 at 4:28 AM, Jeff King <peff@peff.net> wrote:
> > diff --git a/environment.c b/environment.c
> > index 4dac5e9..4de7b81 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -135,15 +135,11 @@ static void setup_git_env(void)
> >         gitfile = read_gitfile(git_dir);
> >         git_dir = xstrdup(gitfile ? gitfile : git_dir);
> >         git_object_dir = getenv(DB_ENVIRONMENT);
> > -       if (!git_object_dir) {
> > -               git_object_dir = xmalloc(strlen(git_dir) + 9);
> > -               sprintf(git_object_dir, "%s/objects", git_dir);
> > -       }
> 
> If DB_ENVIRONMENT is set, we should xstrdup(git_object_dir) because
> getenv's return value is not guaranteed persistent. Since you're touch
> this area, perhaps do it too (in this, or another patch)?

Here's a replacement patch that handles this (and just drops the ugly
mallocs as a side effect).

-- >8 --
Subject: [PATCH] setup_git_env: copy getenv return value

The return value of getenv is not guaranteed to survive
across further invocations of setenv or even getenv. When we
are assigning it to globals that last the lifetime of the
program, we should make our own copy.

Signed-off-by: Jeff King <peff@peff.net>
---
 environment.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/environment.c b/environment.c
index 4dac5e9..efb2fa0 100644
--- a/environment.c
+++ b/environment.c
@@ -124,6 +124,12 @@ static char *expand_namespace(const char *raw_namespace)
 	return strbuf_detach(&buf, NULL);
 }
 
+static char *git_path_from_env(const char *envvar, const char *path)
+{
+	const char *value = getenv(envvar);
+	return value ? xstrdup(value) : git_pathdup(path);
+}
+
 static void setup_git_env(void)
 {
 	const char *gitfile;
@@ -134,19 +140,9 @@ static void setup_git_env(void)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 	gitfile = read_gitfile(git_dir);
 	git_dir = xstrdup(gitfile ? gitfile : git_dir);
-	git_object_dir = getenv(DB_ENVIRONMENT);
-	if (!git_object_dir) {
-		git_object_dir = xmalloc(strlen(git_dir) + 9);
-		sprintf(git_object_dir, "%s/objects", git_dir);
-	}
-	git_index_file = getenv(INDEX_ENVIRONMENT);
-	if (!git_index_file) {
-		git_index_file = xmalloc(strlen(git_dir) + 7);
-		sprintf(git_index_file, "%s/index", git_dir);
-	}
-	git_graft_file = getenv(GRAFT_ENVIRONMENT);
-	if (!git_graft_file)
-		git_graft_file = git_pathdup("info/grafts");
+	git_object_dir = git_path_from_env(DB_ENVIRONMENT, "objects");
+	git_index_file = git_path_from_env(INDEX_ENVIRONMENT, "index");
+	git_graft_file = git_path_from_env(GRAFT_ENVIRONMENT, "info/grafts");
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs = 0;
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
-- 
2.0.0.566.gfe3e6b2
