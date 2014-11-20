From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Wed, 19 Nov 2014 19:24:53 -0800
Message-ID: <20141120032453.GH6527@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
 <546B2CE0.6020208@alum.mit.edu>
 <CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>
 <546BA21C.9030803@alum.mit.edu>
 <xmqqr3x0uu81.fsf@gitster.dls.corp.google.com>
 <546BB722.5020901@alum.mit.edu>
 <xmqqsihgtcyx.fsf@gitster.dls.corp.google.com>
 <CAGZ79kb3DOrL_txW-qxzd0=4sKrOiPTdSg-17_0+__wuj0TBaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 04:26:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrIOE-0005MF-LS
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 04:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005AbaKTDYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 22:24:51 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:60952 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbaKTDYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 22:24:50 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so1977790iec.16
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 19:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=g1YKLezl40WcoFJ4Niv9ls8jdP+7v7YMIB4JxmXlUu8=;
        b=05w7pSbgWAOlP7u6c1T2CsVVKlzoGfKgTx3z2d6TI1m6RSo90MIEo9576kok9LCbN/
         bnSe0DxgYX4LvvtLh01ZuA7hA53+rcbyWP/cCViM3Gur82mOwGzaLP4TBsZbZ7Znx2n2
         Y+X4cJq+lS0IjicXZBXJRQ5buCx0Yuo/wO2ICR8MeaYlMysK23oYqdO1MOwdJR18CgkC
         v5d+vo7bprWwfOzw8XN12crWlk8NrUVQpdconfAotcWAkafp4FI0tZVh009+QA7u5pP7
         Unsl8q2O/v0vdYYJtyTO7DykmB7cuYsqw2oqHYMVApzdXDIgTsSxWAqAnDBEEMUn2aJK
         S+7Q==
X-Received: by 10.50.61.232 with SMTP id t8mr7169802igr.20.1416453890158;
        Wed, 19 Nov 2014 19:24:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id d140sm625815ioe.38.2014.11.19.19.24.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 19:24:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kb3DOrL_txW-qxzd0=4sKrOiPTdSg-17_0+__wuj0TBaQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Sorry for the long delay.
> Thanks for the explanation and discussion.
>
> So do I understand it right, that you are not opposing
> the introduction of "everything should go through transactions"
> but rather the detail and abstraction level of the API?

For what it's worth, I don't personally think it makes sense to put
the options supported by 'git reflog expire' into the transaction API
as top-level functions.

Instead, I think it makes sense, to start off, to support the same
building block operations that are used in the current file-based
code.  That may mean having an API that can't express tricks that e.g.
an SQL-based backend would be able to optimize (removing some items
from a reflog without copying the rest, filtering based on conditions
that can be expressed in SQL such as date, etc) but I think it's fine
as a starting point.  Later we can add new operations, change existing
ones, and so on, based on experience with real backends.

The write operations for file-based reflog handling are simple:

	- create a new reflog with a single reflog entry

	- add an entry to an existing reflog

	- (optional) copy a reflog wholesale --- this can be
	  implemented in terms of "add an entry", but copying in
	  blocks (or making a reflink, on filesystems that support
	  that) can make this faster

	- remove a reflog

The reflog bookkeeping involved in renaming a ref can be implemented
as copy + delete.

I also have some thoughts about how those operations can be
implemented without such a performance hit (reading the whole reflog
into memory as part of the transaction seems problematic to me), but
that should probably wait for a separate message (and I've talked
about it a bit in person).

[...]
> 4. Configure a reference to be reflogged.
> 5. Configure a reference to not be reflogged anymore and delete any
>    existing reflog.
>
> Why do we need 4 and 5 here? Wouldn't all refs be reflog by default and
> why do I want to exclude some?

See --create-reflog in git-branch(1) and core.logallrefupdates in
git-config(1).

Reflogs are disabled by default in bare repositories, which makes it
easier for unnecessary objects on a server to be more promptly removed
by gcs after a non-fast-forward push.  I prefer to turn on reflogs
when setting up a git server for my personal use.  It might be worth
flipping that default (as an orthogonal change).

> 6. Selectively expire old reflog entries, e.g., based on their age.
>
> This is the maintenance operation, which you were talking about.
> In my vision, this also should go into one transaction. So you have the
> business logic figuring out all the changes ("drop reflog entry a b and d")
> and within one transaction we can perform all of the changes.

Makes sense.

Thanks,
Jonathan
