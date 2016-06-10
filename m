From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 11:13:10 -0700
Message-ID: <xmqqeg84gbex.fsf_-_@gitster.mtv.corp.google.com>
References: <20160610075043.GA13411@sigill.intra.peff.net>
	<20160610083102.GA14192@sigill.intra.peff.net>
	<xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
	<CA+P7+xp=bTPiwRRTH=h7v5pV8+=he4+789_3PNz227mv1387MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 20:13:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBQvn-00032l-MM
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 20:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcFJSNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 14:13:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751382AbcFJSNO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 14:13:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A68CC21445;
	Fri, 10 Jun 2016 14:13:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qyt+nsrDV1lgeaXy04j2wNyS3UY=; b=fHC7Wh
	1gpetPvEGBMuyDoLSFXzC8Y5SDqW3/v/OX5QRuM5RRjVVlmVxdeHS3Vo8/kRr3tE
	dIaL9xCQVFDwHKIW8CtWIQqDr25SqVQupgOuNJuJTC5AWkwtj9KQO59H2GhigjX9
	5wAkPTQXsFvxisGii87f6AMi7R9azxBzwyfAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XxhmVMgZL5Ak6U8z8/blKSNb7BBtMUVm
	xZdSAJVU9QMy9rsJmj0RxNdkhETVxJdi41zSmWc5PVKHjQC4H6PzBkBTWwGSe8Np
	d3/Ka24wtNUhYrCil5V4jynK6/eDP/XczpuFFjHs45ftQfNs4+6TGK8Z/1FIvfKv
	9etc20zRnWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9ED2821444;
	Fri, 10 Jun 2016 14:13:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CFDB21442;
	Fri, 10 Jun 2016 14:13:12 -0400 (EDT)
In-Reply-To: <CA+P7+xp=bTPiwRRTH=h7v5pV8+=he4+789_3PNz227mv1387MA@mail.gmail.com>
	(Jacob Keller's message of "Fri, 10 Jun 2016 09:29:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE4D41DE-2F36-11E6-94A7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297014>

Jacob Keller <jacob.keller@gmail.com> writes:

> I think we could use the indentation trick and it might help in this
> case. I agree, let's disable this for this cycle and experiment in the
> next one. Good catch, Peff.
>
> As others have said you will always be able to produce counter
> examples, that's the nature of heuristics. The idea is to see if we
> can come up with something simple that mostly improves the output,
> even if sometimes it might have a negative impact on the outputs. But
> I think we should avoid changing behavior unless it's mostly an
> improvement.

OK, let's do this then for the upcoming release for now.  I am
tempted to flip it back on after the release in 'next', so that
developers would be exposed to the heuristic by default, though.

-- >8 --
Subject: [PATCH] diff: disable compaction heuristic for now

http://lkml.kernel.org/g/20160610075043.GA13411@sigill.intra.peff.net
reports that a change to add a new "function" with common ending
with the existing one at the end of the file is shown like this:

    def foo
      do_foo_stuff()

   +  common_ending()
   +end
   +
   +def bar
   +  do_bar_stuff()
   +
      common_ending()
    end

when the new heuristic is in use.  In reality, the change is to add
the blank line before "def bar" and everything below, which is what
the code without the new heuristic shows.

Disable the heuristics by default and leave it as an experimental
feature for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 05ca3ce..9116d9d 100644
--- a/diff.c
+++ b/diff.c
@@ -25,7 +25,7 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_compaction_heuristic = 1;
+static int diff_compaction_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
-- 
2.9.0-rc2-275-g493bdbb
