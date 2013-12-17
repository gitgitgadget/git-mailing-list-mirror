From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] prune_object_dir(): verify that path fits in the
 temporary buffer
Date: Tue, 17 Dec 2013 18:22:31 -0500
Message-ID: <20131217232231.GA14807@sigill.intra.peff.net>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
 <1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
 <xmqq8uvjmhu5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 00:22:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt3yI-0007SZ-8q
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 00:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090Ab3LQXWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 18:22:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:46356 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905Ab3LQXWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 18:22:33 -0500
Received: (qmail 8542 invoked by uid 102); 17 Dec 2013 23:22:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Dec 2013 17:22:33 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Dec 2013 18:22:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqq8uvjmhu5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239410>

On Tue, Dec 17, 2013 at 10:51:30AM -0800, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > Dimension the buffer based on PATH_MAX rather than a magic number, and
> > verify that the path fits in it before continuing.
> >
> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> > ---
> >
> > I don't think that this problem is remotely exploitable, because the
> > size of the string doesn't depend on inputs that can be influenced by
> > a client (at least not within Git).
> 
> This is shrinking the buffer on some platforms where PATH_MAX is
> lower than 4k---granted, we will die() with the new check instead of
> crashing uncontrolled, but it still feels somewhat wrong.

On such a system, though, does the resulting prune_dir call actually do
anything? We will feed the result to opendir(), which I would think
would choke on the long name.

Still, it is probably better to do everything we can and let the OS
choke (especially because we would want to continue operating on other
paths in this case).

Converting it to use strbuf looks like it will actually let us drop a
bunch of copying, too, as we just end up in mkpath at the very lowest
level. I.e., something like below.

As an aside, I have noticed us using this "push/pop" approach to treating a
strbuf as a stack of paths elsewhere, too. I.e:

  size_t baselen = base->len;
  strbuf_addf(base, "/%s", some_thing);
  some_call(base);
  base->len = baselen;

I wondered if there was any kind of helper we could add to make it look
nicer. But I don't think so; the hairy part is that you must remember to
reset base->len after the call, and there is no easy way around that in
C. If you had object destructors that ran as the stack unwound, or
dynamic scoping, it would be easy to manipulate the object. Wrapping
won't work because strbuf isn't just a length wrapping an immutable
buffer; it actually has to move the NUL in the buffer.

Anyway, not important, but perhaps somebody is more clever than I am.

diff --git a/builtin/prune.c b/builtin/prune.c
index 6366917..4ca8ec1 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -17,9 +17,8 @@ static int verbose;
 static unsigned long expire;
 static int show_progress = -1;
 
-static int prune_tmp_object(const char *path, const char *filename)
+static int prune_tmp_object(const char *fullpath)
 {
-	const char *fullpath = mkpath("%s/%s", path, filename);
 	struct stat st;
 	if (lstat(fullpath, &st))
 		return error("Could not stat '%s'", fullpath);
@@ -32,9 +31,8 @@ static int prune_tmp_object(const char *path, const char *filename)
 	return 0;
 }
 
-static int prune_object(char *path, const char *filename, const unsigned char *sha1)
+static int prune_object(const char *fullpath, const unsigned char *sha1)
 {
-	const char *fullpath = mkpath("%s/%s", path, filename);
 	struct stat st;
 	if (lstat(fullpath, &st))
 		return error("Could not stat '%s'", fullpath);
@@ -50,9 +48,10 @@ static int prune_object(char *path, const char *filename, const unsigned char *s
 	return 0;
 }
 
-static int prune_dir(int i, char *path)
+static int prune_dir(int i, struct strbuf *path)
 {
-	DIR *dir = opendir(path);
+	size_t baselen = path->len;
+	DIR *dir = opendir(path->buf);
 	struct dirent *de;
 
 	if (!dir)
@@ -77,28 +76,39 @@ static int prune_dir(int i, char *path)
 			if (lookup_object(sha1))
 				continue;
 
-			prune_object(path, de->d_name, sha1);
+			strbuf_addf(path, "/%s", de->d_name);
+			prune_object(path->buf, sha1);
+			path->len = baselen;
 			continue;
 		}
 		if (!prefixcmp(de->d_name, "tmp_obj_")) {
-			prune_tmp_object(path, de->d_name);
+			strbuf_addf(path, "/%s", de->d_name);
+			prune_tmp_object(path->buf);
+			path->len = baselen;
 			continue;
 		}
-		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
+		fprintf(stderr, "bad sha1 file: %s/%s\n", path->buf, de->d_name);
 	}
 	closedir(dir);
 	if (!show_only)
-		rmdir(path);
+		rmdir(path->buf);
 	return 0;
 }
 
 static void prune_object_dir(const char *path)
 {
+	struct strbuf buf = STRBUF_INIT;
+	size_t baselen;
 	int i;
+
+	strbuf_addstr(&buf, path);
+	strbuf_addch(&buf, '/');
+	baselen = buf.len;
+
 	for (i = 0; i < 256; i++) {
-		static char dir[4096];
-		sprintf(dir, "%s/%02x", path, i);
-		prune_dir(i, dir);
+		strbuf_addf(&buf, "%02x", i);
+		prune_dir(i, &buf);
+		buf.len = baselen;
 	}
 }
 
@@ -120,7 +130,7 @@ static void remove_temporary_files(const char *path)
 	}
 	while ((de = readdir(dir)) != NULL)
 		if (!prefixcmp(de->d_name, "tmp_"))
-			prune_tmp_object(path, de->d_name);
+			prune_tmp_object(mkpath("%s/%s", path, de->d_name));
 	closedir(dir);
 }
 
