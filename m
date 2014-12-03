From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 3 Dec 2014 13:38:58 -0800
Message-ID: <20141203213858.GC6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
 <20141203210031.GA6631@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:39:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwHde-0006gC-NK
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 22:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbaLCVjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 16:39:04 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35880 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbaLCVjD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 16:39:03 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so14499897iga.8
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 13:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AfZTxtoj57ntqjkYVdq9VjAjaesHKrvK0lIWKTNs42I=;
        b=i9Q6aY7yXbOh/jU+pS8FTpMN7Jv8LXM3L2+9UsB1SYgsHFAIKapCVdjRXsuFGszkp1
         Q/L+id4nnQ7L4dpf9POt3I2NOzZKc4McVJEFt8Z8xKF9EXwTDPNQmN0bvl3fTe+XJvfF
         tcznl9AhCjbbV2ZSr/4gFi4/cSbGhNBBhoTFL9TFEX7BSsBffYfL89WzcnK/oO+NTrpd
         o3XejzUdUgNid2i4sloE+dHRTrdoWcihKo6WUUGSwq8B0rpYvieY5dc7dkwXocTTEm2i
         l3K+2NoCkMKjJArUAXtTUMmLfA9pdKXv5giWEjOi2Cw7rK9hm2X9JlPFTF47xFOFWcsP
         FDDA==
X-Received: by 10.50.79.167 with SMTP id k7mr10749590igx.16.1417642742212;
        Wed, 03 Dec 2014 13:39:02 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id c139sm5457298ioc.28.2014.12.03.13.39.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 13:39:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203210031.GA6631@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260695>

Hi,

Jeff King wrote:

> What about a struct that has an errno-like value _and_ a fixed-size
> buffer? I'm thinking something like:
>
>   struct error {
> 	int code;
> 	char msg[1024];
>   };

My experience with errno is that it is very hard to anticipate what
granularity to use with error codes, especially if the error code is
going to (in some contexts) determine the message printed to the user.
In practice, it is easier to come up with a message at the error
detection site and use a generic "something happened" error code
except in those places where the caller is going to act on specific
error types that need to be distinguished.

Passing a message back through a strbuf leaves room for such
interpretations for the int return value.

The "< 0 means error" convention gives room to use different exit
codes for the errors that need to be programmatically distinguished.
For example, the ref transaction API uses this to distinguish D/F
conflicts from other errors, while still returning an error message
through a strbuf output parameter.

This doesn't help with functions that want to return a pointer (and
NULL on error).  For those, we can use an int output parameter, copy
the kernel's err_ptr trick, or use other sentinels for recoverable
errors that the caller wants to know about.  It hasn't come up in
practice enough for me to be motivated to want to choose between
those.

> If we changed the strbuf to a fixed-size buffer, that would help the
> allocation issue. Some messages might be truncated, but it seems
> unlikely in practice. It still loses readability, though.

I don't like the idea of having to choose a size in advance and not
being able to fit more detailed (perhaps language-specific, and
including user-specified input) messages lest the buffer overflow.
The allocation of a variable-sized buffer is a small overhead that I
don't mind incurring on error.  In the non-error case, the caller
doesn't actually have to free the buffer, and if they choose to, the
overhead incurred is that of free(NULL)'.

My two cents,
Jonathan
