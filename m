From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 13
Date: Tue, 17 Jul 2012 10:21:30 +0200
Message-ID: <20120717082130.GB1849@tgummerer.surfnet.iacbox>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox>
 <7vwr23zb65.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 10:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr32N-00076V-Gm
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 10:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab2GQIVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 04:21:36 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:58154 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab2GQIVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 04:21:33 -0400
Received: by wgbfm10 with SMTP id fm10so3048634wgb.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9q6WJ/v0WA/Yln3J3gXwNqr6Xvz5+vjWLOM8gCyEusM=;
        b=Lyian77RwxEs5YIUJBG0Xs0HM6l7fGHg3huc27dUHe0fFP4oh0/+tfAEzfMrMzE4d2
         //128TgoRKcYGX9lVCAxRFNlXg525hBaSRLa7FLYv2DjTl0GdSrNPy3qLQFw3xtHJTZO
         cSsyMbXhwYzrciqr551UmVx2b6fzzGIK01IJj4pwqNdvpcResdYQjHVzUta/X65ngdTZ
         lKw/gfprkHkqpjAJEgvpLvZSFq/mQR4mijYvyVuIqg1XOvaTTkxDbmkP5dkWH/JRhv7m
         2sBGRmhXzHVfb9ZwOCv8T0tPIUERvVdj2nO1a6aurM+uPr2j4DpvKF6SDNHiDTVchCJo
         6uOw==
Received: by 10.180.98.69 with SMTP id eg5mr2131279wib.3.1342513292467;
        Tue, 17 Jul 2012 01:21:32 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id fb20sm38309058wid.1.2012.07.17.01.21.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 01:21:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwr23zb65.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201592>



On 07/16, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > == Work done in the previous 12 weeks ==
> >
> > - Definition of a tentative index file v5 format [1]. This differs
> >   from the proposal in making it possible to bisect the directory
> >   entries and file entries, to do a binary search. The exact bits
> >   for each section were also defined. To further compress the index,
> >   along with prefix compression, the stat data is hashed, since
> >   it's only used for comparison, but the plain data is never used.
> 
> s/comparison/equality comparison/ perhaps?
> 

Exactly, thanks.

> >   Thanks to Michael Haggerty, Nguyen Thai Ngoc Duy, Thomas Rast
> >   and Robin Rosenberg for feedback.
> 
> > - Read the index format format and translate it to the current in
> 
> s/format format/on-disk file format/ or something?
>

Yes, thanks.

> >   memory format. This doesn't include reading any of the current
> >   extensions, which are now part of the main index. The code again
> >   is on github. [4] Thanks for reviewing the first steps to Thomas
> >   Rast.
> 
> > - Started implementing the writer, which extracts the directories from
> >   the in-memory format, and writes the header and the directories to
> >   disk.
> > - I found a few bugs in the algorithm for extracting the directories
> >   and decided to completely rewrite it, using a hash table instead of
> >   simple lists, since the old one would have to many corner cases to
> >   handle.
> 
> What does "the algorithm" refer to?  Is it the one described in the
> previous bullet point, or is it the code in production?  If latter,
> it would help to separate out the task to fix the breakage, as
> people with the current or previous versions of Git will be
> negatively affected until that bug is fixed.  If former, I am not
> sure if this task needs to be described in two bullet points ("I did
> X, X had bug so I redid X in a different way" is still a single task
> to do X).

It refers to the algorithm in the previous bullet point, which
extracts the directories, and can be included in the above bullet
point. Sorry for the confusion.

> > == Work done int the last week ==
> >
> > - Polished the patch for the ce_namelen field. The thread for the
> >   patch can be found at [5].
> 
> Thanks for this one; I think it is ready for 'next', but if you are
> still not satisfied I do not mind waiting for further perfection.

Thanks, I'm satisfied with it, for me it can be merged to 'next'.
