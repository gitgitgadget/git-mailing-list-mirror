From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] reflog-walk: don't segfault on non-commit sha1's in
 the reflog
Date: Tue, 5 Jan 2016 20:28:25 -0500
Message-ID: <CAPig+cThSHKBiUk5CmtE59mci3JLMv7QPNfHZAYmkqQvZHHofA@mail.gmail.com>
References: <1451552227.11138.6.camel@kaarsemaker.net>
	<20160105211206.GA12057@spirit>
	<CAPig+cRufd4qOwZRpw2TR39npkRGg=7S+7YwfSu6EvRR95kRSA@mail.gmail.com>
	<1452043212.5562.18.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:28:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGctq-000672-6D
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 02:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbcAFB21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 20:28:27 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36643 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbcAFB20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 20:28:26 -0500
Received: by mail-vk0-f67.google.com with SMTP id a185so20107196vkb.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 17:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JJSXSVKGwViFJImrYL0ZSPDc6PCuctQ166i0ID/sDSg=;
        b=RYMEDmJs46DG0K9WwwppMNlB9qO3oGAcziZbCE1G0vsZeC3Rb0ONUPnFpC7yjjiYr4
         +RepXxswp+JD/63d6jNxPvRBwKRmjKPaFMZf1UihJDBGhQnRHo/OcCwkU2QmdVjxs49W
         y0jsVmrf3rzV+POYxDWNDIv2gCx9t20Y8xFQH4P9sJ44Ciz8g4hubW5eQ2m1yiU4wCd5
         NDUfYLzkNg049B7DkPUiHDACpE7O9iXKcsM2sywTww4jH6qpZQXMrDEBOAW/fq/ICBar
         bg41pDts/bzpVM/+BirDcKbYP7v9SjekvJDDoggLeAuj85zdKRNpYXA+CYq0cKvzSo1x
         DU0g==
X-Received: by 10.31.47.130 with SMTP id v124mr66715970vkv.117.1452043705324;
 Tue, 05 Jan 2016 17:28:25 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 5 Jan 2016 17:28:25 -0800 (PST)
In-Reply-To: <1452043212.5562.18.camel@kaarsemaker.net>
X-Google-Sender-Auth: FkBJtRdL3kVirmr2h7QlpP57fio
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283414>

On Tue, Jan 5, 2016 at 8:20 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On di, 2016-01-05 at 20:05 -0500, Eric Sunshine wrote:
>> On Tue, Jan 5, 2016 at 4:12 PM, Dennis Kaarsemaker
>> > +       git update-ref --create-reflog -m "Creating ref" \
>> > +               refs/tests/tree-in-reflog HEAD &&
>> > +       git update-ref -m "Forcing tree" refs/tests/tree-in-reflog
>> > HEAD^{tree} &&
>> > +       git update-ref -m "Restoring to commit" refs/tests/tree-in
>> > -reflog HEAD &&
>> > +       git reflog refs/tests/tree-in-reflog
>> > +'
>>
>> Hmm, this test is successful for me on OS X even without the
>> reflog-walk.c changes applied.
>>
>> > +test_expect_failure 'reflog with non-commit entries displays all
>> > entries' '
>> > +       git reflog refs/tests/tree-in-reflog >actual &&
>> > +       test_line_count = 3 actual
>> > +'
>>
>> And this test actually fails (inversely) because it's expecting a
>> failure, but doesn't get one since the command produces the expected
>> output.
>
> That's... surprising to say the least. What's the content of 'actual',
> and which git.git commit are you on?

% cat t/trash\ directory.t1410-reflog/actual
b60a214 refs/tests/tree-in-reflog@{0}: Restoring to commit
140c527 refs/tests/tree-in-reflog@{1}: Forcing tree
b60a214 refs/tests/tree-in-reflog@{2}: Creating ref
%

This is with only the t/t1410-reflog.sh changes from your patch
applied atop current 'master' (SHA1 7548842).
