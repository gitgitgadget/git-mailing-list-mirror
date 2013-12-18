From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] prune_object_dir(): verify that path fits in the temporary buffer
Date: Wed, 18 Dec 2013 12:15:19 -0800
Message-ID: <xmqqppothq5k.fsf@gitster.dls.corp.google.com>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
	<1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
	<xmqq8uvjmhu5.fsf@gitster.dls.corp.google.com>
	<20131217232231.GA14807@sigill.intra.peff.net>
	<xmqqa9fyhrzt.fsf@gitster.dls.corp.google.com>
	<20131218200043.GA10244@sigill.intra.peff.net>
	<xmqqwqj1hqjd.fsf@gitster.dls.corp.google.com>
	<20131218201101.GA10507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 21:15:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtNWk-0007NK-39
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 21:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab3LRUP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 15:15:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35878 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126Ab3LRUPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 15:15:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69EA55AA8C;
	Wed, 18 Dec 2013 15:15:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=twLRkF8bVrutOhnGdErXnoj5+u4=; b=raBZ+2
	UcarQFZaGDL25UROzEUtciT+XC2HM7O76Lk5MifhIK+dbIqcgAjTZXnyvxS5t1jJ
	T+H/cn144MiiRoAHPncCQPJIzdOf+LzLLLg1fU+0LL6mPnBFwnyAWGKKTQkez3ig
	UqUTE9z1lAjDnfoaElAPWJtM+ZAIMRMykdrPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UKKI+4WJO7xbVCtzarovMQREoXFy1UK+
	88ok4v6xUPcGShvPKYRnQiNC9yrdpHk/0JPSzLhjuYoHw1YGrGbYeap2i6bFsxdx
	xo9t3JCae10g0TZA2ltTUzMJT7tzayY+NrLc6sjDk5+Hfk7I/iXN73NMi92Yf7bd
	uzAiCUBfXXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5324D5AA8B;
	Wed, 18 Dec 2013 15:15:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BE925AA87;
	Wed, 18 Dec 2013 15:15:23 -0500 (EST)
In-Reply-To: <20131218201101.GA10507@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Dec 2013 15:11:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 201D357E-6821-11E3-A388-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239480>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 18, 2013 at 12:07:02PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> > +			prune_object(path->buf, sha1);
>> >> > +			path->len = baselen;
>> >> 
>> >> This is minor, but I prefer using strbuf_setlen() for this.
>> >
>> > Good catch. I do not think it is minor at all; my version is buggy.
>> > After the loop ends, path->len does not match the NUL in path->buf. That
>> > is OK if the next caller is strbuf-aware, but if it were to pass
>> > path->buf straight to a system call, that would be rather...confusing.
>> 
>> Hmph, rmdir(path->buf) at the end of prune_dir() may have that exact
>> issue.
>> 
>> Will squash in the following.
>
> Thanks. Are you picking this up with a commit message, or did you want
> me to re-send with the usual message/signoff?

I think this should be sufficient ;-)

-- >8 --
From: Jeff King <peff@peff.net>
Date: Tue, 17 Dec 2013 18:22:31 -0500
Subject: [PATCH] builtin/prune.c: use strbuf to avoid having to worry about PATH_MAX

While at it, rename prune_tmp_object(), which used to be a helper to
remove temporary files that were created to become loose object
files, to prune_tmp_file(), as the function is also used to remove
any random cruft whose name begins with tmp_ directly in .git/object
or .git/object/pack directories these days.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/prune.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 6366917..99f3f35 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -17,9 +17,8 @@ static int verbose;
 static unsigned long expire;
 static int show_progress = -1;
 
-static int prune_tmp_object(const char *path, const char *filename)
+static int prune_tmp_file(const char *fullpath)
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
+			strbuf_setlen(&path, baselen);
 			continue;
 		}
 		if (!prefixcmp(de->d_name, "tmp_obj_")) {
-			prune_tmp_object(path, de->d_name);
+			strbuf_addf(path, "/%s", de->d_name);
+			prune_tmp_file(path->buf);
+			strbuf_setlen(&path, baselen);
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
+		strbuf_setlen(&buf, baselen);
 	}
 }
 
@@ -120,7 +130,7 @@ static void remove_temporary_files(const char *path)
 	}
 	while ((de = readdir(dir)) != NULL)
 		if (!prefixcmp(de->d_name, "tmp_"))
-			prune_tmp_object(path, de->d_name);
+			prune_tmp_file(mkpath("%s/%s", path, de->d_name));
 	closedir(dir);
 }
 
-- 
1.8.5.2-297-g3e57c29
