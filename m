From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule--helper, module_clone: always operate on absolute paths
Date: Fri, 01 Apr 2016 12:30:20 -0700
Message-ID: <xmqq37r5i0tv.fsf@gitster.mtv.corp.google.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
	<1459469849-9643-2-git-send-email-sbeller@google.com>
	<xmqq7fghi1ds.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	jacob.keller@gmail.com, norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:30:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am4m4-0000hw-OI
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 21:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbcDATaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 15:30:24 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751364AbcDATaX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 15:30:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7598C4FBD1;
	Fri,  1 Apr 2016 15:30:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GxOqKg5dPDALcdeOxDtP0r+B6yc=; b=Xk+Hg1
	j4KYm6HyA6GF4i4936BUnpKoFu2FA3601NnynaEWAcQoHXQJxLDoCXzM/PZkZDa9
	5XjgCSetU3Q4J43kV72JmyRfIfxb/0OuBXwGZCQF3Ov8GrfgYflbdoZbFeUocik4
	3zCtA4eBvCeTE5gc8rEyjRm6oEVrrLqEUsylI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rpvZwkKiZ4zyjruKElM6b5TWFzj/AwVl
	K9UyXXA+Y4ZzMM+3tF1+PDCuHx3WYP213UsktLJHZAUfALzlmJEphBjprUlYeVLF
	t6HWeMBbBvxKZGPXBnNDhlI0tp1Aqmnxa+jsCq2tSLtRsWUTZHI3Ca+G79jVrtAU
	++Zc/qLKqNc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6A1CE4FBD0;
	Fri,  1 Apr 2016 15:30:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D75064FBCE;
	Fri,  1 Apr 2016 15:30:21 -0400 (EDT)
In-Reply-To: <xmqq7fghi1ds.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 01 Apr 2016 12:18:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2CDD5918-F840-11E5-A190-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290576>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, this line is the last use of sm_gitdir_rel before it
> gets freed.  I wonder
>
> 	sm_gitdir = absolute_path(sb.buf);
>
> would be sufficient.  We can lose the variable, and free() on it at
> the end of this function, and an extra allocation if we can do so.
>
>> +	if (!is_absolute_path(path)) {
>> +		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), path);
>> +		path = strbuf_detach(&sb, 0);
>> +	} else
>> +		path = xstrdup(path);
>>  
>>  	if (!file_exists(sm_gitdir)) {
>>  		if (safe_create_leading_directories_const(sm_gitdir) < 0)
>
> Other than that, looks good to me.

Another thing I noticed is that it will not stay safe forever to
borrow the result from absolute_path() for extended period of time.
So how about this one (and Ramsay's "NULL must be spelled NULL, not
0") on top?

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 1 Apr 2016 12:23:16 -0700
Subject: [PATCH] submodule--helper: do not borrow absolute_path() result for too long

absolute_path() is designed to allow its callers to take a brief
peek of the result (typically, to be fed to functions like
strbuf_add() and relative_path() as a parameter) without having to
worry about freeing it, but the other side of the coin of that
memory model is that the caller shouldn't rely too much on the
result living forever--there may be a helper function the caller
subsequently calls that makes its own call to absolute_path(),
invalidating the earlier result.

Use xstrdup() to make our own copy, and free(3) it when we are done.
While at it, remove an unnecessary sm_gitdir_rel variable that was
only used to as a parameter to call absolute_paht() and never used
again.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b660a22..e69b340 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -157,8 +157,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *reference = NULL, *depth = NULL;
 	int quiet = 0;
 	FILE *submodule_dot_git;
-	char *sm_gitdir_rel, *p, *path = NULL;
-	const char *sm_gitdir;
+	char *p, *path = NULL, *sm_gitdir;
 	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 
@@ -199,8 +198,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		die(_("submodule--helper: unspecified or empty --path"));
 
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
-	sm_gitdir_rel = strbuf_detach(&sb, NULL);
-	sm_gitdir = absolute_path(sm_gitdir_rel);
+	sm_gitdir = xstrdup(absolute_path(sb.buf));
 
 	if (!is_absolute_path(path)) {
 		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), path);
@@ -245,7 +243,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 			       relative_path(path, sm_gitdir, &rel_path));
 	strbuf_release(&sb);
 	strbuf_release(&rel_path);
-	free(sm_gitdir_rel);
+	free(sm_gitdir);
 	free(path);
 	free(p);
 	return 0;
-- 
2.8.0-225-g297c00e
