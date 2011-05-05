From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Intermittent Failures in t1450-fsck (Bisected)
Date: Thu, 5 May 2011 02:46:52 -0400
Message-ID: <2838BCC7-FB14-401B-9498-D0FB78C98D91@silverinsanity.com>
References: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu May 05 08:47:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHsKx-0003KV-6I
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 08:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab1EEGq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 02:46:56 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44309 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab1EEGqz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 02:46:55 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 3D3B21FFC134; Thu,  5 May 2011 06:46:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 429CE1FFC0F6;
	Thu,  5 May 2011 06:46:41 +0000 (UTC)
In-Reply-To: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172808>

I finally managed to pin down what triggers the bug and bisect it to its beginning.

I see this failure only when the test suite is run in parallel.  (make -j or -j in GIT_PROVE_OPTS)

The bug starts happening in "e96c19c: config: support values longer than 1023 bytes".

I have no idea why this commit causes failures in a test for fsck, but commits before it were merged work and commits after do not.  (Its direct ancestors work as well.)  Even more telling, reverting it on top of next causes the test to pass again.

~~ Brian

On Apr 13, 2011, at 1:11 PM, Brian Gernhardt wrote:

> t1450-fsck fails in test 10 "tag pointing to something else than its type", but only if I run it as part of the full test suite (with either `make test` or `make prove`).  If I run the test separately, it passes.
> 
> The output from running with GIT_TEST_OPTS="-v" is:
> 
> expecting success: 
> 	sha=$(echo blob | git hash-object -w --stdin) &&
> 	test_when_finished "remove_object $sha" &&
> 	cat >wrong-tag <<-EOF &&
> 	object $sha
> 	type commit
> 	tag wrong
> 	tagger T A Gger <tagger@example.com> 1234567890 -0000
> 
> 	This is an invalid tag.
> 	EOF
> 
> 	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
> 	test_when_finished "remove_object $tag" &&
> 	echo $tag >.git/refs/tags/wrong &&
> 	test_when_finished "git update-ref -d refs/tags/wrong" &&
> 	test_must_fail git fsck --tags 2>out &&
> 	cat out &&
> 	grep "error in tag.*broken links" out
> 
> tagged commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 (wrong) in 66f6581d549f70e05ca586bc2df5c15a95662c36
> missing commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not a blob
> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or missing
> not ok - 10 tag pointing to something else than its type
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
