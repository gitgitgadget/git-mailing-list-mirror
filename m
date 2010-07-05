From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Mon, 5 Jul 2010 07:06:45 -0400
Message-ID: <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu> <20100705025900.GQ22659@josefsipek.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Mon Jul 05 13:07:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVjVx-0004SH-Eh
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 13:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab0GELGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 07:06:49 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:53551 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750733Ab0GELGs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 07:06:48 -0400
X-AuditID: 1209190d-b7c19ae0000009ea-e1-4c31bcc7a07c
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Brightmail Gateway) with SMTP id 2A.8F.02538.7CCB13C4; Mon,  5 Jul 2010 07:06:47 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o65B6kj2031667;
	Mon, 5 Jul 2010 07:06:46 -0400
Received: from [10.0.42.106] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o65B6iCA023490
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 5 Jul 2010 07:06:45 -0400 (EDT)
In-Reply-To: <20100705025900.GQ22659@josefsipek.net>
X-Mailer: Apple Mail (2.1081)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150256>


On Jul 4, 2010, at 10:59 PM, jeffpc@josefsipek.net wrote:
> 
> Am I understanding this right?  You want the timestamps to be monotonically
> increasing?  

Yup, that's correct.  In more modern versions of git most (all?) of the places
that depend on the committer time of the child commit to be greater than the
committer time of its parents have been relaxed to accept up to a day's worth
of clock skew, but in the interests of "be conservative in what you send",
strictly increasing seemed like the best thing to do.

> Is the +60 the most obvious choice?

It's somewhat arbitrary.  I figured a minute increase between commits was
more aesthetically pleasing than a second, 5 minutes, or an hour, which
were some other deltas that previous versions of my patch used while I
was experimenting.

> 
> Can I get an example of how git can get confused?

This first one is explicitly my/guilt's fault (and it's when I learned that I
was causing problems by how I was using guilt in the ext4 tree):

http://kerneltrap.org/mailarchive/git/2010/4/22/28928/thread

In this thread we see how the clock skew gets in the way of an optimization
that speeds up "git tag --contains" by over two orders of magnitude, but it
gets screwed over by extreme clock skew.  I suggested in that thread that 
if git is going to depend on it, then maybe "git commit" should either warn
or error out if the git committer timestamp goes backwards --- and that's when
I decided maybe I should offer up a patch to guilt to fix this, either before or
instead of fixing up "git commit" to throw a warning/error:

http://www.spinics.net/lists/git/msg134307.html

Other threads:

http://kerneltrap.org/mailarchive/git/2010/4/8/27731/thread
http://www.kerneltrap.com/mailarchive/git/2007/5/24/247375

-- Ted
