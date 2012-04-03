From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick failed
Date: Tue, 03 Apr 2012 17:01:00 -0400
Message-ID: <4F7B650C.9060800@sohovfx.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com> <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com> <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com> <20120403144505.GE15589@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:01:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFArJ-0004I6-4k
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 23:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239Ab2DCVBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 17:01:40 -0400
Received: from smtp01.beanfield.com ([76.9.193.170]:57573 "EHLO
	smtp01.beanfield.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753519Ab2DCVBk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 17:01:40 -0400
X-Spam-Status: No
X-beanfield-mta01-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta01-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta01-MailScanner: Found to be clean
X-beanfield-mta01-MailScanner-ID: 1SFAqb-000F8v-Dk
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta01.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1SFAqb-000F8v-Dk; Tue, 03 Apr 2012 17:01:01 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <20120403144505.GE15589@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194645>

On 04/03/2012 10:45 AM, Jonathan Nieder wrote:
> Ok.  Now the user (sensibly) ignores the message from cherry-pick and
> just runs "git rebase --continue".  The rebase finishes but nobody
> feels it's his responsibility to remove the .git/CHERRY_PICK_HEAD file
> and it gets left behind.
>   
Yes, that's exactly what's happening. That particular rebase will leave
behind CHERRY_PICK_HEAD, which have bad consequences such as:
1. Confuses __git_ps1 (from git-completion.bash) into thinking a
cherry-pick is still in progress. (which is what started this discussion)
2. Cause "cherry-pick --continue" to think a cherry-pick is still in
progress.
3. Similarly, if a user then continue on to modifying their files, and
do a "add" and "commit", "commit" would reuse the message from the
CHERRY_PICK_HEAD.

> I suspect a more appropriate long-term fix would involve "git
> cherry-pick" noticing when a patch has resolved to nothing instead of
> leaving it to "git commit" to detect that.
>   
I actually tried implementing a fix like that too. But then I thought
there might be other scenarios where "commit" could fail, and it doesn't
seem to make sense for "cherry-pick" to have to detect all possible
"commit" failures. Though it also feels like the question of whether or
not "cherry-pick" should detects the "empty commit" is a separate issue
altogether.

Besides the "empty commit" failure, "cherry-pick" can still run into
various errors, such as merge conflict. So it will have to keep a state
somehow. And instead of having "cherry-pick" make special cases for
"rebase -i" to remove the state, it makes more sense to teach "rebase
-i" that "cherry-pick" now keeps a state on failure. So if "cherry-pick"
fails, "rebase -i" is responsible for clearing that state. And that's
what this patch is supposed to do.

Perhaps I should rephrase my description to reflect this better?
Something along the line of: "cherry-pick" now keeps a state on failure.
Instead of having a special case inside the sequencer to remove the
state, we teach "rebase -i" that we need to clear the state.
