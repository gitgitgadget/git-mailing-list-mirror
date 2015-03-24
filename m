From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache: tighten checks for do_read_index
Date: Tue, 24 Mar 2015 14:33:04 -0700
Message-ID: <xmqq384u5be7.fsf@gitster.dls.corp.google.com>
References: <CACsJy8CYi+hYu8zwOy=m7zZk3-8fr+Jq9uT4kEf8fLCOcjHJzw@mail.gmail.com>
	<1427216429-15569-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 22:33:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaWRq-0005T3-2b
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 22:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbCXVdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 17:33:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751803AbbCXVdL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 17:33:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3C8F417DE;
	Tue, 24 Mar 2015 17:33:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p230UIa/o56aNMhqnzeMGj6nqaI=; b=PNdibz
	8c+Y9BC61gzcBSCkJKSUl3SW/lbHx4YWzox/KxV6qwcfKMAzNJBQjlNjnkgJoT91
	vuLlaythVyHJQVl7XaJGNakHoQjaWL5d/pScsLbwOqs57MdLoYbqFuqCzMBlhaZp
	HeKHrvvtOucksPThS9koH24PDIgYbzS10PK1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A0yuq4w2fJAJl9jscCpWJNwPCM+vMTbQ
	7wMikqPXazkbEBwcQ5De+SESvao2l4nJpHUVg9SsMQevWqNFnwcOJj/F3bHQroT2
	/vxtmUGs5aLqYG6t09ylItn4/AkhKe+wB8QqzAaunv2tmQr1Tk8Vq7eGjPm4nkeb
	FcWvKNTyjUg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8936417DD;
	Tue, 24 Mar 2015 17:33:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FBCB417DC;
	Tue, 24 Mar 2015 17:33:05 -0400 (EDT)
In-Reply-To: <1427216429-15569-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Tue, 24 Mar 2015 18:00:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B6747D4-D26D-11E4-A0CC-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266230>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> 03f15a7 read-cache: fix reading of split index moved the checks for the
> correct order of index entries out of do_read_index.  This loosens the
> checks more than necessary.  Re-introduce the checks for the order, but
> don't error out when we have multiple stage-0 entries in the index.
> Return a flag for the caller instead, if we have multiple stage-0
> entries and let the caller decide if we need to error out.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> This is a patch on top of my previous patch, as that one has already
> been merged to next.

I am not convinced that this is a good change in the first place.

The original before your fix was wrong exactly because it was too
tightly tied to the implementation of the index file format where
there was only one file whose contents must be sorted, and that is
why it was a broken check in a new world with split-index.  And your
fix in 'next' is the right fix---it makes the verification happen
only on the result is given to the caller for its consumption.

It may be true that entries may have to be sorted in a certain order
when reading the original index file format and also reading some
steps in reading the split-index, but that merely happens to be an
imprementation detail of the two format currently supported, and as
we improve these formats (or even introduce yet another one) in the
longer term, this patch would re-introduce the same issue your
earlier fix corrected, wouldn't it?
