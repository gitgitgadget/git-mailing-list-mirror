From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Tue, 26 Jun 2012 23:32:15 +0100
Message-ID: <20120626223215.GB8336@beczulka>
References: <20120624220835.GA4762@beczulka>
 <7v4nq0hrjb.fsf@alter.siamese.dyndns.org>
 <20120625075726.GO3125@beczulka>
 <7vehp3gwbx.fsf@alter.siamese.dyndns.org>
 <20120626212108.GR3125@beczulka>
 <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:32:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjeJ8-0007tc-9a
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab2FZWcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 18:32:22 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55396 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab2FZWcV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 18:32:21 -0400
Received: by wgbdr13 with SMTP id dr13so378229wgb.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 15:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=P/LJCaMwcqLe0XNv7xcYJR3FEQQZ/uY6yfwX2JBg/Uo=;
        b=hnMypwOB9gXxduBBAjSn2SS+euuw/yXA3YM7/85hML9MCgMSpy1bH77e0KPnsa6xL/
         sbeuyA6IpureCyDzJMrrz+L/yacgfRpr41UkvkdrGyA7W8yxIrNVvI3xWvK3vF2TkyJO
         OnkgHIC77of4gchHxewGS1psAh50iRdzPz2J953JWXBvQHSjVhKqHR98lCJXVjv2TL9W
         W2RQgJFXqFuBvfPl4aZt5DKx/pheb/E5NUsleersswDrj61rwlgNTwQPBwzYgLTp0ijw
         zy/zQyQJ4VWkf5WAvcx9TaPbeS6+njwCh5qkVe0929j72d2sdPlTNjxI+lSvux+q7/fN
         Y+/A==
Received: by 10.180.81.65 with SMTP id y1mr36111254wix.1.1340749940534;
        Tue, 26 Jun 2012 15:32:20 -0700 (PDT)
Received: from beczulka ([89.100.125.149])
        by mx.google.com with ESMTPS id bc2sm12378295wib.0.2012.06.26.15.32.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jun 2012 15:32:19 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1SjeIx-00030I-SA; Tue, 26 Jun 2012 23:32:15 +0100
Content-Disposition: inline
In-Reply-To: <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQlDcLLEHvYWo/vwcJzS0REegh54Pp5VJewlDE+MRLE4X0p55WSOUgzMB5qtxjNJk/L0jefs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200693>

On Tue, Jun 26, 2012 at 03:03:07PM -0700, Junio C Hamano wrote:
> Marcin Owsiany <marcin@owsiany.pl> writes:
> 
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 0b074c4..2379a71 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1612,9 +1612,9 @@ sub post_fetch_checkout {
> >  		}
> >  	}
> >  
> > -	my $valid_head = verify_ref('HEAD^0');
> > +	return if verify_ref('HEAD^0');
> >  	command_noisy(qw(update-ref refs/heads/master), $gs->refname);
> 
> Given that your original motivation was "I do not want master, I am
> using something else for my primary branch", I change that still
> shows "update-ref refs/heads/master" smells like sweeping something
> under the rug

I'm not so sure... With this change, git-svn will only create master on
the initial "clone" and I think that's fine. It's consistent with what
"git clone" does when cloning a regular git repository.

It seems that I have slightly misinterpreted git-svn's actions in my
initial post in 2009. I thought it always updated "master" to the
most recent upstream commit. In reality it only every _creates_ it at
the most recent commit. But never fast-forwards it if it pre-exists.

This makes my idea to do the same to "my something else instead of
master" much less attractive. In fact I don't think such behaviour would
be useful.

I think with the suggested patch git-svn works as I would like it to:
 - creates "master" at initial checkout - consistent with git clone
 - using a different "tracking-like" branch is possible with "dcommit"
 - does not re-create "master" on fetch - so the annoying part is gone

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
