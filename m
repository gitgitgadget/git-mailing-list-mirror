From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 34/44] refs.c: make prune_ref use a transaction to
 delete the ref
Date: Thu, 22 May 2014 09:56:36 -0700
Message-ID: <CAL=YDWkGWwBaNqACS=wYj-kFg2FLddp8n4U=LrUdR0-4sDh9_g@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-35-git-send-email-sahlberg@google.com>
	<20140521230139.GJ12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 18:57:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnWIR-0004a5-4z
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 18:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbaEVQ4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 12:56:38 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:55800 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaEVQ4h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 12:56:37 -0400
Received: by mail-ve0-f180.google.com with SMTP id db12so4697236veb.25
        for <git@vger.kernel.org>; Thu, 22 May 2014 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kC2eIlzma6zJvCXqVWhKvziwBRxQCHl236TdVIIuhFA=;
        b=CKucUtvrLjygX7kBp2lK+hGR3kLedU20CWVZ9ZEWqfiCFlw9Y9W/uTjrMvFPOE8T99
         WG7V7CK0e53JfptuFsBg4tZMgTl4+iZsq1SrCNLdPLBZRiPr7271n0lB9bzxCrtE3xSi
         l+i6d/B4tyLCbd9hxEtKxYf519CHi8b+67ow9KSCbvZkqFIXo6Z4jB6A/gekrrQllGHw
         vaiR4+RPO4RcGLEbenNUcGwba00E+Nzlnies+w4XrkBFFx5yDRJx3Yx3fJkCUsh8Lpc4
         UNoButbU4m0UZNDDr4m5X71c3BDW3ES16u+Qn8LK+//qoP4IWrP68oAgtdMgN59CVStN
         mBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kC2eIlzma6zJvCXqVWhKvziwBRxQCHl236TdVIIuhFA=;
        b=T96hCdDo1hLb22NKU6XQ0NW6BjV3ul8b8CJI1eXpDG0touVjhbKTVoOPb3GIuW7D1/
         MsRL8HFzn5BgUHmST/T5ILIcVeXhs06Huro3iI9/kMxXLrrlFLxnTOzsVCJOnRIOe/Tm
         Tx1JUXHcAiB+SQjN2zbPFIiIVDUt7wVibXYFyVXiZkDx9ivH9MzYyginskdn7EbE/3Xy
         ox82FXqzfRjG2ITBmug93Oh7ZpqxuWkQyABpiM2QexwI7tY/0ZnFvVN6Noo47ddfk5yU
         XCrVkrkApDlGIRLjjHNW2PJDTt/CqSFQJAPxf5jxVsWM2CDoY8FshvkqjNu9QTWiMNfY
         lfcQ==
X-Gm-Message-State: ALoCoQkE3uu6oL0Pme075Dkh0sD9A2S9CAu3/bxLeyGjFIbPCLwYv9mTv46T9WbO+KT08Hwfd8Xt
X-Received: by 10.52.118.212 with SMTP id ko20mr1324237vdb.77.1400777796434;
 Thu, 22 May 2014 09:56:36 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 09:56:36 -0700 (PDT)
In-Reply-To: <20140521230139.GJ12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249918>

Added a comment that any flags >=0x100 are reserved for internal use.


On Wed, May 21, 2014 at 4:01 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Change prune_ref to delete the ref using a ref transaction. To do this we also
>> need to add a new flag REF_ISPRUNING that will tell the transaction that we
>> do not want to delete this ref from the packed refs.
>
> Interesting.  Since the flag is per ref update, it even would allow
> deleting some refs and pruning others in the same transaction.  Makes
> sense.
>
> Looks like this doesn't batch up multiple ref-prunings into a single
> transaction.  Makes sense (it would just make the period while refs
> are locked longer without having any real benefit).
>
> [...]
>> +#define REF_ISPRUNING        0x0100
>
> Can this conflict with bit values declared elsewhere some day?  It
> would be more comfortable if refs.h also had a note about bits >=
> 0x100 being reserved for private use.
>
> The rest of the patch looks good.
>
> Thanks,
> Jonathan
