From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] Support multiple worktrees
Date: Fri, 20 Dec 2013 12:32:43 -0800
Message-ID: <xmqq7gaze00k.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BV6uerMyHNHviL0Jy8s+_jca8NM-hVfnM=u4cr-=JX1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 20 21:32:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu6kh-00077F-Vc
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 21:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab3LTUcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 15:32:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab3LTUct (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 15:32:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88EF2575C5;
	Fri, 20 Dec 2013 15:32:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vGZ3/NQNcp2qx6eH6TaDoW3WWjg=; b=MDy3hO
	pJAEmNUVmHTfEgkdrXTNaXswj5jiZOb7SainUiAbQaNI4jByiVYu72hus4BZxmeq
	y2T2UI+kiHaOYOuY8lKjFWHYHVF2UFdtRtqJCCoHHoyXL9aZ/msLhe/hVwxL/w+h
	4/4ZhFKak45ZYXpiuRkV6svk3lyb9esCNU5H4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UcPn6wX0maSSdKIKF1B/I8fPw+GVv0vN
	rOUi3RFn/5Yyp716c6jmqVhO+G2bLHnuun6B+77KDfnREzuhMgu7mISk2Uoivzi9
	8EMpSaBFJKOngul23eHP8NtJHyPE/9p/rM2ljC2V7yzJ/JITaBWJCR3/fnCH5XZ5
	pFHDYUI6/bU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 747F8575C4;
	Fri, 20 Dec 2013 15:32:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96C58575C0;
	Fri, 20 Dec 2013 15:32:47 -0500 (EST)
In-Reply-To: <CACsJy8BV6uerMyHNHviL0Jy8s+_jca8NM-hVfnM=u4cr-=JX1Q@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 19 Dec 2013 21:12:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E364B1F2-69B5-11E3-97FA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239581>

Duy Nguyen <pclouds@gmail.com> writes:

> I've got a better version [1] that fixes everything I can think of
> (there's still some room for improvements). I'm going to use it a bit
> longer before reposting again. But here's its basic design without
> going down to code
>
> New .git file format includes two lines:
> -- 8< --
> gitid: <id>
> gitdir: <path>
> -- 8< --
>
> Which would set $GIT_COMMON_DIR to <path> and $GIT_DIR to
> <path>/repos/<id>. Repository split is the same as before, worktree
> stuff in $GIT_DIR, the rest in $GIT_COMMON_DIR. This .git file format
> takes precedence over core.worktree but can still be overriden with
> $GIT_WORK_TREE. The main interface to create new worktree is "git
> checkout --to".
>
> "repos" belongs to $GIT_COMMON_DIR (i.e. shared across all checkouts).
> The new worktrees (which I call "linked checkouts") can also access
> HEAD of the original worktree via a virtual path "main/HEAD". This
> makes it possible for a linked checkout to detach HEAD of the main
> one.

I am not happy with the choice of "main/HEAD" that would squat on a
good name for remote-tracking branch (i.e. s/origin/main/), though.
$GIT_DIR/COMMON_HEAD perhaps?

> The interesting thing is support for third party scripts (or hooks,
> maybe) so that they could work with both old and new git versions
> without some sort of git version/feature detection. Of course old git
> versions will only work with ordinary worktrees. To that end, "git
> rev-parse --git-dir" behavior could be changed by two environment
> variables. $GIT_ONE_PATH makes 'rev-parse --git-dir' return the .git
> _file_ in this case, which makes it much easier to pass the repo's
> checkout view around with "git --git-dir=... ".$GIT_COMMON_DIR_PATH
> makes 'rev-parse --git-dir' return $GIT_COMMON_DIR if it's from a
> linked checkout, or $GIT_DIR otherwise.

I do not understand why you need to go such a route.

Existing scripts that works only in a real repository will only know
"git rev-parse --git-dir" as the way to get the real GIT_DIR and
would not care about the "common" thing.  Scripts updated to work
well with the "common" thing needs to be aware of the "common" thing
anyway, so adding "git rev-parse --common-git-dir" or somesuch that
only these updated knows would be sufficient, no?
