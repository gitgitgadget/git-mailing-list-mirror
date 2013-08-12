From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t3404: rebase: interactive: demonstrate short SHA-1 collision
Date: Sun, 11 Aug 2013 23:31:40 -0700
Message-ID: <7vzjsnzagj.fsf@alter.siamese.dyndns.org>
References: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
	<1376280459-55188-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David <bouncingcats@gmail.com>,
	Diogo de Campos <campos@esss.com.br>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 08:31:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8lfQ-0007lE-NH
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 08:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab3HLGbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 02:31:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab3HLGbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 02:31:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C377333DC;
	Mon, 12 Aug 2013 06:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O6pmzIAfd8m63fSLHirxunYfMZ4=; b=JBFzoL
	iciDGu6xOm/yXuCDKSNuZKW7TUOKxsmDiTk1u1bYid7Yefg3fhxOxvOJViWwVRzx
	g79dayg2fCIxqGI4rVKm4uFKuof+GIXqIDkbIqIfbIa+eexo/vPw8HZiydTkIJ8z
	WfPetaPMDPIOl7jkAZgEp51UjhT/zACRMOWks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PuaXTdj1zHESh7uugCh2ugJvswA13kfl
	kUmVQnTd+sVPMe+0aQDBkmre6Yow+3qnUz0tso/r8S19AaJ4LIE7QjbOionFZXM6
	hqE+8bREFRokboaNL1S7t4fw0+eg7Vdax+LFnPc3n3hwcmck/IseWLmhIs0Jz766
	p6WiljKfT7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F23C333DB;
	Mon, 12 Aug 2013 06:31:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43055333D6;
	Mon, 12 Aug 2013 06:31:42 +0000 (UTC)
In-Reply-To: <1376280459-55188-3-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Mon, 12 Aug 2013 00:07:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA0DB2EC-0318-11E3-B91F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232159>

Eric Sunshine <sunshine@sunshineco.com> writes:

> The 'todo' sheet for interactive rebase shows abbreviated SHA-1's and
> then performs its operations upon those shortened values. This can lead
> to an abort if the SHA-1 of a reworded or edited commit is no longer
> unique within the abbreviated SHA-1 space and a subsequent SHA-1 in the
> todo list has the same abbreviated value.
>
> For example:
>
>   edit f00dfad first
>   pick badbeef second
>
> If, after editing, the new SHA-1 of "first" is now
> badbeef5ba78983324dff5265c80c4490d5a809a, then the subsequent 'pick
> badbeef second' will fail since badbeef is no longer a unique SHA-1
> abbreviation:
>
>   error: short SHA1 badbeef is ambiguous.
>   fatal: Needed a single revision
>   Invalid commit name: badbeef
>
> Demonstrate this problem with a couple of specially crafted commits
> which initially have distinct abbreviated SHA-1's, but for which the
> abbreviated SHA-1's collide after a simple rewording of the first
> commit's message.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t3404-rebase-interactive.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index af141be..e5ebec6 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -977,4 +977,21 @@ test_expect_success 'rebase -i with --strategy and -X' '
>  	test $(cat file1) = Z
>  '
>  
> +test_expect_success 'short SHA-1 setup' '
> +	test_when_finished "git checkout master" &&
> +	git checkout --orphan collide &&
> +	git rm -rf . &&
> +	unset test_tick &&

This will inconvenience tests added later to these two in the
future.  Oversight, or deliberate act knowing that these two are the
last tests in this script ;-)?

One bad thing is that "unset" loses information so that such future
tests cannot resurrect test_tick and continue on from where the last
test-tick left off.

> +	test_commit collide1 collide &&
> +	test_commit --notick collide2 collide &&
> +	test_commit --notick "collide3 115158b5" collide collide3 collide3
> +'
>
> +test_expect_failure 'short SHA-1 collide' '
> +	test_when_finished "reset_rebase && git checkout master" &&
> +	git checkout collide &&
> +	FAKE_COMMIT_MESSAGE="collide2 815200e" \

;-)

> +	FAKE_LINES="reword 1 2" git rebase -i HEAD~2
> +'
> +
>  test_done
