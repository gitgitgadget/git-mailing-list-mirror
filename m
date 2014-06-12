From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 16:46:37 -0700
Message-ID: <20140612234637.GB17803@hudson.localdomain>
References: <cover.1402557437.git.jmmahler@gmail.com>
 <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
 <xmqqr42u55dq.fsf@gitster.dls.corp.google.com>
 <20140612193144.GA17077@hudson.localdomain>
 <CAPig+cTVLJQOsW7H4Ht2NNYkeiMb=EWT7BG3sNu0wNsTQ=oZNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 01:46:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvEhi-0003iH-34
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 01:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbaFLXqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 19:46:42 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58113 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaFLXql (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 19:46:41 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so1461373pac.25
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aWz+jDB3QjoHOG9dn78YXQ4kDd1UJkO9Z0lCttDHEeA=;
        b=PRXTC/jAs3QIEkJLvA9uNXTveUGp15CQoX+BZEPXP+I0HJkaKvJx3cnCpBSmf3EuWq
         42LEPPemDKP8NcZY9mw0QVAAZjOmM6P/Vyw0GOZfVdjwWubYUOB316EPQcvBdDabMG9c
         Fh4n4nHnBrM+hmLGe4kESurgBR7dVvEkDlOGytQrlkKzMGMy4O3MUJmwZdbApGCWxbuR
         0TkhdCLNXDgcMNb7D/6ctmO5kgBucWE73roOxXTn4kQNMBr4t/UntFfkzeyRiv77SygO
         C57yKXvLmJiei4l1Kb/mnXRnxtyA2L7zhcIK12SPXPtwKqiq9RdundOLp8I+PsiIig+2
         Wd9g==
X-Received: by 10.68.193.100 with SMTP id hn4mr16173137pbc.50.1402616801069;
        Thu, 12 Jun 2014 16:46:41 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id qv3sm120187pbb.87.2014.06.12.16.46.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 16:46:39 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAPig+cTVLJQOsW7H4Ht2NNYkeiMb=EWT7BG3sNu0wNsTQ=oZNA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251506>

Eric,

On Thu, Jun 12, 2014 at 05:48:52PM -0400, Eric Sunshine wrote:
> On Thu, Jun 12, 2014 at 3:31 PM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> > On Thu, Jun 12, 2014 at 11:50:41AM -0700, Junio C Hamano wrote:
> >> I am on the fence.
> >>
> >> I have this suspicion that the addition of strbuf_set() would *only*
> >> help when the original written with reset-and-then-add sequence was
> >> suboptimal to begin with, and it helps *only* how the code reads,
> >> without correcting the fact that it is still doing unnecessary
> >> "first set to a value to be discarded and then reset to set the
> >> right value", sweeping the issue under the rug.
> >>
> > It is certainly possible that builtin/remote.c (PATCH 2/2) saw the most
> > benefit from this operation because it is so badly designed.  But this
> > seems unlikely given the review process around here ;-)
> >
> > The one case where it would be doing extra work is when a strbuf_set
> > replaces a strbuf_add that didn't previously have a strbuf_reset.
> > strbuf_set is not appropriate for all cases, as I mentioned in the
> > patch, but in some cases I think it makes it more readable.  And in this
> > case it would be doing a reset on an empty strbuf.  Is avoiding this
> > expense worth the reduction in readability?
> >
> > Also, as Eric Sunshine pointed out, being able to easily re-order
> > operations can make the code easier to maintain.
> >
> >> Repeated reset-and-then-add on the same strbuf used to be something
> >> that may indicate that the code is doing unnecessary work.  Now,
> >> repeated uses of strbuf_set on the same strbuf replaced that pattern
> >> to be watched for to spot wasteful code paths.
> >>
> > If a reset followed by and add was a rare occurrence I would tend to
> > agree more.
> 
> When composing my review of the builtin/remote.c changes, I wrote
> something like this:
> 
>     Although strbuf_set() does make the code a bit easier to read
>     when strbufs are repeatedly re-used, re-using a variable for
>     different purposes is generally considered poor programming
>     practice. It's likely that heavy re-use of strbufs has been
>     tolerated to avoid multiple heap allocations, but that may be a
>     case of premature (allocation) optimization, rather than good
>     programming. A different ("better") way to make the code more
>     readable and maintainable may be to ban re-use of strbufs for
>     different purposes.
> 
> But I deleted it before sending because it's a somewhat tangential
> issue not introduced by your changes. However, I do see strbuf_set()
> as a Band-Aid for the problem described above, rather than as a useful
> feature on its own. If the practice of re-using strbufs (as a
> premature optimization) ever becomes taboo, then strbuf_set() loses
> its value.
> 

I am getting the feeling that I have mis-understood the purpose of
strbufs.  It is not just a library to use in place of char*.

If strbufs should only be added to and never reset a good test would be
to re-write builtin/remote.c without the use of strbuf_reset.

builtin/remote.c does re-use the buffers.  But it seems if a buffer is
used N times then to avoid a reset you would need N buffers.

But on the other hand I agree with your comment that re-using a variable
for different purposes is poor practice.

Now I am not even sure if I want my own patch :-)

> >> I dunno...
> >>
> >> > Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> >> > ---
> >> >  Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
> >> >  strbuf.c                               | 21 +++++++++++++++++++++
> >> >  strbuf.h                               | 13 +++++++++++++
> >> >  3 files changed, 52 insertions(+)
> >> >
> >> > diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> >> > index f9c06a7..ae9c9cc 100644
> >> > --- a/Documentation/technical/api-strbuf.txt
> >> > +++ b/Documentation/technical/api-strbuf.txt
> >> > @@ -149,6 +149,24 @@ Functions
> >> >     than zero if the first buffer is found, respectively, to be less than,
> >> >     to match, or be greater than the second buffer.
> >> >  /*----- add data in your buffer -----*/
> > ...
> >> >  static inline void strbuf_addch(struct strbuf *sb, int c)
> >> >  {
> >
> > --
> > Jeremiah Mahler
> > jmmahler@gmail.com
> > http://github.com/jmahler

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
