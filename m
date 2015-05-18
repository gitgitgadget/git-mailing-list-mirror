From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1020: cleanup subdirectory tests a little
Date: Mon, 18 May 2015 12:08:59 -0700
Message-ID: <xmqqlhglbt4k.fsf@gitster.dls.corp.google.com>
References: <1431972817-18178-1-git-send-email-sbeller@google.com>
	<xmqqwq05buz1.fsf@gitster.dls.corp.google.com>
	<xmqqsiatbuwb.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZjjKD6J3bQ0SWBUO-6bTY1Ld=Y7mRHVbw+RO5AFN+r5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jens.Lehmann@web.de, "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 18 21:09:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQPp-0005Lg-5P
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbbERTJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 15:09:06 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34084 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139AbbERTJB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:09:01 -0400
Received: by ieczm2 with SMTP id zm2so106799620iec.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4O0bIOi8+9Wchw/aN9nKh/4+bcf+SF5mEq2oI1WNkag=;
        b=Wc7U4dQCKzheQPznzBoXIWU+NcxeNfzDAs3VPBRjrpdJCUPip5/eW2RZFcbLlut3mB
         tfvDv1kWUAhowKG/6FHTWwOZwylHcDcMxUO0y2P6fHW2a7O7EXGADaYFz+9BXwziY9Ln
         fZfpmaVQ+F9k7whhB9DwayN+jAa0LLD2xjzRRzcjXQNSgxxGkwfY5e8xBC2yXjyvp0nU
         NosvIFqVXS/RgfXZIsU6Bfz3ke8N8etR4ZiFAw1wvWoCsHJO5KvU0IRjAKHWckSC9LJA
         7hrDQ+kzQ/hzbkA2tiMnFYbVDXqmMBcz1pAMPyIk9MLd8yc34XEhUCGPkgd1hNJ1MCUd
         HFWg==
X-Received: by 10.107.9.88 with SMTP id j85mr4462045ioi.39.1431976140870;
        Mon, 18 May 2015 12:09:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2120:a5f3:f7b6:7da9])
        by mx.google.com with ESMTPSA id o21sm8268430ioo.31.2015.05.18.12.08.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 12:09:00 -0700 (PDT)
In-Reply-To: <CAGZ79kZjjKD6J3bQ0SWBUO-6bTY1Ld=Y7mRHVbw+RO5AFN+r5A@mail.gmail.com>
	(Stefan Beller's message of "Mon, 18 May 2015 11:36:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269302>

Stefan Beller <sbeller@google.com> writes:

> On Mon, May 18, 2015 at 11:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> If it does not still work, shouldn't it be marked as
>> test_expect_failure instead of being commented out?

> When commenting in, it doesn't work because
> git clone -s --bare .git foo.git fails, as foo.git is already there.
> That problem removed it succeeds.

That is to be expected no?  If we want to have both working, we
would need to rename to allow them to co-exist.

I think what is going on is this (quoting the original without any
of your patches):

| test_expect_success 'no file/rev ambiguity check inside .git' '
| 	git commit -a -m 1 &&
| 	(
| 		cd .git &&
| 		git show -s HEAD
| 	)
| '

Inside a $GIT_DIR that has a working tree associated to it, does Git
notice that the user could never have meant a pathspec HEAD and
proceed without complaining?

| test_expect_success 'no file/rev ambiguity check inside a bare repo' '
| 	git clone -s --bare .git foo.git &&
| 	(
| 		cd foo.git &&
| 		GIT_DIR=. git show -s HEAD
| 	)
| '

Inside a bare repository, does Git notice that the user could never
have meant a pathspec HEAD and proceed without complaining, *IF* we
helped Git by an explicit GIT_DIR=. exported?

I suspect that back when this test was written, Git didn't correctly
work *WITHOUT* the explicit help, which is what the comment says for
the other commented-out one.

| # This still does not work as it should...
| : test_expect_success 'no file/rev ambiguity check inside a bare repo' '
| 	git clone -s --bare .git foo.git &&
| 	(
| 		cd foo.git &&
| 		git show -s HEAD
| 	)
| '

And this was the real test the previous one wanted to be back then
but somehow couldn't.

I agree that the temporarly test put in place with helping GIT_DIR=.
should have been commented why it has a seemingly unnecessary
GIT_DIR=. in it.  Without it it may be confusing, unless you can
correctly guess why the commented-out one is there and the helping
one is not exactly what we wanted to test.  Perhaps

	git clone -s --bare .git foo.git &&
	(
		cd foo.git &&
                # older Git needed help by exporting GIT_DIR=.
                # to realize that it is inside a bare repository
                GIT_DIR=. git show -s HEAD
	)

or something.

I do not know if we have fixed that bug over time offhand, so we'd
need to do some digging to verify the "older" above.

But assuming we have, I would say that the right thing to do is to
keep the original one with help (because we do not want it to break
in the future), and reinstate the commented-out one that does the
right thing without us helping.  But we would obviously need to
rename foo.git to bar.git or something else while doing so.

If we still have that bug, then I think the right thing is to do the
same as above, but mark the one that exhibits the bug to expect
failure.  That way, people can hunt and fix the bug (probably in
setup.c somewhere).

Thanks.
