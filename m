From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Concurrent pushes updating the same ref
Date: Thu, 06 Jan 2011 10:46:38 -0500
Message-ID: <4D25E3DE.7050801@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 06 16:56:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PasCn-0000cW-Oa
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 16:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab1AFP4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 10:56:44 -0500
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:35973 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab1AFP4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 10:56:43 -0500
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jan 2011 10:56:43 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp51.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 2451920575
	for <git@vger.kernel.org>; Thu,  6 Jan 2011 10:48:57 -0500 (EST)
X-Virus-Scanned: OK
Received: from smtp172.iad.emailsrvr.com (unknown [192.168.23.172])
	by smtp51.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTPS id 1282620236
	for <git@vger.kernel.org>; Thu,  6 Jan 2011 10:48:57 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp47.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 953353A94B3;
	Thu,  6 Jan 2011 10:47:46 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp47.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 8AC843A94E3;
	Thu,  6 Jan 2011 10:46:50 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164636>

Hi all,

[ BACKGROUND: I've modified our build system to push a custom ref at the
start of each build.  The aim is to identify in the repo which revision got
built.  For us, an overall "build" consists of creating about a dozen
products, all from the same source tree.  The build system (Hudson) launches
each product's build concurrently on one or more build slaves.  Each of those
individual product builds clones the repo, checks out the appropriate
revision, and pushes up the custom ref.  (I would have liked to make the
Hudson master job push up the ref, instead of all the slave jobs, but I
couldn't find a way to do that.) ]

Usually this works:  Each slave is setting the ref to the same value, so the
order of the updates doesn't matter.  But every once in a while, the push
fails with:

fatal: Unable to create
'/usr/xiplink/git/public/Main.git/refs/builds/3.3.0-3.lock': File exists.
If no other git process is currently running, this probably means a
git process crashed in this repository earlier. Make sure no other git
process is running and remove the file manually to continue.
fatal: The remote end hung up unexpectedly

I think the cause is pretty obvious, and in a normal interactive situation
the solution would be to simply try again.  But in a script trying again
isn't so straightforward.

So I'm wondering if there's any sense or desire to make git a little more
flexible here.  Maybe teach it to wait and try again once or twice when it
sees a lock file.  I presume that normally a ref lock file should disappear
pretty quickly, so there shouldn't be a need to wait very long.

Thoughts?

		M.
