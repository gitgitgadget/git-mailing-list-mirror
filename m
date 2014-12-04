From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 00/13] the refs-transactions-reflog series
Date: Thu, 4 Dec 2014 10:14:04 -0800
Message-ID: <20141204181404.GD9992@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
 <54809577.4080302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, ronniesahlberg@gmail.com,
	gitster@pobox.com, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:14:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwaur-00066U-DW
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 19:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbaLDSOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 13:14:09 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:53262 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455AbaLDSOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 13:14:07 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so16451041ieb.3
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 10:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZnGbYFZohsaasOCVuxlSVb32mx1FA5DHBRcwBbQhaNc=;
        b=uxqd+W2S8UaK80BTplSOvKG/kgeX+zbYbCmV2vDAt/yEZLoUCCqMoYl5+txt/JJ3CL
         GYxBnCqh1n/XYyBdR8ISTyqprMfmIQS7JnDQqHLq0I6pBbbPwnz9MuMpeDA0+ZypQZLb
         w6lj8ZJX2neBl8t6yY2dH6ZQq1nT4NaynFgZnwaiEQJYY5TmXyNHG1c/32rjtnEXCrhd
         a+JmUhaGyGInvGw+oS4/TqCbGMxPpwkZPYXpdXO/7Lwp5ewYqFFXqA3oRJ04cZ6hPqCp
         mjwbulg7o1OBq2wMFIjSx+1oMP0ynIr3VcFGcs/vfX7rSNLz+fnYORW0FOEd65/wAqfJ
         ICpA==
X-Received: by 10.43.137.131 with SMTP id io3mr12396234icc.69.1417716847315;
        Thu, 04 Dec 2014 10:14:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c1ad:3fe5:3da3:c161])
        by mx.google.com with ESMTPSA id fk8sm20666173igb.9.2014.12.04.10.14.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 10:14:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54809577.4080302@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260775>

Michael Haggerty wrote:

> I am still unhappy with the approach of this series, for the reasons
> that I explained earlier [1]. In short, I think that the abstraction
> level is wrong. In my opinion, consumers of the refs API should barely
> even have to *know* about reflogs, let alone implement reflog expiration
> themselves.

Okay, now returning to the substance of this comment.  This is
revisiting themes from [3], so my opinions are probably not a
surprise.

I think that the API changes that you and Stefan are proposing are
consistent and could both go in.

You suggested refactoring expire_reflogs() to use a callback that
decides what to expire.  Then it doesn't have to care that the
expiration happens by creating a new reflog and copying over the
reflog entries that are not being expired.  The result is a clean
reflog expiration API.

The ref-transaction-reflog series allows those low-level steps to be
part of a ref transaction.  Any ref backend (the current files-based
backend or a future other one) would get a chance to reimplement those
low-level steps, which are part of what happens during ref updates and
reflog deletion.  The goal is for all reflog updates to use the
transaction API, so that new ref/reflog backends only need to
implement the transaction functions.

So *both* are making good changes, with different goals.

The implementation of the reflog expiration API can use the ref
transaction API.

> Of course, reflog expiration *should* be done atomically. But that is
> the business of the refs module; callers shouldn't have to do all the
> complicated work of building the transaction themselves.

I don't understand this comment.  After the ref-transaction-reflog
series, a transaction_update_ref() call still takes care of the
corresponding reflog update without the caller having to worry about
it.

Thanks for looking it over,
Jonathan

> [1] http://thread.gmane.org/gmane.comp.version-control.git/259712/focus=259770
[3] http://thread.gmane.org/gmane.comp.version-control.git/259939/focus=259967
