From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Allow git-apply to ignore the hunk headers (AKA
 recountdiff)
Date: Thu, 05 Jun 2008 21:55:08 -0700
Message-ID: <7vve0nw4b7.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
 <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer>
 <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer>
 <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer>
 <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer>
 <alpine.DEB.1.00.0806051720070.21190@racer>
 <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806052304300.21190@racer>
 <alpine.DEB.1.00.0806060005581.21190@racer>
 <alpine.DEB.1.00.0806060006370.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 06:56:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4U00-000175-9o
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 06:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbYFFEza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 00:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbYFFEza
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 00:55:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbYFFEzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 00:55:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4535D3F20;
	Fri,  6 Jun 2008 00:55:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 134D63E5E; Fri,  6 Jun 2008 00:55:16 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806060006370.21190@racer> (Johannes
 Schindelin's message of "Fri, 6 Jun 2008 00:06:50 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C44786AE-3384-11DD-93CA-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84019>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +static int recount_diff(char *line, int size, struct fragment *fragment)
> +{
> +	int line_nr = 0;

At this point, line points at the beginning of the line that immediately
follows "@@ -oldpos,oldlines +newpos,newlines @@ ...\n", right?

> +	if (size < 1)
> +		return -1;
> +
> +	fragment->oldpos = 2;

Why do you discard oldpos information, and use magic number "2"?

> +	fragment->oldlines = fragment->newlines = 0;
> +
> +	for (;;) {
> +		int len = linelen(line, size);
> +		size -= len;
> +		line += len;

And you look at the line of the patch, measure how long it is, and you
already advance line to point at the next line without ever looking at the
contents of the line (you could look at line[-len], but that is crazy).

> +		if (size < 1)
> +			return 0;

Why?  It may be the last line in the hunk but you haven't done anything to
the current line yet.

> +		switch (*line) {
> +		case ' ': case '\n':
> +			fragment->newlines++;
> +			/* fall through */
> +		case '-':
> +			fragment->oldlines++;
> +			break;
> +		case '+':
> +			fragment->newlines++;
> +			if (line_nr == 0) {
> +				fragment->leading = 1;
> +				fragment->oldpos = 1;
> +			}
> +			fragment->trailing = 1;

Again, why muck with oldpos?  Also leading and trailing?  After you
recount the newlines and oldlines you ignored from the hunk header, the
caller will behave as if the original patch had the right numbers on the
hunk header to compute leading and trailing, doesn't it?

> +			break;
> +		case '@':
> +			return size < 3 || prefixcmp(line, "@@ ");
> +		case 'd':
> +			return size < 5 || prefixcmp(line, "diff ");
> +		default:
> +			return -1;

I do not understand these return values.  Your caller, parse_fragment()
with your patch, gives you chance to recount the old and new line count,
and you are responsible for only recounting them.  The change you made to
parse_fragment() returns error, aborting the whole git-apply, when
recount_diff() returns non-zero, but having extra lines after the patch
text is perfectly fine and there is no reason to force aborting from
here.  IOW, this function should not even have power to do so.  The one
and only thing this function should do well is to reliably count the
number of patch lines.

> @@ -1013,6 +1058,9 @@ static int parse_fragment(char *line, unsigned long size,
>  	offset = parse_fragment_header(line, len, fragment);
>  	if (offset < 0)
>  		return -1;
> +	if (offset > 0 && patch->recount &&
> +			recount_diff(line + offset, size - offset, fragment))
> +		return -1;

... and this "return -1" is uncalled for.
