From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bundle: use a strbuf to scan the log for boundary
 commits
Date: Wed, 22 Feb 2012 19:38:13 -0800
Message-ID: <7vty2i5ie2.fsf@alter.siamese.dyndns.org>
References: <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch> <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 23 04:38:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0PVg-0000BI-2s
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 04:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab2BWDiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 22:38:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976Ab2BWDiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 22:38:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1B746547;
	Wed, 22 Feb 2012 22:38:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3WLyLs0BkT5cPNzRjXPn9uei0xs=; b=X7gC6S
	At4qRwDSGUWcLiPrOFTZsiQrZqENkduJt3qyNExz5biPrbhK2gZ8Qm/eEQkJpdOG
	PL48Ye4yvtf5VOzCnusRmA73UALqYqnJOMcunLbHgWUMHwKVN/5QD971joA5mufu
	62Or9q6EuchwwSXkcNaLg0fyhYP/lG4kt0Jmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AyzjpFsVmU/JH/A93Uc05KK+hIDLr2dY
	despokXvAV+Kg0VE1sZal1U6y0Rxue/CZOsP8l7wZLgLK3Zv/SWIDnZG3fD+14Cv
	JzwTKgfDt4uUAVvg5CuTTfs+qx3p1PRiu3ukwR90jabrV2hhYQOTTiF5eoi7XXoo
	jPFntAxUb5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B95D26546;
	Wed, 22 Feb 2012 22:38:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30D826545; Wed, 22 Feb 2012
 22:38:15 -0500 (EST)
In-Reply-To: <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed, 22 Feb 2012 20:34:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D17E2642-5DCF-11E1-B6CE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191326>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/bundle.c b/bundle.c
> index 313de42..0dbd174 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -234,7 +234,7 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
>  	const char **argv_pack = xmalloc(6 * sizeof(const char *));
>  	int i, ref_count = 0;
> -	char buffer[1024];
> +	struct strbuf buf = STRBUF_INIT;
>  	struct rev_info revs;
>  	struct child_process rls;
>  	FILE *rls_fout;
> @@ -266,16 +266,16 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	if (start_command(&rls))
>  		return -1;
>  	rls_fout = xfdopen(rls.out, "r");
> -	while (fgets(buffer, sizeof(buffer), rls_fout)) {
> +	while (strbuf_getwholeline(&buf, rls_fout, '\n') != EOF) {

I'd add strbuf_release(&buf) after this loop.

Perhaps we would want to squash something like this to the test to avoid
"seq", using J6t's idea.  The issue is that we do not write the end of
line for the long boundary (because it is hidden from us), keep reading
and rejecting bogus letters, and then the tip is written without
terminating the boundary line.  So checking boundary line is not a very
useful test, but "fetch" and "list-heads" are.

 t/t5704-bundle.sh |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index 7c2f307..5319b84 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -59,19 +59,20 @@ test_expect_success 'empty bundle file is rejected' '
 
 '
 
-# If "ridiculous" is at least 1004 chars, this traps a bug in old
-# versions where the resulting 1025-char line (with --pretty=oneline)
-# was longer than a 1024-char buffer
+# This triggers a bug in older versions where the resulting line (with
+# --pretty=oneline) was longer than a 1024-char buffer.
 test_expect_success 'ridiculously long subject in boundary' '
 
-	: > file4 &&
+	: >file4 &&
 	test_tick &&
 	git add file4 &&
-	printf "abcdefghijkl %s\n" $(seq 1 100) | git commit -F - &&
+	printf "%0982d\n" 0 | git commit -F - &&
 	test_commit fifth &&
 	git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
+	git bundle list-heads long-subject-bundle.bdl >heads &&
+	test -s heads &&
 	git fetch long-subject-bundle.bdl &&
-	sed -n "/^-/{p;q}" long-subject-bundle.bdl > boundary &&
+	sed -n "/^-/{p;q}" long-subject-bundle.bdl >boundary &&
 	grep "^-$_x40 " boundary
 
 '
-- 
1.7.9.2.258.g4407a
