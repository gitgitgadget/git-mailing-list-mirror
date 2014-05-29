From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 25/41] fast-import.c: use a ref transaction when
 dumping tags
Date: Thu, 29 May 2014 10:41:06 -0700
Message-ID: <20140529174106.GE12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-26-git-send-email-sahlberg@google.com>
 <20140528194746.GX12314@google.com>
 <CAL=YDWkUhdoJkdg_zaq+p=XRu7H9fqNXDz89uPhbr4equTyVLQ@mail.gmail.com>
 <20140528221720.GB12314@google.com>
 <CAL=YDW=ruMzd=twadncjgFTh3yv=796cN72amJ4ep8a41tgmrA@mail.gmail.com>
 <20140528233940.GC12314@google.com>
 <CAL=YDW=WmNObkTO_uybTToeMKGGQf5NC0oFvy_pMrsg+ehpzog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 29 19:41:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq4KK-000144-79
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 19:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbaE2RlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 13:41:11 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:48869 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932640AbaE2RlK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 13:41:10 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so725828pab.3
        for <git@vger.kernel.org>; Thu, 29 May 2014 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DwDql8Fm5a8ijOC0RL9+dutiN/FNLfw35dkZVocRsus=;
        b=p1ag6cgqmEqZ/q+pbx+nmwIT6QhqPKnYodoZEhQtbpvxWb7y47zOmdpr0f+z8YmbyB
         8dxCTdmGE7X+Vn5ILIgrLzUfeVAdhHV9pEJBzZ9bl7PwFFvSmACVAFhcdmAtq+iYd+gU
         6vGTmDMExxoJ5778a0sGAXcH/CltGBKWRS4h/uU/zv6i8+98pqM0oCNG03910EU+4Cxt
         knQb8MmS1Hi3DUL9fkvqShAMHbJKknE0CQ5ahSuQ34pMJJS91K04LB3zxivI89eQ3ieh
         iGuZXygQ5s9f2JkCaPNUsMFTuEcb0Ix7+W4cgAiTDBx611RUEuBWdiMhTlIgGqwTwDRj
         H5hQ==
X-Received: by 10.66.242.204 with SMTP id ws12mr11005726pac.10.1401385269658;
        Thu, 29 May 2014 10:41:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iz2sm2198163pbb.95.2014.05.29.10.41.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 May 2014 10:41:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDW=WmNObkTO_uybTToeMKGGQf5NC0oFvy_pMrsg+ehpzog@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250394>

Ronnie Sahlberg wrote:
> On Wed, May 28, 2014 at 4:39 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Usually when ref_transaction_commit is called I can do
>>
>>         struct strbuf err = STRBUF_INIT;
>>         if (ref_transaction_commit(..., &err))
>>                 die("%s", err.buf);
>>
>> and I know that since ref_transaction_commit has returned a nonzero
>> result, err.buf is populated with a sensible message that will
>> describe what went wrong.
[...]
>> But the guarantee you are describing removes that property.  It
>> creates a case where ref_transaction_commit can return nonzero without
>> updating err.  So I get the following message:
>>
>>         fatal:
>>
>> I don't think that's a good outcome.
>
> In this case "fatal:" can not happen.
> This is no more subtle than most of the git core.
>
> I have changed this function to explicitly abort on _update failing
> but I think this is making the api too restrictive.

I don't want to push you toward making a change you think is wrong.  I
certainly don't own the codebase, and there are lots of other people
(e.g., Michael, Junio, Jeff) to get advice from.  So I guess I should
try to address this.

I'm not quite sure what you mean by too restrictive.

 a. Having API constraints that aren't enforced by the function makes
    using the API too fussy.

    I agree with that.  That was something I liked about keeping track
    of the OPEN/CLOSED state of a transaction, which would let
    functions like _commit die() if someone is misusing the API so the
    problem gets detected early.

 b. Having to check the return value from _update() is too fussy.
 
    It certainly seems *possible* to have an API that doesn't require
    checking the return value, while still avoiding the usability
    problem I described in the quoted message above.  For example:

     * _update() returns void and has no strbuf parameter
     * error handling happens by checking the error from _commit()

    That would score well on the scale described at
    http://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html

    An API where checking the return value is optional would be
    doable, too.  For example:

     * _update() returns int and has a strbuf parameter
     * if the strbuf parameter is NULL, the caller is expected to
       wait for _commit() to check for errors, and a relevant
       message will be passed back then
     * if the strbuf parameter is non-NULL, then calling _commit()
       after an error is an API violation

I don't understand the comment about no more subtle than most of git.
Are you talking about the errno action at a distance you found in some
functions?  I thought we agreed that those were mistakes that accrue
when people aim for a quick fix without thinking about maintainability
and something git should have less of.

Jonathan
