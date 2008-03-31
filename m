From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH] Add new git-graph command
Date: Mon, 31 Mar 2008 00:09:05 -0700
Message-ID: <20080331070904.GA19242@adamsimpkins.net>
References: <20080330195840.GA8695@adamsimpkins.net> <7vprtbwz5v.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 09:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgE9g-0006Rj-Bd
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 09:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbYCaHJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 03:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbYCaHJJ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 03:09:09 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:38246 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbYCaHJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 03:09:09 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 39F831B4058;
	Mon, 31 Mar 2008 03:09:07 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id EBC531B404A;
	Mon, 31 Mar 2008 03:09:06 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 884B514100B8; Mon, 31 Mar 2008 00:09:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vprtbwz5v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78564>

On Sun, Mar 30, 2008 at 04:49:16PM -0700, Junio C Hamano wrote:
> What's wrong with "tig -g", I have to wonder...

As I mentioned in my initial email, I tried using the graph in tig,
but I found it very hard to read.  However, going back and taking a
closer look at tig, I think its graph is just plain wrong in some
cases.

For example, here's a comparison of the first several lines of output
of "git-graph --date-order --all" and "tig -- --all" in my repository
for one of the projects I am working on.  I've replaced the commit
subjects with just the abbreviated hashes.  (Hopefully your mail
reader displays this with a monospace font.)

git-graph:

*   8076867
*   2613e2b
M    542f526
|\  
* |   642b381
| | *   e73dfa2
| \ \ 
|  \ \ 
M-. \ \   64e1d85
|\ \ \ \ 
| | * | |   836521f
| | | | | *   ce43181
| | | | | *   eaeeb08
| | | | | M    79d3db3
| | | | | |\  
| | | | | | *   da5bc9e
| * | | | | |   b947aab
| | | | | M  \   9ade1bc
| | | | | |\  | 
| | | | * | | |   8f3727b
| | | | * | | |   2d102cd
* | | | | | | |   bf5c6e3
| |/ / / / / / 
|/| / / / / / 
* | | | | | |   a570370
|/ / / / / / 
* | | | | |   dde9a00
| | | | | *   09048ce
| | | | |/ 
| | | | *   4ee2351



tig (version 0.10.git):

+ 8076867
* 2613e2b
M 542f526
* | 642b381
| | + e73dfa2
M |  \ \ 64e1d85
|`.`* | | 836521f
| | | | | + ce43181
| | | | | * eaeeb08
| | | | | M 79d3db3
| | | | | |`* da5bc9e
| * | | | | | b947aab
| | | | | M  \ 9ade1bc
| | | | * |`.`. 8f3727b
| | | | * | | | 2d102cd
* | | | | | | | bf5c6e3
*' / / / / / / a570370
*' / / / / / dde9a00
| | | | | * 09048ce
| | | | *' 4ee2351


Looking at the tig output, it seems like tig is definitely screwing up
around the 3-way merge at 64e1d85.  The way I read the output, it
looks like it is telling me that commit 836521f is a parent of
542f526, which is incorrect.

It also doesn't seem to display things correctly when branch lines
need to cross.  For example, 836521f is a child of a570370, and
b947aab is a child of dde9a00.  However, the way I read tig's graph,
it looks like it is telling me exactly the opposite--that 836521f is a
child of dde9a00 and b947aab is a child of a570370.

I think part of the problem is that tig displays exactly 1 commit per
line.  It's hard to represent octopus merges and crossing branches if
it all has to fit in 1 line.  This is why git-graph sometimes takes
extra lines in between commits to display where the branch lines are
going.

The git-forest command that Matthieu Moy pointed out also seems to do
a good job of representing the graph, while being a bit more compact
than git-graph when displaying crossing branches.  (I just joined the
list in the last couple of days, so I wasn't aware of git-forest.  I
did try googling for similar tools before I started, but only came up
with tig.)

-- 
Adam Simpkins
adam@adamsimpkins.net
