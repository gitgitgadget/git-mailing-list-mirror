From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] is_submodule_modified(): clear environment properly
Date: Tue, 23 Feb 2010 19:32:31 -0800
Message-ID: <7veikbjokw.fsf@alter.siamese.dyndns.org>
References: <4B844D07.8070406@web.de>
 <cb7bb73a1002231413n3a38e344hce8188671763c17b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 04:32:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk7zU-0004TV-O0
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 04:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051Ab0BXDco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 22:32:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab0BXDcn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 22:32:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BF849C670;
	Tue, 23 Feb 2010 22:32:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nOPN13nhsHnkxWJMaHnet17zS4Q=; b=q1CzMQ
	a+HVfDyYsdZmrIxEFKzbr6u+joj4YsFtUCW8qDhjLV1qQmFPEee4aTFvh0rwLbNS
	I+4eMS5vw0UhIjZalgjmEhNuCbFgacROIFZ0/q6AYw3D+RtLXmhyHXYdOyHJ2xV1
	wbUb/408tAuSOqYP0hEiaX/bCSLr4qjihlAzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mOjnd7fAhsZQIRQ5iV8VVDTuf/M4/t6s
	AUcIi2t/Cz23NR/fiDRREExolY1++/Y/dJJp1Owwu28CmMfNr35kNPlZYDwl705o
	XHlJ+4+srErd7y/U5KRG8aIrIGZ5H/ojw4mssku/6DTwKBRj5kdgebh4T0BfFbip
	Isqi3f/3+/M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 288E09C66C;
	Tue, 23 Feb 2010 22:32:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95CFA9C665; Tue, 23 Feb
 2010 22:32:34 -0500 (EST)
In-Reply-To: <cb7bb73a1002231413n3a38e344hce8188671763c17b@mail.gmail.com>
 (Giuseppe Bilotta's message of "Tue\, 23 Feb 2010 23\:13\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 420868EC-20F5-11DF-85B0-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140894>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Tue, Feb 23, 2010 at 10:47 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Only GIT_INDEX_FILE was cleared until now, but other environment variables
>> have to be cleared too before running git status in a submodule.
>>
> Of course this third use-case has a difference in that GIT_DIR is
> actually set to something else and not just cleared, but this
> particular case could just deep-copy the array modifying the
> appropriate entry.

Something like this, I guess.

It is a bit frustrating that local_repo_env[] is a NULL terminated array
and we cannot use ARRAY_SIZE(local_repo_env) as a compile-time constant.

 submodule.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7d70c4f..5bd70c4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -123,14 +123,14 @@ void show_submodule_summary(FILE *f, const char *path,
 
 int is_submodule_modified(const char *path)
 {
-	int len;
+	int len, i, dynbase;
 	struct child_process cp;
 	const char *argv[] = {
 		"status",
 		"--porcelain",
 		NULL,
 	};
-	char *env[4];
+	const char *env[20];
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_addf(&buf, "%s/.git/", path);
@@ -142,17 +142,21 @@ int is_submodule_modified(const char *path)
 	}
 	strbuf_reset(&buf);
 
+	for (i = 0; local_repo_env[i] && i < ARRAY_SIZE(env); i++)
+		env[i] = local_repo_env[i];
+	if (ARRAY_SIZE(env) <= i + 3)
+		die("Bug: recompile submodule.c with larger array size");
+	dynbase = i;
+
 	strbuf_addf(&buf, "GIT_WORK_TREE=%s", path);
-	env[0] = strbuf_detach(&buf, NULL);
+	env[i++] = strbuf_detach(&buf, NULL);
 	strbuf_addf(&buf, "GIT_DIR=%s/.git", path);
-	env[1] = strbuf_detach(&buf, NULL);
-	strbuf_addf(&buf, "GIT_INDEX_FILE");
-	env[2] = strbuf_detach(&buf, NULL);
-	env[3] = NULL;
+	env[i++] = strbuf_detach(&buf, NULL);
+	env[i++] = NULL;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
-	cp.env = (const char *const *)env;
+	cp.env = env;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
@@ -165,9 +169,9 @@ int is_submodule_modified(const char *path)
 	if (finish_command(&cp))
 		die("git status --porcelain failed");
 
-	free(env[0]);
-	free(env[1]);
-	free(env[2]);
+	for (i = dynbase; env[i]; i++)
+		free((char *)env[i]);
+
 	strbuf_release(&buf);
 	return len != 0;
 }
