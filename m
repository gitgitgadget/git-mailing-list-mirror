From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: [PATCH] git-cvsserver: handle CVS 'noop' command.
Date: Thu, 29 Jan 2009 17:12:27 -0800
Message-ID: <1233277947-17175-1-git-send-email-stefan.karpinski@gmail.com>
References: <7vhc3hd6ba.fsf@gitster.siamese.dyndns.org>
Cc: Stefan Karpinski <stefan.karpinski@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 02:14:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LShxc-0005nE-5X
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 02:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759690AbZA3BMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 20:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759602AbZA3BMa
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 20:12:30 -0500
Received: from zion.cs.ucsb.edu ([128.111.52.118]:61692 "EHLO zion.cs.ucsb.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759569AbZA3BM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 20:12:29 -0500
Received: by zion.cs.ucsb.edu (Postfix, from userid 401)
	id 298769D6461; Thu, 29 Jan 2009 17:12:27 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.3.g08dd8
In-Reply-To: <7vhc3hd6ba.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107759>

The CVS protocol documentation, found at

  http://www.wandisco.com/techpubs/cvs-protocol.pdf

states the following about the 'noop' command:

  Response expected: yes. This request is a null command
  in the sense that it doesn't do anything, but merely
  (as with any other requests expecting a response) sends
  back any responses pertaining to pending errors, pending
  Notified responses, etc.

In accordance with this, the correct way to handle the 'noop'
command, when issued by a client, is to call req_EMPTY.

The 'noop' command is called by some CVS clients, notably
TortoiseCVS, thus making it desirable for git-cvsserver to
respond to the command rather than choking on it as unknown.

Signed-off-by: Stefan Karpinski <stefan.karpinski@gmail.com>
---
On Thu, Jan 29, 2009 at 3:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Because the issue currently has our attention, and we think we know that
> the code does not do the right thing currently, and that we are fairly
> sure that the right thing is to do req_EMPTY, I'd rather see a tested fix
> applied so that we can forget about it ;-)
>
> It's good that you moved your people to native git environment, but if you
> have an environment where you can test the fix still lying around, I'd
> appreciate a quick test and resubmit.

I've done the best testing I could do under the circumstances. What
that means is that the only windows machine I have access to test
this on right now is running Vista, which is only partially (read
poorly) supported by TortoiseCVS. So things seem to work well enough,
but TortoiseCVS keeps crapping out for Vista-related reasons rather 
than git-cvsserver-related reasons. But I did manage to coax it into
successfully checking out a complete working repository without the
"noop" errors that it used to give.

 git-cvsserver.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index fef7faf..277ee4e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -76,6 +76,7 @@ my $methods = {
     'history'         => \&req_CATCHALL,
     'watchers'        => \&req_EMPTY,
     'editors'         => \&req_EMPTY,
+    'noop'            => \&req_EMPTY,
     'annotate'        => \&req_annotate,
     'Global_option'   => \&req_Globaloption,
     #'annotate'        => \&req_CATCHALL,
-- 
1.6.0.3.3.g08dd8
