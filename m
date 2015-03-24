From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-cache: fix reading of split index
Date: Tue, 24 Mar 2015 10:19:42 -0700
Message-ID: <xmqqpp7y71ox.fsf@gitster.dls.corp.google.com>
References: <20150320195943.GB6545@hank>
	<1426887794-9655-1-git-send-email-t.gummerer@gmail.com>
	<1426887794-9655-3-git-send-email-t.gummerer@gmail.com>
	<CACsJy8CYi+hYu8zwOy=m7zZk3-8fr+Jq9uT4kEf8fLCOcjHJzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:19:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSUb-0005Ig-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbbCXRTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:19:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756324AbbCXRTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:19:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99A65411A5;
	Tue, 24 Mar 2015 13:19:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kuvw7mpDqvuwylygH7UUzDaORF0=; b=HBuELc
	uGfD7UpfhhQS29c4lE5DFH+kNBMY32+rYCrK5vnUklJ7dEsfq9or54stwBG/hL7F
	ECBTZ7wauMPqQ35yYVTbV5xSbrm8PbIMSExRVfmbkp6NFUE1K5ta6lrnG4+CQeIf
	7PRHtkh5yJOOx85fpv+6sbB9WscGZJbmrqiYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=neSZ3jHLHUE47Lnh7Jn/C6OJROUV5I7s
	oqoxzYn/9uqMQE+zLUyWnvOWTizeg6zSrMw08lA/to7CudQaFVVtq9Y0wi+snYz9
	COEzW1ILmIL/cm4//QJ2tD1hcz1IIiGjX2/0BL+hHi+GrimgosHyxp49eIP9PEo0
	x6szDU7jd8k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91B9C411A4;
	Tue, 24 Mar 2015 13:19:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0897A411A2;
	Tue, 24 Mar 2015 13:19:43 -0400 (EDT)
In-Reply-To: <CACsJy8CYi+hYu8zwOy=m7zZk3-8fr+Jq9uT4kEf8fLCOcjHJzw@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 24 Mar 2015 20:02:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6A658E4-D249-11E4-B46F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266203>

Duy Nguyen <pclouds@gmail.com> writes:

> Thank you for catching this. I was about to write "would be nice to
> point out what tests fail so the reviewer has easier time trying
> themselves", but whoa.. quite a few of them!
>
> May I suggest a slight modification. Even though stage info is messed
> up before the index is merged, I think we should still check that both
> front and base indexes have all the names sorted correctly (and even
> stronger, the base index should never contain staged entries).

I smell a slight layering violation here, though.  As far as the
code to check the validity of the index is concerned, it is only
about the in-core index other code uses at runtime, and how that
in-core index is prepared, and most importantly, what is recorded in
the istate before it gets ready to be used by other code, is not its
concern.  The state immediately after the base index is read but
before it gets fixed up by the split-index code can have quirks
specific to how split-index code does things and it is perfectly OK
if it does not pass the check for the final shape.

The above does not change if the current split-index code happens to
promise certain properties in that intermediate state.  It is fine
if the split-index codepath wants to add its own validator to the
intermediate state for added robustness, but the rules for the
intermediate state and the rules for the final state can be
different, and from the maintainability's point of view, it is
better if we keep the validator for the final-shape oblivious to
what split-index does.
