From: Johan Herland <johan@herland.net>
Subject: BUG? in --dirstat when rearranging lines in a file
Date: Thu, 7 Apr 2011 15:49:37 +0200
Message-ID: <201104071549.37187.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 15:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7pbf-0000bp-Oh
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 15:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab1DGNub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 09:50:31 -0400
Received: from smtp.opera.com ([213.236.208.81]:34814 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab1DGNua (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 09:50:30 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p37Dnb4h002831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 7 Apr 2011 13:49:39 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171060>

Hi,

(CCed the two main authors of --dirstat and diffcore-delta.c)

Consider the following sequence of commands:

$ git init
$ mkdir dir
$ echo -e "foo\nbar" > dir/file
$ git add dir
$ git commit -m "first"
$ # Rearrange lines in dir/file
$ echo -e "bar\nfoo" > dir/file
$ git diff
diff --git a/dir/file b/dir/file
index 3bd1f0e..1289765 100644
--- a/dir/file
+++ b/dir/file
@@ -1,2 +1,2 @@
-foo
 bar
+foo
$ git diff --stat
 dir/file |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git diff --dirstat
$ # WTF!?

"git diff" and "git diff --stat" generates the expected output, but "git 
diff --dirstat" unexpectedly generates no output at all. I've traced 
this down through show_dirstat(), to diffcore_count_changes() which 
processes the pre-image and post-image to accumulate two counts:

- src_copied (#lines (or 64-byte chunks) copied from pre- to post-)

- literal_added (#lines/chunks added in post-).

When the diff consists only of rearranging lines (like the above 
example) the line-based hashing and subsequent sorting in 
diffcore-delta.c ends up hiding he fact that lines have been moved 
around, and the resulting --dirstat reports less changes than expected.

Is this a bug or a feature? :)


(This issue was originally found by a colleague at $dayjob who wrote a 
script (using --dirstat) to produce a summary of the areas of the 
source tree touched by a given commit)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
