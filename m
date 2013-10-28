From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [BUG?] inconsistent `git reflog show` output, possibly `git fsck` output
Date: Mon, 28 Oct 2013 12:16:06 -0500
Message-ID: <8761shjoyx.fsf@gmail.com>
References: <871u4hzusr.fsf@gmail.com> <523F749E.5030306@gmail.com>
	<xmqqtxgib1qm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Roberto Tyley <roberto.tyley@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 18:16:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaqQI-0006qZ-U3
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 18:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172Ab3J1RQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 13:16:10 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:50708 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab3J1RQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 13:16:09 -0400
Received: by mail-oa0-f50.google.com with SMTP id j6so3912787oag.37
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Shbw8urz5CtoH89OG+rPBk1kCI+HG8Tp3kwBUsLP9ts=;
        b=aoJyLBf3xPfnTP/ZAGCx5qLVv9SMFxaMfMYJI0bg7Vppy67f7h05rXd8ZZA3OjRJhF
         UyhuWOI4dbggqXboxXRupyRHLUE5TcORb/1qS+l9hhQD/p/7/owouNesVsibxZ9PUvT4
         PPFOja/Vbqp345scRfb6yGzJXVgKUxpAVQzkJlZ6rB5FYx7RfHxhJ7YFYDuYawh9f8Dz
         FanmmDdHqedDvvB0DZkWRbNSFqDoaKLvdP4Uw5T81Yh20rSmrbeRHaNjneCqbkuipl10
         a/tbrwcoVE/yc5uQ1IHHoGxGxGi/TJdRqrd0Pr6reDWMlVZF7twDpgC1VofgXywpE6JE
         IDvA==
X-Received: by 10.182.125.65 with SMTP id mo1mr15825295obb.40.1382980568633;
        Mon, 28 Oct 2013 10:16:08 -0700 (PDT)
Received: from localhost (cpe-72-179-6-119.austin.res.rr.com. [72.179.6.119])
        by mx.google.com with ESMTPSA id hs4sm27932524obb.5.2013.10.28.10.16.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2013 10:16:07 -0700 (PDT)
In-Reply-To: <xmqqtxgib1qm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 15 Oct 2013 15:36:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236841>

Junio C Hamano <gitster@pobox.com> writes:
> Roberto Tyley <roberto.tyley@gmail.com> writes:
>> On 21/09/2013 23:16, Keshav Kini wrote:
>>> [SNIP]
>>> This situation came about because the BFG Repo-Cleaner doesn't write new
>>> reflog entries after creating its new objects and moving refs around.
>>
>> True enough - I don't think the BFG does write new entires to the
>> reflog when it does the final ref-update, and it would be nicer if it
>> did. I'll get that fixed.
>
> (sorry for replying late)
>
> So this can be closed as "BFG not writing reflog in a consistent
> way, and 'git reflog show' is acting GIGO way"?  Or was there
> something the core side needs to do?

Hi Junio,

Below I'm resending a mail that I sent to the list earlier, but not to
you or Roberto personally, as I just realized.  So in case you didn't
see it before, here it is -- if you did see it before, sorry for the
noise.



Hi Junio,

Thanks for your reply. In my original mail, immediately after the
snippet Roberto quoted above, I said, "But that aside, I think how git
handles the situation might be a bug." To wit:

> It seems to me that one of two things should be the case. Either 1) it
> should be considered impossible to have a reflog for a ref X which
> doesn't contain a chain of commits leading up to the current location of
> X; or 2) if reflogs are allowed not to form an unbroken chain of commits
> leading to X, then `git reflog show` should at least make sure to
> actually display a commit ID corresponding to the second field of each
> reflog entry it reads, and not some other commit ID.
> 
> In the first case, the bug is that `git fsck` doesn't catch the
> supposedly impossible situation that exists in the repository I've
> described in this email. In the second case, the bug is that `git reflog
> show` has bad output.

Before this is closed, I would appreciate it if I could get some
feedback from git developers on the above two paragraphs.

Thanks,
    Keshav
