From: Jeff King <peff@peff.net>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 16:25:00 -0400
Message-ID: <20120627202500.GB11700@sigill.intra.peff.net>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
 <20120627195205.GA11700@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Lyubomirov <daniel@digitalus.bg>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 22:25:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjynX-0006u0-5Q
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 22:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670Ab2F0UZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 16:25:05 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:47215
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab2F0UZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 16:25:04 -0400
Received: (qmail 2322 invoked by uid 107); 27 Jun 2012 20:25:07 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jun 2012 16:25:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jun 2012 16:25:00 -0400
Content-Disposition: inline
In-Reply-To: <20120627195205.GA11700@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200741>

On Wed, Jun 27, 2012 at 03:52:05PM -0400, Jeff King wrote:

> I think you'd want to do just do something like:
> 
> diff --git a/diff.c b/diff.c
> index 1a594df..aac72b7 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2684,9 +2684,6 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
>  		struct stat st;
>  		int fd;
>  
> -		if (!strcmp(s->path, "-"))
> -			return populate_from_stdin(s);
> -
>  		if (lstat(s->path, &st) < 0) {
>  			if (errno == ENOENT) {
>  			err_empty:
> 
> to temporarily fix it. That breaks
> 
>   echo content | git diff --no-index - some-file
> 
> but that code path should be fixed properly (with a use_stdin flag in
> the filespec).

Something like the patch below, which keeps the stdin test in t4002
working for me.

I suspect there are other problems lurking with the stdin case. For
example, we try to drop filespec contents whenever we can to reduce
memory pressure, under the assumption that we can always re-read the
blob later. But with stdin, we would need to be careful to mark the
contents as precious somehow.

diff --git a/diff-no-index.c b/diff-no-index.c
index f0b0010..c64bd5c 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -51,6 +51,21 @@ static int get_mode(const char *path, int *mode)
 	return 0;
 }
 
+static struct diff_filespec *noindex_filespec(const char *name, int mode)
+{
+	struct diff_filespec *r;
+
+	if (!name)
+		name = "/dev/null";
+	r = alloc_filespec(name);
+
+	fill_filespec(r, null_sha1, mode);
+	if (!strcmp(name, "-"))
+		r->is_stdin = 1;
+
+	return r;
+}
+
 static int queue_diff(struct diff_options *o,
 		      const char *name1, const char *name2)
 {
@@ -137,15 +152,8 @@ static int queue_diff(struct diff_options *o,
 			tmp_c = name1; name1 = name2; name2 = tmp_c;
 		}
 
-		if (!name1)
-			name1 = "/dev/null";
-		if (!name2)
-			name2 = "/dev/null";
-		d1 = alloc_filespec(name1);
-		d2 = alloc_filespec(name2);
-		fill_filespec(d1, null_sha1, mode1);
-		fill_filespec(d2, null_sha1, mode2);
-
+		d1 = noindex_filespec(name1, mode1);
+		d2 = noindex_filespec(name2, mode2);
 		diff_queue(&diff_queued_diff, d1, d2);
 		return 0;
 	}
diff --git a/diff.c b/diff.c
index 1a594df..449bfba 100644
--- a/diff.c
+++ b/diff.c
@@ -2675,6 +2675,9 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 	if (size_only && 0 < s->size)
 		return 0;
 
+	if (s->is_stdin)
+		return populate_from_stdin(s);
+
 	if (S_ISGITLINK(s->mode))
 		return diff_populate_gitlink(s, size_only);
 
@@ -2684,9 +2687,6 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		struct stat st;
 		int fd;
 
-		if (!strcmp(s->path, "-"))
-			return populate_from_stdin(s);
-
 		if (lstat(s->path, &st) < 0) {
 			if (errno == ENOENT) {
 			err_empty:
diff --git a/diffcore.h b/diffcore.h
index 8f32b82..be0739c 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -43,6 +43,7 @@ struct diff_filespec {
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
 	unsigned dirty_submodule : 2;  /* For submodules: its work tree is dirty */
+	unsigned is_stdin : 1;
 #define DIRTY_SUBMODULE_UNTRACKED 1
 #define DIRTY_SUBMODULE_MODIFIED  2
 	unsigned has_more_entries : 1; /* only appear in combined diff */
