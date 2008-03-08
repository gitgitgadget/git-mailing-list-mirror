From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Add test for filter-branch on a subdirectory that's been
 added and deleted and re-added
Date: Sat, 08 Mar 2008 12:08:58 -0800
Message-ID: <7vmyp9t1ut.fsf_-_@gitster.siamese.dyndns.org>
References: <1204977007-7267-3-git-send-email-kevin@sb.org>
 <7vzlt9t5wr.fsf@gitster.siamese.dyndns.org>
 <91DF7A2E-540B-4AD6-91B2-BDB0B04EFC71@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 21:10:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY5NJ-00032M-4F
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 21:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029AbYCHUJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 15:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757019AbYCHUJK
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 15:09:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756991AbYCHUJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 15:09:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DFF7339AB;
	Sat,  8 Mar 2008 15:09:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D992539AA; Sat,  8 Mar 2008 15:09:00 -0500 (EST)
In-Reply-To: <91DF7A2E-540B-4AD6-91B2-BDB0B04EFC71@sb.org> (Kevin Ballard's
 message of "Sat, 8 Mar 2008 13:45:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76577>

Kevin Ballard <kevin@sb.org> writes:

> On Mar 8, 2008, at 1:41 PM, Junio C Hamano wrote:
>
>> Such a test is a very good incentive to the people involved in the
>> failing
>> part of the system to fix, and is greatly appreciated.  However,
>>
>> * please mark "currently-failing" test with "test_expect_failure";
>
> Ahh, didn't know about that. In retrospect I should have been able to
> guess, though.
>
>> * please hint (after --- lines) if you will shortly be following up
>> with
>>   a fix patch yourself, or if you are only reporting a bug.
>
> Ah. Yeah, I'm only reporting a bug. I don't know anything about how
> this stuff works, and the bug doesn't bite me, it bit someone else
> instead, I just thought it deserved to be documented somewhere as a
> failure.
>
>> I can fix-up and forge your Sign-off.
>
> That would be great, thanks.

Heh, your test is broken.  You are not re-adding foo.

Here is a fix.

---

 git-filter-branch.sh     |   11 ++++++++++-
 t/t7003-filter-branch.sh |    5 ++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 49e13f0..8382212 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -252,7 +252,16 @@ while read commit parents; do
 		git read-tree -i -m $commit
 		;;
 	*)
-		git read-tree -i -m $commit:"$filter_subdir"
+		# The commit may not have the subdirectory at all
+		err=$(git read-tree -i -m $commit:"$filter_subdir" 2>&1) || {
+		    if ! git rev-parse $commit:"$filter_subdir" 2>&1
+			then
+				rm -f "$GIT_INDEX_FILE"
+			else
+				echo >&2 "$err"
+				false
+			fi
+		}
 	esac || die "Could not initialize the index"
 
 	GIT_COMMIT=$commit
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 2ea8e3b..8f92fef 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -188,8 +188,11 @@ test_expect_failure 'Subdirectory filter on folder with non-contiguous history'
 	git commit -m "Removing foo" &&
 	mkdir foo &&
 	touch foo/bar &&
+	git add foo &&
 	git commit -m "Re-adding foo" &&
-	git filter-branch --subdirectory-filter foo
+
+	git filter-branch --subdirectory-filter foo &&
+	test $(git rev-list master | wc -l) = 3
 '
 
 test_done
