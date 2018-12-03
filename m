Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BAAC211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 01:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbeLCBBD (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 20:01:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57311 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLCBBD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 20:01:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42E8C3763A;
        Sun,  2 Dec 2018 20:00:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h6kq3i3eLLou6up78jjgOXQ5DoM=; b=nMFU5j
        xMLeOyV//Y/eeM+94TEKa9nz2TTMVfZazFx/AAK3rK2n/9z46Pl1yb6czGMoqSeo
        RIpBXGudRxriUP7QpXXF6gmrn5QswXqDZRsWX6QORdH1s9/3kDvjN96ofBbpY/WX
        JGuTixKhI/ojmjfL3uppbLfMU4vA4ycsQJP1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vXHhOtOReyv+z5k1bHazf4l/fbPlWW6/
        FskYhE/V8SrZAOFfvSdU4siqKKvV2LQ0xchN/MQYRhLkPIIAgzwVjKQ1V1ol0t7n
        bmoJ6t5I1FZ6Z0rMvB4PAnAxsxmQGSTrjVq1A+LzE3jw+CcwHqograhhCq3wNoUq
        bAHHkC7ekCA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CAAC37639;
        Sun,  2 Dec 2018 20:00:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5056937636;
        Sun,  2 Dec 2018 20:00:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "H.Merijn Brand" <h.m.brand@xs4all.nl>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Do not fail test if '.' is part of $PATH
References: <20181201180757.0b2d3c89@pc09.procura.nl>
Date:   Mon, 03 Dec 2018 10:00:50 +0900
In-Reply-To: <20181201180757.0b2d3c89@pc09.procura.nl> (H. Merijn Brand's
        message of "Sat, 1 Dec 2018 18:07:57 +0100")
Message-ID: <xmqqr2ezh1a5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E17D955C-F696-11E8-A4D8-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> When $PATH contains the current directory as .:PATH, PATH:., PATH:.:PATH,
> or (maybe worse) as :PATH, PATH:, or PATH::PATH - as an empty entry is
> identical to having dot in $PATH - this test used to fail

It is totally unclear what "this test" refers to.  Let's retitle it
to

> Subject: [PATCH] t0061: do not fail test if '.' is part of $PATH

and do something like this:

    t0061 created a script named with an unlikely name in the
    current directory to ensure that it is not found via the
    run_command() API, expecting that $PATH does not contain an
    element that names the current directory (i.e. '.' or '') in a
    sane environment.  This obviously would not work if the $PATH
    does contain such an element.

    Introduce a DOT_IN_PATH lazy prerequisite to catch such a case
    and skip the test when the environment is not so sane.

> +test_lazy_prereq DOT_IN_PATH '
> +       case ":$PATH:" in
> +       *:.:*|*::*) true  ;;
> +       *)          false ;;
> +       esac
> +'
> +
> +test_expect_success !DOT_IN_PATH 'run_command is restricted to PATH' '
>         write_script should-not-run <<-\EOF &&
>         echo yikes
>         EOF

I also like Peff's more straight-forward approach that avoids
looking into PATH but instead ask the shell what we care about
(i.e. would we end up running 'should-not-run' if we asked the
system to run it without giving an explicit path to it?).  The last
paragraph of the above would need to change if we were to go in that
direction to something like

    Check if the running shell picks up the script without an
    explicit path to it and skip the test when it does.

perhaps.  The code to do so got a bit more compact than what Peff
wrote but I think it still retains its main beauty, which is how
straight-forward it is.

 t/t0061-run-command.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index cf932c8514..17b560370e 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -29,7 +29,15 @@ test_expect_success 'run_command can run a command' '
 	test_must_be_empty err
 '
 
-test_expect_success 'run_command is restricted to PATH' '
+
+test_lazy_prereq RUNS_COMMANDS_FROM_PWD '
+	write_script runs-commands-from-pwd <<-\EOF &&
+	true
+	EOF
+	runs-commands-from-pwd >/dev/null 2>&1
+'
+
+test_expect_success !RUNS_COMMANDS_FROM_PWD 'run_command is restricted to PATH' '
 	write_script should-not-run <<-\EOF &&
 	echo yikes
 	EOF
