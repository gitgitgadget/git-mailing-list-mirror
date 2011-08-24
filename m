From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: clean error message for --continue after
 failed exec
Date: Wed, 24 Aug 2011 11:54:50 -0700
Message-ID: <7vy5yiod1h.fsf@alter.siamese.dyndns.org>
References: <vpqk4a3rkwb.fsf@bauges.imag.fr>
 <1314194508-12067-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v62lmps6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 24 20:54:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwIbK-0002gh-Tq
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 20:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab1HXSyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 14:54:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753492Ab1HXSyw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 14:54:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47A114E0E;
	Wed, 24 Aug 2011 14:54:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DJeLk4q/BSwATLfDBjTo08r1AaY=; b=HA3leT
	usD+meCzjBwjDDC3OHeoj9gRRmqHpsyveK4JcjPWL71jgDlCumTaRHMUcAnJEeRx
	qY11qFD012YFNCfdEaN4HmvYJtWxikk3QALhMYjYPx+D0B+WLz5GZDPBwXY52vU5
	VK9Q0coUnOjjc4amxiwPzP227JFjQNN8wH2C0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=etZc05+JUMAjEiDfpxV7yxz8LzvI5LJ+
	h82DXqrwOO4v+yMfaFmqk1uHIR+0ieCipFZFhsBWdu3SNvs1WkwjCKzMgugtES2s
	9KFOkqfwOfOyXrkN0FrasoVZg+QHw4ciID7O5ynRb439cXq75RNxH3UM1sDMm0JI
	moMNjz291gI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4062B4E0D;
	Wed, 24 Aug 2011 14:54:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C28AC4E0C; Wed, 24 Aug 2011
 14:54:51 -0400 (EDT)
In-Reply-To: <7v62lmps6k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 24 Aug 2011 11:42:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C6BF3EA-CE82-11E0-A700-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180026>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> If after a failed "exec" instruction there are staged changes,...
>
> I have to wonder why whatever "exec" runs is mucking with the index in the
> first place. Shouldn't we forbid it?

I suspect your patch amounts to the same thing of forbidding, but
detecting the lack of $author_script feels like it is covering up the
symptom and not directly going for the cause of the symptom.

I wonder if doing something like this would be more direct approach to
achieve the same thing.

 git-rebase--interactive.sh |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c6ba7c1..31026dc 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -472,24 +472,31 @@ do_next () {
 		git rev-parse --verify HEAD > "$state_dir"/stopped-sha
 		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
 		status=$?
+		# Run in subshell because require_clean_work_tree can die.
+		dirty=f
+		(require_clean_work_tree "rebase") || dirty=t
 		if test "$status" -ne 0
 		then
 			warn "Execution failed: $rest"
+			test "$dirty" = f ||
+			warn "and made changes to the index and/or the working tree"
+
 			warn "You can fix the problem, and then run"
 			warn
 			warn "	git rebase --continue"
 			warn
 			exit "$status"
 		fi
-		# Run in subshell because require_clean_work_tree can die.
-		if ! (require_clean_work_tree "rebase")
-		then
+		if test "$dirty" = t
+			warn "Execution succeeded: $rest"
+			warn "but left changes to the index and/or the working tree"
 			warn "Commit or stash your changes, and then run"
 			warn
 			warn "	git rebase --continue"
 			warn
 			exit 1
 		fi
+
 		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
