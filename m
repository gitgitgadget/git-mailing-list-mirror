From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to warnings
Date: Mon, 22 Dec 2014 13:59:49 -0800
Message-ID: <xmqqfvc78hwq.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqoarbidv7.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:59:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3B1B-0003x3-LG
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 22:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664AbaLVV7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 16:59:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755153AbaLVV7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 16:59:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A0AA2925B;
	Mon, 22 Dec 2014 16:59:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iJiQAJIxe2FQ7l2Abus/NW1AAhw=; b=ssOlI0
	bykvoMwNYSHsa0mt94zyQ4AQWbSHV2uXIecZdW9oZDerZcDP6hHw2wswa/SSfiJ4
	fa9eCsuO00T5vGavgRTY6HD9BNoXphJKh2f2npJ3FtLG9ctAH63CKUdOsnOOWwMC
	XRn7YJquh4ctfEIXHpZsUdkvhp+aaRHWDonUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MpVKhZDhJwsRXn8IVXBW74rW6mVmSWOp
	A2DQF4GZWYiEaY1qEzlQgOMDozqks0Y1VGrzXharGEKg23xzrxuqkl+fLx8BkNqh
	w4kcsc/4Y3uobFUzF4+5UO8OgYkr10QzTLhLc3Jt80ffXNFl7THfpvIhX7cMrp8k
	mFNryWP3df8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 913CA2925A;
	Mon, 22 Dec 2014 16:59:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10DEA29259;
	Mon, 22 Dec 2014 16:59:50 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 22 Dec 2014 22:43:21 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA6A3FEA-8A25-11E4-8EAB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261677>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In other words, at some point wouldn't we be better off with
>> something like this
>> 
>> 	struct {
>>         	enum id;
>>                 const char *id_string;
>>                 enum error_level { FSCK_PASS, FSCK_WARN, FSCK_ERROR };
>> 	} possible_fsck_errors[];
>
> I considered that, and Michael Haggerty also suggested that in a private
> mail. However, I find that there is a clear hierarchy in the default
> messages: fatal errors, errors, warnings and infos.

I am glad I am not alone ;-)

These classes are ordered from more severe to less, but I do not
think it makes much sense to force the default view of "if you
customize to demote a questionable Q that is classified as an error
by default as an warning, you must demote all the other ones that we
deem less serious than Q, which come earlier (or later---I do not
remember which) in our predefined list".  So in that sense, I do not
consider that various kinds of questionables fsck can detect are
hierarchical at all.

I do agree that it makes it easier to code the initialization of
such an array to have "up to this point we assign the level 'fatal
error' by default" constants.  Then the initialization can become

	for (i = 0; i < FIRST_WARN; i++)
        	possible_fsck_errors[i].error_level = FSCK_INFO;
	while (i < FIRST_ERROR)
        	possible_fsck_errors[i++].error_level = FSCK_WARN;
	while (i < ARRAY_SIZE(possible_fsck_errors))
        	possible_fsck_errors[i++].error_level = FSCK_ERROR;

or something.  So I am not against the FIRST_WARNING constant at
all, but I find it very questionable in a fully customizable system
to use such a constant anywhere other than the initialization time.
