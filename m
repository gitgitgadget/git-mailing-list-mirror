From: Eli Barzilay <eli@barzilay.org>
Subject: Possible bug with --word-diff=porcelain
Date: Sun, 1 May 2011 16:00:20 -0400
Message-ID: <19901.48084.941695.439684@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 22:09:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGcxf-0005t8-6W
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 22:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761373Ab1EAUJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 16:09:44 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:36910 "EHLO
	winooski.ccs.neu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761356Ab1EAUJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 16:09:42 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 May 2011 16:09:42 EDT
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id p41K0LDH016378
	for <git@vger.kernel.org>; Sun, 1 May 2011 16:00:21 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id p41K0Lum016375;
	Sun, 1 May 2011 16:00:21 -0400
X-Mailer: VM 8.1.93a under 23.2.1 (x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172544>

It looks like there are cases where a newline is omitted in the output
of --word-diff=porcelain:

  $ cat A
  A foo B
  zzzzzzzz
  C
  $ cat B
  A bar B
  C
  $ git diff --word-diff=porcelain A B
  diff --git a/A b/B
  index dfadf3e..3e2f1ba 100644
  --- a/A
  +++ b/B
  @@ -1,3 +1,2 @@
   A 
  -foo
  +bar
    B                        /// right
  -zzzzzzzz                  \\\ here
  ~
   C
  ~

I'd expect the output to be

  --- a/A
  +++ b/B
  @@ -1,3 +1,2 @@
   A 
  -foo
  +bar
    B
  ~
  -zzzzzzzz
  ~
   C
  ~

Actually it looks like the problem is not just in the porcelain
output: I see it with other formats too, like the plain one:

  diff --git a/A b/B
  index dfadf3e..3e2f1ba 100644
  --- a/A
  +++ b/B
  @@ -1,3 +1,2 @@
  A [-foo-]{+bar+} B[-zzzzzzzz-]
  C

and with --word-diff=color:

   diff --git a/A b/B
   index dfadf3e..3e2f1ba 100644
   --- a/A
   +++ b/B
   @@ -1,3 +1,2 @@
   A foobar Bzzzzzzzz
   C

(where the colors are correct, but the newline is missing)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
