From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Fix `git rev-list --show-notes HEAD` when there are no
 notes
Date: Mon, 24 Aug 2015 12:23:52 +0200
Organization: gmx
Message-ID: <98f2f674e384ac3af38e305165135a60@www.dscho.org>
References: <0LZlZ2-1Z1Zyn1mzk-00lZ3Z@mail.gmx.com>
 <20150823174309.GA24735@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 24 12:24:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTov9-00085R-VE
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 12:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbbHXKYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 06:24:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:62769 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbbHXKYA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 06:24:00 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlpJU-1YuU6F3T4i-00ZQS3; Mon, 24 Aug 2015 12:23:55
 +0200
In-Reply-To: <20150823174309.GA24735@sigill.intra.peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:s6roJYO/c2D0hoQqc3FSCYjkt4ZFNbQydHTEgtKtXDr/H5hh++V
 kmR8F0offjypc3ZRX7Hfe2UQsaVI4jeaeBPlhx1HTk532/GzxlZL9dIZJDLenUfuoOaeYra
 qntvRyOrmJyQ9Y+KliKrZ6SRN/MOK1qAiZTYyYtz08+idBjMVtudRi6b1IBHyI5pHkz9Eaf
 e707ruHwYPwpaE9rLMspw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2sYHErUXFys=:4XJ4ws7humfjqWaZUng2wb
 nzmRRf8VAy/JBd7e3KTj5J8jznIbYpyJZlzg1dXq3RnS2fzkK3QVTVVk0NEqGXx8wnLShZFJ5
 l9Y7aJrNzhnR3wvj8PbC9mPL28cGmgc7AZfBR8EkOVyTKvGJ8VdWbNSgQIHOU1gHVEjveR8i9
 gf6xq5kiaD6L+b1uxmVYw9eWtPhJCUDdbptsgWyPDb2asI37X2kI8FuToU54eyGo/AKF0Krce
 ABHYHPXc0lAIp0ju9M58y8TGYTLe8YgtZz6AbnWvstqIF+bc79MmCrlOXPkRwttV84+XiB8uF
 hMaM54fkPjqicGZaSysI1w1EuNvMOjKBSnnrZzo+GlFe/MP9Zk6o5HBsgRe4ppa6j6RUJ1CKa
 BuX2VotHNecgGTAV9pMBuZ105DW1V1Uht3GT2OrQjvVkVOYll1G3g0n99HLIlnqmZok3Wm33i
 EYNmfNZyM0pVL/YobEu7sBT4YqtVs9CYlr+bn8x0j3oZod8sut365TQc5gU8FPAIUfL9n9Qfl
 ugTvSVh6B8YfcPmIS6oeLKw9cic19M2DGZiHIb33jartrBsW/B3a6cQ8yXUaad3VVCGuhas2U
 lDFUKc0x4GxQOEYCCw1pvRRH4QBTDa72IWbRFSRAnRMHzIFpT5dP54duu8cMMfi5l/FMJNOcT
 Q7nLQ4GK3QakDzpRLzWTzS/CGrCh+0K/ol1Bj2O0Wn0zPfze0WDXg/CkHKst0KuX+hXgg1/uH
 ssfLtrZq6yMYuqf/9SKn8NTr8Dc+TQgzMo64kw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276443>

Hi Peff,

On 2015-08-23 19:43, Jeff King wrote:
> On Sat, Aug 22, 2015 at 05:14:39PM +0200, Johannes Schindelin wrote:
> 
>> The `format_display_notes()` function clearly assumes that the data
>> structure holding the notes has been initialized already, i.e. that the
>> `display_notes_trees` variable is no longer `NULL`.
>>
>> However, when there are no notes whatsoever, this variable is still
>> `NULL`, even after initialization.
>>
>> So let's be graceful and just return if that data structure is `NULL`.
> 
> Hrm. This is supposed to be made non-NULL by calling init_display_notes.
> The "git-log" code does this properly, and can show notes. The
> "rev-list" code does not, and hits this assert. But that also means that
> it cannot actually _show_ notes, and your patch is papering over the
> problem.

Good point...

> it looks like [patch] is not enough to convince the pretty-printer to
> actually show notes (I suspect we need something like the
> pretty_ctx->notes_message setup that is in show_log()).
> 
> I don't know how deeply anybody _cares_ about showing notes via
> rev-list. It has clearly never worked. But rather than silently
> accepting --show-notes (and not showing any notes!), perhaps we should
> tell the user that it does not work. Likewise, the "%N" --format
> specifier never expands in rev-list, and should probably be removed from
> the rev-list documentation.

Hmpf. I really did not want to uncover yet another rabbit hole...

>> Reported in https://github.com/msysgit/git/issues/363.
> 
> After reading your subject, I wondered why "git rev-list --show-notes
> HEAD" did not crash for me (whether or not I had notes). But the key
> element from that issue is the addition of "--grep", which is what
> triggers us to actually look at the notes (since rev-list otherwise does
> not support displaying them). And that _does_ work with my patch above.
> So perhaps that is useful, though again, it has never worked in the
> past (and with your patch, it would silently return no results, whether
> the grep matched or not).
> 
> Of course it's a terrible interface to make "--show-notes --grep" grep
> the notes, but not actually _show_ them. :-/

It is.

> So I'm not really in favor of this approach, but if we do go that route,
> the comment above the declaration of format_display_notes needs to be
> updated.

You're right. I think the best approach for now is to error out when `--show-notes` is passed to rev-list. Do you agree?

Ciao,
Dscho
