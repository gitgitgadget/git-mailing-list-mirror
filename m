Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E87B1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754847AbcK3WEp (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:04:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64750 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751086AbcK3WEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:04:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E5E654BCB;
        Wed, 30 Nov 2016 17:04:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=56WdrN9FIfqgAHjnrZiLdjeARtk=; b=IqhA3h
        X87KRDYiXrYUTc98aqdBotM85USX9Gxpg3ooUUMOWhseZ7+rsBh62lrEPg95+Vrk
        budIw+xOWypK0RU3/4SAA+3AAZifZkuhn3QUklHzP91YIbhElrcunKfl/Tk/0UUw
        jHAAuEExz9tyYzlJ1NOu8shhFoNdC0NRdA8dY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ww1czBXm2zzI0sD8QqlovSFI9TXpsUC7
        09vq9arhxmDt4WpeB3P6OFKiiSy47e0CvjOgaPj9hQlrjsSg5dmdly2s7G3Oxcff
        KBreEdK32dceMuvSqutdE4IKWvIhIPdcde4LpiN0D8Y9Hxo6f13wloX+bPCGsWy0
        45gz+UqP9yM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71CAD54BC9;
        Wed, 30 Nov 2016 17:04:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4A1A54BC7;
        Wed, 30 Nov 2016 17:04:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, Peter Urda <peter.urda@gmail.com>
Subject: Re: "git add -p ." raises an unexpected "warning: empty strings as pathspecs will be made invalid in upcoming releases. please use . instead if you meant to match all paths"
References: <CAEnOLdvG=SoKFxeJ_pLmamGj_8osC+28TSg+pbFLLTr+ZLcpQA@mail.gmail.com>
        <20161130211100.GA18680@ikke.info>
Date:   Wed, 30 Nov 2016 14:04:40 -0800
In-Reply-To: <20161130211100.GA18680@ikke.info> (Kevin Daudt's message of
        "Wed, 30 Nov 2016 22:11:00 +0100")
Message-ID: <xmqq7f7kd3pj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEAAA42E-B748-11E6-B090-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> On Wed, Nov 30, 2016 at 12:31:49PM -0800, Peter Urda wrote:
>> After upgrading to version 2.11.0 I am getting a warning about empty
>> strings as pathspecs while using 'patch'
>> 
>> - Ran 'git add -p .' from the root of my git repository.
>> 
>> - I was able to normally stage my changes, but was presented with a
>> "warning: empty strings as pathspecs will be made invalid in upcoming
>> releases. please use . instead if you meant to match all paths"
>> message.
>> 
>> - I expected no warning message since I included a "." with my original command.
>> 
>> I believe that I should not be seeing this warning message as I
>> included the requested "." pathspec.

Yes, this seems to be caused by pathspec.c::prefix_pathspec()
overwriting the original pathspec "." into "".  The callchain
looks like this:

    builtin/add.c::interactive_add()
     -> parse_pathspec()
        passes argv[] that has "." to the caller,
        receives pathspec whose pathspec->items[].original
	is supposed to point at the unmolested original,
        but prefix_pathspec() munges "." into ""
     -> run_add_interactive()
        which runs "git add--interactive" with
	pathspec->items[].original as pathspecs


Perhaps this would work it around, but there should be a better way
to fix it (like, making sure that what we call "original" indeed
stays "original").

 builtin/add.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e8fb80b36e..137097192d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -167,9 +167,18 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	if (revision)
 		argv_array_push(&argv, revision);
 	argv_array_push(&argv, "--");
-	for (i = 0; i < pathspec->nr; i++)
+	for (i = 0; i < pathspec->nr; i++) {
 		/* pass original pathspec, to be re-parsed */
+		if (!*pathspec->items[i].original) {
+			/*
+			 * work around a misfeature in parse_pathspecs()
+			 * that munges "." into "".
+			 */
+			argv_array_push(&argv, ".");
+			continue;
+		}
 		argv_array_push(&argv, pathspec->items[i].original);
+	}
 
 	status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
 	argv_array_clear(&argv);
@@ -180,7 +189,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 {
 	struct pathspec pathspec;
 
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_SYMLINK_LEADING_PATH |
 		       PATHSPEC_PREFIX_ORIGIN,
