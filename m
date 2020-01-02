Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12027C2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F1B20866
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qj9dvGvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgABU0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:26:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65056 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABU0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 15:26:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B719FB51B5;
        Thu,  2 Jan 2020 15:26:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x7g5W6q16MJ5BThIUexf785iYdY=; b=qj9dvG
        vSXjHfrA/3pVIbMM4tLZDJ+OAwwhXRn1ntyxIHfSafnH1LWDveQqMzB4OY6gm6r/
        FpjrdL5HrQruYWdmr3PN95rXXFx5G82TlE/oIT87lUTcukxDnhnnJnYjMSHkWvZU
        LwEmGI6BqwFts/C9pYoe8uuk1QcpOPnPh8o/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ghwg/Io45sn5cJl1r7qsvpAhGb68S7IS
        iBpr2pWs2m0OnnOcFFcrdeDwufvYPiuEuTUecHe1ohOshzQgoOIzqG+u6UMskdhK
        NtC1Q3CvIKfiMf/jSJxpito3R3GCWyuezSwin51mHrXCEG7d/FLyTM+cmujT0Hof
        /XCLdwQ/858=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFCB9B51B4;
        Thu,  2 Jan 2020 15:26:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7626B51B3;
        Thu,  2 Jan 2020 15:26:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: sendemail-validate hook is run too early
References: <875zhut5yd.fsf@intel.com>
Date:   Thu, 02 Jan 2020 12:26:10 -0800
In-Reply-To: <875zhut5yd.fsf@intel.com> (Jani Nikula's message of "Thu, 02 Jan
        2020 14:10:02 +0200")
Message-ID: <xmqqk169ehb1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E8E99F2-2D9E-11EA-9ED1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jani Nikula <jani.nikula@intel.com> writes:

> I'm trying to use the sendemail-validate hook to validate the recipients
> of the patch email, among other things. Turns out the hook gets run
> immediately on the input patches, *not* on the "e-mail to be sent" as
> claimed by githooks(5).

I will make two suggestions, so please do not react before reading
both ;-)

The purpose of the validate hook, at least as it was originally
designed, was to vet the log message and patch contents, so what you
reported is not at all surprising.  After all, the sub that uses the
hook is called "validate_patch" ;-).

A low-hanging documentation fix (this is one suggestion) is to
phrase "e-mail to be sent" as "e-mail that has been submitted (to
git-send-email)" to avoid the confusion.

You do not want to use the sendemail-validate hook for checking for
the recipients, because the e-mail message is not a good source of
that information.

When a recipient is added, two things happen:

 * The recipient is added to the (internal) list of recipients on
   the underlying sendmail command line arguments.  This is the list
   of addresses that actually matter where the piece of email goes.

 * The recipient is added to the text of the message being sent, if
   s/he is being added to either To: or Cc: (this is purely for
   human consumption and does not affect where the piece of email
   goes).  A blind-carbon-copy recipient would not be added for
   obvious reasons.

If you truly want to validate where the message goes, you'd need to
vet the former list, not the latter one.  Otherwise, you'll miss BCC
recipients.

So the other suggestion is to have a separate hook to validate the
list of recipients.  This might be a bit more involved if we want to
execute cleanly, but should not be rocket science.  

The send_message() sub prepares @recipients list to form quite a bit
of processing at the beginning, and the uses the resulting list to
drive the sendmail by adding it to @sendmail_parameters().  The
contents of this @recipients list is what you want to vet before the
code talks to the sendmail program or daemon later in the function.
