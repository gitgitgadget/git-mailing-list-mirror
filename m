From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Sat, 21 Mar 2015 11:01:43 -0700
Message-ID: <xmqq384ydybc.fsf@gitster.dls.corp.google.com>
References: <20150320100429.GA17354@peff.net>
	<CAPig+cRCbhMR58_PSFnsWoyo_aZoTOVZM2YeYC6Tvo7iXMZwBA@mail.gmail.com>
	<20150321081909.GA8221@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 21 19:01:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZNie-0006pL-Hq
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 19:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbbCUSBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 14:01:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751608AbbCUSBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 14:01:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 605353EBD0;
	Sat, 21 Mar 2015 14:01:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WuOe57dfWvA102Zn4LouNEp8ocM=; b=uo1fXY
	3lzHTGp9hRC6RM794NkVy1PM4VvmhYDYF/2JRlJc1v8J0L4L8YM1uzsWE7X6nQJd
	FmbHz23r3/v8/Yf32AfUAbIQjKyk6zUf/XjSOBM2pFdGSZdUZamKjl2e1NzKaz5v
	kM7XRYyPw686Ujr31jGOJS95ubjsn4VJdY0Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yOP15Ry4Rusg6RnuhZYcyxmVpFerUhv0
	t3wb/haBukN/b+HWEP56y4d8LZt94fr4FR4mg5e+sAvxnp1x9y+6nEhrlYKaIy6v
	DiDnn9XS5XCDKKeS0+V8m1vG/Tvze+07swIPRBvRIQN60X6uI1yg5r1IA5x4EtWm
	aj+ln1FOWr8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 585343EBCF;
	Sat, 21 Mar 2015 14:01:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCC593EBC9;
	Sat, 21 Mar 2015 14:01:44 -0400 (EDT)
In-Reply-To: <20150321081909.GA8221@peff.net> (Jeff King's message of "Sat, 21
	Mar 2015 04:19:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 55ECD682-CFF4-11E4-BF33-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266028>

Jeff King <peff@peff.net> writes:

> Running:
>
>   git diff origin origin/jk/test-chain-lint |
>   perl diff-blame.pl jk/test-chain-lint |
>   grep EOF
>
> was fun. At least I am not the only one. :)

The parameter to diff-blame.pl should be origin, instead of
jk/test-chain-lint, I presume?  You are grabbing the preimage line
numbers and asking blame to find out who wrote them.

> Nor the worst in the "severe" category.

I do not quite get what this means---the script does not seem to
judge what is severe and what is not, so I presume that this is to
be judged by whoever is reading the output from the above pipeline
after replacing "grep EOF" with "less" or something?

> # diff-blame.pl
> use warnings FATAL => 'all';
> use strict;
>
> my $head = shift
>   or die "usage: git diff <start> <end> | $0 <start> [blame-opts]";
>
> my $file;
> my @lines;
> my $line_nr;
>
> while (<STDIN>) {
>   if (m{^--- .*?/(.*)}) {

This may match a removal of a line that begins with "^-- something/" ;-)

>     flush();
>     $file = $1;
>     @lines = ();
>   }
>   elsif (m{^@@ -(\d+)}) {
>     $line_nr = $1;
>   }
>   elsif (m{^ }) {
>     $line_nr++;
>   }
>   elsif (m{^-}) {
>     push @lines, $line_nr++;
>   }
> }
> flush();
> exit 0;
>
> sub flush {
>   return unless defined $file && @lines > 0;
>
>   # XXX coalesce blocks of adjacent lines into ranges?
>   system(qw(git --no-pager blame), @ARGV,

You may want to pass an option to always show the filename here.

>          (map { "-L$_,$_" } @lines), $head, $file);
> }
