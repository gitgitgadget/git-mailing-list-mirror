From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -u nonexistent-file
Date: Tue, 09 Feb 2010 13:58:16 -0800
Message-ID: <7v7hqm2hs7.fsf@alter.siamese.dyndns.org>
References: <20100208182929.GB14355@neumann>
 <a038bef51002081112s2d552835m4b34973f797ab4f8@mail.gmail.com>
 <20100209003958.GA4065@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:58:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ney6N-0002bs-GT
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 22:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659Ab0BIV6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 16:58:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0BIV63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 16:58:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50C9E98958;
	Tue,  9 Feb 2010 16:58:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=OMEhedpN383MWf3cGlqonm0Ft1g=; b=aMmelEGgwoBJrydqGJeL6rw
	FhNi9/0WkeeyFNj+QHRzPzXFnPtbyrfn7z7muD8FPv2keioi+4r6vypqUvTucwU7
	hfQTyunsmEWm20qVmk6aCxBB8kLx5AMpqB1N1y+nZKJTAQhQ1d5Y1KVYHqh4JMFB
	bwt1WGPN1Z8nAUl4JBxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TB1VozQ3+WRWuRoar2cklxFXyw0mPjHklblIEgqQ+5U5TwR80
	xXROlfcH95R+eKTNunV/ghbUDGSeSZnz1q5OJgVpr+AD+8W5JnEpYRwwFmvRGQtU
	utQggQm7t8fp8ubDjgjWxgjSQVVai7ryNq4b667SMSILmf0KxlE19UonqY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E1E398957;
	Tue,  9 Feb 2010 16:58:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0CEC98950; Tue,  9 Feb
 2010 16:58:17 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3DE161C2-15C6-11DF-918C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139446>

Jeff King <peff@peff.net> writes:

> It's not ignoring the extra parameters. They limit the scope of the
> operation. So:
>
>   $ git init
>   $ touch file && mkdir subdir && touch subdir/file
>   $ git add . && git commit -m one
>   $ echo changes >file && echo changes >subdir/file
>   $ git add -u subdir
>   $ git status
>   # On branch master
>   # Changes to be committed:
>   #       modified:   subdir/file
>   #
>   # Changed but not updated:
>   #       modified:   file
>   #
>
> That being said, you noticed that the regular add case notes unused
> pathspecs on the command line:
>
>   $ git add bogus
>   fatal: pathspec 'bogus' did not match any files
>
> We could probably do the same here.

It won't be entirely trivial to do so efficiently but it shouldn't be a
rocket surgery.

Something like this (untested of course)?

 builtin-add.c |   38 +++++++++++++++++++++++++++++---------
 1 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 2705f8d..87d2980 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -117,7 +117,19 @@ static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
 	}
 }
 
-static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
+static char *find_used_pathspec(const char **pathspec)
+{
+	char *seen;
+	int i;
+
+	for (i = 0; pathspec[i];  i++)
+		; /* just counting */
+	seen = xcalloc(i, 1);
+	fill_pathspec_matches(pathspec, seen, i);
+	return seen;
+}
+
+static char *prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
 	char *seen;
 	int i, specs;
@@ -137,13 +149,7 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 	}
 	dir->nr = dst - dir->entries;
 	fill_pathspec_matches(pathspec, seen, specs);
-
-	for (i = 0; i < specs; i++) {
-		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]))
-			die("pathspec '%s' did not match any files",
-					pathspec[i]);
-	}
-        free(seen);
+	return seen;
 }
 
 static void treat_gitlinks(const char **pathspec)
@@ -359,6 +365,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int flags;
 	int add_new_files;
 	int require_pathspec;
+	char *seen = NULL;
 
 	git_config(add_config, NULL);
 
@@ -418,7 +425,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		/* This picks up the paths that are not tracked */
 		baselen = fill_directory(&dir, pathspec);
 		if (pathspec)
-			prune_directory(&dir, pathspec, baselen);
+			seen = prune_directory(&dir, pathspec, baselen);
 	}
 
 	if (refresh_only) {
@@ -426,6 +433,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		goto finish;
 	}
 
+	if (pathspec) {
+		int i;
+		if (!seen)
+			seen = find_used_pathspec(pathspec);
+		for (i = 0; pathspec[i]; i++) {
+			if (!seen[i] && pathspec[i][0]
+			    && !file_exists(pathspec[i]))
+				die("pathspec '%s' did not match any files",
+				    pathspec[i]);
+		}
+		free(seen);
+	}
+
 	exit_status |= add_files_to_cache(prefix, pathspec, flags);
 
 	if (add_new_files)
