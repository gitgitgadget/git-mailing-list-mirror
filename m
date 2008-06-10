From: Don Zickus <dzickus@redhat.com>
Subject: git-apply quirks
Date: Tue, 10 Jun 2008 15:40:00 -0400
Message-ID: <20080610194000.GD9304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 21:41:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K69iT-0007HV-HD
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 21:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbYFJTkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 15:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbYFJTkK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 15:40:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59117 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754585AbYFJTkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 15:40:07 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5AJe6Ff003583
	for <git@vger.kernel.org>; Tue, 10 Jun 2008 15:40:06 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5AJe086014808
	for <git@vger.kernel.org>; Tue, 10 Jun 2008 15:40:00 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5AJe0LW014758
	for <git@vger.kernel.org>; Tue, 10 Jun 2008 15:40:00 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5AJe0dk000945
	for <git@vger.kernel.org>; Tue, 10 Jun 2008 15:40:00 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5AJe0Sd000944
	for git@vger.kernel.org; Tue, 10 Jun 2008 15:40:00 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84538>

Hi.

I work with a lot of backporting of patches and there are times when
people combine multiple patches together such that the resulting patch can
have multiple chunks changing the same file.  I have noticed git-apply
does not handle this case correctly.  It usually ignores all previous
chunks and only applies the last one.

The same scenario can also cause git-apply to fail if a later patch chunk
depends on changes from an earlier patch chunk.

The traditional 'patch' command seems to handle the successfully.  Is this
git-apply behaviour intended or is it a bug?

The following example summarizes the problem:

#cd <some git repo>
# cat > dummy << EOF
This is
a
test
of
git-apply
doing
something
incorrectly.

Please
help.

EOF
#git-add dummy
#git commit -m 'test'
#git-apply <attached patch below>

You will notice in the git-diff output the first chunk is ignored and only
the second applies.

Cheers,
Don


diff a/dummy b/dummy
--- a/dummy
+++ b/dummy
@@ -1,5 +1,5 @@
 This is
-a
+the first
 test
 of
 git-apply

diff a/dummy b/dummy
--- a/dummy
+++ b/dummy
@@ -6,6 +6,8 @@ git-apply
 doing
 something
 incorrectly.
+Now here is the
+second test.
 
 Please
 help.
