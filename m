From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Also read SQUASH_MSG if a conflict on a merge squash occurred
Date: Wed, 09 Mar 2016 12:24:44 -0800
Message-ID: <xmqqziu7h01f.fsf@gitster.mtv.corp.google.com>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
	<xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
	<xmqqfuvzil3y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 21:24:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adkf7-0007WV-2U
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 21:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbcCIUYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 15:24:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752164AbcCIUYr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 15:24:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 431404C6A0;
	Wed,  9 Mar 2016 15:24:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iJdPsfunyfzbiNzw3MTs2xdlsxs=; b=e5JWMa
	kzZv/rjU5gFIi/Jhoo+t2v8XZQhhmzXO3KHqT/jD0vur7liJuchJnznrj4ifHsFS
	r+0yPJRW9F9EM7s15jZRmJHDNxzemIzVBtIjEdXA950NGigber20gQuaQNyew11Q
	BrctFCXqLyaAL3hHPIEn4fJszElBHkrhLZKbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kRe8h3XTmcv3RUEd01Oavr35tN3cEzrs
	EzAZJI+gzjPRiwA/dNQgzOkCjnxnJo0l4UU5pB5Tz16t5eIKnFL8+5OcwPBMjFbS
	puKSRqSidLLuIjj2nHzjUvMIpZMpz372yFJPeNMTx6Efb69VNzXIZ9GXum7/9kcP
	ZeCS6gSNw/M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AC534C69F;
	Wed,  9 Mar 2016 15:24:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AABBC4C69E;
	Wed,  9 Mar 2016 15:24:45 -0500 (EST)
In-Reply-To: <xmqqfuvzil3y.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 09 Mar 2016 10:04:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6C0000A-E634-11E5-8347-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288571>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The duplicated code to read the same file bothers me somewhat.
>>
>> I wondered if it makes the result easier to follow (and easier to
>> update) if this part of the code is restructured like this:
>>
>> 	if (file_exists(git_path_merge_msg()) ||
>>             file_exists(git_path_squash_msg())) {
>> 	    if (file_exists(git_path_squash_msg())) {
>> 		read SQUASH_MSG;
>> 	    }
>>             if (file_exists(git_path_merge_msg()))
>>             	read MERGE_MSG;
>> 	    }
>>             hook_arg1 = "merge";
>> 	}
>>
>> but I am not sure if that structure is better.
>
> ... as this duplicates file_exists() call to the same thing, which
> is no better than duplicated calls to read *_MSG files.

So, let's take the program structure from your original, but fix the
order of the inclusion (and the log message), perhaps like the
attached patch.

Don't we also want to have a new test so that this "contents from
both files are included in the result in the expected order" feature
will not get broken in the future?

-- >8 --
Subject: [PATCH] commit: do not lose SQUASH_MSG contents

When concluding a conflicted "git merge --squash", the command
failed to read SQUASH_MSG that was prepared by "git merge", and
showed only the "# Conflicts:" list of conflicted paths.

Place the contents from SQUASH_MSG at the beginning, just like we
show the commit log skeleton first when concluding a normal merge,
and then show the "# Conflicts:" list, to help the user write the
log message for the resulting commit.

Signed-off-by: Sven Strickroth <sven@cs-ware.de>
---

 builtin/commit.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b3bd2d4..4ad3931 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -726,9 +726,19 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				      &sb, &ctx);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(), &statbuf)) {
+		hook_arg1 = "merge";
+
+		/*
+		 * In a conflicted 'merge squash', the material to help
+		 * writing the log message is found in SQUASH_MSG.
+		 */
+		if (!stat(git_path_squash_msg(), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
+				die_errno(_("could not read SQUASH_MSG"));
+			hook_arg1 = "squash";
+		}
 		if (strbuf_read_file(&sb, git_path_merge_msg(), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
-		hook_arg1 = "merge";
 	} else if (!stat(git_path_squash_msg(), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
-- 
2.8.0-rc1-141-gbaa22e3
