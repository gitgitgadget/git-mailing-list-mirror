From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: Re: [PATCH] use lockfile.c routines in git_commit_set_multivar()
Date: Thu, 26 Jul 2007 14:48:49 -0400
Message-ID: <f158199e0707261148r29419a39h7d83fc7bd0ea7df1@mail.gmail.com>
References: <11854689283208-git-send-email-bradford.carl.smith@gmail.com>
	 <Pine.LNX.4.64.0707261926590.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE8OM-000099-RJ
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 20:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbXGZSsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 14:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761236AbXGZSsw
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 14:48:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:51943 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759835AbXGZSsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 14:48:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so581851ugf
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 11:48:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jkj29kksTGJmLeM63EDrXCa41TsWJzLMmt3TklM7++LKVCZlO7YEv9c0McO8xJXAQOp8LpdCQWo+PVE/Xfa8k0XcEYDDxF9QaO1fSyTBL5jF1AxpZdfCYdCqCWy7DblDzx1w/0T8yQBBvKj91dhirdcDPFrasP4jHmahAkp20CA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N7+lCvo4nKSCkpulLGF37N1rL0J49I6gf+BkUCyGVfsnEBpOd1kOgXRMWb6icjdpPUobHgTF66zb6JrQ5mHmGQSqy1h1fkOvgEJc6RBM36s3d+xDS6+TwzvQpizvXDIAJjYX0/2MvsexwPAIVtUQ51mEaMqNt0k2TFg+/Np5uwY=
Received: by 10.82.175.17 with SMTP id x17mr1836798bue.1185475729819;
        Thu, 26 Jul 2007 11:48:49 -0700 (PDT)
Received: by 10.82.191.19 with HTTP; Thu, 26 Jul 2007 11:48:49 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707261926590.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53857>

On 7/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 26 Jul 2007, Bradford C. Smith wrote:
>
> > +     /* fd is closed, so don't try to close it below. */
> > +     fd = -1;
> > +     /*
> > +      * lock is committed, so don't try to roll it back below.
> > +      * NOTE: Since lockfile.c keeps a linked list of all created
> > +      * lock_file structures, it isn't safe to free(lock).  It's
> > +      * better to just leave it hanging around.
> > +      */
> > +     lock = NULL;
> >       ret = 0;
> >
> >  out_free:
> >       if (0 <= fd)
> >               close(fd);
> > +     if (lock)
> > +             rollback_lock_file(lock);
>
> Wouldn't it be better to put the rollback_lock_file() into the if clause
> when commit failed?

Actually no.  There are multiple goto statements that lead to
out_free.  It isn't even needed at the point that the commit failed,
because commit_lock_file() sets the lock file name to "" even when it
fails.

> Besides, I think you can safely call rollback_lock_file(lock) on a
> committed lock_file, since the name will be set to "" by the latter, which
> is checked by the former.

Quite right.  I really just put in the comment and 'lock= NULL' line
to increase readability.  I wanted to make it very clear to the reader
that the commit wouldn't be undone by the rollback.

> But I am fine with the patch as is (have not tested it, though).

Thanks!

FWIW, I have successfully run 'make test' and also verified that it
behaves as I expect with my ~/.gitconfig symlink (in conjunction with
the my other patch for resolving symlinks).

Best Regards,

Bradford
