From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout does not warn about tags without corresponding
 commits
Date: Sat, 03 Jan 2009 03:36:04 -0800
Message-ID: <7vr63k8vvf.fsf@gitster.siamese.dyndns.org>
References: <200901021325.58049.henrik@austad.us>
 <7v8wptcrhp.fsf@gitster.siamese.dyndns.org>
 <200901031200.01883.henrik@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Henrik Austad <henrik@austad.us>
X-From: git-owner@vger.kernel.org Sat Jan 03 12:38:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ4pm-0003Cm-CN
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 12:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbZACLgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 06:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754472AbZACLgQ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 06:36:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbZACLgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 06:36:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 68B238CE5C;
	Sat,  3 Jan 2009 06:36:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2C3448CE5B; Sat,
  3 Jan 2009 06:36:06 -0500 (EST)
In-Reply-To: <200901031200.01883.henrik@austad.us> (Henrik Austad's message
 of "Sat, 3 Jan 2009 12:00:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B7D9290C-D98A-11DD-9E34-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104461>

Henrik Austad <henrik@austad.us> writes:

> On Friday 02 January 2009 22:44:50 Junio C Hamano wrote:
>> Henrik Austad <henrik@austad.us> writes:
>> > I recently tried to do a checkout of (what I thought was the first) inux
>> > kernel in the linux git repo.
>> >
>> > git checkout -b 2.6.11 v2.6.11
>>
>> This should have barfed, and indeed I think it is a regression around
>> v1.5.5.  v1.5.4 and older git definitely fails to check out a tree object
>> like that.
>
> You're right, I bisected it down to commit 
> 782c2d65c24066a5d83453efb52763bc34c10f81

I am not surprised.

That one discarded an implementation of "git checkout" in Bourne shell,
with a complete reimplementation in C.

I haven't looked at the code very closely, but I think this should fix
it.  Thorough reviewing (not just running the test suite) is much
appreciated.

-- >8 --
Subject: git-checkout: do not allow switching to a tree-ish

"git checkout -b newbranch $commit^{tree}" mistakenly created a new branch
rooted at the current HEAD, because in that case, the two structure fields
used to see if the command was invoked without any argument (hence it
needs to default to checking out the HEAD), were populated incorrectly.

Upon seeing a command line argument that we took as a rev, we should store
that string in new.name, even if that does not name a commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c               |    2 +-
 t/t2011-checkout-invalid-head.sh |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git c/builtin-checkout.c w/builtin-checkout.c
index c2c0561..b5dd9c0 100644
--- c/builtin-checkout.c
+++ w/builtin-checkout.c
@@ -681,8 +681,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		argv++;
 		argc--;
 
+		new.name = arg;
 		if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
-			new.name = arg;
 			setup_branch_path(&new);
 			if (resolve_ref(new.path, rev, 1, NULL))
 				new.commit = lookup_commit_reference(rev);
diff --git c/t/t2011-checkout-invalid-head.sh w/t/t2011-checkout-invalid-head.sh
index 764bb0a..798790d 100755
--- c/t/t2011-checkout-invalid-head.sh
+++ w/t/t2011-checkout-invalid-head.sh
@@ -15,4 +15,8 @@ test_expect_success 'checkout master from invalid HEAD' '
 	git checkout master --
 '
 
+test_expect_success 'checkout should not start branch from a tree' '
+	test_must_fail git checkout -b newbranch master^{tree}
+'
+
 test_done
