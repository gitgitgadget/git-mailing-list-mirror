Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B59E81E1B
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 17:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjJFRFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 13:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjJFRFl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 13:05:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94688BF
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 10:05:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A173D1B7454;
        Fri,  6 Oct 2023 13:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=gI8opwXGBoy0FB7jmRD9oWxCn2SyDCKSasaSRy
        stK5I=; b=rFI/qLmoxdA9xt5a8mBFw7CFQD1VPnVczqPNzUH5OQDE7+84PfoNh0
        jxE0IxyvAi87iBoyLb/+QL6jfxZen7pa7J/4eFdvIKaMlIT5J2EmtqGhTEqx+JFI
        3TDrEOCx6uB30F+I9r///6jv4rJIasuEcxqZ5bVm60RA508aIE6BY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A6081B7453;
        Fri,  6 Oct 2023 13:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0012D1B7451;
        Fri,  6 Oct 2023 13:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joanna Wang <jojwang@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Allow attr magic for git-add, git-stash.
In-Reply-To: <xmqqedi8bhf1.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        05 Oct 2023 19:42:26 -0700")
References: <20231005232423.1834298-1-jojwang@google.com>
        <xmqqedi8bhf1.fsf@gitster.g>
Date:   Fri, 06 Oct 2023 10:05:35 -0700
Message-ID: <xmqqttr3adgg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91C7D38C-646A-11EE-9053-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -test_expect_success 'fail if attr magic is used places not implemented' '
>> -	# The main purpose of this test is to check that we actually fail
>> -	# when you attempt to use attr magic in commands that do not implement
>> -	# attr magic. This test does not advocate git-add to stay that way,
>> -	# though, but git-add is convenient as it has its own internal pathspec
>> -	# parsing.
>> -	test_must_fail git add ":(attr:labelB)" 2>actual &&
>> -	test_i18ngrep "magic not supported" actual
> ...
> IOW, do not remove the above test, but find something
> other than "add" that is suitable to still follow the original
> intention of the test.

We can do something like the attached, instead of discarding the
protection from future breakage.  You're welcome to find another
command and magic that are less likely to be implemented than
check-ignore with attr magic and replace them, of course.  I just
eyeballed the hits from

    $ git grep -A2 parse_pathspec\(

and picked one that has pathspec magic restriction (i.e., the second
parameter is not zero) and appears near the surface (i.e., the one
in blame.c for example is a bad target, because it is to ensure that
a pathspec that is internally created out of an end-user provided
pathname is treated only literally, and is impossible to pass a
pathspec with offending magic to that codepath from the outside) to
make it easier to pass offending magic from the command line.

A tangent (to the topic of testing, but relevant to the whole
patch).  I notice 'stash' is mentioned on the topic, but I do not
see changes to the codepath that is specific to 'stash', and changes
to the tests do not demonstrate existing breakage.  The lack of code
changes probably is because something shared, which is pretected
with magic guard lifted by the patch, is called from 'stash' as well
as 'add', or something?  Whatever the reason is, it would be better
to document it in the proposed log message, and have a test to make
sure that the command works with the attr magic.

Alternatively, leave the mention of 'stash' out of the patch, if it
is not affected, perhaps?

In any case, here is a replacement for the removed test.


diff --git c/t/t6135-pathspec-with-attrs.sh w/t/t6135-pathspec-with-attrs.sh
index f70c395e75..b450cb5b3a 100755
--- c/t/t6135-pathspec-with-attrs.sh
+++ w/t/t6135-pathspec-with-attrs.sh
@@ -242,10 +242,10 @@ test_expect_success 'fail on multiple attr specifiers in one pathspec item' '
 test_expect_success 'fail if attr magic is used places not implemented' '
 	# The main purpose of this test is to check that we actually fail
 	# when you attempt to use attr magic in commands that do not implement
-	# attr magic. This test does not advocate git-add to stay that way,
-	# though, but git-add is convenient as it has its own internal pathspec
-	# parsing.
-	test_must_fail git add ":(attr:labelB)" 2>actual &&
+	# attr magic. This test does not advocate check-ignore to stay that way.
+	# When you teach the command to grok the pathspec, you need to find
+	# another commnad to replace it for the test.
+	test_must_fail git check-ignore ":(attr:labelB)" 2>actual &&
 	test_i18ngrep "magic not supported" actual
 '
 
