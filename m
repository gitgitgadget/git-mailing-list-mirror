From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Intermittent Failures in t1450-fsck (Bisected)
Date: Thu, 5 May 2011 17:58:26 -0400
Message-ID: <E577B7D7-423E-4E9E-AE47-30E4DB4D21BC@silverinsanity.com>
References: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com> <2838BCC7-FB14-401B-9498-D0FB78C98D91@silverinsanity.com> <20110505093226.GA29595@sigill.intra.peff.net> <60194977-A4A9-4E18-9878-C1CDE77B75C2@silverinsanity.com> <20110505210317.GE1770@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 23:58:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI6ZA-0000g0-Jt
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 23:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab1EEV6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 17:58:30 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46513 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1EEV63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 17:58:29 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C20AD1FFC134; Thu,  5 May 2011 21:58:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id D53BD1FFC0F6;
	Thu,  5 May 2011 21:58:20 +0000 (UTC)
In-Reply-To: <20110505210317.GE1770@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172920>


On May 5, 2011, at 5:03 PM, Jeff King wrote:

> On Thu, May 05, 2011 at 04:04:33PM -0400, Brian Gernhardt wrote:
> 
>> The original e-mail was from next at that point.  The output from the
>> rebased version and current next (76e37e2) is identical.
> 
> Thanks. The weird thing is that running t1450 on 76e37e2 gives me this
> output:
> 
> broken link from     tag 66f6581d549f70e05ca586bc2df5c15a95662c36
> broken link from unknown unknown
> dangling blob 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, not a commit
> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not load tagged object
> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
> 
> whereas from your original email, you had:
> 
>>>>> tagged commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 (wrong) in 66f6581d549f70e05ca586bc2df5c15a95662c36
>>>>> missing commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
>>>>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not a blob
>>>>> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or missing
> 
> which is weird. We do call "remove_object $sha", but only inside
> test_when_finished. I wonder if there is some bug with
> test_when_finished on your platform. Have you tried instrumenting the
> remove_object function to print a message when it is run? That might
> give us a clue if it is accidentally being run early.

I've done so, and the output is at the end of the e-mail.  I also added calls to `git show` to see if the objects could still be read.

>> This is on my OS X laptop and last I knew valgrind was very buggy on
>> OS X, so I've never tried it.  I'll install it now and see if I can
>> get anything useful out of it.
> 
> I've tried but been unable to reproduce on Linux, so it seems like
> something OS X specific.

Quite possibly.  My /bin/sh is GNU bash 3.2.48(1), so I don't know if that makes a difference.

I've actually nailed it down to something even more specific than "OS X".  It's failing when I run it on a ramdisk.

git/t$ dev=`hdiutil attach -nomount ram://512000`
git/t$ diskutil erasevolume HFS+ Git_Test $dev
Started erase on disk1
Unmounting disk
Erasing
Initialized /dev/rdisk1 as a 250 MB HFS Plus volume
Mounting disk
Finished erase on disk1 Git_Test
git/t$ ./t1450-fsck.sh -v --root=/Volumes/Git_Test  # Fails

~~ Brian

expecting success: 
	sha=$(echo blob | git hash-object -w --stdin) &&
	test_when_finished "remove_object $sha" &&
	cat >wrong-tag <<-EOF &&
	object $sha
	type commit
	tag wrong
	tagger T A Gger <tagger@example.com> 1234567890 -0000

	This is an invalid tag.
	EOF

	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
	test_when_finished "remove_object $tag" &&
	echo $tag >.git/refs/tags/wrong &&
	git show $blob &&
	git show $tag &&
	test_when_finished "git update-ref -d refs/tags/wrong" &&
	test_must_fail git fsck --tags 2>out &&
	cat out &&
	grep "error in tag.*broken links" out

commit c9145d6720f85544cc4bb6009a2e541660aa156b
Author: A U Thor <author@example.com>
Date:   Thu Apr 7 15:14:13 2005 -0700

    B

diff --git a/fileB b/fileB
new file mode 100644
index 0000000..f719efd
--- /dev/null
+++ b/fileB
@@ -0,0 +1 @@
+two
tag wrong
Tagger: T A Gger <tagger@example.com>
Date:   Fri Feb 13 23:31:30 2009 +0000

This is an invalid tag.
error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not a blob
error: Could not read object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
removing 66f6581d549f70e05ca586bc2df5c15a95662c36
removing 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
not ok - 10 tag pointing to something else than its type
#	
#		sha=$(echo blob | git hash-object -w --stdin) &&
#		test_when_finished "remove_object $sha" &&
#		cat >wrong-tag <<-EOF &&
#		object $sha
#		type commit
#		tag wrong
#		tagger T A Gger <tagger@example.com> 1234567890 -0000
#	
#		This is an invalid tag.
#		EOF
#	
#		tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
#		test_when_finished "remove_object $tag" &&
#		echo $tag >.git/refs/tags/wrong &&
#		git show $blob &&
#		git show $tag &&
#		test_when_finished "git update-ref -d refs/tags/wrong" &&
#		test_must_fail git fsck --tags 2>out &&
#		cat out &&
#		grep "error in tag.*broken links" out
#	

expecting success: 
	git fsck >actual 2>&1 &&
	test_cmp empty actual

--- empty	2011-05-05 21:56:11.000000000 +0000
+++ actual	2011-05-05 21:56:12.000000000 +0000
@@ -0,0 +1 @@
+error: refs/tags/wrong does not point to a valid object!
not ok - 11 cleaned up
#	
#		git fsck >actual 2>&1 &&
#		test_cmp empty actual
#	

# failed 2 among 11 test(s)
1..11
