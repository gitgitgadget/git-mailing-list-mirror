From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/12] git submodule update: Use its own list implementation.
Date: Fri, 16 Oct 2015 14:02:18 -0700
Message-ID: <xmqqy4f2cysl.fsf@gitster.mtv.corp.google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
	<1444960333-16003-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 23:02:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnC8w-0000bG-4V
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 23:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbbJPVCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 17:02:21 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35706 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbJPVCU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 17:02:20 -0400
Received: by padcn9 with SMTP id cn9so15340554pad.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XgODwM3c5wh6cxN7P4N9UTmAbP8GjQmudOU1NtFfw0s=;
        b=q/o0RUdPidtrQwyFPHnvAO20ERhu5fa0wqfyOGGE9xzEPJHdCi9pEx/VmxxChjxArJ
         YLPGlwgxHHU1AWzG9ZPC3go8TKSrDVaSSRmyg5tENeOioCjb+r3C4Zb4MZPdAriXwRya
         Wrr+N2RoKHHIMqzh05kmFNvrtCp3Ra+g9KaGUqaGC48HbMzvHkUOmasQ5b7e1oJaSfRY
         +zVHnPzMasrGYYvzy9QlSSe94FPxFW98x56YUfWyqLTBu9WYy3jF0NdTnDFgvh5dugNy
         kVxblzCFTr0LbfhfU/Yct+3r3mmYEKYdqMbtspGSV148qcdN1tk2CebeaGWP53W9Nly4
         TaSQ==
X-Received: by 10.67.3.2 with SMTP id bs2mr18753119pad.118.1445029340372;
        Fri, 16 Oct 2015 14:02:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b1ee:7c8f:ac32:e39f])
        by smtp.gmail.com with ESMTPSA id ug4sm22999745pac.11.2015.10.16.14.02.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 14:02:19 -0700 (PDT)
In-Reply-To: <1444960333-16003-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 15 Oct 2015 18:52:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279770>

Stefan Beller <sbeller@google.com> writes:

> Discussions turned out that we cannot parallelize the whole loop below
> `git submodule--helper list` in `git submodule update`, because some
> changes should be done only one at a time, such as messing up a submodule
> and leave it up to the user to cleanup the conflicted rebase or merge.
>
> The submodules which are need to be cloned however do not expect to create
> problems which require attention by the user one at a time, so we want to
> parallelize that first.
>
> To do so we will start with a literal copy of `git submodule--helper list`
> and port over features gradually.

I am not sure what you mean by this.

Surely, the current implementation of "update" does the fetching and
updating as a single unit of task and iterate over these tasks, and
we would rather want to instead have one iteration of submodules to
do the fetching part (without doing other things that can fail and
have to get attention of the end user), followed by another
iteration that does the "other things", in order to get closer to
the end goal of doing the fetch in parallel and then doing the
remainder one-module-at-a-time sequencially.

I would imagine that the logical first step towards the end goal, if
I understood you correctly, would be to split that single large loop
that does a fetch and other things for a single module in each
iteration into two, one that iterates and fetches all, followed by a
new one that does the checkout/merge.

What I do not understand is why that requires a different kind of
enumerator (unless this is a kind of premature optimization, knowing
that the set of modules iterated by these two loops are slightly
different or something).

>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index bb8b2c7..d2d80e2 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -656,7 +656,7 @@ cmd_update()
>  	fi
>  
>  	cloned_modules=
> -	git submodule--helper list --prefix "$wt_prefix" "$@" | {
> +	git submodule--helper list-or-clone --prefix "$wt_prefix" "$@" | {
>  	err=
>  	while read mode sha1 stage sm_path
>  	do
