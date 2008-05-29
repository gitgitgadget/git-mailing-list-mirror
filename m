From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: log --graph: extra space with --pretty=oneline
Date: Thu, 29 May 2008 01:57:53 -0700
Message-ID: <20080529085752.GA31865@adamsimpkins.net>
References: <20080528112405.GA12065@mithlond.arda.local>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu May 29 10:59:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1dz8-0007o8-Ui
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 10:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbYE2I6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 04:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbYE2I6B
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 04:58:01 -0400
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:56954 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbYE2I56 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 04:57:58 -0400
Received: from relay1.r1.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay1.r1.iad.emailsrvr.com (SMTP Server) with ESMTP id D175C44C115;
	Thu, 29 May 2008 04:57:55 -0400 (EDT)
Received: by relay1.r1.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 8916244C096;
	Thu, 29 May 2008 04:57:55 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id D690B14100CA; Thu, 29 May 2008 01:57:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080528112405.GA12065@mithlond.arda.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83182>

On Wed, May 28, 2008 at 02:24:05PM +0300, Teemu Likonen wrote:
> Sometimes "log --graph --pretty=oneline" prints a sort of broken graph
> line. In the git repository try this:
> 
> $ git log --graph --pretty=oneline --abbrev-commit -4 8366b7b
> 
> [current graph output removed]
> 
> Extra spaces there. I don't mind that myself but to some users it may
> look like a bug. Maybe one would expect output like this:
> 
> 
> M   8366b7b... Merge branch 'maint'
> |\  
> | M   a2f5be5... Merge branch 'jk/maint-send-email-compose' into maint
> | |\  
> | | \
> | M  \  93c7b9c... Merge branch 'hb/maint-send-email-quote-recipients' into maint
> | |\  \ 
> | | \  \
> | M  \  |  6abf189... Merge branch 'maint-1.5.4' into maint
> | |\  | |
> 
> It requires more lines though.


Hmm.  Yes, the output could definitely be improved.  This problem
occurs for merges with 2 parents (not octopus merges), and only when
the branch line to the right of the merge was moving right at the end
of the previous commit (i.e., it was displayed with '\' instead of '|'
or '/').

Note that this doesn't require extra lines to fix:

M   8366b7b... Merge branch 'maint'
|\  
| M   a2f5be5... Merge branch 'jk/maint-send-email-compose' into maint
| |\  
| M \  93c7b9c... Merge branch 'hb/maint-send-email-quote-recipients' into maint
| |\ \ 
| M \ \  6abf189... Merge branch 'maint-1.5.4' into maint
| |\ \ \

This can easily be implemented by changing the output for 2-way merges
from something like this:

| M  \
| |\  |

to this:

| M \
| |\ \

However, I find this makes the graph slightly uglier when the incoming
branch to the right of the merge wasn't '\' on the previous line.  The
following change seems to look better when the branch line was '|' or
'/' on the previous line:

| M |
| |\ \

For comparison, here's a comparison of several scenarios of how the
output looks now, and how it would look with these fixes.

Current behavior        Option 1                 Option 2

| |\                    | |\                     | |\
| M  \                  | M \                    | M |
| |\  |                 | |\ \                   | |\ \

| | |                   | | |                    | | |
| M  \                  | M \                    | M |
| |\  |                 | |\ \                   | |\ \

| |  /                  | |  /                   | |  /
| M  \                  | M \                    | M |
| |\  |                 | |\ \                   | |\ \

| | |/                  | | |/                   | | |/
| M  \                  | M \                    | M |
| |\  |                 | |\ \                   | |\ \

Note that in the case of octopus merges, the current code already
produces output like that of option 1.

However, I find that both options 1 and 2 look a little uglier than
the current behavior when the branch lines need to be collapsed again
after the merge.  The graph has more pointy angles, but it is still
readable in all cases:

Current behavior        Option 1                 Option 2

| * | |                 | * | |                  | * | |
| M  \ \                | M \ \                  | M | |
| |\  | |               | |\ \ \                 | |\ \ \
|/ / / /                |/ / / /                 |/ / / /

For sections of the graph where there are several merge commits in a
row, I think option 1 looks the best:

Current behavior        Option 1                 Option 2

* |                     * |                      * |
M  \                    M \                      M |
|\  |                   |\ \                     |\ \
M  \ \                  M \ \                    M | |
|\  | |                 |\ \ \                   |\ \ \
M  \ \ \                M \ \ \                  M | | |
|\  | | |               |\ \ \ \                 |\ \ \ \


What is everyone's preference between the 3 options?  Personally, I'm
leaning towards Option 2.

I'll send out some informal patches of both option 1 and option 2, for
comparison.

In the future, the code could even be improved to dynamically choose
between these three options based on the output printed for the
previous commit.  Currently it doesn't store enough information from
the previous commit to do this.

-- 
Adam Simpkins
adam@adamsimpkins.net
