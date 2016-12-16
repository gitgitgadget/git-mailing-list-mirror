Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FA41FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 18:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757798AbcLPSyR (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 13:54:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64272 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757643AbcLPSyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 13:54:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E972655901;
        Fri, 16 Dec 2016 13:54:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KJEexpPOV8NmDSTx4/E+48szav0=; b=Baelua
        b+ogOfgAYsAcbscBuOxNIN0IStkzusYOeoBu7WxqzAkG7iWyvUWt2I/x+qX3QIpo
        TeklB4MnJDhUdfU8gnDGQiZGy5EZ0fPMrxxVE0M172969O5uRPP+Xg2aGuSR37/t
        apHeBt1zN3K+DGyNmnJDWWMnFCj/tPs3J0IqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qTt5ASv1Jzk1NrplZGsKGaUGSybTGPNQ
        oF9/7UVsaZ/cVbTgZ87GFNSepZyK4qMQis02X8RNb7ugeNANocl4uxghHVWBRRCB
        kf8PQTXie/PoZVPSBjg+VGub6Bff2J86484u1xtk0DRxIO/GMahN7g9x8Nu6XtU2
        bzTVPGxOSwQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E166355900;
        Fri, 16 Dec 2016 13:54:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6541D558FF;
        Fri, 16 Dec 2016 13:54:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: index-pack outside of repository?
References: <20161215204000.avlcfaqjwstkptu2@sigill.intra.peff.net>
        <xmqqshpou3wt.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 16 Dec 2016 10:54:13 -0800
In-Reply-To: <xmqqshpou3wt.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 15 Dec 2016 16:13:38 -0800")
Message-ID: <xmqqlgvfso16.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09F18846-C3C1-11E6-BC4E-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> ...
>> I'm actually wondering if the way it calls die() in 'next' is a pretty
>> reasonable way for things to work in general. It happens when we lazily
>> try to ask for the repository directory. So we don't have to replicate
>> logic to say "are we going to need a repo"; at the moment we need it, we
>> notice we don't have it and die. The only problem is that it says "BUG"
>> and not "this operation must be run in a git repository".
>
> Isn't what we currently have is a good way to discover which
> codepaths we missed to add a check to issue the latter error?

I am tempted to suggest an intermediate step that comes before
b1ef400eec ("setup_git_env: avoid blind fall-back to ".git"",
2016-10-20), which is the attached, and publish that as part of an
official release.  That way, we'll see what is broken without
hurting people too much (unless they or their scripts care about
extra message given to the standard error stream).  I suspect that
released Git has a slightly larger user base than what is cooked on
'next'.

 environment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 0935ec696e..88f857331e 100644
--- a/environment.c
+++ b/environment.c
@@ -167,8 +167,11 @@ static void setup_git_env(void)
 	const char *replace_ref_base;
 
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-	if (!git_dir)
+	if (!git_dir) {
+		if (!startup_info->have_repository)
+			warning("BUG: please report this at git@vger.kernel.org");
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+	}
 	gitfile = read_gitfile(git_dir);
 	git_dir = xstrdup(gitfile ? gitfile : git_dir);
 	if (get_common_dir(&sb, git_dir))
