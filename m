From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/3] mailinfo: allow individual e-mail files as input
Date: Thu,  6 Aug 2009 20:08:12 -0500
Message-ID: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil>
References: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUOUuBmX-VWMCz3MUVwvBOlIZzlIXRRMP6EMS7BRy_6uJvxt5H-FbtdY@cipher.nrlssc.navy.mil>
Cc: ni.s@laposte.net, giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 07 03:09:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZDxZ-0004W5-2e
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbZHGBJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754509AbZHGBJI
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:09:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33962 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZHGBJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 21:09:06 -0400
Received: by mail.nrlssc.navy.mil id n77191WP024819; Thu, 6 Aug 2009 20:09:02 -0500
In-Reply-To: <COrzR9ThNBy5SQ7chsXyUOUuBmX-VWMCz3MUVwvBOlIZzlIXRRMP6EMS7BRy_6uJvxt5H-FbtdY@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 07 Aug 2009 01:09:01.0876 (UTC) FILETIME=[A674DF40:01CA16FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125149>

From: Junio C Hamano <gitster@pobox.com>

We traditionally allowed a mbox file or a directory name of a maildir (but
never an individual file inside a maildir) to be given to "git am".  Even
though an individual file in a maildir (or more generally, a piece of
RFC2822 e-mail) is not a mbox file, it contains enough information to
create a commit out of it, so there is no reason to reject one.  Running
mailsplit on such a file feels stupid, but it does not hurt.

This builds on top of a5a6755 (git-am foreign patch support: introduce
patch_format, 2009-05-27) that introduced mailbox format detection.  The
codepath to deal with a mbox requires it to begin with "From " line and
also allows it to begin with "From: ", but a random piece of e-mail can
and often do begin with any valid RFC2822 header lines.

Instead of checking the first line, we extract all the lines up to the
first empty line, and make sure they look like e-mail headers.

This fixes the test in t4150-am.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Junio,

You'll notice that I changed your grep -E to an egrep and dropped the -e.
I do not see any other grep which uses -e, and I seem to recall Jeff King
actively removing -e claiming that some greps do not recognize it.  I do not
have a perfect memory though, so apologies to Jeff if I am mistaken.

-brandon


 git-am.sh     |   14 ++++++++++++++
 t/t4150-am.sh |    2 +-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index d64d997..dd60f5d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -191,6 +191,20 @@ check_patch_format () {
 			esac
 			;;
 		esac
+		if test -z "$patch_format" &&
+			test -n "$l1" &&
+			test -n "$l2" &&
+			test -n "$l3"
+		then
+			# This begins with three non-empty lines.  Is this a
+			# piece of e-mail a-la RFC2822?  Grab all the headers,
+			# discarding the indented remainder of folded lines,
+			# and see if it looks like that they all begin with the
+			# header field names...
+			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
+			egrep -v '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
+			patch_format=mbox
+		fi
 	} < "$1" || clean_abort
 }
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index ad2a85f..4e8e176 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -114,7 +114,7 @@ test_expect_success 'am applies patch correctly' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
-test_expect_failure 'am correctly applies patch from email lacking "From" in first 3 lines' '
+test_expect_success 'am correctly applies patch from email lacking "From" in first 3 lines' '
 	git checkout first &&
 	git am patch1.eml &&
 	! test -d .git/rebase-apply &&
-- 
1.6.4
