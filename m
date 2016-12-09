Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DD9D1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 23:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753678AbcLIXCN (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 18:02:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51307 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753665AbcLIXCM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 18:02:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7839556423;
        Fri,  9 Dec 2016 18:02:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oWh4D1p3iknzoBVrD0uNXv6Gg1c=; b=hTOzQq
        nKYPcqPX8FXaHPT4q7FyqHc3KzrohRlJqz02Wr6JAUrRWDDBAb54/u4rXHDZhmF6
        cFbpiq7Kw0Q6kpigJxUbOzx5wWu/0vPCezzVBNVpNBqDHXEBCA/GN8vSloSFJQBl
        YZU6t71hlzRMzWtE7kJ9aSLo/cC9m9VxO5O90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wb9umJMXfUucNe+aoEYrdw00BBxCDqFq
        r75Gn43xJVDdnW34ISy+UwfduAF+JQLk2x3BMpydoSzL2Bqp5ZpWT9QOXRzQPDRX
        wfCG+uP5evqkibI0I6WsnrYXb/b2QA9ylrGpT3c9PU2cmA2ZCNEE9MT48CdfDIbb
        3l+g34n6RUk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FE3856422;
        Fri,  9 Dec 2016 18:02:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D468056421;
        Fri,  9 Dec 2016 18:02:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] difftool: chdir as early as possible
References: <20161209085848.10929-1-davvid@gmail.com>
        <20161209085848.10929-2-davvid@gmail.com>
Date:   Fri, 09 Dec 2016 15:02:09 -0800
In-Reply-To: <20161209085848.10929-2-davvid@gmail.com> (David Aguilar's
        message of "Fri, 9 Dec 2016 00:58:47 -0800")
Message-ID: <xmqqbmwkr9ji.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 841C05A0-BE63-11E6-B530-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> @@ -182,10 +188,6 @@ EOF
>  		}
>  	}
>  
> -	# Go to the root of the worktree so that the left index files
> -	# are properly setup -- the index is toplevel-relative.
> -	chdir($workdir);
> -
>  	# Setup temp directories
>  	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
>  	my $ldir = "$tmpdir/left";

What codebase are you basing your work on?  I do not see these
removed four lines in my tree, so it seems that the patch is fixing
up some other fix I do not yet have.

> @@ -235,10 +237,10 @@ EOF
>  			symlink("$workdir/$file", "$rdir/$file") or
>  			exit_cleanup($tmpdir, 1);
>  		} else {
> -			copy("$workdir/$file", "$rdir/$file") or
> +			copy($file, "$rdir/$file") or
>  			exit_cleanup($tmpdir, 1);
>  
> -			my $mode = stat("$workdir/$file")->mode;
> +			my $mode = stat($file)->mode;
>  			chmod($mode, "$rdir/$file") or
>  			exit_cleanup($tmpdir, 1);
>  		}
> @@ -430,10 +432,10 @@ sub dir_diff
>  			$error = 1;
>  		} elsif (exists $tmp_modified{$file}) {
>  			my $mode = stat("$b/$file")->mode;
> -			copy("$b/$file", "$workdir/$file") or
> +			copy("$b/$file", $file) or
>  			exit_cleanup($tmpdir, 1);
>  
> -			chmod($mode, "$workdir/$file") or
> +			chmod($mode, $file) or
>  			exit_cleanup($tmpdir, 1);
>  		}
>  	}
