From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible regression in git-rev-list --header
Date: Sun, 31 Dec 2006 19:21:35 -0800
Message-ID: <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	<Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>
	<7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
	<Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 01 04:21:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1DkH-0002vp-SL
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 04:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbXAADVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 22:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932892AbXAADVi
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 22:21:38 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43891 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887AbXAADVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 22:21:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070101032137.NHDU16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 22:21:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5fLp1W00b1kojtg0000000; Sun, 31 Dec 2006 22:20:50 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35720>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 12/31/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>
>> Further, if you rely on parsing being super-fast, why not just parse
>> _only_ the header information that you actually need? The header still
>> consists of
>>
>>         - exactly one "tree",
>>         - an arbitrary amount of "parent" lines,
>>         - exactly one "author", and
>>         - exactly one "committer" line
>>
>> After that may come optional headers,

They are more like 'other' headers.  Nobody said the set of
headers are cast in stone forever.  The only things parsers
safely can assume are that the original four kinds come at the
beginning in the above order, and there is a blank line that
separates headers and the body.

> If you intorduce the concept of an 'optional header part' you
> logically and naturally _may_ also introduce the concept of disabling
> the display of _that_ optional header, or better, to keep back
> compatibility...

While I am somewhat sympathetic, and am willing to apologize for
trying to advance the i18n support without enough advance
warning, I think you already know what you are saying does not
make much sense in the larger picture and as the longer term
solution.  Does any MUA ask the filesystem, POP3 server or IMAP
server not to give X-* headers?

We could declare "headers are cast in stone and we will not
enhance it in any way forever", and go back to my original hack
to use hidden trailer, but I do not think it would solve
anything.  Porcelains that would try to take advantage of the
trailer would now start assuming incorrectly that the set of
trailers are cast in stone and will break when new information
is added to the trailer, which would bring us back to exactly
where we are now.

Having said that, I think what is in the current tip of 'master'
is of much less impact for normal repositories than the one that
bit you, in two aspects.

 * Your sample commit had "encoding UTF-8" header, presumably
   because the repository that the commit was created in had
   core.commitencoding set to "UTF-8".  The intent was not to
   add anything when the log message is UTF-8, but the earlier
   code was checking only for "utf-8".  With the current tip of
   master this should not happen anymore.

 * When the output encoding conversion is done successfully, the
   current tip of master drops "encoding" header from the
   output, so in your sample situation where the commit has
   (incorrectly) "encoding UTF-8" and your output encoding is
   also "UTF-8" (because either you have core.commitencoding set
   to it, or you do not have the configuration and let git fall
   back to its default which is UTF-8), you would not see the
   "encoding" header in the output from the rev-list.

The reason we did the latter, by the way, does not have anything
to do with helping broken parsers.  We drop the header after
re-coding the log message into an encoding specified by the user
(which is presumably different from what the commit was
originally recorded in) because the encoding recorded on
"encoding" header would not match the re-coded log message
anymore.
