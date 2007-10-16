From: Andrew Morton <akpm@linux-foundation.org>
Subject: git-merge performance
Date: Tue, 16 Oct 2007 10:17:48 -0700
Message-ID: <20071016101748.ff132685.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:18:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihq3N-0003AH-FN
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759464AbXJPRRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759111AbXJPRRv
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:17:51 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40279 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758847AbXJPRRu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 13:17:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GHHmxf014242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 10:17:49 -0700
Received: from box (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l9GHHmGK006894
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 10:17:48 -0700
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
X-Spam-Status: No, hits=-2.647 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61223>


My git-pulling script (git-1.4.2) seems to have got quite a bit slower
since the post-2.6.23 patchflood.  I just did a bit of poking and it's
git-merge which is taking most of the time.


Using git-watchdog as an example:

box:/usr/src/git26> cat .git/branches/git-watchdog 
git+ssh://master.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog-mm.git
box:/usr/src/git26> git reset --hard origin
box:/usr/src/git26> git fetch git-watchdog
box:/usr/src/git26> time git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null                  
Automatic merge failed; fix conflicts and then commit the result.
git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null  47.03s user 26.53s system 97% cpu 1:15.67 total


Try git-md-accel:

box:/usr/src/git26> cat .git/branches/git-md-accel 
git://lost.foo-projects.org/~dwillia2/git/iop#md-for-linus
box:/usr/src/git26> time git reset --hard origin
git reset --hard origin  0.51s user 0.11s system 100% cpu 0.615 total
box:/usr/src/git26> time git fetch git-md-accel
git fetch git-md-accel  0.12s user 0.05s system 11% cpu 1.379 total
box:/usr/src/git26> time git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null                  
Automatic merge failed; fix conflicts and then commit the result.
git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null  42.52s user 24.18s system 96% cpu 1:08.93 total


And git-unionfs:

box:/usr/src/git26> cat .git/branches/git-unionfs      
git+ssh://master.kernel.org/pub/scm/linux/kernel/git/ezk/unionfs.git
box:/usr/src/git26> time git reset --hard origin
git reset --hard origin  0.52s user 0.09s system 100% cpu 0.611 total
box:/usr/src/git26> time git fetch git-unionfs      
git fetch git-unionfs  0.16s user 0.03s system 8% cpu 2.285 total
box:/usr/src/git26> time git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null                  
Automatic merge went well; stopped before committing as requested
git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null  42.81s user 24.86s system 96% cpu 1:09.98 total


Everything is in pagecache, and I just did git-repack -a -d;git
prune;git-fsck-objects --full.

Pulling 70-80 trees at a minute and a half each gets a bit dull ;)
