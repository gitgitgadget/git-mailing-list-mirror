From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Thu, 08 May 2014 13:55:57 -0700
Message-ID: <xmqq4n102dnm.fsf@gitster.dls.corp.google.com>
References: <536B4680.1010806@web.de>
	<1399569814-20644-1-git-send-email-dturner@twopensource.com>
	<1399569814-20644-3-git-send-email-dturner@twopensource.com>
	<xmqqha502ghc.fsf@gitster.dls.corp.google.com>
	<1399581623.11843.105.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 08 22:56:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiVMO-00064R-GJ
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 22:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbaEHU4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 16:56:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59592 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831AbaEHU4C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 16:56:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA0C316350;
	Thu,  8 May 2014 16:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bzEiRmVT5pBZvM6m2mSicSDz1hY=; b=gvU7Xd
	gW/VSBbTH29UipQQ6X9hbFDyffXQvTuVDPnhuReSJDTxFg9W9bH5T88Jm296Xpez
	9lbllXEPolOjurF3AtvRhiynWahjJBbkJZlQ4xEGQOti423eqoAxD5I0SuM3nM9x
	RpQYIaVUu3wpCw/+uxJJOOOEZFMFmmoNcnLo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RnX6KWKgd5zTgqm303s6IEA2t8WO9GY0
	ngJsttQsyzcE/ptHUiTD+HP44nmIPnxix+VynbbSrfO2cje+AqQ4FkAmqlnQhjz8
	oXRAg17vFuNFEU+FTWHSE1TGAvfgFNZSS7tsxUAE4xELwXzNTJHjqMNd+aFNqAex
	1pXuvzX/XMg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE87F1634F;
	Thu,  8 May 2014 16:56:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C57C1634C;
	Thu,  8 May 2014 16:55:58 -0400 (EDT)
In-Reply-To: <1399581623.11843.105.camel@stross> (David Turner's message of
	"Thu, 08 May 2014 13:40:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 282C20FE-D6F3-11E3-8438-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248447>

David Turner <dturner@twopensource.com> writes:

>> Hmm, I would find it easier to read if it were:
>> 
>> 		... if (lstat(dst, &st) == 0 &&
>>                 	!(ignore_case && !strcasecmp(src, dst))) {
>> 
>> That is, "it is an error for dst to exist, unless we are on a case
>> insensitive filesystem and src and dst refer to the same file.", but
>> maybe it is just me.
>
> I personally dislike the double negative. I also considered breaking it
> out into a little function with a self-documenting name -- does that
> sound better?

No, it shows that it is just me.  I did not say that the original is
unreadable.

>> More importantly, what is the end-user visible effect of this
>> change?  Is it fair to summarize it like this?
>> 
>>     On a case-insensitive filesystem, "mv hello.txt Hello.txt"
>>     always trigger the "dst already exists" error, because both
>>     names refer to the same file to MS-DOS, requiring the user to
>                                      ^^^^^^
> (I have not actually tested on Windows; I tested on the Mac since that's
> what I have handy)
>
>>     pass the "--force" option.  Allow it without "--force".
>
> Yes.
>
>> Overwriting an existing file with "mv hello.txt Hello.txt" on a case
>> sensitive filesystem *is* an unusual operation, and that is the
>> reason why we require "--force" to make sure that the user means it.
>> I have a slight suspicion that the same "mv hello.txt Hello.txt" on
>> a case insensitive filesystem, where two names are known (to the end
>> user of such a filesystem) to refer to the same path would equally
>> be a very unusual thing to do, and such an operation may deserve a
>> similar safety precaution to make sure that the user really meant to
>> do so by requiring "--force".
>> 
>> So, I dunno.
>
> The argument against --force is that git's behavior should not
> significantly differ between sensitive and insensitive filesystems
> (where possible).  I do not see a case-changing rename as unusual on a
> case-insensitive filesystem; these filesystems typically preserve case,
> and a user might reasonably care about the case of a filename either for
> aesthetic reasons or for functionality on sensible filesystems (e.g.
> developers who work on Macs but deploy on GNU/Linux, as is quite
> common).
>
> The Mac's interface itself provides conflicting evidence: on one hand,
> we might expect git mv to work like plain mv: nothing special is needed
> to do a case-changing mv). On the other hand, in the Finder, attempting
> a case-changing rename causes an error message (which there is no way to
> get around other than the two-rename dance).  I read this as "ordinary
> users never intentionally change the case of files, but developers
> sometimes do", but that's not the only possible reading.
>
> I myself am not actually a Mac user; I simply support a bunch of Mac
> users (which is where the merge bug came from).  So I don't know what
> Mac users would prefer.  Maybe there are some on the git mailing list?
>
> I also have not tried on Windows.  I put in an email to the one
> Windows-using friend I can think of to ask her to give Windows Explorer
> (or whatever it's called these days) a try.  My guess (based on a quick
> Google search) would be is that it works without error, but I will send
> an update if I hear otherwise.

Alright.  Thanks for sanity checking.

I've already queued your patch as-is when I was composing the
message you responded to and today's integration cycle is already
going, so unless other people have ideas to convince us both that
this is a bad idea, all is well without any further action.

Thanks.
