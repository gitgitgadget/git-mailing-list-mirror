Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB7C2D0C2
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB8D21734
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 09:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgACJqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:46:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:12405 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACJqn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 04:46:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 01:46:42 -0800
X-IronPort-AV: E=Sophos;i="5.69,390,1571727600"; 
   d="scan'208";a="214415975"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 01:46:41 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: sendemail-validate hook is run too early
In-Reply-To: <xmqqk169ehb1.fsf@gitster-ct.c.googlers.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <875zhut5yd.fsf@intel.com> <xmqqk169ehb1.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 03 Jan 2020 11:46:39 +0200
Message-ID: <87sgkwswhs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 02 Jan 2020, Junio C Hamano <gitster@pobox.com> wrote:
> Jani Nikula <jani.nikula@intel.com> writes:
>
>> I'm trying to use the sendemail-validate hook to validate the recipients
>> of the patch email, among other things. Turns out the hook gets run
>> immediately on the input patches, *not* on the "e-mail to be sent" as
>> claimed by githooks(5).
>
> I will make two suggestions, so please do not react before reading
> both ;-)
>
> The purpose of the validate hook, at least as it was originally
> designed, was to vet the log message and patch contents, so what you
> reported is not at all surprising.  After all, the sub that uses the
> hook is called "validate_patch" ;-).
>
> A low-hanging documentation fix (this is one suggestion) is to
> phrase "e-mail to be sent" as "e-mail that has been submitted (to
> git-send-email)" to avoid the confusion.

Agreed; I think this should be done no matter what.

> You do not want to use the sendemail-validate hook for checking for
> the recipients, because the e-mail message is not a good source of
> that information.
>
> When a recipient is added, two things happen:
>
>  * The recipient is added to the (internal) list of recipients on
>    the underlying sendmail command line arguments.  This is the list
>    of addresses that actually matter where the piece of email goes.
>
>  * The recipient is added to the text of the message being sent, if
>    s/he is being added to either To: or Cc: (this is purely for
>    human consumption and does not affect where the piece of email
>    goes).  A blind-carbon-copy recipient would not be added for
>    obvious reasons.
>
> If you truly want to validate where the message goes, you'd need to
> vet the former list, not the latter one.  Otherwise, you'll miss BCC
> recipients.

Understood.

> So the other suggestion is to have a separate hook to validate the
> list of recipients.  This might be a bit more involved if we want to
> execute cleanly, but should not be rocket science.
>
> The send_message() sub prepares @recipients list to form quite a bit
> of processing at the beginning, and the uses the resulting list to
> drive the sendmail by adding it to @sendmail_parameters().  The
> contents of this @recipients list is what you want to vet before the
> code talks to the sendmail program or daemon later in the function.

One key point here is using the patch as input to the recipient
validation. For example, requiring specific recipients when certain
files are changed (a bit like get_maintainers.pl in Linux kernel). To
make it easier for the hook writer, both the patch and the recipients
should be passed to the hook at the same time.

I think one possible alternative to adding a completely new hook would
be postponing the sendemail-validate hook, passing the same patch on the
command-line as before (to ensure current users are unchanged), and
additionally passing in the recipients. Perhaps write the recipient list
in a temp file, and pass the filename on the command-line or via the
environment to the hook.

Alas implementing this in perl *is* rocket science to me, so I'm pretty
much dependent on the git community's help here.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
