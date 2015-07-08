From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and
 REVERT_HEAD as refs
Date: Wed, 08 Jul 2015 15:16:02 -0400
Organization: Twitter
Message-ID: <1436382962.4542.8.camel@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	 <1436316963-25520-2-git-send-email-dturner@twopensource.com>
	 <559D6208.8090607@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 21:16:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCupH-0006ZH-7X
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 21:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbbGHTQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 15:16:07 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35871 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693AbbGHTQF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 15:16:05 -0400
Received: by qkei195 with SMTP id i195so170456295qke.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 12:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=WK14SJ3KVY85X0Zi+EaEK6FwXQStqG2nKH0RwijBDOA=;
        b=AMas+LDqX1Yh2pv5lbXGOsy6nONOAZBP70SjBVpupve9slg6pVaUb4Ukmvygg/nvC0
         nrnVMg3iZR8coM1Gu5vFKkdGOzBTKk/QMbsUa2jcvDnFhehqBfkg1LJ+69X2UZGdMfNK
         YDFSV94a13DqbBCgIUPKxc56wCidko9eAuHPfnzjSeYyEDd7WL/VRCr8FBTNUNbdBZkG
         jmCVmQfGg4JhOiIKjgwcngW2OQJYzLXIl2z5AjbT0zkqJ9CUOejw3wGbhbUMLmGf8WOc
         9GuucSIsep89AY5nBHAaXqjRmK21adezUuCDs+BvkMi33Lv59X/4Y9lU5M0WxgG+gx3a
         QaZQ==
X-Gm-Message-State: ALoCoQmih44rSSJLsXyoRpl4psHlzxLHY2oGd6E+MiWRsm7fCW8K0aIEq2JTRZiRChC1SluI/EG2
X-Received: by 10.140.21.138 with SMTP id 10mr18562293qgl.47.1436382964751;
        Wed, 08 Jul 2015 12:16:04 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 16sm1287453qkt.27.2015.07.08.12.16.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 12:16:03 -0700 (PDT)
In-Reply-To: <559D6208.8090607@kdbg.org>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273702>

On Wed, 2015-07-08 at 19:46 +0200, Johannes Sixt wrote:
> Am 08.07.2015 um 02:55 schrieb David Turner:
> > Instead of directly writing to and reading from files in
> > $GIT_DIR, use ref API to interact with CHERRY_PICK_HEAD
> > and REVERT_HEAD.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> ...
> > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> > index 366f0bc..e2c5583 100644
> > --- a/contrib/completion/git-prompt.sh
> > +++ b/contrib/completion/git-prompt.sh
> > @@ -415,9 +415,9 @@ __git_ps1 ()
> >   			fi
> >   		elif [ -f "$g/MERGE_HEAD" ]; then
> >   			r="|MERGING"
> > -		elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
> > +		elif git rev-parse --quiet --verify "CHERRY_PICK_HEAD" >/dev/null; then
> >   			r="|CHERRY-PICKING"
> > -		elif [ -f "$g/REVERT_HEAD" ]; then
> > +		elif git rev-parse --quiet --verify "REVERT_HEAD" >/dev/null; then
> >   			r="|REVERTING"
> >   		elif [ -f "$g/BISECT_LOG" ]; then
> >   			r="|BISECTING"
> 
> We are trying very hard not to spawn any new processes in __git_ps1(). 
> So, I raise a moderate veto against this hunk.

Do you have an alternate suggestion about how to accomplish the same
thing? Here are my ideas:

We could special-case CHERRY_PICK_HEAD and REVERT_HEAD to be files
independent of the ref backend, but that tends to complicate the
backends.  I think this is a mistake.

We could reduce the number from two to one by providing a new
git-am-status command which outputs one of "CHERRY-PICKING",
"REVERTING", or "" (or maybe it would also handle rebase and am).  We
could also generalize it to "git-prompt-helper" or something by moving
that entire bunch of if statements inside.  This would replace calls to
"git describe".

But you probably have a better idea.
