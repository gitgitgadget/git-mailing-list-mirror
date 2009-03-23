From: Adam Heath <doogie@brainfood.com>
Subject: large(25G) repository in git
Date: Mon, 23 Mar 2009 16:10:11 -0500
Message-ID: <49C7FAB3.7080301@brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 22:19:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlrYf-0002BT-V0
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 22:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757861AbZCWVRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 17:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbZCWVRv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 17:17:51 -0400
Received: from newmail.brainfood.com ([70.103.162.5]:43774 "EHLO
	newmail.brainfood.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbZCWVRu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 17:17:50 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Mar 2009 17:17:50 EDT
Received: from localhost (localhost [127.0.0.1])
	by newmail.brainfood.com (Postfix) with ESMTP id A842FF88A9
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 16:10:16 -0500 (CDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 0.101
X-Spam-Level: 
X-Spam-Status: No, score=0.101 tagged_above=-10 required=6.6
	tests=[BAYES_50=0.001, RDNS_DYNAMIC=0.1]
Received: from newmail.brainfood.com ([127.0.0.1])
	by localhost (newmail.brainfood.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Gqu-1m9Y-PK for <git@vger.kernel.org>;
	Mon, 23 Mar 2009 16:10:12 -0500 (CDT)
Received: from [192.168.2.49] (70-103-162-249.brainfood.com [70.103.162.249])
	by newmail.brainfood.com (Postfix) with ESMTP id 26ED1F885E
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 16:10:11 -0500 (CDT)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114351>

We maintain a website in git.  This website has a bunch of backend
server code, and a bunch of data files.  Alot of these files are full
videos.

We use git, so that the distributed nature of website development can
be supported.  Quite often, you'll have a production server, with
online changes occurring(we support in-browser editting of content), a
preview server, where large-scale code changes can be previewed, then
a development server, one per programmer(or more).

Last friday, I was doing a checkin on the production server, and found
1.6G of new files.  git was quite able at committing that.  However,
pushing was problematic.  I was pushing over ssh; so, a new ssh
connection was open to the preview server.  After doing so, git tried
to create a new pack file.  This took *ages*, and the ssh connection
died.  So did git, when it finally got done with the new pack, and
discovered the ssh connection was gone.

So, to work around that, I ran git gc.  When done, I discovered that
git repacked the *entire* repository.  While not something I care for,
I can understand that, and live with it.  It just took *hours* to do so.

Then, what really annoys me, is that when I finally did the push, it
tried sending the single 27G pack file, when the remote already had
25G of the repository in several different packs(the site was an
hg->git conversion).  This part is just unacceptable.

So, here are my questions/observations:

1: Handle the case of the ssh connection dying during git push(seems
simple).

2: Is there an option to tell git to *not* be so thorough when trying
to find similiar files.  videos/doc/pdf/etc aren't always very
deltafiable, so I'd be happy to just do full content compares.

3: delta packs seem to be poorly done.  it seems that if one repo gets
repacked completely, that the entire new pack gets sent, when the
target has most of the objects already.

4: Are there any config options I can set to help in this?  There are
tons of options, and some documentation as to what each one does, but
no recommended practices type doc, that describes what should be done
for different kinds of workflows.

ps: Thank you for your time.  I hope that someone has answers for me.

pps: I'm not subscribed, please cc me.  If I need to be subscribed,
I'll do so, if told.
