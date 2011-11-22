From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/3] Re: cherry-pick/revert error messages
Date: Tue, 22 Nov 2011 05:12:08 -0600
Message-ID: <20111122111207.GA7399@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 12:12:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSoH3-0000eZ-VX
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 12:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab1KVLMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 06:12:17 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38346 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab1KVLMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 06:12:16 -0500
Received: by ghrr1 with SMTP id r1so30984ghr.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 03:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7FdA3qoU+mjewe2PbghGsqZgBPQ/1Cy/H5tNJRllDOo=;
        b=KvVkXbakbVmJVv00oZIxf6jzTAQw0wjqvo+26drA4wq0PgD219prSBJU9n8saXLeCt
         r83tp1s4qZCCGSAAJhamo4iXJjUtaHcXHyA7oPyG1Zz7VGP454z/U2vS4EQy/ilsXeXU
         XQkXWNB4KBguCogrLDNOiwgILhOZfI6z7tIH4=
Received: by 10.50.185.138 with SMTP id fc10mr19627266igc.33.1321960335500;
        Tue, 22 Nov 2011 03:12:15 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id jm11sm58754362ibb.1.2011.11.22.03.12.13
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 03:12:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111120094650.GB2278@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185781>

Hi again,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:

>> Looks much better!  Yes, a series pretty'fying error messages would be
>> really nice.
>
> Good to hear.  Here's a rough one.

Here's a less rough version.  Same scope.

Patch 1 renames --reset to --quit, keeping --reset as a synonym for
backward compatibility this time.  I don't suspect anyone was using
--reset, but splitting out the backward-incompatible changes seems
like a useful habit to follow nonetheless.

Patch 2 is a small code cleanup in preparation for patch 3, unchanged
from v1.

The change description for patch 3 said 'double redundant first
"error:" message', which was kind of amusing.  This time it says
'redundant first "error:" message'.

More notably, this version has some bonus patches:

Patch 4 introduces the REVERT_HEAD pseudoref, which is analagous to
CHERRY_PICK_HEAD except it is populated by "git revert" and does not
influence the behavior of "git commit".  This could allow tools like
__git_ps1 to detect when we are in the middle of a conflicted revert,
though the series does not include a patch to do that.  I'm kind of
fond of it.

Patch 5 introduces a "git cherry-pick --abort" command that rolls back
the series of commits made so far in a conflicted cherry-pick.
Compare --quit, which tells cherry-pick to leave HEAD alone and get
out of the way.

Patch 6 removes the --reset compatibility option.  There might not be
much reason to do that, aside from removing clutter and saving a few
bytes.  The alternate motivation of removing the option to prevent
people from relying on it seems less compelling after patch 1 made it
harder to stumble upon the option.

May the series can provide some amusement.

Thanks to Junio and Jakub for the useful feedback so far.

Jonathan Nieder (3):
  revert: rename --reset option to --quit
  revert: rearrange pick_revisions() for clarity
  revert: improve error message for cherry-pick during cherry-pick

 Documentation/git-cherry-pick.txt |    2 +-
 Documentation/git-revert.txt      |    2 +-
 Documentation/sequencer.txt       |   10 ++--
 builtin/revert.c                  |   74 +++++++++++++++++++------------------
 sequencer.h                       |    2 +-
 t/t3510-cherry-pick-sequence.sh   |   31 +++++++++++++--
 t/t7106-reset-sequence.sh         |    2 +-
 7 files changed, 73 insertions(+), 50 deletions(-)
