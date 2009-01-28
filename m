From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Honoring a checked out gitattributes file
Date: Wed, 28 Jan 2009 17:44:03 +0100
Message-ID: <49808B53.6040907@drmicha.warpmail.net>
References: <498078F1.20807@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Kristian Amlie <kristian.amlie@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 17:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSDXi-0001Pc-9p
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 17:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbZA1QoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 11:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbZA1QoI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 11:44:08 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:42852 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754686AbZA1QoH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 11:44:07 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.fastmail.fm (Postfix) with ESMTP id 0547625FCD5;
	Wed, 28 Jan 2009 11:44:06 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 28 Jan 2009 11:44:06 -0500
X-Sasl-enc: 2l6q5Ua/LrPqwykkagsl5TdlTvomHojoonFE7hJrPr+j 1233161045
Received: from [139.174.44.152] (steinitz.math.tu-clausthal.de [139.174.44.152])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 637072C28B;
	Wed, 28 Jan 2009 11:44:05 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <498078F1.20807@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107549>

Kristian Amlie venit, vidit, dixit 28.01.2009 16:25:
> Hi!
> 
> We currently use msysGit in our company test farm to checkout the latest
> development branch and do autotests. However, we have one problem:
> Certain files require UNIX line endings, even though this is a Windows
> system. For this we use .gitattributes.
> 
> However, if the .gitattributes file is also checked in to the branch, it
> will not always be honored. I browsed the code a bit, and it seems to
> happen whenever there is an existing .gitattributes file, but the
> checkout adds new files to it. These new files will not get the correct
> line endings (although I'm not sure if it happens *every* time, it could
> depend on the order they are checked out).
> 
> I think this should be fairly straightforward to fix, by ensuring that
> if there is a file called .gitattributes in the index of the current
> directory, check it out first, before all the other files that may be
> affected by it. I can produce a patch and testcase for it, but I wanted
> to hear the opinions of some developers in case there is an obvious flaw
> in my solution.
> 
> What do you think?

I think there's a general time ordering problem. Say you do the
following commits:

A: add a.txt
B: add a .gitattributes file covering *.txt (say with crlf or any filter)
C: add c.txt

Now, with an empty dir, you do either

1) checkout A, B, C sequentially
2) checkout C

The contents of the checkout will be different in cases 1) and 2):
1) a.txt is checked out out as is, c.txt according to the attributes
2) with current git: probably like 1), with your suggestion: both a.txt
and c.txt filtered according to the attributes.

If you add a file and .gitattributes covering it in the same commit
there is an ordering ambiguity which can be solved (patched away)
easily, but I think the difference between 1) and 2) is still
problematic, and would need to be dealt with.

The main problem seems to be that changing a file like gitattributes can
potentially change (by changing filters) the contents which should be
stored for a different file even if the checkout of that file doesn't
change.

Cheers,
Michael
