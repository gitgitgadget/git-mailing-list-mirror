Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E901C20193
	for <e@80x24.org>; Thu, 27 Oct 2016 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbcJ0Tor (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 15:44:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58820 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755146AbcJ0Tom (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 15:44:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB43048EE9;
        Thu, 27 Oct 2016 15:44:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uj4CdzgY2d+QKCR8CSnBjemukRM=; b=ob3U7g
        KgrpX1kE1xjgg2NqYKyauhk6H5EcGF6qMrbVgLFm5d5QSIK/ZWXUT7NtT7+ed8vG
        D2+nv98gcjypZlJA/MM8RQfFRYZVVWIwofUNNvgW0Sl0ymX2TEPEdfRLacGbhyD8
        uHVcHfYA7USo42gQnIikNYltQohd+N+tjdyZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bHnJFI/Zesc+fZn54593umzBFtTNNXd4
        UkNMIxVVwhRQlIUUdNC1HivaQ5gYHM5pzd4ESE+RERzg3U+qkc1ffz9dTAqwnY3h
        RfkrdhjoNlDtZutzWyen7q8BW+h/Ry655rSZiNOCBLeCnewqRVU5LdcpcrKjNX59
        j1LyFyPKfsw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2ADB48EE8;
        Thu, 27 Oct 2016 15:44:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2211948EE7;
        Thu, 27 Oct 2016 15:44:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Gavin Lambert <github@mirality.co.nz>
Subject: Re: [PATCH] git-svn: do not reuse caches memoized for a different architecture
References: <653aa0cd566a2486bbc38cfd82ddfcfdfe48271c.1477398004.git.johannes.schindelin@gmx.de>
        <20161025212357.GA8683@starla>
Date:   Thu, 27 Oct 2016 12:44:38 -0700
In-Reply-To: <20161025212357.GA8683@starla> (Eric Wong's message of "Tue, 25
        Oct 2016 21:23:57 +0000")
Message-ID: <xmqqmvhp60gp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCC30BA8-9C7D-11E6-ABCA-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
>> +++ b/perl/Git/SVN.pm
>> @@ -1658,6 +1658,11 @@ sub tie_for_persistent_memoization {
>>  	if ($memo_backend > 0) {
>>  		tie %$hash => 'Git::SVN::Memoize::YAML', "$path.yaml";
>>  	} else {
>> +		# first verify that any existing file can actually be loaded
>> +		# (it may have been saved by an incompatible version)
>> +		if (-e "$path.db") {
>> +			unlink "$path.db" unless eval { retrieve("$path.db"); 1 };
>> +		}
>
> That retrieve() call is unlikely to work without "use Storable"
> to import it into the current package.
>
> I also favor setting "$path.db" once to detect typos and avoid
> going over 80 columns.  Additionally, having error-checking for
> unlink might be useful.
>
> So perhaps squashing this on top:
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 025c894..b3c1460 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1660,10 +1660,15 @@ sub tie_for_persistent_memoization {
>  	} else {
>  		# first verify that any existing file can actually be loaded
>  		# (it may have been saved by an incompatible version)
> -		if (-e "$path.db") {
> -			unlink "$path.db" unless eval { retrieve("$path.db"); 1 };
> +		my $db = "$path.db";
> +		if (-e $db) {
> +			use Storable qw(retrieve);
> +
> +			if (!eval { retrieve($db); 1 }) {
> +				unlink $db or die "unlink $db failed: $!";
> +			}
>  		}
> -		tie %$hash => 'Memoize::Storable', "$path.db", 'nstore';
> +		tie %$hash => 'Memoize::Storable', $db, 'nstore';
>  	}
>  }
>  
>
> Thoughts?  Thanks.

Just peeking from the sideline, but the your squash looks like an
improvement to me.

Hopefully the final version after your interaction with Dscho can
come to me via another "pull this now"?

Thanks.
