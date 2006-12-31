From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Possible regression in git-rev-list --header
Date: Sun, 31 Dec 2006 16:27:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com> 
 <Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>  <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net> <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 16:27:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H12ah-00010u-6Z
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 16:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933192AbWLaP1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 10:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933188AbWLaP1H
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 10:27:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:40139 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933192AbWLaP1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 10:27:06 -0500
Received: (qmail invoked by alias); 31 Dec 2006 15:27:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 31 Dec 2006 16:27:04 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35701>

Hi,

On Sun, 31 Dec 2006, Marco Costalba wrote:

> Regarding qgit parsing 'bug' I would like to point out something that
> probably is not clear.

But it _is_ a bug!

> 1) Parsing routine _must_ be able to sustain the loading of more then
> 40000 revisions in a couple of seconds, so must be very quick. A lot
> of effort has been put to index the header info at maximum speed. Now
> it takes about 300ms to parse the whole linux tree. You can have this
> only if the header format is 'fixed enough', it means that you would
> not expect whole new lines (new '\n' chars) to appear from nowhere in
> header, with the exception of log message and parents info lines of
> course.

I don't see why this would slow down parsing _at all_. Besides, you should 
really stop relying on the header format being fixed for all eternity. 
There has been talk about putting more useful information into the header, 
and there _are_ valid reasons to keep the header extensible.

Further, if you rely on parsing being super-fast, why not just parse 
_only_ the header information that you actually need? The header still 
consists of

	- exactly one "tree",
	- an arbitrary amount of "parent" lines,
	- exactly one "author", and
	- exactly one "committer" line

After that may come optional headers, but by that time you should 
_already_ have stopped parsing! And the order is fixed already 
(parse_commit_buffer() relies on it).

After all, you have an initial parsing for the purpose of organizing the 
commits, and you can have _another_ for the purpose of displaying the 
message (you can remember the offset where the first parsing stopped to 
accelerate the second). The latter parsing should be done individually, 
when displaying the commit.

And I still have to disagree with Junio that the encoding header is no 
longer needed when displaying the commit message. The "tree" and "parent" 
headers are also displayed, even if their information is already used for 
purposes of displaying them.

The commit header contains information about that particular commit, and 
if I ask to see the headers, I want to see them, and not be treated like 
an idiot who does not know how to handle that information.

(If I ask for git-log to show everything encoded in Latin-1, it might 
still be interesting to know who used which encoding. And if it is 
displayed in my local encoding, but the commit header says UTF-8, I _do_ 
know that this is the original encoding, not the displayed one, thank you 
very much!)

So please, Marco, fix that bug in qgit. Otherwise you will restrict our 
ability to enhance commit objects with useful meta information _anyway_. 
IOW, even if the encoding header is not shown (which I would not like), 
you should fix that bug.

Ciao,
Dscho
