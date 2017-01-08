Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C90D20756
	for <e@80x24.org>; Sun,  8 Jan 2017 02:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941930AbdAHCd2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 21:33:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56574 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933053AbdAHCd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 21:33:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 588D85D9D1;
        Sat,  7 Jan 2017 21:33:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DBv01F0uQWxMg4kBFXtHX3nei9M=; b=gqimYN
        +1shVN37SGSY9S8F0v2Ighh3LNDxPv5+EwbDu2NrwnyHoOU025v96kIaYygAiNrV
        h5+tpIV3JE4pXrenv28oKAILKP42DJ6acQqDDu9Y8RM5DxGS8ID30pO+4IukvQUX
        wLkS1Vt8ZzxItpEv4+9/gFYY7E3+hBpsVBVWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T7sPUxJUK8lfwpTRmzWdIoF1WY78dzwR
        ef3LUFFAl1UvFKdbIbonW6PzUr5QKvSGk/taKV2MJPtToM/oKXoLyIyZ2aMzMhP6
        H5Rne6mfyUhaetm01jboi6xIJs8dMyXKw33OaKkWwkZWgJYcsGL7wr04Kn85a1av
        yFrONqajzQc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50A415D9D0;
        Sat,  7 Jan 2017 21:33:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B57C55D9CF;
        Sat,  7 Jan 2017 21:33:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
Date:   Sat, 07 Jan 2017 18:33:23 -0800
In-Reply-To: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 2 Jan 2017 13:09:03 +0100
        (CET)")
Message-ID: <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D44E5322-D54A-11E6-B41A-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +			if (ssh) {
> +				char *split_ssh = xstrdup(ssh);
> +				const char **ssh_argv;
> +
> +				if (split_cmdline(split_ssh, &ssh_argv))
> +					ssh_argv0 = xstrdup(ssh_argv[0]);
> +				free(split_ssh);
> +				free((void *)ssh_argv);
> +			} else {
>  				/*
>  				 * GIT_SSH is the no-shell version of
>  				 * GIT_SSH_COMMAND (and must remain so for
> @@ -807,8 +813,11 @@ struct child_process *git_connect(int fd[2], const char *url,
>  				if (!ssh)
>  					ssh = "ssh";
>  
> -				ssh_dup = xstrdup(ssh);
> -				base = basename(ssh_dup);
> +				ssh_argv0 = xstrdup(ssh);
> +			}
> +
> +			if (ssh_argv0) {
> +				const char *base = basename(ssh_argv0);
>  
>  				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
>  					!strcasecmp(base, "tortoiseplink.exe");

I suspect that this will break when GIT_SSH_COMMAND, which is meant
to be processed by the shell, hence the user can write anything,
begins with a one-shot environment variable assignment, e.g.

	[core] sshcommand = VAR1=VAL1 VAR2=VAL2 //path/to/tortoiseplink

One possible unintended side effect of this patch is when VAL1 ends
with /plink (or /tortoiseplink) and the command is not either of
these, in which case the "tortoiseplink" and "putty" variables will
tweak the command line for an SSH implementation that does not want
such a tweak to be made.  There may be other unintended fallouts.

Sorry, no concrete suggestion to get this to work comes to my mind
offhand. 

Perhaps give an explicit way to force "tortoiseplink" and "putty"
variables without looking at and guessing from the pathname, so that
the solution does not have to split and peek the command line?


 connect.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/connect.c b/connect.c
index 8cb93b0720..1768122456 100644
--- a/connect.c
+++ b/connect.c
@@ -691,6 +691,23 @@ static const char *get_ssh_command(void)
 	return NULL;
 }
 
+static void get_ssh_variant(int *tortoiseplink, int *putty)
+{
+	const char *variant;
+	if (!git_config_get_string_const("ssh.variant", &variant))
+		return;
+	if (!strcmp(variant, "tortoiseplink")) {
+		*tortoiseplink = 1;
+		*putty = 1;
+	} else if (!strcmp(variant, "putty")) {
+		*tortoiseplink = 0;
+		*putty = 1;
+	} else {
+		*tortoiseplink = 0;
+		*putty = 0;
+	}
+}
+
 /*
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -824,6 +841,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, "-4");
 			else if (flags & CONNECT_IPV6)
 				argv_array_push(&conn->args, "-6");
+
+			get_ssh_variant(&tortoiseplink, &putty);
+
 			if (tortoiseplink)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
