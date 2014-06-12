From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Thu, 12 Jun 2014 19:30:35 -0400
Organization: Twitter
Message-ID: <1402615835.5629.34.camel@stross>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	 <xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 01:30:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvESD-0003e8-1u
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 01:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbaFLXal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 19:30:41 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:44248 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbaFLXaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 19:30:39 -0400
Received: by mail-qc0-f180.google.com with SMTP id i17so3123997qcy.25
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 16:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=Wzn9grFw7H9PC7onwzkThZmrfeXzNX6/cJVrmc+YRqA=;
        b=iVEZZP/4CM4B4L6O+t7SW0JIk+habq8o6klEZp+6UkS4E6VWHtrefVLOt4tInfkTos
         KeUrkH/+JRSywp2xpVUAd/+AYgQUx5qx0n9/Vh3KkFrK0xYzRzwSCCXVw4252pjUjd6l
         2KHM4M9MRPUA7R7aRduRHvW622WRbmdGhnN6wi9AK3gbpr8B+eKrk4+731hkaDg+fpDg
         0xRzTOhl0aaxoljzZl+Sy11PPdiSFb5qMBwQkO9fC4ATaJvMnBfqRSPGVgUAWLeIKyoI
         I8PfXey9NpGE4OhcJJ9rNaFTVuUluFrWDrlDazXI8b+hDq0BwRc5hQqlt9UvA+/tOUvL
         aO1A==
X-Gm-Message-State: ALoCoQkM6jBEgCgHbOfxmfamNe9L0VsRpxE43rbU1hnbjOtLD3TEyJeTkPc8UrtJtDrZV6Q8M/Uw
X-Received: by 10.224.14.79 with SMTP id f15mr37775008qaa.96.1402615838308;
        Thu, 12 Jun 2014 16:30:38 -0700 (PDT)
Received: from [172.18.24.43] ([8.25.196.26])
        by mx.google.com with ESMTPSA id 73sm66784qgw.5.2014.06.12.16.30.36
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 12 Jun 2014 16:30:37 -0700 (PDT)
In-Reply-To: <xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251505>

On Thu, 2014-06-12 at 12:47 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > This issue bit us again recently.
> >
> > In talking with some colleagues, I realized that the previous version
> > of this patch, in addition to being potentially slow, was incomplete.
> > Specifically, it didn't handle the case of refs/heads/case/one vs
> > refs/heads/CASE/two; these are case clones even though they strcasecmp
> > different.
> 
> Good catch to realize that two refs that share leading paths that
> are the same except for cases are also problematic, but that makes
> this feature even less about "case clones", doesn't it?

I agree: word "clone" is less good now.  Maybe "case conflicts"?

> Also it somehow feels that the patch attempts to solve the issue at
> a wrong level.  On a platform that cannot represent two refs like
> these (e.g. trying to create "FOO" when "foo" already exists, or
> trying to create "a/c" when "A/b" already exists---ending up with
> "A/c" instead, which is not what the user wanted to create), would
> it be more sensible to fail the ref creation without touching the
> users of ref API such as receive-pack?  That way, you would also
> catch other uses of refs that are not supported on your system,
> e.g. "git branch a/c" when there already is a branch called "A/b",
> no?

So we would change is_refname_available?  And to do this, we would
change the ref_dir functions to take case into account?

This might be somewhat complicated because we could be starting from a
repo which already has case conflicts.  What should we do about that?  I
think this is even possible on a case-insensitive filesystem with
packed-refs, although I have not checked.  The simplest idea is probably
to pretend that the first conflicting refname component we find is the
one true one, and reject new refs containing versions which are case
conflicting with this one until the user cleans up their repo.  In other
words, if the user has A/b and a/c already, and we find A/b first, then
we reject a/d but allow A/d.   This is arbitrary, but workable.  We
could warn about this situation when we load up the refs, too.  

Does this match what you are suggesting? 

If so, I think it is possible, and if I don't hear anything back from
the other ref folks, I'll see if I have time to implement it.
