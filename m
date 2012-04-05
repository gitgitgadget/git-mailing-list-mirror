From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Thu, 5 Apr 2012 19:24:29 -0400
Message-ID: <20120405232429.GA8654@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 01:24:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFw2m-0002y1-4a
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 01:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab2DEXYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 19:24:39 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:59499 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab2DEXYi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 19:24:38 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SFw2Y-0006YY-M5; Thu, 05 Apr 2012 19:24:32 -0400
Content-Disposition: inline
In-Reply-To: <7vd37m5458.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194820>

On Thu, Apr 05, 2012 at 01:12:51PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > As a convienience, it would be nice if we could pop entries off the argv_array
> > structs so that if they had multiple uses in a function, we wouldn't have to
> > clear them and repopulate common entries.  This patch adds the argv_array_pop
> > function to do just that.  Common entries can be added to an argv_array first,
> > then useage specific ones can be added on the end and removed later on.
> >
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> 
> > CC: Jeff King <peff@peff.net>
> > CC: Phil Hord <phil.hord@gmail.com>
> > CC: Junio C Hamano <gitster@pobox.com>
> > ---
> 
> Please don't do "Cc:" here; they belong to your e-mail header.
> 
You mean place them below the snip line?  I can do that.

> > diff --git a/argv-array.c b/argv-array.c
> > index a4e0420..ce24a48 100644
> > --- a/argv-array.c
> > +++ b/argv-array.c
> > @@ -39,6 +39,18 @@ void argv_array_pushf(struct argv_array *array, const char *fmt, ...)
> >  	argv_array_push_nodup(array, strbuf_detach(&v, NULL));
> >  }
> >  
> > +int argv_array_pop(struct argv_array *array, unsigned int num)
> > +{
> > +	if (num > array->argc)
> > +		return -1;
> 
> If your use case is "After using an argv_array for the first invocation,
> truncate it while keeping the common ones that appear early, so that ones
> that are specific to the second invocation can be pushed", it strikes me
> somewhat odd why you would want to specify "how many to pop".
> 
Why?  It seems perfectly logical to me to be able to, as a convienience, specify
how many items to pop, and the api call seems pleasantly symmetric to the
push[f] calls.

> Wouldn't argv_array_truncate() or argv_array_setlen() make more sense?
> 
No, truncate is vague about its meaning.  Truncate to zero would be useless, as
its equivalent to the clear call at that point, and truncating to a specific
value is exactly the same as what I have currently, minus the symmetry to the
push[f] calls.  Likewise setlen doesn't seem to fit in properly, plus theres the
possibility there of believing the api call might be able to set a length longer
than what exists in the array already, which, while silly, requires additional
error checking.  Popping a fixed number of elements off an argv_array that have
previously been pushed makes perfectly good sense to me.

> 
> > +	for(num--; num>0; num--) {
> 
> Gaah.
> 
Eeek :).  If you want something else equally....equal here, please ask for it.
I prefer for loops, but if you would rather have a while loop here, I'm fine
with that.

Regards
Neil
