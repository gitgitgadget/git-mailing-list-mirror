From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] Add a test for subtree rebase that loses commits
Date: Sun, 17 Jan 2016 16:50:22 -0600
Message-ID: <87y4bnaki9.fsf@waller.obbligato.org>
References: <1451968805-6948-2-git-send-email-greened@obbligato.org>
	<1452467297-16868-1-git-send-email-greened@obbligato.org>
	<1452467297-16868-2-git-send-email-greened@obbligato.org>
	<CAPig+cQ6Dfvc4dkQVZ6BqzD76nZ4mCcqkO4eAecrMENKWtgWEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 23:51:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKwA2-0005V5-Ng
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 23:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbcAQWui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 17:50:38 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:32972 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752887AbcAQWug (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 17:50:36 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aKwAs-0003by-HT; Sun, 17 Jan 2016 16:51:54 -0600
In-Reply-To: <CAPig+cQ6Dfvc4dkQVZ6BqzD76nZ4mCcqkO4eAecrMENKWtgWEg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 14 Jan 2016 20:19:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Eric Sunshine <sunshine@sunshineco.com> writes: > On Sun,
   Jan 10, 2016 at 6:08 PM, David Greene <greened@obbligato.org> wrote: >> From:
    "David A. Greene" <greened@obbligato.org> >> >> This test merges an external
    tree in as a subtree, makes some commits >> on top of it and splits it back
    out. In the process the added commits >> are lost or the rebase aborts with
    an internal error. The tests are >> marked to expect failure so that we don't
    forget to fix it. > > This version looks better. A few minor comments below
    (not necessarily > deservi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284270>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Jan 10, 2016 at 6:08 PM, David Greene <greened@obbligato.org> wrote:
>> From: "David A. Greene" <greened@obbligato.org>
>>
>> This test merges an external tree in as a subtree, makes some commits
>> on top of it and splits it back out.  In the process the added commits
>> are lost or the rebase aborts with an internal error.  The tests are
>> marked to expect failure so that we don't forget to fix it.
>
> This version looks better. A few minor comments below (not necessarily
> deserving a re-roll)...

I'll re-roll because I think your comments make sense.

>> Signed-off-by: David A. Greene <greened@obbligato.org>
>> ---
>> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
>> @@ -0,0 +1,79 @@
>> +#!/bin/sh
>> +
>> +test_description='git rebase tests for -Xsubtree
>> +
>> +This test runs git rebase and tests the subtree strategy.
>> +'
>> +. ./test-lib.sh
>> +. "$TEST_DIRECTORY"/lib-rebase.sh
>> +
>> +check_equal() {
>> +       test_debug 'echo'
>> +       test_debug "echo \"check a:\" \"{$1}\""
>> +       test_debug "echo \"      b:\" \"{$2}\""
>> +       test "$1" = "$2"
>> +}
>
> I'm still curious as to why check_equal() is preferred over
> test-lib-functions.sh:verbose().

I can change it.  Better to use standard tools when available.  I like
the output from test_debug when I want to look at it but that's a
relatively minor thing.

>> +last_commit_message() {
>> +       git log --pretty=format:%s -1
>> +}
>> +
>> +test_expect_success 'setup' '
>> +       test_commit README &&
>> +       mkdir files &&
>> +       (
>> +               cd files &&
>> +               git init &&
>> +               test_commit master1 &&
>> +               test_commit master2 &&
>> +               test_commit master3
>> +       ) &&
>> +       test_debug "echo Add project master to master" &&
>
> Are these test_debug invocations still useful now that the test has
> been fully developed?

Yeah, I'll remove these.

>> +       git fetch files master &&
>> +       git branch files-master FETCH_HEAD &&
>> +       test_debug "echo Add subtree master to master via subtree" &&
>> +       git read-tree --prefix=files_subtree files-master &&
>> +       git checkout -- files_subtree &&
>> +       tree=$(git write-tree) &&
>> +       head=$(git rev-parse HEAD) &&
>> +       rev=$(git rev-parse --verify files-master^0) &&
>> +       commit=$(git commit-tree -p $head -p $rev -m "Add subproject master" $tree) &&
>> +       git reset $commit &&
>> +       (
>> +               cd files_subtree &&
>> +               test_commit master4
>> +       ) &&
>> +       test_commit files_subtree/master5
>> +'
>> +
>> +# Does not preserve master4 and master5.
>
> This comment is explaining why the test is marked "failure", right?

Right.

> When someone gets around to fixing the breakage and toggling this to
> "success", there is a reasonably good chance that the comment will be
> overlooked and thus become stale. Perhaps prefixing the comment with a
> bold "FAILURE:" would serve as a reminder that the comment should be
> dropped when the problem is fixed?

Good idea.

                        -David
