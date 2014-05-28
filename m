From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 25/41] fast-import.c: use a ref transaction when
 dumping tags
Date: Wed, 28 May 2014 16:39:40 -0700
Message-ID: <20140528233940.GC12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-26-git-send-email-sahlberg@google.com>
 <20140528194746.GX12314@google.com>
 <CAL=YDWkUhdoJkdg_zaq+p=XRu7H9fqNXDz89uPhbr4equTyVLQ@mail.gmail.com>
 <20140528221720.GB12314@google.com>
 <CAL=YDW=ruMzd=twadncjgFTh3yv=796cN72amJ4ep8a41tgmrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 29 01:39:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpnRk-0002pd-6t
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 01:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbaE1Xjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 19:39:44 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:47946 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbaE1Xjn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 19:39:43 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so11977492pbb.17
        for <git@vger.kernel.org>; Wed, 28 May 2014 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9R0A9cWGF0nupwxnSArGHb1SLEzRWQvhbrwyf0uDnJg=;
        b=0jlXidJ/87Dar3LfQJUBJGqLssIc7FhXOtwGevgvEdr9dNV3w3rjje14zhgU6Ymh7I
         wptJoAD2A1o2OqtFHarRdOBSzkUkh6If2PhoglHRO1gqFe7zYVvcR8GOSPM8jiLWRFvd
         i0onWQW5CQ6s84qpf8SeJoh0s5x5f0nTGyygVRAz/jD1ujtDfQuOAqoXtMIS9A5mvc20
         ApfKT24f2QE6LOfoutXL/753cn31nWS6PQPrmqCOUJDQ5x2s9fklRyXwIWbW98C3WUzU
         +mSSk+tp9uePnApy/44c40dAYHout7LK5xtGOiyGAti3vplzKYTWgxny8GZR9+hroqd/
         hcMA==
X-Received: by 10.68.225.105 with SMTP id rj9mr3833854pbc.108.1401320383383;
        Wed, 28 May 2014 16:39:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sm8sm30197746pbc.92.2014.05.28.16.39.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 16:39:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDW=ruMzd=twadncjgFTh3yv=796cN72amJ4ep8a41tgmrA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250345>

Ronnie Sahlberg wrote:

> I rely on the fact that if the transaction has failed then it is safe
> to call ref_transaction_commit since it is guaranteed to return an
> error too.

Yes, I am saying that behavior for ref_transaction_commit is weird.

Usually when ref_transaction_commit is called I can do

	struct strbuf err = STRBUF_INIT;
	if (ref_transaction_commit(..., &err))
		die("%s", err.buf);

and I know that since ref_transaction_commit has returned a nonzero
result, err.buf is populated with a sensible message that will
describe what went wrong.

That's true even if there's a bug elsewhere in code I didn't write
(e.g., someone forgot to check the return value from
ref_transaction_update).

But the guarantee you are describing removes that property.  It
creates a case where ref_transaction_commit can return nonzero without
updating err.  So I get the following message:

	fatal:

I don't think that's a good outcome.

Sure, if I am well acquainted with the API, I can make sure to use the
same strbuf for all transaction API calls.  But that would result in
strange behavior, too: if multiple _update calls fail, then I get
concatenated messages.

Okay, I can make sure to do at most one failing _update, before
calling _commit and printing the error.  But at that point, what is
the advantage over normal exception handling, where the error gets
handled at the _update call site?

Jonathan
