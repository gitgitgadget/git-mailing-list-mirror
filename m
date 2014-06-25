From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] setup_git_env: use git_pathdup instead of xmalloc + sprintf
Date: Wed, 25 Jun 2014 10:20:13 -0700
Message-ID: <xmqqmwd0aotu.fsf@gitster.dls.corp.google.com>
References: <20140619211659.GA32412@sigill.intra.peff.net>
	<20140619212800.GF28474@sigill.intra.peff.net>
	<CACsJy8B-zQUH++U_RKq16_M+6FF5bmHXA100xM3uO42TUj3kJg@mail.gmail.com>
	<20140624205815.GA28724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 19:20:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzqs3-0002iE-Jo
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 19:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757828AbaFYRU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 13:20:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51745 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757564AbaFYRU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 13:20:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1725A2002F;
	Wed, 25 Jun 2014 13:20:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yGhnUEOmC/Jcw0s07RhYzCijeuw=; b=bORruh
	MjYy+PCfH+TshJKl1UFPcpOeFSCH6JFUeD94nY/g4wz4aS/O6/Lv8jVh/KYdtAEc
	EZaJGBhGgNkPwuwlHfKc4TV/wpusUiIbGw3fKr7Dy/JsezaVt40YGkB+K+Jx2oCi
	pVbzIB22Xlsdtl8sM2QXoZKmujBDnehYAwwDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OGAelmoZ58Rf3mSskxGOOexpN8n/VwCP
	4hNvVrgZH40Lb4bX3LATI0OhAFohNeBHrjokb3q5w+lCZS1qM/pj+yHCY12s/A39
	TN7Erg4mRcwR2FdYMPFGaYkhVlhG6H+7kELq8Qp0FqGaiwNMmrubGDoK1lmAZIHL
	AVNAWg5s++E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CCBD2002E;
	Wed, 25 Jun 2014 13:20:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3388220027;
	Wed, 25 Jun 2014 13:20:09 -0400 (EDT)
In-Reply-To: <20140624205815.GA28724@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 24 Jun 2014 16:58:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F54B519A-FC8C-11E3-AC26-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252449>

Jeff King <peff@peff.net> writes:

> Here's a replacement patch that handles this (and just drops the ugly
> mallocs as a side effect).
>
> -- >8 --
> Subject: [PATCH] setup_git_env: copy getenv return value
>
> The return value of getenv is not guaranteed to survive
> across further invocations of setenv or even getenv. When we
> are assigning it to globals that last the lifetime of the
> program, we should make our own copy.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Sigh. This mail unfortunately crossed with 64f25581 (Merge branch 'jk/xstrfmt'
into next, 2014-06-23) with about 20 hours of lag.

I'd make it relative like the attached on top of the series.  Note
that I tweaked the args to git_pathdup() to avoid the "are you sure
you want to give a variable format string to git_pathdup() which you
said is like printf(3)?" warning from the compiler.

Thanks.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Tue, 24 Jun 2014 16:58:15 -0400
Subject: [PATCH] setup_git_env(): introduce git_path_from_env() helper

"Check the value of an environment and fall back to a known path
inside $GIT_DIR" is repeated a few times to determine the location
of the data store, the index and the graft file, but the return
value of getenv is not guaranteed to survive across further
invocations of setenv or even getenv.

Make sure to xstrdup() the value we receive from getenv(3), and
encapsulate the pattern into a helper function.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 environment.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/environment.c b/environment.c
index 4de7b81..565f652 100644
--- a/environment.c
+++ b/environment.c
@@ -124,6 +124,12 @@ static char *expand_namespace(const char *raw_namespace)
 	return strbuf_detach(&buf, NULL);
 }
 
+static char *git_path_from_env(const char *envvar, const char *path)
+{
+	const char *value = getenv(envvar);
+	return value ? xstrdup(value) : git_pathdup("%s", path);
+}
+
 static void setup_git_env(void)
 {
 	const char *gitfile;
@@ -134,15 +140,9 @@ static void setup_git_env(void)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 	gitfile = read_gitfile(git_dir);
 	git_dir = xstrdup(gitfile ? gitfile : git_dir);
-	git_object_dir = getenv(DB_ENVIRONMENT);
-	if (!git_object_dir)
-		git_object_dir = git_pathdup("objects");
-	git_index_file = getenv(INDEX_ENVIRONMENT);
-	if (!git_index_file)
-		git_index_file = git_pathdup("index");
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
2.0.0-641-g934bf98
