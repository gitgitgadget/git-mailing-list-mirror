From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] unpack-trees: fix path search bug in verify_absent
Date: Sun, 04 Jan 2009 02:01:14 -0800
Message-ID: <7vtz8fz8yd.fsf@gitster.siamese.dyndns.org>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
 <1230843273-11056-2-git-send-email-drizzd@aon.at>
 <1230843273-11056-3-git-send-email-drizzd@aon.at>
 <alpine.DEB.1.00.0901022248070.27818@racer> <20090103103904.GA4479@localhost>
 <alpine.DEB.1.00.0901031353090.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 04 11:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJPok-0001Q3-D8
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 11:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbZADKBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 05:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbZADKBZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 05:01:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbZADKBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 05:01:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 90D698DDD4;
	Sun,  4 Jan 2009 05:01:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B09228DDD3; Sun,
  4 Jan 2009 05:01:16 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A36D1DEA-DA46-11DD-919F-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104500>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 3 Jan 2009, Clemens Buchacher wrote:
>
>> On Fri, Jan 02, 2009 at 10:59:47PM +0100, Johannes Schindelin wrote:
>> > This explanation makes sense.  However, this:
>> > 
>> > > @@ -289,7 +289,8 @@ static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmas
>> > >  	return 0;
>> > >  }
>> > >  
>> > > -static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
>> > > +static int unpack_callback(int n, unsigned long mask, unsigned long dirmask,
>> > > +		struct name_entry *names, struct traverse_info *info)
>> > >  {
>> > >  	struct cache_entry *src[5] = { NULL, };
>> > >  	struct unpack_trees_options *o = info->data;
>> > 
>> > ... is distracting during review, and this:
>> > 
>> > > @@ -517,22 +518,22 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
>> > >  	namelen = strlen(ce->name);
>> > >  	pos = index_name_pos(o->src_index, ce->name, namelen);
>> > >  	if (0 <= pos)
>> > > -		return cnt; /* we have it as nondirectory */
>> > > +		return 0; /* we have it as nondirectory */
>> > >  	pos = -pos - 1;
>> > >  	for (i = pos; i < o->src_index->cache_nr; i++) {
>> > 
>> > ... is not accounted for in the commit message.  Intended or not, that is 
>> > the question.
>> 
>> Those are trivial readability improvements in the context of the patch.
>
> They are not trivial enough for me not to be puzzled.  Reason enough to 
> explain in the commit message?

I'd say the first hunk quoted is probably on the borderline.  It is an
unnecessary churn that won't even be commented on if it were sent alone,
but as a "while we are at it" hunk in a patch that is not too big, this is
a kind of thing that often is tolerated, because it is obvious enough not
to hurt anything from the correctness standpoint [*1*].

The second one is moderately worse for two reasons.

 * I actually had to scratch my head because you need to view the change
   in a lot wider context that covers the initializing definition of "int
   cnt" near the beginning of the function down to the area affected by
   the hunk, in order to see that the new "return 0" is the same as the
   old "return cnt" and does not break things.  A comment to say that "at
   this point in the codeflow, cnt which is returned by the old code is
   always zero", perhaps below the three-dash marker, would have saved me
   a minute.

 * The function's purpose and logic is to see if the subdirectory is
   clean, and return how many cache entries need to be skipped if it is
   (otherwise a negative number as an error indicator).  For that purpose,
   the return value cnt is initialized to 0 (i.e. "we haven't counted any
   entry that needs to be skipped yet"), the loop below the patched part
   counts it up while performing the verification, and then the resulting
   count is returned from the function.  The logic flow, at least to me,
   is easier to follow if it returned the value in cnt, not a hardcoded 0,
   from the place the patch tries to touch.

The latter point is with "at least to me", because I think an alternate
position is entirely valid if the author wants to justify the change by
saying something like:

    The function's purpose is ....  Before entering the loop to count the
    number of entries to skip, this check to detect if we do not even have
    to count appears.  When this check triggers, we know we do not want to
    skip anything, and returning constant 0 is much clearer than returning
    a variable cnt that was initialized to 0 near the beginning of the
    function; we haven't even started using it to count yet.

But the point is, if that is the reason the author thinks it is an
improvement, that probably needs to be stated.

[Footnote]

*1* I am not sure if it is obviously clear that the change improves any
readability.  Some people argue that splitting the function definition
header hurts greppability for one thing.  I personally do not find it easy
to read when the subsequent header lines are indented without aligning
(compare the way it is indented in the postimage of the patch with the way
the headers verify_absent() and show_stage_entry() are indented), either.
