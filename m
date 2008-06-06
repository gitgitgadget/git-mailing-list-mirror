From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] Allow git-apply to ignore the hunk headers (AKA
 recountdiff)
Date: Fri, 6 Jun 2008 14:58:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061441120.1783@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806052304300.21190@racer>
 <alpine.DEB.1.00.0806060005581.21190@racer> <alpine.DEB.1.00.0806060006370.21190@racer> <7vve0nw4b7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 16:02:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4cVN-0004gX-Gb
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 16:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758116AbYFFN7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 09:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758095AbYFFN7t
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 09:59:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:46815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758086AbYFFN7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 09:59:48 -0400
Received: (qmail invoked by alias); 06 Jun 2008 13:59:46 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 06 Jun 2008 15:59:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19s+JMfWZ5sMBGtbNmUrCC3KvP+vbX5o9G8IzZl5y
	M3ynjQCzu5xZj9
X-X-Sender: gene099@racer
In-Reply-To: <7vve0nw4b7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 5 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +static int recount_diff(char *line, int size, struct fragment *fragment)
> > +{
> > +	int line_nr = 0;
> 
> At this point, line points at the beginning of the line that immediately
> follows "@@ -oldpos,oldlines +newpos,newlines @@ ...\n", right?

No.  At this point, it points directly after the last "@@", but still on 
the same line.

> > +	if (size < 1)
> > +		return -1;
> > +
> > +	fragment->oldpos = 2;
> 
> Why do you discard oldpos information, and use magic number "2"?

Because the old information should be ignored.  If the first line is a "+" 
line, the line number needs to be set to 1, otherwise the patch will not 
apply.

Maybe the easiest would be to set it to 1 regardless of the hunk.

> > +	fragment->oldlines = fragment->newlines = 0;
> > +
> > +	for (;;) {
> > +		int len = linelen(line, size);
> > +		size -= len;
> > +		line += len;
> 
> And you look at the line of the patch, measure how long it is, and you
> already advance line to point at the next line without ever looking at the
> contents of the line (you could look at line[-len], but that is crazy).

No, as I said, the "line" parameter points just after "@@" of the hunk 
header.

BTW this is what I referred to when I said that it now works by design; 
formerly, it relied on a space being present after the "@@", which it 
would mistakenly count as a common line, which was the reason I set the 
counts to -1 initially.

> > +		if (size < 1)
> > +			return 0;
> 
> Why?  It may be the last line in the hunk but you haven't done anything to
> the current line yet.

No, see above.

> > +		switch (*line) {
> > +		case ' ': case '\n':
> > +			fragment->newlines++;
> > +			/* fall through */
> > +		case '-':
> > +			fragment->oldlines++;
> > +			break;
> > +		case '+':
> > +			fragment->newlines++;
> > +			if (line_nr == 0) {
> > +				fragment->leading = 1;
> > +				fragment->oldpos = 1;
> > +			}
> > +			fragment->trailing = 1;
> 
> Again, why muck with oldpos?  Also leading and trailing?  After you
> recount the newlines and oldlines you ignored from the hunk header, the
> caller will behave as if the original patch had the right numbers on the
> hunk header to compute leading and trailing, doesn't it?

No.  Because I can never know if the _positions_ in the hunk header are 
right.

> > +			break;
> > +		case '@':
> > +			return size < 3 || prefixcmp(line, "@@ ");
> > +		case 'd':
> > +			return size < 5 || prefixcmp(line, "diff ");
> > +		default:
> > +			return -1;
> 
> I do not understand these return values.  Your caller, parse_fragment() 
> with your patch, gives you chance to recount the old and new line count, 
> and you are responsible for only recounting them.  The change you made 
> to parse_fragment() returns error, aborting the whole git-apply, when 
> recount_diff() returns non-zero, but having extra lines after the patch 
> text is perfectly fine and there is no reason to force aborting from 
> here.

Then I understood you not correctly at all when you complained about the 
"Probably a diff" part.

So what do you want?  Should it be anal, or lax?  You can't have both.

> IOW, this function should not even have power to do so.  The one
> and only thing this function should do well is to reliably count the
> number of patch lines.
> 
> > @@ -1013,6 +1058,9 @@ static int parse_fragment(char *line, unsigned long size,
> >  	offset = parse_fragment_header(line, len, fragment);
> >  	if (offset < 0)
> >  		return -1;
> > +	if (offset > 0 && patch->recount &&
> > +			recount_diff(line + offset, size - offset, fragment))
> > +		return -1;
> 
> ... and this "return -1" is uncalled for.

Again.  Lax or not lax?

Ciao,
Dscho
 
