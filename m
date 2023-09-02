Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE50C001DB
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 22:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjIBWRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 18:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjIBWRF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 18:17:05 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87428CE0
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 15:16:57 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id A022A3FA23;
        Sun,  3 Sep 2023 00:16:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 104723F956;
        Sun,  3 Sep 2023 00:16:53 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OoWPdgBpNTpI; Sun,  3 Sep 2023 00:16:53 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id ECC533FA21;
        Sun,  3 Sep 2023 00:16:51 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] Emit warning when rebasing without a forkpoint
Date:   Sat,  2 Sep 2023 18:16:38 -0400
Message-ID: <20230902221641.1399624-1-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.114.g06b8c4a877
In-Reply-To: <xmqq1qfiubg5.fsf@gitster.g>
References: <xmqq1qfiubg5.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=zNV7Rl7Rt7sA:10 a=N3miCFJ7AAAA:8 a=EB05EcHrLFStfZYGjRsA:9
        a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second version of the patch series.

Patch 1: Be able to use rebase.forkpoint and --root
Patch 2: Adding the warning + tests
Patch 3: Update documenation

I think I have covered most of your concerns and feedback in this second
version.

On 8/31/23 16:57, Junio C Hamano wrote:
> Wesley Schwengle <wesleys@opperschaap.net> writes:
>=20
> Here is my attempt to rewrite the above:
>=20
>      When 'git rebase' is run without specifying <upstream> on the
>      command line, the current default is to use the fork-point
>      heuristics, but this is expected to change in a future version
>      of Git, and you will have to explicitly give "--fork-point" from
>      the command line if you keep using the fork-point mode.  You can
>      run "git config rebase.forkpoint false" to adopt the new default
>      in advance and that will also squelch the message.

I agree. I'll change the text to your version.

> Note that the parsing of "rebase.forkpoint" is a bit peculiar in
> that
>=20
>   - By leaving it unspecified, the .fork_point =3D -1 in
>     REBASE_OPTIONS_INIT takes effect (which is unsurprising);
>=20
>   - By setting it to false, .fork_point becomes 0; but
>=20
>   - If you set the configuration variable to true, .fork_point
>     becomes -1, not 1.

I changed this in patch 1.

> And this is very much deliberate if I understand it correctly [*1*].
> By the time we get to this part of the code (i.e. .fork_point is
> -1), the user may already have rebase.forkpoint set to true.  IOW,
> setting it to 'true' is not a valid way to squelch this message.

So this works now with patch 2.

> Another worrysome thing about rebase.forkpoint is that it will be
> inevitable for folks to start complaining that it does not work the
> way other configuration variables do.  Setting the variable to
> 'true' is not the same as passing '--fork-point=3Dtrue' from the
> command line.

I think it is now with the current series.

> I actually think it would be a lot larger behaviour change with a
> huge potential to be received as a regression if we start making the
> variable to mean the same thing as passing '--fork-point=3Dtrue'.
> People may like the current "if you are rebuilding your branch on
> its usual upstream, pay attention to the rebase and rewind of the
> upstream itself, but if you are giving an explicit upstream from the
> command line, the tool does not second guess you with the fork-point
> heuristics" behaviour and prefer to set it to true.  We would be
> breaking them big time if suddenly the rebase.forkpoint=3Dtrue they
> set previously starts triggering the fork-point heuristics when they
> run "git rebase upstream".  So that needs to be kept in mind when/if
> we fix the "setting the variable, even to 'true', will squelch the
> warning".

I get what you are saying. My solution is to make the --fork-point or
--no-fork-point more explicit. People could use an alias for this?

It would mean a different approach to the problem and deprecating
rebase.forkpoint as a boolean value. It could become one of three values:
"true", "false" and "legacy". Where "legacy" can be "implicit" or "auto".
Although you had some ideas on "auto" already. I'm not sure on how I woul=
d call
it. "no-upstream"?

--=20
Wesley

Why not both?


