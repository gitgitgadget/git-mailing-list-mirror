From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: interrupt rebase when "commit --amend" failed
 during "reword"
Date: Tue, 29 Nov 2011 12:08:37 -0800
Message-ID: <7vk46isncq.fsf@alter.siamese.dyndns.org>
References: <20111117125847.190e9b25@ashu.dyn.rarus.ru>
 <1322496952-23819-1-git-send-email-andrew.kw.w@gmail.com>
 <1322496952-23819-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 21:08:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVTyw-0002va-TR
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 21:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497Ab1K2UIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 15:08:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756287Ab1K2UIl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 15:08:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43EF86C0B;
	Tue, 29 Nov 2011 15:08:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eIv65S2isSr1ncGhgNO7GPWKaE8=; b=GmTP42
	WRwsvFwMROnp+Fvo9UC/m0+MFhbUvyzE9CU3Prny5hF/ML/DXxybIuHL2qkXVbYi
	miDWeBe3szB6Z21iBanEeGbqfsEp2QHQ8QYN0TZRTKwRnXmu7DDoFZ2YBf30eXk+
	Lpa6wJxv47AebG+VIAzIqBPS+nEK24NFcw7Bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z8ISKf8tAJC9Sf14cNHn06JGqH1QHHb9
	U6V7ARrpsvWbQAhZ1iLFmf8cr3wUzxqfoHIdqAzIoV63KvTTk1ncga7siv7NVIu+
	peJBPayMsz9Z2c/C8W1Hp9YdjUngsQEeb4HwidnB6jyxyUpSiCXEewL8P5h/fh5/
	UVEPOaDKTxQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AE696C0A;
	Tue, 29 Nov 2011 15:08:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 955156C08; Tue, 29 Nov 2011
 15:08:39 -0500 (EST)
In-Reply-To: <1322496952-23819-2-git-send-email-andrew.kw.w@gmail.com>
 (Andrew Wong's message of "Mon, 28 Nov 2011 11:15:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDACCECE-1AC5-11E1-92D3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186079>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> "commit --amend" could fail in cases like the user empties the commit
> message, or pre-commit failed.  When it fails, rebase should be
> interrupted, rather than ignoring the error and continue on rebasing.
> This gives users a way to gracefully interrupt a "reword" if they
> decided they actually want to do an "edit", or even "rebase --abort".
>
> Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>

Makes sense, especially if "commit" itself failed due to some unknown
reason or a refusal from the pre-commit hook. Even though a user could
have been using the "empty the commit log message and the original is
kept" as a trick to recover from a botched rewording attempt and this
change will regress for such use cases, I have a feeling that it does
not matter.

Is there anything we should be saying more than "fatal: Cannot amend" to
help users when this new "die" triggers? What is the recommended recovery
procedure? Run "git commit --amend" after doing whatever is needed to fix
the tree (e.g. if pre-commit refused because of a coding style violation,
it may involve fixing the tree being committed; if it refused because of a
typo in the log message, the tree itself may be OK and nothing needs to be
done) and then "git rebase --continue"?

>  git-rebase--interactive.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 804001b..669f378 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -408,7 +408,8 @@ do_next () {
>  		mark_action_done
>  		pick_one $sha1 ||
>  			die_with_patch $sha1 "Could not apply $sha1... $rest"
> -		git commit --amend --no-post-rewrite
> +		git commit --amend --no-post-rewrite ||
> +			die_with_patch $sha1 "Cannot amend commit after successfully picking $sha1... $rest"
>  		record_in_rewritten $sha1
>  		;;
>  	edit|e)
