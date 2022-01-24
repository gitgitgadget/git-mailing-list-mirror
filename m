Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3531BC433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 20:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356675AbiAXUUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 15:20:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58582 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379495AbiAXULg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 15:11:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E25511C051;
        Mon, 24 Jan 2022 15:11:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=N
        O1sEm/SCniALHcc7F9w3DWfWixQayp0M7jo9jS0z9g=; b=N/0CADUYJJ/8GsCWc
        o6vRoH4U+YBFqc88+aRfqALEcZ2SW+ciGAI8RyUmXX+NfoBbyzo7O9RnMttUtOEA
        vFMyP/zPx6OIsjROKO6KbVf7HqMHwg9ZWexdYBcFPDTw5IPAPbaKh/blHNZV2cqB
        +czhIurXsT6rOMxn1P48BdW3x0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1699611C050;
        Mon, 24 Jan 2022 15:11:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 734A411C04F;
        Mon, 24 Jan 2022 15:11:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [RFC] shell: local x=$1 may need to quote the RHS
Date:   Mon, 24 Jan 2022 12:11:33 -0800
Message-ID: <xmqqsftc3nd6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D409FC7C-7D51-11EC-8140-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though this message ends with a patch that could be applied to
your tree, it is not for application at all.  It is to demonstrate a
potential problem in the code in our tree. 

While I was playing with the "Linux development environment (beta)"
on one of my Chromebooks, I say its default /bin/sh (which is Dash
0.5.10) mishandled this construct:

	func () {
		local x=$1
		clobber x and nothing else and feel safe
		message="I expect this to be visible by the caller"
	}

	func "a message"
	use "$message"

It assigned 'a' to $x in the function, DECLARED the varilable
$message as local to the function, hence the caller after func
returned did not see what I intended to see in $message.

The breakage is subtle; unless you have a character in $1 that would
not make a valid variable name, you won't get any error message yet
the program would behave in an unexpected way.

In other words, all of these hits are suspect and may misbehave with
such a shell.

    $ git grep -e '^[	 ]*local.* [a-z0-9_]*=\$' t
    t/lib-parallel-checkout.sh:	local expected_workers=$1 &&
    t/t0000-basic.sh:	local x=$1
    t/t4011-diff-symlink.sh:	local oid=$(printf "%s" "$1" | git hash-object --stdin) &&
    t/t4011-diff-symlink.sh:	local oid=$(git hash-object "$1") &&
    t/t4210-log-i18n.sh:	local engine=$1
    t/t4210-log-i18n.sh:	local pattern=$1
    t/test-lib-functions.sh:	local basename=${1#??}
    t/test-lib-functions.sh:	local var=$1 port
    t/test-lib-functions.sh:	local expr=$(printf '"%s",' "$@")
    t/test-lib-functions.sh:	local expr=$(printf '"%s".*' "$@")

Outside t/, I didn't find anything that may be run with dash and
can be fed problematic input, so as far as I can tell, it is a
problem that only affects the current set of tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 t/t0000-basic.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git c/t/t0000-basic.sh w/t/t0000-basic.sh
index b007f0efef..915eb2384f 100755
--- c/t/t0000-basic.sh
+++ w/t/t0000-basic.sh
@@ -45,6 +45,19 @@ test_expect_success 'verify that the running shell supports "local"' '
 	test_cmp expected2 actual2
 '
 
+try_local_unquoted () {
+	local x=$1
+	y="newvalue"
+}
+
+test_expect_success 'verify that "local x=$1" do not quoting' '
+	y=oldvalue &&
+	echo "newvalue" >expect &&
+	try_local_unquoted "x y" &&
+	echo "$y" >actual &&
+	test_cmp expect actual
+'
+
 ################################################################
 # git init has been done in an empty repository.
 # make sure it is empty.
