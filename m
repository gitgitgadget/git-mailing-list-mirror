From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] mergetool/difftool cleanup
Date: Fri, 21 Nov 2014 11:28:03 -0800
Message-ID: <xmqqmw7kz73w.fsf@gitster.dls.corp.google.com>
References: <1416532829-68662-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 20:28:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrtsK-0004WF-69
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 20:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbaKUT2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 14:28:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750856AbaKUT2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 14:28:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 62CDF20F0F;
	Fri, 21 Nov 2014 14:28:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LUo7bakNLwlMEpyiuWQSWxcQ48s=; b=PMoI0k
	HFiNqv37Lr0hAtKKRqeriexVRZwb1wsZZj9WE8yBuMZxa+GeqQGy/XHHfihP5tSH
	X/B1HQKBTUDOqPW7z1kyU1KncKgapmIisG+TpFzPQAg4EBRaoeEmodqzchcgWJb9
	tWKzd48CRZaxYExxm5HRePMoou8x+Nw88c0vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GAXFkdh6FM/IFeXQgwAlNhoE6rsnYKOs
	7TKzGdCKYrXIRq7GtSP+SMbRt/QmI/fvrOzXE2/lvGVFRM1Yb/ZJtxkxRI4KyvEm
	O13lQ0qV/0g2o1SpAOakLTGrQ4uT+29s6EDFMXyUwI5v3ExUlqR3hRaTDJnPYjCH
	etrxethkQFs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A06F20F0E;
	Fri, 21 Nov 2014 14:28:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC40F20F0A;
	Fri, 21 Nov 2014 14:28:04 -0500 (EST)
In-Reply-To: <1416532829-68662-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Thu, 20 Nov 2014 17:20:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 83D56CD8-71B4-11E4-A783-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> This is a cleanup series to remove the use of the $status
> global variable in mergetool/difftool.
>
> This should wait until after the current RC series is
> over but figured I'd send it out.
>
> David Aguilar (3):
>   mergetool--lib: remove use of $status global
>   difftool--helper: add explicit exit statement
>   mergetool: simplify conditionals
>
>  git-difftool--helper.sh |  2 ++
>  git-mergetool--lib.sh   | 20 +++++---------------
>  git-mergetool.sh        | 16 +++++-----------
>  3 files changed, 12 insertions(+), 26 deletions(-)

Looked quite straight-forward from a cursory read.

I tentatively inserted the attached patch before 1/3.  If the series
was done with that extra step as preliminary clean-up, I wouldn't
have had to wonder if the hunk at "@@ -130,13" was correct.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 21 Nov 2014 11:17:57 -0800
Subject: [PATCH] mergetool--lib: remove no-op assignment to $status from setup_user_tool

Even though setup_user_tool assigns the exit status from "eval
$merge_tool_cmd" to $status, the variable is overwritten by the
function it calls next, check_unchanged, without ever getting looked
at by anybody.  And "return $status" at the end of this function
returns the value check_unchanged assigned to it (which is the same
as the value the function returns).  Which makes the assignment a
no-op.

Remove it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-mergetool--lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 2b66351..3e06389 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -130,7 +130,6 @@ setup_user_tool () {
 		then
 			touch "$BACKUP"
 			( eval $merge_tool_cmd )
-			status=$?
 			check_unchanged
 		else
 			( eval $merge_tool_cmd )
-- 
2.2.0-rc2-128-ge2b5e8e
