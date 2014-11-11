From: Johan Herland <johan@herland.net>
Subject: Re: mac test failure -- test 3301
Date: Wed, 12 Nov 2014 00:57:53 +0100
Message-ID: <CALKQrgfaWett4zWRW3R8sKi8OOfq4_RnD8gMXhENjw_kmgGQ0w@mail.gmail.com>
References: <CAO2U3QhiWVvVKivBhE5R2xhjf8SPPtg6VSaQMxw7vbm_454jBQ@mail.gmail.com>
	<CAPig+cRxCj82F5aak0Y+Ce_SvUETtQ5dwM1RtzjUUvwtJ=WPYw@mail.gmail.com>
	<CALKQrgexnrCy-P6yTZB+U0--5peaTys9KqB+KGKqbAuyLA=NqA@mail.gmail.com>
	<20141111024128.GA21328@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 00:58:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoLKA-0007QH-N6
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 00:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbaKKX6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 18:58:10 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:59285 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbaKKX6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 18:58:09 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1XoLJy-0002yK-Pb
	for git@vger.kernel.org; Wed, 12 Nov 2014 00:58:03 +0100
Received: from mail-pd0-f172.google.com ([209.85.192.172])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XoLJw-00053D-WF
	for git@vger.kernel.org; Wed, 12 Nov 2014 00:58:01 +0100
Received: by mail-pd0-f172.google.com with SMTP id r10so11044532pdi.31
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 15:57:53 -0800 (PST)
X-Received: by 10.70.34.44 with SMTP id w12mr15001472pdi.151.1415750273954;
 Tue, 11 Nov 2014 15:57:53 -0800 (PST)
Received: by 10.70.68.3 with HTTP; Tue, 11 Nov 2014 15:57:53 -0800 (PST)
In-Reply-To: <20141111024128.GA21328@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 11, 2014 at 3:41 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 11, 2014 at 02:40:19AM +0100, Johan Herland wrote:
>> > This and all other failures are due to the output of 'wc -l', which on
>> > Mac is "{whitespace}1" rather than just "1" as it is on other
>> > platforms. fbe4f748 added quotes around the $(... | wc -l) invocation
>> > which caused the whitespace to be retained. A minimum fix would be to
>> > drop the quotes surrounding $().
>>
>> Ah, thanks!
>>
>> I thought that quoting command output was a good idea in general. Am I
>> wrong, or is this just one exception to an otherwise good guideline?
>
> It usually is a good idea to prevent whitespace splitting by the shell
> (and especially with things that might unexpectedly be empty, in which
> case they end up as "no argument" and not an empty one). So yeah, this
> is an exception.
>
>> Anyway, here is the minimal diff to remove quoting from the $(... | wc
>> -l) commands (probably whitespace damaged by GMail - sorry). Junio:
>> feel free to squash this in, or ask for a re-roll:
>
> I think we have test_line_count exactly because of this unportability
> with wc output.
>
> You'd want:
>
>   git ls-tree refs/notes/commits >actual &&
>   test_line_count = 1 actual
>
> or similar.

Thanks. Will use this in the re-roll.

> By the way, the point of that "ls-tree" appears to be to check the
> number of total notes stored. Since notes are stored in a hashed
> structure, should it be "ls-tree -r"? Otherwise, we see only the leading
> directories; two notes whose sha1s start with the same two characters
> would be considered a single entry.

Yes and no... The notes' nested fanout structure is developed
dynamically as the number of notes increase. As long as the number of
notes stay low, the notes tree remain at fanout level 0 (i.e. no
nesting), so ls-tree happens to work here. Still ls-tree -r is the
correct for any size notes tree. Will fix to use ls-tree -r.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
