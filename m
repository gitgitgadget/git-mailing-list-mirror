From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: avoid symlinks when reusing worktree files
Date: Wed, 28 Oct 2015 18:55:39 -0700
Message-ID: <20151029015539.GA12513@gmail.com>
References: <1445981088-6285-1-git-send-email-davvid@gmail.com>
 <xmqq1tcgne4u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 02:55:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrcRP-0002Ap-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 02:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbbJ2Bzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 21:55:43 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35392 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbJ2Bzm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 21:55:42 -0400
Received: by pasz6 with SMTP id z6so23925835pas.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cmJjYehZCx8yp2aBxFWm2QMSu/dut/HztArdzJpzAmw=;
        b=Xh8eed0uMQ5RdQ03JV0onSvql9nDpc7UUumVEdCKWIUyciQP7sWH9Ygaw41JjQXRGl
         PPfZHFdXzopA26bRZRETUsNf2l6sJKiilruaTCujnbCeqPeuPn0IH/8Hsu/Usb+e53So
         nNPdhqZ3gOC0rc85esLuq+icCAJJrx+cmB/xwhwlao+WzuYMn7WnDSsRemcgeh35nOkN
         hNnHhLIdWXZMAQL8qmD1hm4gS4k24yhWpqDL5UAZJOARfavEZ0tP855O8zWDxFuN1NK+
         0IFkWaUU6S0NxekgMf2ErMMiHcwwaKOMPQQVp66QENFJeSIk6DOvESP43qYnBK1emaiS
         NsvQ==
X-Received: by 10.66.164.161 with SMTP id yr1mr37335105pab.62.1446083742162;
        Wed, 28 Oct 2015 18:55:42 -0700 (PDT)
Received: from gmail.com (w.disneyanimation.com. [198.187.190.241])
        by smtp.gmail.com with ESMTPSA id ce3sm47774159pbb.35.2015.10.28.18.55.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2015 18:55:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq1tcgne4u.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280432>

On Tue, Oct 27, 2015 at 03:24:49PM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > difftool's dir-diff should never reuse a symlink, regardless of
> > what it points to.  Tighten use_wt_file() so that it rejects all
> > symlinks.
> >
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> 
> Sorry.  I do recall saying "it is wrong to feed the contents of a
> file that a symlink points at to hash-object" but other than that,
> I completely lost track.
> 
> What purpose does this function play in its callchain?  What does
> its caller wants it to compute?  Is use of the entity in the working
> tree completely optional?  Would the caller happily produce correct
> result even if we changed this function to unconditionally return
> ($use=0, $wt_sha1='0'x40) regardless of the result of lstat(2) on
> "$workdir/$file"?
> 
> The conclusion of the thought process that starts from "it is wrong
> to feed the contents of a file that a symlink points at to
> hash-object" may not be "so let's return $use=0 for all symlinks",
> which is this patch. Depending on what its caller wants it to
> compute, the right conclusion may be "we need to call hash-object
> correctly by first running readlink and then feeding the result to
> it".
> 
> And if the answer is "the caller wants us to compute the hash for a
> symbolic link and say $use=1", then we would instead need to do
> an equivalent of
> 
> 	wt_sha1=$(readlink "$workdir/$file" | hash-object --stdin)
> 
> I cannot quite tell which from the patch and explanation.
> 
> Perhaps an additional test or two would help illustrate what issues
> are being addressed better?
> 
> Thanks.

Right.  At first I thought I could revise the commit message to
make it clearer that we simply want to skip all symlinks, since
it never makes sense to reuse a worktree symlinks, but looking
at the tests and implementation makes me realize that it's not
that simple.

This is going to take a bit more time to get right.  John, I was
hoping you'd be able to take a look -- I'm playing catch-up too.
When it was first reported I let it sit for a while in hopes
that the original author would pickup the issue, but months
passed and I figured I'd take a stab at helping the user out.

Anyways, it'll take me a bit more time to understand the code
and work out a sensible solution.  My gut feeling is that we
should adjust the dir-diff feature so that it ignores all
symlinks.  That seems like a simple answer since we're deciding
to skip that chunk of complexity.

John, do you have any thoughts on how we can best handle this?
-- 
David
