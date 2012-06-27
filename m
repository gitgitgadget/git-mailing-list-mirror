From: Jeff King <peff@peff.net>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 15:52:05 -0400
Message-ID: <20120627195205.GA11700@sigill.intra.peff.net>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Lyubomirov <daniel@digitalus.bg>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 21:52:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjyHe-0006rN-PH
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 21:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679Ab2F0TwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 15:52:09 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:47177
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab2F0TwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 15:52:08 -0400
Received: (qmail 1955 invoked by uid 107); 27 Jun 2012 19:52:11 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jun 2012 15:52:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jun 2012 15:52:05 -0400
Content-Disposition: inline
In-Reply-To: <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200736>

On Wed, Jun 27, 2012 at 11:28:21AM -0700, Junio C Hamano wrote:

> Thanks for a report.  I think the "diff" callchain should be
> refactored so that the caller can mark the special "stdin" token in
> a saner way, but until it happens, the following one-liner should
> do.

Yeah, I assume this is there at all to support "diff --no-index -", so the
special marking should happen at that layer.

> diff --git a/diff.c b/diff.c
> index 1a594df..caa2309 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2589,6 +2589,14 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
>  	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1))
>  		return 0;
>  
> +	/*
> +	 * And asking to read "-" from the working tree triggers stdin
> +	 * input (which needs to be fixed separately by refactoring the
> +	 * callchain), forbid "reuse" for now.
> +	 */
> +	if (!strcmp(name, "-"))
> +		return 0;
> +

Unfortunately this is not enough. The problematic code path is the call
to populate_from_stdin in diff_populate_filespec. And we follow that
conditional if reuse_worktree_file is true, _or_ if the sha1_valid flag
on the filespec is not set. We hit the latter due to the --no-index
case, but we can also hit it if we are comparing a working tree file in
the repo that is stat-dirty.

So without your patch, this reads from stdin:

  git init repo &&
  cd repo &&
  echo foo >- &&
  git add - &&
  git commit -m foo

when the commit command tries to generate the diff summary. Your patch
fixes it, but remains broken if you then do:

  echo changes >>- &&
  git diff

I think you'd want to do just do something like:

diff --git a/diff.c b/diff.c
index 1a594df..aac72b7 100644
--- a/diff.c
+++ b/diff.c
@@ -2684,9 +2684,6 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		struct stat st;
 		int fd;
 
-		if (!strcmp(s->path, "-"))
-			return populate_from_stdin(s);
-
 		if (lstat(s->path, &st) < 0) {
 			if (errno == ENOENT) {
 			err_empty:

to temporarily fix it. That breaks

  echo content | git diff --no-index - some-file

but that code path should be fixed properly (with a use_stdin flag in
the filespec).

-Peff
