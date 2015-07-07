From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 1/7] refs.c: add err arguments to reflog functions
Date: Tue, 07 Jul 2015 18:41:22 -0400
Organization: Twitter
Message-ID: <1436308882.5521.15.camel@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	 <1435609076-8592-2-git-send-email-dturner@twopensource.com>
	 <559AA490.3080605@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 08 00:41:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCbYR-0000R3-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 00:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565AbbGGWl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 18:41:27 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35895 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932851AbbGGWlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 18:41:25 -0400
Received: by qgeg89 with SMTP id g89so91831314qge.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 15:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=5xegKLrJdL8alOFDAnPnN0r9LUsUHcveUhOYOu+xpl4=;
        b=llFYdo2Xgglc/aXNCh1vP062XgtBCicgxYSpwK3qBKZ3aBcT7NuW48RKvQGNPTH6Sc
         NHawQ2Nr5nEoURnvyK5JT1a6QpZMcrPaqJm7Q8ssZ7tKVtcu4ZY2YkV+O9LiZEe+FvpQ
         w+iPQf9KTnOmE8g5kmUpEugZs1WgcGjW7+xBIHGSRoYR5T4SyP5tQ5HPnnI3hUTABmkd
         iYzd5ur51xNT4frxVq3sJFOVfAE1VtB85PPXyAzPYHbJ3YfT5b9bRM8xImuePwo3ye8n
         CrY0oGQf68dTs7L/vRJvPF2gD/OT4koveARo1WXVR9APEA0YC924JS8KnvNjn1GMCCQC
         ie8w==
X-Gm-Message-State: ALoCoQkYVLa+XW1ukVr3YuLL29O+M90okyNRvW5oja0pfrNbRwbUY+MdtkXDSqLdC3nWBBeiS8mu
X-Received: by 10.55.19.25 with SMTP id d25mr10826492qkh.19.1436308884416;
        Tue, 07 Jul 2015 15:41:24 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id 87sm11972285qkv.22.2015.07.07.15.41.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2015 15:41:23 -0700 (PDT)
In-Reply-To: <559AA490.3080605@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273613>

On Mon, 2015-07-06 at 17:53 +0200, Michael Haggerty wrote:
> On 06/29/2015 10:17 PM, David Turner wrote:
> > Add an err argument to log_ref_setup that can explain the reason
> > for a failure. This then eliminates the need to manage errno through
> > this function since we can just add strerror(errno) to the err string
> > when meaningful. No callers relied on errno from this function for
> > anything else than the error message.
> > 
> > Also add err arguments to private functions write_ref_to_lockfile,
> > log_ref_write_1, commit_ref_update. This again eliminates the need to
> > manage errno in these functions.
> > 
> > Update of a patch by Ronnie Sahlberg.
> 
> First a general comment: we have a convention, not yet very well adhered
> to, that error messages should start with lower-case letters. I know
> that in many cases you are just carrying along pre-existing error
> messages that are capitalized. But at a minimum, please avoid adding new
> error messages that are capitalized. And if you are feeling ambitious,
> feel free to lower-case some existing ones :-)

I'll save lowercasing messages for other patches, but I'll try to take
care with new messages.

...

> Above, the call to close(logfd) could clobber errno. It would be better
> to exchange the calls.

Done, thanks.

> Since you are passing err into log_ref_write(), I assume that it would
> already have an error message written to it by the time you enter into
> this block. Yet in the block you append more text to it.
> 
> It seems to me that you either want to clear err and replace it with
> your own message, or create a new message that looks like
> 
>     Cannot update the ref '%s': %s
> 
> where the second "%s" is replaced with the error from log_ref_write().

Done, thanks.

> > @@ -3317,7 +3322,8 @@ static int commit_ref_update(struct ref_lock *lock,
> >  					      head_sha1, &head_flag);
> >  		if (head_ref && (head_flag & REF_ISSYMREF) &&
> >  		    !strcmp(head_ref, lock->ref_name))
> > -			log_ref_write("HEAD", lock->old_oid.hash, sha1, logmsg);
> > +			log_ref_write("HEAD", lock->old_oid.hash, sha1, logmsg,
> > +				      err);
> 
> Here you don't check for errors from log_ref_write(). So it might or
> might not have written something to err. If it has, is that error
> handled correctly?

That was the case before this patch too. But I guess I might as well
check.

> Previously, the error generated here was "cannot update the ref '%s'."
> But now that you are letting write_ref_to_lockfile() fill err, the error
> message will be something from that function. This might be OK or it
> might not. If you think it is, it would be worth a word or two of
> justification in the commit message.

Will adjust commit message.
