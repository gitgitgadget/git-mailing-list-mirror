From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 39/44] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Thu, 22 May 2014 10:44:27 -0700
Message-ID: <20140522174427.GP12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-40-git-send-email-sahlberg@google.com>
 <20140522014242.GO12314@google.com>
 <CAL=YDW=fqDFFMomX-GDyANsABz6E5zww+JKgD6V0A+mc6Ja96g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 19:44:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnX2h-000500-1b
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 19:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbaEVRob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 13:44:31 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:56363 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaEVRoa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 13:44:30 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so2810239pbb.31
        for <git@vger.kernel.org>; Thu, 22 May 2014 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HS8EOHEzTLb/Mkp4sHZ2tYzwIInVb5UU+M32H15e75I=;
        b=A5Nb9vHKM+BIQrNVS7L0AWWz3FayGJJllwL/I5dGzbejVFJ3o4F4LzFgadx6j2Dia+
         cLfCoBdp7i+/qIxYaIdrQaOUJVfKmmHN0+7+WIG3zi2X6P9veA+iwuZelukDNdPfs3zr
         022tgLBQ3zm5qBjuaQxSuWksm6vQb0j1lqpv3R8JVj5c5O+CPbiCPL0+sv90IBwgTm2k
         JJdOLHEwpDrGr1+bDcbZq3lolpT6ekZTtjk2E2f5hHjUz2HriClA308hY6zUGBFnPpQ6
         l3idpbmbrcKoeEd4joMG8OUUQ3e6Y+YiFSPRz38gkCWzk5CZGo5ULNA2KdTNfnQ9ANbQ
         uuqw==
X-Received: by 10.67.4.169 with SMTP id cf9mr68747783pad.45.1400780670428;
        Thu, 22 May 2014 10:44:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id it4sm643044pbc.39.2014.05.22.10.44.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 10:44:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDW=fqDFFMomX-GDyANsABz6E5zww+JKgD6V0A+mc6Ja96g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249921>

Ronnie Sahlberg wrote:
> On Wed, May 21, 2014 at 6:42 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>         $ git rev-parse HEAD >.git/refs/heads/foo..bar
>>         $ git branch -m foo..bar something-saner
>>         fatal: Invalid branch name: 'foo..bar'
>>
>> "git branch -m" has an explicit codepath ("recovery = 1;") to handle
>> this case, but it looks like it was not well tested and regressed in
>> v1.7.8-rc0~19^2~7 (resolve_ref(): verify that the input refname has
>> the right format, 2011-09-15).
>>
>> Is what the recovery codepath of branch -m does misguided?
[...]
> I don't think we should allow external caller any other way to
> access/modify refs than through
> the transaction api. This may make it awkward to handle cases such as
> foo/../bar was created  and how would you now delete it ?
>
> The exception to this I think would be 'git fsck'. We could allow fsck
> to have low level access to the backing store and allow it to access
> the files directly,
> or allow fsck to set magic flags that disable various checks.

Interesting.  Do you mean that 'git fsck' should notice invalid refnames
and have an option to repair them on its own?

That would be a big change from what git fsck currently does --- it's
currently read-only (except for "fsck --lost-found", which is read-only
except in the .git/lost-found/ directory).  If there's an option to
check refnames only and not have to wait for the full check of all
objects then I think it makes sense.

In the meantime, 'git branch -m' and 'git update-ref -d' (which were
the historical ways to do this kind of repair) are already broken, so
at least this patch doesn't seem to make anything worse. :/  (I
haven't checked all callers, though.)

Jonathan
