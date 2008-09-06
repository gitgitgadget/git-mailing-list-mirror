From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Expose the raw timezone offset from PersonIdent
Date: Sat, 6 Sep 2008 12:27:27 -0700
Message-ID: <20080906192727.GC18631@spearce.org>
References: <1220578639-11723-1-git-send-email-spearce@spearce.org> <200809061705.56879.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 21:28:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc3SX-0007Hj-UI
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 21:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbYIFT13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 15:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbYIFT12
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 15:27:28 -0400
Received: from george.spearce.org ([209.20.77.23]:32905 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbYIFT12 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 15:27:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7B89338353; Sat,  6 Sep 2008 19:27:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809061705.56879.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95095>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> fredagen den 5 september 2008 03.37.19 skrev Shawn O. Pearce:
> > Applications may wish to have this value, much as they
> > can get the raw seconds-since-epoch and reformat it
> > for their own uses.
> 
> Necessary (performance) or just nice? We already provide the
> timezone in java.util format.

It isn't necessary from a performance perspective, but is required
to read the commit data exactly, but in parsed form.

What I'm doing at the application level is taking a RevCommit and
converting it into a different data structure (more specifically
a Google Protocol Buffer) that has all of the parts broken out.
It looks like this:

  message GitPerson {
    required string name = 1;
    required string email = 2;
    required int32 when = 3;
    required int32 tz = 4;
  }
  
  message GitCommit {
    required string id = 1;
    repeated string parent_id = 2;
    required GitPerson author = 3;
    optional GitPerson committer = 4;
    optional string message = 5;
  }

I'm later processing the GitPerson in Python and need to use the tz
to offset when to format a time for display.  If the author has a
"funny" offset in their commit our existing getTimeZone() method
can return null, which means I have to then lie and send 0 to the
Python code.  I'd rather send the exact offset.

-- 
Shawn.
