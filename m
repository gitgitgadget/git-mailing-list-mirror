From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Git clone of a bundle fails, but works (somewhat) when run
 with strace
Date: Sun, 24 Feb 2013 22:59:08 -0800
Message-ID: <7vy5eczxoj.fsf@alter.siamese.dyndns.org>
References: <511E8D84.6060601@gmail.com> <kfmclb$4ro$2@ger.gmane.org>
 <kfmide$4ro$3@ger.gmane.org> <20130216040109.GA31630@sigill.intra.peff.net>
 <kfqkak$ugv$1@ger.gmane.org> <20C7ED1EA37C4EECA28070D1483C57B7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Philip Oakley" <philipoakley@iee.org>,
	"Alain Kalker" <a.c.kalker@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 07:59:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9s2C-0006id-R9
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 07:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab3BYG7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 01:59:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42465 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535Ab3BYG7K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 01:59:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 272969C93;
	Mon, 25 Feb 2013 01:59:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ZJ2+l1NrCwG7aUWKtUSSRvsoOZ8=; b=tGzB8CNr1cBQwhB131mD
	9uJ6PMgTvSHn7SFaZTrwvUpFrW5yaZs0QYBhQYYeAXLSbN/vBVpeiO5JVbrVsyVQ
	i42Zr74jtENDej+8RlnZ23zBYd1YwgcVTN45gdK9fcmpk1XuwbuvxQFJeALLi1nD
	7eGJvMehCX8aIQjFmhlI7oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Ah8ZDiTxGQRgeSo3SUI7sXTCceA1HwOUQUsEmFvUtNhOfc
	5YsVXd6ZcHFTRzxGB914ttdiT6cZkXlTbcBeSmeE29sIlGMTjtDJ4MpCOG5drMGB
	ZsUjifroUErutHWWuHz6UG+pWKwlNrbK2cHdRN+L9RinqWl8hQb4/Y/hkY8Mc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C0BE9C92;
	Mon, 25 Feb 2013 01:59:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F50C9C91; Mon, 25 Feb 2013
 01:59:09 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA7AB9F2-7F18-11E2-9A69-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217044>

"Philip Oakley" <philipoakley@iee.org> writes:

>>> You probably wanted "git bundle create ../repo.bundle --all" which
>>> includes both "master" and "HEAD".
>>
>> That explains it, thanks! Maybe this could be added as an example to
>> the
>> documentation for `git bundle`? People looking at `man git-bundle`
>> hoping
>> to use it as one possible way to make a backup of a Git repository
>> might
>> not realize right away that --all is the way to specify all refs, like
>> with `git log`.
>
> I had posted a documentation patch back in Setemeber last year,
> http://thread.gmane.org/gmane.comp.version-control.git/205887/focus=205897,
> however Junio highlighted some additional concerns that I wasn't able
> to respond to at the time.
>
> It may be worth resurrecting once the concerns have been addressed.

A saner thing to do, instead of explaining away the lack of HEAD as
"the creator of the bundle did not bother to name it", might be to
automatically add an artificial HEAD to the resulting bundle when
the arguments given to specify the "range" do not have any negative
ones (because by definition such a bundle is unsuitable for use with
"git clone" [*1*]), and HEAD is not among the refs.

The heuristics to pick what to record as the artificial HEAD could
vary, though. Without thinking things through...

 * When only one positive ref is given, use it (sort of obvious);

 * When two or more positive refs are given, and the current branch
   is one of them, use that;

 * Otherwise, pick the "first" positive ref given from the command
   line.

perhaps?


[Footnote]

*1* Strictly speaking, this condition could be loosened, as long as
cloning side uses an appropriate --depth, but I do not know such an
"advanced use case" needs a hand-holding change to add a HEAD that
was not asked by the user.
