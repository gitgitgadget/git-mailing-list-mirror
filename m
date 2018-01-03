Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78BBC1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 21:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbeACVPV (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 16:15:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60778 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750996AbeACVPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 16:15:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA02CD15F3;
        Wed,  3 Jan 2018 16:15:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N1usp4+nksRVz8dxfyPmtvpJnK0=; b=tPd/YS
        UNV2LpDjmuitMSO6ZAHsf7McckhdsXEniaFbqYLE4LA1xD700VUKw/wQ55b37uaV
        jD7iQ77kk0zkoVn2A++/ZwcZ1ELDYtKAkQ8vCQ0hufgM+I191EAXwKjeS8flYiOm
        3vIz//x2hZeuMvBOAjTI6vk13RjoDv8iiIbpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ftVTNp4d4I5Ls5NWXzliYpugIUQP2L0H
        SXLY0025jYpD0H3h3jAjPdK/2OmBM6OlHX+eny77J2xaJJY3RDudv4Q8wLfEQnA0
        zZoSlg/eCKH01QxLu8cu9a0/fT1MNqbKyDc4UzoMr/RWJvYTdUeEtwVrnMvevEY4
        xJ5lDlMKgHQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8127D15F0;
        Wed,  3 Jan 2018 16:15:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24CE9D15EF;
        Wed,  3 Jan 2018 16:15:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
        <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
        <20180103050730.GA87855@aiede.mtv.corp.google.com>
Date:   Wed, 03 Jan 2018 13:15:17 -0800
In-Reply-To: <20180103050730.GA87855@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 2 Jan 2018 21:07:30 -0800")
Message-ID: <xmqqk1wyhcey.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 338858FA-F0CB-11E7-B99B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> It's good you caught this flaw in the detection.  Would something like
> the following make sense?  If so, I can resend with a commit message
> and tests tomorrow or the day after.

So the idea is to keep the 'simple' for implementations that do not
support OpenSSH options, but declare that the auto-detection was
overly conservative and assume that -4/6/p are supported by
everybody?

This change means that those who were meant to be helped by the
original change, that introduced 'simple' and made the (overly
conservative) auto-detection, would now have to explicitly set
ssh.variant to simple, because otherwise they will be passed one of
these three options.  Am I reading the intention of the change
correctly?  If so, I tend to agree that it is lesser of the two
evils to make sure things continue to work for older openssh users
with their current setting like this patch does, even with the cost
of telling users with implementations that do not honor -4/6/p to
set things up manually, I guess.

Thanks, both, for digging this issue through.

>
> diff --git i/Documentation/config.txt w/Documentation/config.txt
> index 64c1dbba94..75eafd8db6 100644
> --- i/Documentation/config.txt
> +++ w/Documentation/config.txt
> @@ -2118,8 +2118,8 @@ ssh.variant::
>  	unrecognized, Git will attempt to detect support of OpenSSH
>  	options by first invoking the configured SSH command with the
>  	`-G` (print configuration) option and will subsequently use
> -	OpenSSH options (if that is successful) or no options besides
> -	the host and remote command (if it fails).
> +	OpenSSH options if that is successful or a conservative set of
> +	OpenSSH-style options if it fails.
>  +
>  The config variable `ssh.variant` can be set to override this detection.
>  Valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
> diff --git i/connect.c w/connect.c
> index c3a014c5ba..3784c2be53 100644
> --- i/connect.c
> +++ w/connect.c
> @@ -941,10 +941,9 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
>  
>  	if (flags & CONNECT_IPV4) {
>  		switch (variant) {
> -		case VARIANT_AUTO:
> -			BUG("VARIANT_AUTO passed to push_ssh_options");
>  		case VARIANT_SIMPLE:
>  			die("ssh variant 'simple' does not support -4");
> +		case VARIANT_AUTO:
>  		case VARIANT_SSH:
>  		case VARIANT_PLINK:
>  		case VARIANT_PUTTY:
> @@ -953,10 +952,9 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
>  		}
>  	} else if (flags & CONNECT_IPV6) {
>  		switch (variant) {
> -		case VARIANT_AUTO:
> -			BUG("VARIANT_AUTO passed to push_ssh_options");
>  		case VARIANT_SIMPLE:
>  			die("ssh variant 'simple' does not support -6");
> +		case VARIANT_AUTO:
>  		case VARIANT_SSH:
>  		case VARIANT_PLINK:
>  		case VARIANT_PUTTY:
> @@ -970,10 +968,9 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
>  
>  	if (port) {
>  		switch (variant) {
> -		case VARIANT_AUTO:
> -			BUG("VARIANT_AUTO passed to push_ssh_options");
>  		case VARIANT_SIMPLE:
>  			die("ssh variant 'simple' does not support setting port");
> +		case VARIANT_AUTO:
>  		case VARIANT_SSH:
>  			argv_array_push(args, "-p");
>  			break;
> @@ -1026,7 +1023,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
>  				 VARIANT_SSH, port, flags);
>  		argv_array_push(&detect.args, ssh_host);
>  
> -		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
> +		variant = run_command(&detect) ? VARIANT_AUTO : VARIANT_SSH;
>  	}
>  
>  	argv_array_push(&conn->args, ssh);
> diff --git i/t/t5601-clone.sh w/t/t5601-clone.sh
> index 0f895478f0..0224edc85b 100755
> --- i/t/t5601-clone.sh
> +++ w/t/t5601-clone.sh
> @@ -365,6 +365,11 @@ test_expect_success 'OpenSSH variant passes -4' '
>  	expect_ssh "-4 -p 123" myhost src
>  '
>  
> +test_expect_success 'OpenSSH passes GIT_PROTOCOL envvar' '
> +	git -c protocol.version=1 clone [myhost:123]:src ssh-v1-clone &&
> +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
> +'
> +
>  test_expect_success 'variant can be overridden' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/putty" &&
>  	git -c ssh.variant=putty clone -4 "[myhost:123]:src" ssh-putty-clone &&
> @@ -377,19 +382,32 @@ test_expect_success 'variant=auto picks based on basename' '
>  	expect_ssh "-4 -P 123" myhost src
>  '
>  
> -test_expect_success 'simple does not support -4/-6' '
> +test_expect_success 'variant=simple does not support -4/-6' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
> -	test_must_fail git clone -4 "myhost:src" ssh-4-clone-simple
> +	test_must_fail git -c ssh.variant=simple clone -4 "myhost:src" ssh-4-clone-simple
>  '
>  
> -test_expect_success 'simple does not support port' '
> +test_expect_success 'variant=simple does not support port' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
> -	test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-simple
> +	test_must_fail git -c ssh.variant=simple clone "[myhost:123]:src" ssh-bracket-clone-simple
> +'
> +
> +test_expect_success 'old OpenSSH passes -4 and -p' '
> +	copy_ssh_wrapper_as "$TRASH_DIRECTORY/old" &&
> +	git -c ssh.variant=auto clone -4 "[myhost:123]:src" old-ssh-clone &&
> +	expect_ssh "-4 -p 123" myhost src
>  '
>  
> -test_expect_success 'uplink is treated as simple' '
> +test_expect_success 'old OpenSSH does not pass GIT_PROTOCOL envvar' '
> +	copy_ssh_wrapper_as "$TRASH_DIRECTORY/old" &&
> +	git -c protocol.version=1 -c ssh.variant=auto clone "[myhost:123]:src" old-ssh-protocol-v1 &&
> +	expect_ssh "-p 123" myhost src
> +'
> +
> +test_expect_success 'uplink is treated as old OpenSSH' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
> -	test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
> +	git -c protocol.version=1 clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
> +	expect_ssh "-p 123" myhost src &&
>  	git clone "myhost:src" ssh-clone-uplink &&
>  	expect_ssh myhost src
>  '
> @@ -405,8 +423,8 @@ test_expect_success 'OpenSSH-like uplink is treated as ssh' '
>  	test_when_finished "rm -f \"\$TRASH_DIRECTORY/uplink\"" &&
>  	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
>  	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\"" &&
> -	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
> -	expect_ssh "-p 123" myhost src
> +	git -c protocol.version=1 clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
> +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
>  '
>  
>  test_expect_success 'plink is treated specially (as putty)' '
