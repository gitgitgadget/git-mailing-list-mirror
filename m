Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3EE820323
	for <e@80x24.org>; Thu, 16 Mar 2017 16:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbdCPQUe (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 12:20:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65402 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753269AbdCPQUd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 12:20:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE9EF688FF;
        Thu, 16 Mar 2017 12:20:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iqGCc+x5GeAn/pJMKfDuqKsaXco=; b=Sb0sOs
        zTno3SaDTu7iWy2X6x6yNf5kltPE6/jLuN/b21QVy1tw++gMGBpqNdHNBOPlGtbc
        b0w4gOrtbU/r8v8GZh7s9K8MDSvo/JEfWX18jXKYps03m3KLBMLbaFHOxhSUHXxq
        DkdR0fBH2yx6vj0PJZkFk4eBvWOr1KaNHCsl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bcXQQk/XWs5GXciSLt7YG79kNDWcA/e5
        13TPv6lsvwcB3+U7kTckCGV0RV2i4rg9LxAsbZwzEwjZw0PBaxdbn0PHyP3Wd+Wl
        V2wjKHDqd9ydLoRzXHTULea6uFZTh1v0Nl8nP0naSuNg/aqBe6dCyR9A0XLeiZnI
        LGXAlW+ES7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E690B688FE;
        Thu, 16 Mar 2017 12:20:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B1C3688FD;
        Thu, 16 Mar 2017 12:20:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v4 3/4] credential-cache: use XDG_CACHE_HOME for socket
References: <20170314003246.71586-4-lehmacdj@gmail.com>
        <20170316051827.97198-1-lehmacdj@gmail.com>
        <20170316051827.97198-4-lehmacdj@gmail.com>
Date:   Thu, 16 Mar 2017 09:20:29 -0700
In-Reply-To: <20170316051827.97198-4-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Thu, 16 Mar 2017 01:18:26 -0400")
Message-ID: <xmqqd1dhchwy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 791520CC-0A64-11E7-850E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> +	If your home directory is on a network-mounted filesystem, you
> +	may need to change this to a local filesystem. You must specify
> +	an absolute path.

Nicely explained. 

If a socket cannot be created in "~/.git-credential-cache", existing
users would have created a symbolic link that points at a local
directory.  With XDG_CACHE_HOME mechanism, they would just set the
variable to directly point at a local directory and there is no need
for symlink trick, on the other hand.

Which points us back to the observation I made in my review on the
previous step.

> +static char *get_socket_path(void)
> +{
> +	char *old_credential_dir, *socket;
> +	old_credential_dir = expand_user_path("~/.git-credential-cache");
> +	if (old_credential_dir && directory_exists(old_credential_dir))
> +		socket = expand_user_path("~/.git-credential-cache/socket");
> +	else
> +		socket = xdg_cache_home("credential/socket");
> +	free(old_credential_dir);
> +	return socket;
> +}

As we do not want to use the dir.c::directory_exists(), which is
meant to be used for working tree files, we can do something like
this instead:

static char *get_socket_path(void)
{
	struct stat st;
	char *path;

	path = expand_user_path("~/.git-credential-cache");
	if (path && !stat(path, &st) && S_ISDIR(st.st_mode))) {
		free(path);
		path = expand_user_path("~/.git-credential-cache/socket");
	} else {
		path = xdg_cache_home("credential/socket");
	}                
	return path;
}

The duplication of "~/.git-credential-cache" bothers me somewhat and
perhaps people can suggest better ways to get rid of the dup.

Other than that, makes sense to me.

Thanks.
