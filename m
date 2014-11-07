From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 2/3] t3312-notes-empty: Test that 'git notes' removes
 empty notes by default
Date: Fri, 7 Nov 2014 10:09:37 +0100
Message-ID: <CALKQrgf+0gp6x4oi-jZguz2p-psZVRWPii81u+bz3yHMe=5cSA@mail.gmail.com>
References: <1415176347-18694-1-git-send-email-johan@herland.net>
	<1415176347-18694-2-git-send-email-johan@herland.net>
	<xmqqmw85o4lj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 10:10:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmfYK-0007LO-2z
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 10:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbaKGJJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 04:09:52 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:59280 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaKGJJr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 04:09:47 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1XmfY8-00051Y-ET
	for git@vger.kernel.org; Fri, 07 Nov 2014 10:09:44 +0100
Received: from mail-pd0-f180.google.com ([209.85.192.180])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XmfY8-000Ebq-5s
	for git@vger.kernel.org; Fri, 07 Nov 2014 10:09:44 +0100
Received: by mail-pd0-f180.google.com with SMTP id ft15so2958248pdb.11
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 01:09:37 -0800 (PST)
X-Received: by 10.66.180.166 with SMTP id dp6mr10521486pac.101.1415351377113;
 Fri, 07 Nov 2014 01:09:37 -0800 (PST)
Received: by 10.70.68.3 with HTTP; Fri, 7 Nov 2014 01:09:36 -0800 (PST)
In-Reply-To: <xmqqmw85o4lj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 5, 2014 at 8:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> +verify_missing() {
>> +     git log -1 > actual &&
>
> Hmph, it was unclear what exactly you are trying to check with this
> one and the other "git log -1 >expect_missing".
>
> Perhaps a comment that says "We are interested in the trailing
> 'Notes: ...' in the output" is necessary here, or (probably even
> better) use the --format='%N' to make it crystal clear?

I'm rewriting the tests not to use 'git log' at all. We already have
other tests that check the formatting of notes, so we really only need
to use "git notes list HEAD" in these tests.

>> +     test_cmp expect_missing actual &&
>> +     ! git notes list HEAD
>
> Isn't this test_must_fail (i.e. if somebody screws up to make "git
> notes list" segfault, the test should fail, not taking the dying
> with SEGV as a sign of success)?

Yes, will fix.

>> +}
>> +
>> +for cmd in \
>> +     'add' \
>> +     'add -F /dev/null' \
>> +     'add -m ""' \
>> +     'add -c "$empty_blob"' \
>> +     'add -C "$empty_blob"' \
>> +     'append' \
>> +     'append -F /dev/null' \
>> +     'append -m ""' \
>> +     'append -c "$empty_blob"' \
>> +     'append -C "$empty_blob"' \
>> +     'edit'
>> +do
>> +     test_expect_success "'git notes $cmd' removes empty note" "
>> +             cleanup_notes &&
>> +             MSG= git notes $cmd &&
>> +             verify_missing
>> +     "
>> +done
>
> Perhaps just a taste issue, but I would think
>
>         while read cmd
>         do
>                 ... that test eval with $cmd interpolation ...
>         done <<-\EOF
>         add
>         add -F /dev/null
>         ...
>         EOF
>
> would be easier to maintain and to read, without having to worry
> about quoting and backslashing.

Thanks. That's much easier to read. Will fix.

On Wed, Nov 5, 2014 at 7:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> By definition, an empty note is empty ;-) and devoid of useful
> information other than a single bit, its existence.  I would
> understand a handful of tests that check "oh by the way, we should
> also handle empty ones sensibly", but are you sure that a _new_
> separate test script, not addition to existing test script, is worth
> to check _only_ empty notes?

Will move the tests into t3301 in the re-roll.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
