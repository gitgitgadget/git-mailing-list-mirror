From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug in "git rebase" (non-interactive) with regards to
 post-rewrite
Date: Wed, 22 Dec 2010 16:02:30 -0800
Message-ID: <7vipyl4aqx.fsf@alter.siamese.dyndns.org>
References: <AANLkTikv+TuVK3uyEd5ymLRq6Qs7tQYm4kUH3t9hTtQP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mihai Rusu <dizzy@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 01:02:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYdo-0001yv-Ev
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 01:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab0LWACk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 19:02:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0LWACj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 19:02:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0219F33FE;
	Wed, 22 Dec 2010 19:03:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O/5uiRjsntJC3ymrWTG/kueoa+8=; b=iiy+gT
	5prXrt2PGZh2+gSXSZyu2uvD23gYD9AefSeXu2OPulY5j8606IDdIkOKhzbSrw9m
	0u0joQvHQ/x/QpQG00zliiXlkJPrX03J4DFUsJzz5nZx5K4Nf/h//N/NSWeYkXBj
	LzGFkuIWmoCZtvUz7aBFBBmMoTmj2zl8QxXKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kXDrM7UMyWDQLOlHFmaMqq6PTVusW2GT
	Rbs36OZllRcF+1lEicgJjNCL6bhaHl6snBtnSOr+2+Zk5a6PO1WrMu27DPkiqr17
	OhTfHFJ5ZM/RpTWxIKSY+Bxb9JxPMPQNYz7CvSlRLPiSIfErUGj7CtGSvO8BGNcD
	0R2HJymoWzw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D461B33FC;
	Wed, 22 Dec 2010 19:03:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F1C5333FA; Wed, 22 Dec 2010
 19:03:01 -0500 (EST)
In-Reply-To: <AANLkTikv+TuVK3uyEd5ymLRq6Qs7tQYm4kUH3t9hTtQP@mail.gmail.com>
 (Mihai Rusu's message of "Mon\, 18 Oct 2010 15\:39\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03EAA450-0E28-11E0-94CE-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164111>

Mihai Rusu <dizzy@google.com> writes:

> I have found a possible bug in Git. When running "git rebase"
> (non-interactively, ie not "git rebase -i") on code that would
> conflict on the last commit that is being rebased and if that last
> commit is being skipped (git rebase --skip) then after the rebase is
> done the "post-rewrite" hook is not called by "git rebase". If I get a
> conflict and "git rebase --skip" any other commit or if I use "git
> rebase -i" and "git rebase --skip" the last commit when it conflicts
> then it calls post-rewrite just fine. Because this hook is normally
> called only once, at the end of a non-aborted rebase the fact that
> "git rebase" does not call it when the last commit conflicts and is
> skipped means the script is not called at all for that rebase
> operation thus breaking the code that depends on it.
>
> Please advise, thank you.

Perhaps this?  Totally untested...

 git-am.sh |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index cf1f64b..6cdd591 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -577,13 +577,6 @@ then
 	resume=
 fi
 
-if test "$this" -gt "$last"
-then
-	say Nothing to do.
-	rm -fr "$dotest"
-	exit
-fi
-
 while test "$this" -le "$last"
 do
 	msgnum=`printf "%0${prec}d" $this`
