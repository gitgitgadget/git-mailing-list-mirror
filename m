From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Copy resolve_ref() return value for longer use
Date: Sat, 12 Nov 2011 23:59:18 -0800
Message-ID: <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
References: <CACsJy8Aw4_O_GMiK_D=HTENfxGUXTTzCHqM7FkriqU+mQtVWtA@mail.gmail.com>
 <1320719428-1802-1-git-send-email-pclouds@gmail.com>
 <7vehxcpns5.fsf@alter.siamese.dyndns.org>
 <CACsJy8ARAzNWjZfXwnNG0AprCFXLCkiDrE+eFj9icbeNX14xKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tony Wang <wwwjfy@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 08:59:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPUyM-0005fI-Iv
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 08:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab1KMH7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 02:59:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab1KMH7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 02:59:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5976F2FF4;
	Sun, 13 Nov 2011 02:59:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UQDJxPA4BYGhzKWxubD10JiQFFE=; b=gerJFC
	nSecIHU5kSnS/TiSI1fG4xvCFCvVAqga1dZkRPtCwL1IRU84kR7d2RPZw5C4EjXJ
	AxEzU0ZDZISvpDipUWGzo3NGhL3irhS5XMUSDWyRbPAXi0Jt+sYIni0KTJRjjHao
	Gv8q2TmVKXgXwG91EYRqI95xG6r7bhwMItfO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=djb25qKO/qsQI2Ehsi7jwlhVgr171bHz
	/Yf6Wl9LyMZDT1ZQHJbBLh7fhhxPzbbfgqv6jYsmG140iXBiFtckpcDY8oGI9yC3
	A4pSzLM6p+xYRV0yF4fluFO/t3StW+EUqFNK/FJ4nI5PCiDAZU4QGg4xcRVnrSvX
	2P/cScQROi0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F8512FF3;
	Sun, 13 Nov 2011 02:59:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A5132FF2; Sun, 13 Nov 2011
 02:59:19 -0500 (EST)
In-Reply-To: <CACsJy8ARAzNWjZfXwnNG0AprCFXLCkiDrE+eFj9icbeNX14xKw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 13 Nov 2011 14:09:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6415B432-0DCD-11E1-A0D2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185324>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I went through all of them. Most of them only checks if return value
> is NULL, or does one-time string comparison. Others do xstrdup() to
> save the return value. Will update the patch message to reflect this.

Thanks. Given your analysis, I think the potential change I alluded to to
return allocated memory from the function is probably overkill in the
current state of the code.

But as the codepaths around the existing callsites evolve, some of these
call sites that are not problematic in today's code can become problematic
if we are not careful. I was primarily wondering if an updated API could
force us to be careful when making future changes.

And a change along the lines of your suggestion

> ... Though if you don't mind a bigger patch, we could turn
>
> const char *resolve_ref(const char *path, const char *sha1, int
> reading, int *flag);
>
> to
>
> int resolve_ref(const char *path, const char *sha1, int reading, int
> *flag, char **ref);
>
> where *ref is the current return value and is only allocated by
> resolve_ref() if ref != NULL.

might be one such updated API that makes mistakes harder to make. I dunno.

But if we were to go that route, as the first step, it might make sense to
rewrite "only checks if it returns NULL and uses sha1" callers to call
either read_ref() or ref_exists(), so that we do not have to worry about
leaking at such callers when we later decide to return allocated memory
from resolve_ref().


 builtin/branch.c |    3 +--
 builtin/merge.c  |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 51ca6a0..94948a4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -565,7 +565,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 static void rename_branch(const char *oldname, const char *newname, int force)
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
-	unsigned char sha1[20];
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	int recovery = 0;
 
@@ -577,7 +576,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 		 * Bad name --- this could be an attempt to rename a
 		 * ref that we used to allow to be created by accident.
 		 */
-		if (resolve_ref(oldref.buf, sha1, 1, NULL))
+		if (ref_exists(oldref.buf))
 			recovery = 1;
 		else
 			die(_("Invalid branch name: '%s'"), oldname);
diff --git a/builtin/merge.c b/builtin/merge.c
index dffd5ec..42b4f9e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -420,7 +420,7 @@ static struct object *want_commit(const char *name)
 static void merge_name(const char *remote, struct strbuf *msg)
 {
 	struct object *remote_head;
-	unsigned char branch_head[20], buf_sha[20];
+	unsigned char branch_head[20];
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf bname = STRBUF_INIT;
 	const char *ptr;
@@ -479,7 +479,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		strbuf_addstr(&truname, "refs/heads/");
 		strbuf_addstr(&truname, remote);
 		strbuf_setlen(&truname, truname.len - len);
-		if (resolve_ref(truname.buf, buf_sha, 1, NULL)) {
+		if (ref_exists(truname.buf)) {
 			strbuf_addf(msg,
 				    "%s\t\tbranch '%s'%s of .\n",
 				    sha1_to_hex(remote_head->sha1),
