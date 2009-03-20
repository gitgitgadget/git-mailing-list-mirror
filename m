From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.defaultOptions"
Date: Fri, 20 Mar 2009 10:11:27 -0700 (PDT)
Message-ID: <alpine.GSO.2.00.0903200911530.16242@kiwi.cs.ucla.edu>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0903170825340.16242@kiwi.cs.ucla.edu>
 <20090320070148.GD27008@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:13:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkiHN-00046n-4k
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 18:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317AbZCTRLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 13:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756906AbZCTRLk
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 13:11:40 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:35674 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703AbZCTRLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 13:11:39 -0400
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n2KHBRRR018223;
	Fri, 20 Mar 2009 10:11:27 -0700 (PDT)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n2KHBRji018220;
	Fri, 20 Mar 2009 10:11:27 -0700 (PDT)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <20090320070148.GD27008@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113981>

Peff,

Thank you for this extremely thoughtful reply.  First, I want to ease concern 
over the point about "intent-to-change".  BTW, everything I describe here is 
already implemented in v3.

On Fri, 20 Mar 2009, Jeff King wrote:

> Look, I am not opposed to layer flattening if that's what is required to get 
> it right. But consider the downside of layer flattening: we must always record 
> intent-to-change when making a change to the struct (i.e., the "mask" variable 
> in your original patches). This is fine for members hidden behind macros, but 
> there are a lot of members that are assigned to directly. We would need to:
> 
>   1. Introduce new infrastructure for assigning to these members.

Only the bit flag fields need special infrastructure!  IOW, the macros are only 
necessary for the bit flags.  For numeric data or pointer data, there's no need 
to keep extra state, and there's no need for callsites to change from direct 
assignment.  Only for bit flags, we need an extra bit to remember whether the 
value is pristine or not.  For all other data:

(a) numeric data (integers, chars, and floats): define magic value(s) that 
represent pristineness.  Initialize all fields to PRISTINE.  Later, if a field 
has any value other than PRISTINE, we know there was intent-to-change.

(b) pointer data: NULL is the pristine value.  Any value other than NULL means 
intent-to-change.

>   2. Fix existing locations by converting them to this infrastructure.

As of 628d5c2, all callsites that set bit flags are already updated to use the 
macros.  As mentioned above, all other locations can keep on keepin' on using 
direct assignment.  No change here.

>   3. Introduce some mechanism to help future callers get it right (since
>      otherwise assigning directly is a subtle bug).

Yes, in the future, someone could write naughty code that sets a bit flag 
directly rather than using one of the macros.  In C, we probably can't make that 
impossible.  But generally speaking we can't protect against all forms of gross 
negligence.  In order to commit his crime, this hypothetical programmer must 
ignore the fact that these bits are never set directly, anywhere in the code, 
period.  A competent programmer would, after deciding that he needs to set a 
bit, look at other spots where such bits are set, and mimic.  I think the normal 
patch auditing process this community follows would raise alarms on patches 
coming from negligent programmers (there are always tell-tale signs).  And, in 
the event that, nevertheless, Junio applies a bit-flag-direct-assignment patch, 
it will result in a bug of precisely the following form: an explicitly-given 
command-line option to a porcelain command fails to override a default option.  
It will be noticed and fixed.  It's not fatal, it doesn't corrupt data, it 
affects only porcelain and it's not hidden.  Of all the insect kingdom (grand 
scheme of hypothetical bugs), this one isn't worth abandoning a good design 
over.

All in all, turns out v3 requires surprisingly little modification of existing 
code outside of diff.h/diff.c.  Actually, it only adds 3 lines, that's it!!

 builtin-diff.c                  |    2 +
 builtin-log.c                   |    1 +
 diff.c                          |  112 ++++++++++++++++++++++++-
 diff.h                          |   17 +++-

Shall I post v3?
                                 -- Keith
