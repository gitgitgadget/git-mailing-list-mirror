From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase --preserve-merges keeps empty merge commits
Date: Mon, 14 Jan 2013 09:15:33 -0800
Message-ID: <7vwqvfele2.fsf@alter.siamese.dyndns.org>
References: <1358023561-26773-1-git-send-email-hordp@cisco.com>
 <vpqpq17zwdl.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org,
	phil.hord@gmail.com, Neil Horman <nhorman@tuxdriver.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 14 18:15:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tundd-0001oE-F8
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 18:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519Ab3ANRPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 12:15:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33334 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073Ab3ANRPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 12:15:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A705A9A4;
	Mon, 14 Jan 2013 12:15:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eumVx+BDHnwy2/xjpfwNJsnJOiY=; b=ueDG4K
	qLNOlTkmJkJE1k1WcwVPO613ZOfo/Dh0wbxRVJpkxFcdEuNtzj4SYnGpKHlbHzF+
	MMxZEgrC/4yGsxiljDzMSQBQKAzHhDz30cE3dJlE6gd//8NhpOhFON7pwADBhxx2
	7V7SmR4zKwsvsq+DQnkQrGuanAh+11smY+SYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iHx778rJnIjufV19XMSp+mMDnKzP2N08
	AmIIUYNTm3CPdVk6OOdpkiPD0Onq/GHzNYxuwEgGJAI0lu1BN04IMkzwIBhVfpZT
	lqUVKzklllfoDPpYEk7uUApOWt8STtZ/kB01wNWGPh6Wkx44zFiL18NFfNV5T9YE
	cfzTVlNa60g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F3CDA9A3;
	Mon, 14 Jan 2013 12:15:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0F57A9A0; Mon, 14 Jan 2013
 12:15:34 -0500 (EST)
In-Reply-To: <vpqpq17zwdl.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 14 Jan 2013 15:12:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0207710C-5E6E-11E2-9CE1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213502>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Phil Hord <hordp@cisco.com> writes:
>
>> Subject: [PATCH] rebase --preserve-merges keeps empty merge commits
>
> I would rephrase it as
>
>   rebase --preserve-merges: keep empty merge commits
>
> we usually give orders in commit messages, not state facts (it's not
> clear from the existing subject line whether keeping merge commit is the
> new behavior or a bug that the commit tries to fix).

Thanks for giving a concise rationale on our use of imperative mood.

Phil, I think you meant to and forgot to sign-off; here is what I'll
queue.

Thanks.

-- >8 --
From: Phil Hord <hordp@cisco.com>
Date: Sat, 12 Jan 2013 15:46:01 -0500
Subject: [PATCH] rebase --preserve-merges: keep all merge commits including empty ones

Since 90e1818f9a  (git-rebase: add keep_empty flag, 2012-04-20)
'git rebase --preserve-merges' fails to preserve empty merge commits
unless --keep-empty is also specified.  Merge commits should be
preserved in order to preserve the structure of the rebased graph,
even if the merge commit does not introduce changes to the parent.

Teach rebase not to drop merge commits only because they are empty.

A special case which is not handled by this change is for a merge commit
whose parents are now the same commit because all the previous different
parents have been dropped as a result of this rebase or some previous
operation.

Signed-off-by: Phil Hord <hordp@cisco.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..2fed92f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -175,6 +175,11 @@ is_empty_commit() {
 	test "$tree" = "$ptree"
 }
 
+is_merge_commit()
+{
+	git rev-parse --verify --quiet "$1"^2 >/dev/null 2>&1
+}
+
 # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
 # GIT_AUTHOR_DATE exported from the current environment.
 do_with_author () {
@@ -796,7 +801,7 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
 while read -r shortsha1 rest
 do
 
-	if test -z "$keep_empty" && is_empty_commit $shortsha1
+	if test -z "$keep_empty" && is_empty_commit $shortsha1 && ! is_merge_commit $shortsha1
 	then
 		comment_out="# "
 	else
-- 
1.8.1.1.338.g126d652
