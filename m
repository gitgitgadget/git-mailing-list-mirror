From: "Kyle Moffett" <kyle@moffetthome.net>
Subject: Re: current git kernel has strange problems during bisect
Date: Tue, 13 Jan 2009 15:26:09 -0500
Message-ID: <f73f7ab80901131226s6af7730cucf9c44bc2b4f9545@mail.gmail.com>
References: <200901111602.53082.borntraeger@de.ibm.com>
	 <20090111194258.GA4840@uranus.ravnborg.org>
	 <alpine.LFD.2.00.0901111200330.6528@localhost.localdomain>
	 <200901112239.20306.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Sam Ravnborg" <sam@ravnborg.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
To: "Christian Borntraeger" <borntraeger@de.ibm.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 21:27:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMprK-0000E0-V4
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 21:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbZAMU0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 15:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754580AbZAMU0M
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 15:26:12 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:10923 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbZAMU0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 15:26:10 -0500
Received: by yw-out-2324.google.com with SMTP id 9so96738ywe.1
        for <multiple recipients>; Tue, 13 Jan 2009 12:26:09 -0800 (PST)
Received: by 10.101.70.15 with SMTP id x15mr16899040ank.112.1231878369362;
        Tue, 13 Jan 2009 12:26:09 -0800 (PST)
Received: by 10.100.4.5 with HTTP; Tue, 13 Jan 2009 12:26:09 -0800 (PST)
In-Reply-To: <200901112239.20306.borntraeger@de.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105531>

On Sun, Jan 11, 2009 at 4:39 PM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> In my opinion we should really avoid subtree merges in the future as a curtesy
> to people who do the uncool work of testing, problem tracking and bisecting.
> </rant>

As an alternative, you can relatively easily rewrite the following
independent histories:

A -- B -- C
X -- Y -- Z

To look like this:

A -- B -- C -- X' -- Y' -- Z'

Where X' is (C + sub/dir/X), Y' is (C + sub/dir/Y), etc...

Assuming the following:
  "master" branch points to commit C
  "child" branch points to commit Z
  "${KIDSTART}" is the SHA1 id of commit X

echo "${KIDSTART} $(git rev-parse --verify master)" >>.git/info/grafts

git filter-branch --index-filter 'git read-tree master && git
read-tree --prefix="sub/dir/" "${GIT_COMMIT}"' -- master..child

The one downside is then somebody actually has to *test* those commits
when doing a bisect, even though they did not materially change
anything.  The upside is that there isn't any "what the hell just
happened?" when you *do* end up in the newly-created branch.

Cheers,
Kyle Moffett
