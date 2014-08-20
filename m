From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Wed, 20 Aug 2014 10:49:14 -0700
Message-ID: <20140820174914.GE20185@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
 <1403275409-28173-44-git-send-email-sahlberg@google.com>
 <53BC07FC.8080601@alum.mit.edu>
 <20140715180424.GJ12427@google.com>
 <CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>
 <CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>
 <53F4B642.7020002@alum.mit.edu>
 <CAL=YDW=zmqwjLzjWYLGCjwb_aQTofTJ-CrmPgoq3KKJjfHR3XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:49:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKA0k-00043M-0A
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 19:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbaHTRtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 13:49:20 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36228 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbaHTRtT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 13:49:19 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so12353427pde.24
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nUsWvhNppUzkED1dVc78Ivp8yispNH57eIgf5T7I01Q=;
        b=Wb1b7ox8ecOuGKMOBeDTinXe0DX4gI+e+8zVv0rD3DgaAucD/rjYtWYareuqrxBF2H
         DnzoiH44RlOdVsNEimixIaKUnMVPSiPSTJN/zna7QLdg30otr/5j1D+1HaeF6U3bQufB
         U+/OjvElvvpdowXmhoos0sGMHero8mCpmX0Hj/PruhSHZ9S8h6E5rQ+IhIDa39SRqmCa
         +LqgB8lz0TcBwZ4MotYWfNhE8mqOX2iUvHnP7nCwSmKKHko4Vcwa03EaNsqxYu9NOjcb
         QRHaoFb61L4e3uoW7F8dbIlGzdom/VY85G6jzUYKdOQPVGRoT1uGlLbKbTWJ/kirxqX1
         NG4A==
X-Received: by 10.70.137.37 with SMTP id qf5mr61628906pdb.56.1408556959170;
        Wed, 20 Aug 2014 10:49:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:2490:21da:8eb0:dc73])
        by mx.google.com with ESMTPSA id ct1sm34984369pdb.59.2014.08.20.10.49.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 10:49:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDW=zmqwjLzjWYLGCjwb_aQTofTJ-CrmPgoq3KKJjfHR3XQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255576>

Hi,

Ronnie Sahlberg wrote:
> On Wed, Aug 20, 2014 at 7:52 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

>> I'm a little worried that abandoning *all* refname checks could open us
>> up to somehow trying to delete a "reference" with a name like
>> "../../../../etc/passwd".  Either such names have to be prohibited
>> somehow, or we have to be very sure that they can only come from trusted
>> sources.
>
> I only set this flag from builtin/branch.c so it should only be used
> when a user runs 'git branch -D' from the command line.
> All other places where we delete branches we should still be checking
> the rename for badness.

Right, this should be safe for 'git branch -D' and 'git update-ref -d'.

But if we wanted to open it up in the future for 'git push --delete',
too, then it would be a way to break out of the repository on hosts where
people use git-shell instead of relying on filesystem permissions.  And
that wouldn't be good.

I think elsewhere git has some checks for "does this pathname fall in
this directory".  Could that be reused here, too, to make sure the
resolved path is under the resolved $GIT_DIR/refs directory?

Alternatively, when a ref being deleted doesn't meet the
'check-ref-format' checks, would it make sense to check that it is one
of the refs you can get by iteration?

Jonathan
