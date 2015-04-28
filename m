From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Tue, 28 Apr 2015 14:06:47 -0700
Message-ID: <20150428210647.GP5467@google.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
 <20150428061741.GL24580@peff.net>
 <CAMpP7Nb3aiMoTjtPJNJPv38G54ZawS8B+NDX0x2iNe6FA-L+Lw@mail.gmail.com>
 <20150428201918.GA10902@peff.net>
 <20150428203400.GN5467@google.com>
 <20150428203645.GA11473@peff.net>
 <20150428204213.GO5467@google.com>
 <20150428204853.GA12153@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: erik =?iso-8859-1?Q?elfstr=F6m?= <erik.elfstrom@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:06:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnCiX-0000fZ-7D
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 23:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031074AbbD1VGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 17:06:52 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:32827 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030957AbbD1VGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 17:06:50 -0400
Received: by igbpi8 with SMTP id pi8so96041319igb.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7p9dk7EA73O1Y9+acMbSQSRPQzvCN6XePsHsPBZrzEw=;
        b=0SvxmFv8ANsJfk8eH9F7W4YjiyN23C5fK4LamoVN3OWznQTz13Gai1zsZ5lAMSlW8b
         UBHwgRWTOyDV8Ptq2SSSESJY3Nmc2JFFbm85IDSKpDIObKlAToVAzzz850rCE2AIIFDk
         2Qys5LprEJ8wkz3hWShgTmVYe0Ebdt+l4Q49271Ylei0Vj4QR7OuQqHxJKsBkVx9zaki
         sBpKwLTbp0zpiubYtKv4yEzznYpM/qIxg/Zm6jBZW3ScMekimfF9AOh6VDEAy7qLPtWG
         0Pk/Bk/eaQJiq7lmJgNRIlW5Rn1eydC4vBN3Yivfz1u7ddmeUJ9qWisrxF28trKlPyX9
         ubnw==
X-Received: by 10.107.128.3 with SMTP id b3mr23882646iod.24.1430255209649;
        Tue, 28 Apr 2015 14:06:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c979:ad68:d2ca:9e9e])
        by mx.google.com with ESMTPSA id fv2sm7917354igb.22.2015.04.28.14.06.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Apr 2015 14:06:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150428204853.GA12153@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267945>

Jeff King wrote:
> On Tue, Apr 28, 2015 at 01:42:13PM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> But the NULL does not carry the information about _which_ error, and
>>> Erik is suggesting that the caller may need to change behavior based on
>>> that information. IOW, his current patch (return NULL and set the
>>> specific integer code in a variable) allows this, but switching the
>>> integer code out for a human-readable strbuf does not.
>>
>> Right.  Two ways to handle that are:
>
> Sure, but "this system" that I was referring to one was not one of
> those ways. :)

That means I wasn't communicating well.

I never advocated *not* providing an integer return code when you want
to affect control flow.

An example of a function that provides information both to the caller
and user and doesn't conflate the two is ref_transaction_commit.  It
returns TRANSACTION_NAME_CONFLICT for a certain kind of recoverable
error and TRANSACTION_GENERIC_ERROR for all other errors.  In either
case, the 'err' parameter is populated with information intended for
the user.

Sometimes you might want to affect control flow without providing
information for the user.  Then there's no need for a string output
parameter and you can just provide the int.

At other times you might want to provide information for the user
without affecting control flow.  Then you can provide a string without
the int.

Providing error codes when you also want to return a string or struct
pointer is an unrelated problem.  One runs into that problem even if
only intending to provide a return code.  Possible approaches, like
mentioned before, are

 - an int * parameter to pass back the return code
 - using ERR_PTR to embed error codes in the pointer space

There is another approach which is sometimes nicer:

 - return int and pass the string or struct pointer through an output
   paramter

Thanks and sorry for the lack of clarity,
Jonathan
