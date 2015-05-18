From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sh -x -i -v with continuous integration, was Re: [PATCH 1/4] t7601: test for pull.ff=true overrides merge.ff=false
Date: Mon, 18 May 2015 13:41:31 -0700
Message-ID: <xmqq8uclbouc.fsf@gitster.dls.corp.google.com>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
	<1431510740-9710-2-git-send-email-pyokagan@gmail.com>
	<2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
	<xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
	<81926313e0a131cd7224f0f6f8984dd2@www.dscho.org>
	<xmqqh9rf84we.fsf@gitster.dls.corp.google.com>
	<20150516152858.GA19269@peff.net>
	<xmqq1tigfij8.fsf@gitster.dls.corp.google.com>
	<20150518184528.GA11463@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 18 22:41:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuRr5-0003V1-4x
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 22:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbbERUli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 16:41:38 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34684 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbbERUld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 16:41:33 -0400
Received: by igbhj9 with SMTP id hj9so17484516igb.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 13:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ekq4aw+Uc+ovme0EqDqVYSp2y62EQ/xVS7oH63DKJqM=;
        b=Dt8kYMCJrlX2Us+kNn7X1bgsvcCaJJ0DgevDhPvXpLxsJ68OXmhw8ZEIlF1gXQEJ1m
         AROnhNuStD4t4Iust7Hccx1R5O96izvA4bmoIEQF4fTPW8kDsQsSPiOcA25UV5cKaaBJ
         RfC9U+le0ao1tbwoLOQnXfjQLUDHkQRw+B8t6fKnW/osLW+sLP0+afpOb82P3uNYI3pG
         4z1NGaB0X6p3lYgBX2VLC6henFgOgXDQJgQCTE5pnKcgyqFkF+w+iPhmtfUpuAV9fJY+
         s9+2D5PD6XzxZ1SuvHNKnbt4FIs5hgrDYyHM3L0pU00CE/cZgCWf9gF2fF8hUgSKI9bD
         Xd4Q==
X-Received: by 10.42.104.143 with SMTP id r15mr13950241ico.33.1431981693021;
        Mon, 18 May 2015 13:41:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id i80sm8445199iod.6.2015.05.18.13.41.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 13:41:32 -0700 (PDT)
In-Reply-To: <20150518184528.GA11463@peff.net> (Jeff King's message of "Mon,
	18 May 2015 14:45:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269315>

Jeff King <peff@peff.net> writes:

> [2] For the most part, actually, I think the status quo is using
>     test_cmp, and most of the uses of "test" are old. Using test_cmp is
>     more verbose, but it does have the advantage of checking the exit
>     code of the sub-programs (and also its output is much saner for
>     multi-line comparisons, but that isn't relevant to Paul's patches).
>
>     I'd be in favor of helpers that made it shorter to use test_cmp.
>     E.g.:
>
>       # "actual" contains "foo\n"; we save one line of "echo"
>       git foo >actual &&
>       test_cmp_str foo actual
>
>       # same, but take multiline input on stdin. Saves one line of "cat"
>       git foo >actual &&
>       test_cmp_str - actual <<-\EOF
>       foo
>       EOF
>
>       # similar, but it runs the command for us and compares its
>       # stdout, saving another line. Note that we take stdout as-is,
>       # so you get no opportunity to post-process it (but you
>       # can still do it the "long" way as above if you need to).
>       test_cmp_cmd foo git foo
>
>       # same, with stdin; obviously this doesn't work if you need to
>       # send something over stdin to the command, but again, you can
>       # fallback to the old way.
>       test_cmp_cmd - git foo <<-\EOF
>       foo
>       EOF
>
>    These also go in the direction of "verbose", by providing generic
>    solutions rather than specific ones. So by the argument you made
>    above, this is a bad thing.

I do not agree with that.  Perhaps "unconstained" was an unfit
phrase.

"test_cmp_cmd expected-string git foo" may be "test $a = $b" inside,
but its debug error message could be made to say "output from 'git
foo' is different from 'expected-string'", which is a very good
thing.  Contrast that with:

	verbose test "$(git foo)" = "expected-string"

which would not give you that information (and you'd need to do the
"-x" thing to find out where the string that is different from the
expected string came from).

Ultimately that is because 'test' that an individual test script
writes in it does not constrain what is on each side of comparison
(for that matter, it does not even constrain that what is tested is
comparison between two things), which makes it very hard to give
useful diagnoses.  'test' itself operates at too low a level, and
wrapping it with 'verbose' does not recover the information already
lost when invoking 'test'.

So, I suspect we want more or less the same thing.

We agree that we need shorter, easier to use, and less error prone
idioms, like test_cmp (comparing two files and show the differences
as diagnosis), test_cmp_rev (comparing two extended SHA-1
expressions as object names), and test_line_count (checking the
number of lines in a file).  I just do not think "verbose" that can
apply to any command will help us move in that direction very much,
and I find that "verbose" applied to something overly versatile like
"test" is a prime example that it does not help us much.
