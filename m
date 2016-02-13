From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Fri, 12 Feb 2016 21:07:47 -0800
Message-ID: <xmqq37sxtcyk.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
	<CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
	<CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
	<20160210210115.GA10155@google.com>
	<CACsJy8DLYjXW1VBsxLYwcpjFV2s3MKqw9FL_2S7dMXpZigc2kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 06:07:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUSR1-0004SW-9M
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 06:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbcBMFHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 00:07:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750738AbcBMFHu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 00:07:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 72C4144570;
	Sat, 13 Feb 2016 00:07:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dy0y4hyy5/r4/THvN53nVY6lbL0=; b=UVBiV1
	4hkma4ugsHlSYU11j68nZ/zrnwBjDG1r4ZvWhiVDVBQldUCe10GPp5jJ6r7hVvo4
	RBbZ6kaZjbA8K29GJLNgfAYYE9BVoldxMFoGZCthCuHT9xInKsmPfIaDAKwtenNp
	89znNA2l2EzH47m6pxYjJeD4pUTYfXvUVPiWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rESlgW2cyaP6j1vpuOEWFy61Xm9YR/FI
	lAOtAU6xesBY4s/fCvZczikkPgz0YBbuJvHtIrvpzJFEuwDKOwO7CM0/m2+D35GQ
	mVZdNNms+krfYrJMc0Lx8anYyvqdICo5UQQMXFrtRk5AWArk/f0316S+T6WDgDrD
	wtARRsLuXqU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 69B3D4456F;
	Sat, 13 Feb 2016 00:07:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DB8B34456D;
	Sat, 13 Feb 2016 00:07:48 -0500 (EST)
In-Reply-To: <CACsJy8DLYjXW1VBsxLYwcpjFV2s3MKqw9FL_2S7dMXpZigc2kA@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 12 Feb 2016 06:53:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B9DAF070-D20F-11E5-B1DB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286106>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 11, 2016 at 4:01 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> ....
>>
>> I really like this design.  I'm tempted to implement it (since it
>> lacks a bunch of the downsides of clone.bundle).
>
> A bit disappointed we still do not address resumable fetch.

As you already said, the initial "clone" and subsequent incremental
"fetch" are orthogonal issues.

Because the proposed update to "clone" has much larger payoff than
the proposed change to "fetch", i.e.

 * The amount of data that gets transferred is much larger, hence
   the chance of network timing out in a poor network environment is
   much higher, need for resuming much larger.

 * Not only the approach makes "clone" resumable and helping
   clients, it helps the server offload bulk transfer out to CDN.

and it has much smaller damage to the existing code, i.e.

 * We do not have to pessimize the packing process, only to discard
   the bulk of bytes that were generated, like the proposed approach
   for "fetch".

 * The area new code is needed is well isolated and the switch to
   new protocol happens very early in the exchange without sharing
   code to existing codepath; these properties make it less risky to
   introduce regression.

it is simply a good taste to give "clone" higher priority between
the two.

So I do not think there is much reason to feel disappointed.
