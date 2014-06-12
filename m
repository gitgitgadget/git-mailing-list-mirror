From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 12:31:44 -0700
Message-ID: <20140612193144.GA17077@hudson.localdomain>
References: <cover.1402557437.git.jmmahler@gmail.com>
 <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
 <xmqqr42u55dq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:31:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvAj2-0007Pe-SY
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbaFLTbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:31:49 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35423 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaFLTbs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 15:31:48 -0400
Received: by mail-pa0-f53.google.com with SMTP id kx10so1333046pab.12
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/4RCVvkPRWYyLQGuaoQ6fycK4nzFHowCcptwn+Km+wI=;
        b=bjeRyf263/X215j8ssIuxvXDrLfbr6ii1i+UbTtE92LJzhSmnWlJGg1G2J94rVMMLM
         knAPykA/gLWoTxYhcIfe6cFnYWQRZryyTsiF2raI56tj6Ymiihx56vBpDiHqWCOAEVKD
         ilFdRDv3VbAcKD2/mTrxWpzCWSimPv2UwaH9vvslgmRuouQw4rVu1t+BKvedkMhkAo9a
         GoLH5fHPJvnkfkSnUTl3orALJJAFGEftz1oC1tILZNcZO9U8MCInM4AfFCpB18h1zNi8
         qaM0DZap3otezN2/S4M0JLyqAQ1zfWowDw5ZC2cTF1jqzuEGjSkNAZGnnTAW43OoTknc
         llrw==
X-Received: by 10.66.66.225 with SMTP id i1mr23650899pat.0.1402601507618;
        Thu, 12 Jun 2014 12:31:47 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id wk4sm9424576pab.5.2014.06.12.12.31.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 12:31:46 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqr42u55dq.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251484>

Junio,

Comments below...

On Thu, Jun 12, 2014 at 11:50:41AM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
> > A common use case with strubfs is to set the buffer to a new value.
> > This must be done in two steps: a reset followed by an add.
> >
> >   strbuf_reset(buf);
> >   strbuf_add(buf, new_buf, len);
> >
> > In cases where the buffer is being built up in steps, these operations
> > make sense and correctly convey what is being performed.
> >
> >   strbuf_reset(buf);
> >   strbuf_add(buf, data1, len1);
> >   strbuf_add(buf, data2, len2);
> >   strbuf_add(buf, data3, len3);
> >
> > However, in other cases, it can be confusing and is not very concise.
> >
> >   strbuf_reset(buf);
> >   strbuf_add(buf, default, len1);
> >
> >   if (cond1) {
> >     strbuf_reset(buf);
> >     strbuf_add(buf, data2, len2);
> >   }
> >
> >   if (cond2) {
> >     strbuf_reset(buf);
> >     strbuf_add(buf, data3, len3);
> >   }
> >
> > Add strbuf_set operations so that it can be re-written in a clear and
> > concise way.
> >
> >   strbuf_set(buf, default len1);
> >
> >   if (cond1) {
> >     strbuf_set(buf, data2, len2);
> >   }
> >
> >   if (cond2) {
> >     strbuf_set(buf, data3, len3);
> >   }
> 
> Or even more concisely without making unnecessary internal calls to
> strbuf_reset():
> 
> 	strbuf_reset(buf);
>         if (cond2)
>         	strbuf_add(buf, data3, len3);
> 	else if (cond1)
>         	strbuf_add(buf, data2, len2);
> 	else
>         	strbuf_add(buf, default, len2);
> 
> ;-)

_add would work in your example.  strbuf_set would also work and it
would perform the same number of operations (one set and one add).

However your example is different from mine in which cond1 and cond2 are
not necessarily mutually exclusive.

> 
> I am on the fence.
> 
> I have this suspicion that the addition of strbuf_set() would *only*
> help when the original written with reset-and-then-add sequence was
> suboptimal to begin with, and it helps *only* how the code reads,
> without correcting the fact that it is still doing unnecessary
> "first set to a value to be discarded and then reset to set the
> right value", sweeping the issue under the rug.
> 
It is certainly possible that builtin/remote.c (PATCH 2/2) saw the most
benefit from this operation because it is so badly designed.  But this
seems unlikely given the review process around here ;-)

The one case where it would be doing extra work is when a strbuf_set
replaces a strbuf_add that didn't previously have a strbuf_reset.
strbuf_set is not appropriate for all cases, as I mentioned in the
patch, but in some cases I think it makes it more readable.  And in this
case it would be doing a reset on an empty strbuf.  Is avoiding this
expense worth the reduction in readability?

Also, as Eric Sunshine pointed out, being able to easily re-order
operations can make the code easier to maintain.

> Repeated reset-and-then-add on the same strbuf used to be something
> that may indicate that the code is doing unnecessary work.  Now,
> repeated uses of strbuf_set on the same strbuf replaced that pattern
> to be watched for to spot wasteful code paths.
> 
If a reset followed by and add was a rare occurrence I would tend to
agree more.

> I dunno...
> 
> > Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> > ---
> >  Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
> >  strbuf.c                               | 21 +++++++++++++++++++++
> >  strbuf.h                               | 13 +++++++++++++
> >  3 files changed, 52 insertions(+)
> >
> > diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> > index f9c06a7..ae9c9cc 100644
> > --- a/Documentation/technical/api-strbuf.txt
> > +++ b/Documentation/technical/api-strbuf.txt
> > @@ -149,6 +149,24 @@ Functions
> >  	than zero if the first buffer is found, respectively, to be less than,
> >  	to match, or be greater than the second buffer.
> >  /*----- add data in your buffer -----*/
...
> >  static inline void strbuf_addch(struct strbuf *sb, int c)
> >  {

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
