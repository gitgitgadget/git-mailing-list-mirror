From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Thu, 17 Sep 2015 08:15:27 -0700
Message-ID: <xmqqh9mtkrg0.fsf@gitster.mtv.corp.google.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	<xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ51+TKvOiJvWa-emmJJGirAqkr9m0a_7BrQ2UbiSJdjA@mail.gmail.com>
	<CAOLa=ZQxounTiJk0t+zB2-7=UQa8oL+uJ9EQpTkWL7kYFHjxwQ@mail.gmail.com>
	<vpqpp1hqgcd.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 17 17:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcauM-00013z-Mg
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 17:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbbIQPPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 11:15:30 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35477 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbbIQPP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 11:15:29 -0400
Received: by pacfv12 with SMTP id fv12so22783415pac.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=H6ufYLOy/7n98A95x8sKUkATKLXUiUcky2zzsHOvhGY=;
        b=gr/pS1CcQMb9lbkpUyt5w5Kg6TmaxDMNvID/yDqRg7rmQfkChLJM3tVJ1smqc6bAV4
         0lB8nIquzH6IsOoyfqQNOWpaZMGsRm1uevQG1a8KvECKnekSvIBh3DOqGeriWOfBQndr
         DwX2qKadcIwuxImFNxNiHv611RxurF4fXlz5wT6uWLxf2qnahfGr29DLQVS2q6Jz6FhU
         GSemPUwWqrgQhmoQSU4BgtzDIlFKuTv5V4FRuvxlJs6RUbAIISw2rjf2bA/AD3Ii3roU
         CxAX/RGmV1s9fCSEL8rTF4oxo82cJbYQUrB6i3A9PI6/t0qZAPMxqCUVtkT4du7lyHrD
         5Ifg==
X-Received: by 10.68.109.97 with SMTP id hr1mr72525996pbb.110.1442502928902;
        Thu, 17 Sep 2015 08:15:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id fx4sm4034580pbb.92.2015.09.17.08.15.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 08:15:27 -0700 (PDT)
In-Reply-To: <vpqpp1hqgcd.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	17 Sep 2015 16:18:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278120>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> So either we could introduce a new atom for sorting something like
>> `branch_sort` which uses the FILTER_REFS_(DETACHED_HEAD | BRANCHES |
>> REMOTES)
>
> I don't think you need a new atom. You can just change the sorting
> function to consider that detached HEAD is always first, and when
> comparing two non-detached-HEAD branches, use the atom supplied by the
> user.
>
> That would mean the detached HEAD would be displayed first regardless of
> --sort (which is the case right now).

I am a bit fuzzy about this.  I do not understand why Karthik thinks
a new atom is necessary in the first place, and I do agree that the
best way to go would be to teach the sort function to do "the right
thing", but I am not sure why it has to be "regardless of --sort".

In the original for-each-ref (before it was butchered^W updated with
ref-filter), we grab refs and sort with default_sort() when "--sort"
is not given.  When --sort is given, we just use atoms to compare.

I do not think ref-filter broke that pattern, and as long as it kept
that pattern, I do not think the solution has to be more than just
"teach that default_sort() function, which sorts by refname, to
always show HEAD first".  When you throw HEAD into the mix, instead
of grabbing only from refs/*, you can still give that set to a
sorting function, which by default puts "HEAD" before others (just
like the sorting function for "branch -a" by default puts local
before remote-tracking), and you are done, no?

When the user does give a custom --sort criteria, the logic in
default_sort() would not kick in, so there is no need for special
casing for "HEAD" like the code I questioned in this thread.

What am I missing?

> Introducing a new atom would mean that "git branch --sort authorname"
> would not use this new atom, hence the HEAD would be sorted like the
> others.

I think that is exactly what people would expect.

Perhaps a slightly tricky would be "git branch -a --sort refname".
If you have HEAD, refs/heads/master, and refs/remotes/origin/master,
I'd expect that it would sort these in that order purely because
that is the textual/ascii sort order of the FULL refname.

And then at the presentation level you would strip refs/heads and
refs/remotes from local and remote-tracking branches, just like "git
branch -a" output has always done, from the sorted result when
showing.

"git branch -a --sort refname:short" would sort using HEAD vs master
vs origin/master in the above example and would end up mixing loal
and remote-tracking together, but that is what the user is asking
for, and the user deserves to get what s/he asked for.

Somewhat confused....
