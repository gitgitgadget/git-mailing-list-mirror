Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3363C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 22:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899F220775
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 22:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="esIFcMI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgD3WKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 18:10:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62103 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgD3WKD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 18:10:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBC53BBAC9;
        Thu, 30 Apr 2020 18:09:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=61GEwxjeOpHVdePayS+CF7EU7jI=; b=esIFcM
        I5dAYLMyw7ZXJFX+qdEOKaKxD05F52oesgvSYsOtqXyd5DrzhRjFixfXg4dLrdUb
        d8DkTE/UcL78NENas7E1R4E1nDwYl/k4dkf1pzJQ+SouOINhi6VBEIYBsMdTQUCL
        RDSO+0ORkSAdm6lAYAcdQXvqc/H1TNoMrXeZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jgqjehaE3wkLne2NRpWJ0v8HKbMkRpds
        bgl4WbXdSl1nyVXCgrqLJ+BTpTEPixVb7yMNylrKPHADKhwIpv7z9gbZxnatKUNj
        GR6zTSyuAkgywBfzX1KtCM9mPy65zscVuoIlEbS7jXMxp40aA5goY0ELHYTuPS/E
        9BNXHiC1UlI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4149BBAC7;
        Thu, 30 Apr 2020 18:09:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 39302BBAC6;
        Thu, 30 Apr 2020 18:09:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] bugreport: collect list of populated hooks
References: <20200427233820.179891-1-emilyshaffer@google.com>
        <20200430012425.209122-1-emilyshaffer@google.com>
        <20200430015049.GA115238@google.com>
        <xmqqv9lgswar.fsf@gitster.c.googlers.com>
Date:   Thu, 30 Apr 2020 15:09:55 -0700
In-Reply-To: <xmqqv9lgswar.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 30 Apr 2020 10:44:28 -0700")
Message-ID: <xmqqwo5wpqvg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53B7DE24-8B2F-11EA-B05E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> When we do that, this "mkdir .git/hooks" will fail because the
>> directory already exists.  Ideas:
>>
>>  A. Include a preparatory patch in this series that removes that "mv"
>>     command.  That way, this test can do
>
> While I do not think it is realistic to anticipate that the "test"
> repository may someday come with a hooks/ directory, even if we did
> so, we would not enable any hook by default in there.  So "move away
> and restore" feels way overkill.
>
>>   B. Run "git init" ourselves so we know what we're getting:
>
> That is certainly safer, and simpler.  But perhaps the simplest
> would be
>
>     C. Use "mkdir -p .git/hooks" so we won't get affected.

In the meantime, I added this SQUASH on top.  I do not claim that
this is the best solution, but the idea is to refuse to be affected
by what is left in .git/hooks either by the test framework or
earlier tests in the same test script file.

 t/t0091-bugreport.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 612c12a918..9450cc02e3 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -58,11 +58,14 @@ test_expect_success 'can create leading directories outside of a git dir' '
 '
 
 test_expect_success 'indicates populated hooks' '
-	test_when_finished rm git-bugreport-hooks.txt &&
-	test_when_finished rm -fr .git/hooks &&
+	rm -fr .git/hooks &&
 	mkdir .git/hooks &&
-	write_script .git/hooks/applypatch-msg &&
-	write_script .git/hooks/prepare-commit-msg.sample &&
+	for hook in applypatch-msg prepare-commit-msg.sample
+	do
+		write_script ".git/hooks/$hook" <<-\EOF || return 1
+		echo "hook $hook exists"
+		EOF
+	done &&
 	git bugreport -s hooks &&
 	grep applypatch-msg git-bugreport-hooks.txt &&
 	! grep prepare-commit-msg git-bugreport-hooks.txt
-- 
2.26.2-447-gd61d20c9b4

