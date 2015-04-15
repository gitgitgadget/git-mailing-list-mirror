From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: plug small leak of commit buffer
Date: Wed, 15 Apr 2015 14:30:17 -0700
Message-ID: <xmqqa8y9jd06.fsf@gitster.dls.corp.google.com>
References: <xmqqegnljd80.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 23:30:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiUt8-0003xk-2a
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 23:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbbDOVaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 17:30:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752159AbbDOVaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 17:30:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4140348E52;
	Wed, 15 Apr 2015 17:30:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q4T56CDthbcOzbpT0cjjwYUloy0=; b=kRcqGX
	QB+G49FXmnIKqyYTNcrnqkRCxJGwRnYgAgRvKSrOKaKw2NsN3KZXEeoQi9wP0/rF
	3AbyBxdYnkoHO3r+sBkwOxxDtmmr6xqHj/d1kDlx98NRWMIYIuU6vazt7g5IKQoy
	wJcZQmZf5OvGSgvo5TKXBpiTp+UdhlWNjS9Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sxWJ3CnlNTJHON2eW7KCKgRrgMbRQ8/X
	ezYzB/FLEX7hz9cPEQblG7NaG7N8okYQrJx5bwYnMdv/QFv/1QdqSURN2f0An7EX
	1pDCYxylFHIisSIq4+iFok05fHbwxYOHOaFH9bEOAQ4AAIuEIJjuOISd9e7EuAFV
	oQSP7hd3wMs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A35F48E51;
	Wed, 15 Apr 2015 17:30:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A92F948E4D;
	Wed, 15 Apr 2015 17:30:18 -0400 (EDT)
In-Reply-To: <xmqqegnljd80.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 15 Apr 2015 14:25:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D174940-E3B6-11E4-ABC0-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267241>

Junio C Hamano <gitster@pobox.com> writes:

> A broken or badly formatted commit might not record author or
> committer lines; the function record_person() returned after
> calling get_commit_buffer() without calling unuse_commit_buffer()
> on the memory, potentially leaking it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * to be applied on bc6b8fc1 (use get_commit_buffer everywhere,
>    2014-06-10)

I spoke too soon.  There are two error-exit paths in this function.

-- >8 --
A broken or badly formatted commit might not record author or
committer lines or we may not find a valid name on them.  The
function record_person() returned after calling get_commit_buffer()
without calling unuse_commit_buffer() on the memory it obtained in
such cases, potentially leaking it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fmt-merge-msg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 01f6d59..76277d1 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -239,7 +239,7 @@ static void record_person(int which, struct string_list *people,
 	buffer = get_commit_buffer(commit);
 	name = strstr(buffer, field);
 	if (!name)
-		return;
+		goto leave;
 	name += strlen(field);
 	name_end = strchrnul(name, '<');
 	if (*name_end)
@@ -247,9 +247,8 @@ static void record_person(int which, struct string_list *people,
 	while (isspace(*name_end) && name <= name_end)
 		name_end--;
 	if (name_end < name)
-		return;
+		goto leave;
 	name_buf = xmemdupz(name, name_end - name + 1);
-	unuse_commit_buffer(commit, buffer);
 
 	elem = string_list_lookup(people, name_buf);
 	if (!elem) {
@@ -258,6 +257,8 @@ static void record_person(int which, struct string_list *people,
 	}
 	elem->util = (void*)(util_as_integral(elem) + 1);
 	free(name_buf);
+leave:
+	unuse_commit_buffer(commit, buffer);
 }
 
 static int cmp_string_list_util_as_integral(const void *a_, const void *b_)
-- 
2.4.0-rc2-173-gefc434b
