From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: gracefully handle symlinks to directories
Date: Tue, 27 Oct 2015 14:30:56 -0700
Message-ID: <20151027213056.GA6527@gmail.com>
References: <1445414673-15307-1-git-send-email-davvid@gmail.com>
 <xmqq8u6usqx1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:55:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrCD8-0004JD-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 22:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbbJ0Vyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 17:54:54 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35503 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414AbbJ0VbT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 17:31:19 -0400
Received: by pasz6 with SMTP id z6so233462119pas.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rLsKQbL3PRqNF/x0sicUcjTFKgkYl5HkVIffesxt9TE=;
        b=LV+VcL8dKWdjS7tgYG1AlMDxOVcUidWgRC+t6Ak3nDZ0FaAodiOwHzCbJdnFtPbYrg
         sQLNrSO0B1wS6F9HudsDdLbFeXoeEbmQjYP3zbl7RgirPk/FLV99MnEtSUjH02hHTMDn
         sgAoQpO8JFMBqOkNPKNj8PHpERYqtjzQQX7DTBhjefb7qsuC487dd2O440mguBs8Qs1+
         qTcJQCEv/CINcoyLQvuxZD62vK4d1chud+3gWkKuLitVbZh/At29UKW1Qjs/AHYuDBgJ
         2zx3Lw+w8rykACOfXxD/8fvkkRvmgeYrJROhKsh6RLd6PFjP0Jd05A8Ar4moBLghOzHx
         YXXg==
X-Received: by 10.66.220.2 with SMTP id ps2mr29589148pac.145.1445981478569;
        Tue, 27 Oct 2015 14:31:18 -0700 (PDT)
Received: from gmail.com (cpe-45-48-246-9.socal.res.rr.com. [45.48.246.9])
        by smtp.gmail.com with ESMTPSA id yq2sm41339847pbb.39.2015.10.27.14.31.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2015 14:31:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq8u6usqx1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280306>

On Thu, Oct 22, 2015 at 11:23:54AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > difftool's dir-diff feature was blindly feeding worktree paths
> > to hash-object without checking whether the path was indeed a
> > file, causing the feature to fail when repositories contain
> > symlinks to directories.
> 
> Wait.  Anything that considers symlinks "to directories" any special
> smells like a misdesign here.  Why is it safe to substitute a
> symbolic link that happens to point at a file with the file it
> points at?
> 
> Because the way you would hash a symblic link is not by hashing the
> file it points at, but by hashing the result of readlink(2) of it,
> we must not reuse the working tree files for any symbolic link,
> regardless of its target, I would think.
> 
> After all, a symbolic link may even be dangling and not pointing at
> anything.

Ah, right.  I think the simplest thing to do is to tighten
use_wt_file() so that it always rejects symlinks.  That seems
like a safe way to go for now without needing to invent a new
paradigm for how to handle symlinks in the dir-diff code.

I just sent a follow-up patch that does just that.  Let me know
if you'd like a replacement patch that combines the two patches
instead.

Thanks for the review,
-- 
David
