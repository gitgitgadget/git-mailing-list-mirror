Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4948C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiEXWv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiEXWv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:51:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A743A5C662
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:51:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A49E9127E10;
        Tue, 24 May 2022 18:51:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=22veOSuZ8OOks+pJZSTJmuMhx3GVCfs3hpnuTJJwoJ0=; b=ifwF
        q3mdLAe5rzcefY6FwCXrbYn9JOLBI9Rvd/n5ab+mMACPxGIJH2Y411RxNB8TvPee
        Ra73L9AzCAeeQAfw/lYePWNs9QMwvb8tpT85fTqvZi3R54yICeOwHe0HW0fMcMza
        ZZ4fSOiRjqg+LJHOnpcBqhQsxdc2ugiP69Yf0nU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CC9F127E0E;
        Tue, 24 May 2022 18:51:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FD39127E0D;
        Tue, 24 May 2022 18:51:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olsson John <john.olsson@saabgroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Error handling when giving empty command line arguments
References: <dc08a8ee5ed64850872fd6529d1462e1@saabgroup.com>
Date:   Tue, 24 May 2022 15:51:52 -0700
Message-ID: <xmqq35gyee7r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B5508C2-DBB4-11EC-96B7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olsson John <john.olsson@saabgroup.com> writes:

>   git fetch "${force}"
> ...
>   $ git fetch ""
>   fatal: no path specified; see 'git help pull' for valid url syntax
>   $
> ...
> That is, 'git fetch' does not check if the given string is an
> empty string before writing the error message. The empty string is
> completely unrelated to any path/URI and in this case it was not
> that helpful.

The user is not giving enough information to Git to allow it to tell
if "git fetch ''" it got came from any of these with unset variable:

	$ git fetch "$path"
	$ git fetch "$url"
	$ git fetch "$force"

because all Git sees is an empty string.

It is unfair to complain "is completely unrelated".  The user didn't
give enough information to even allow Git to tell if it is or is not
related.

The message _is_ complaining about a malformed URL.  You can fetch
from a local repository by specifying the path to the directory, or
you can fetch from a remote repository by specifying a URL.  Since
"" turns out to be neither a valid path or URL, the message hints
that it didn't see any path or valid url on the command line.  This
is coming from connect.c::parse_connect_url() that does not know
which end-user facing command ended up reaching there, so it is
understandable that it picked a command that ought to be more
familiar to users, i.e. "pull".  FWIW, 

	$ git ls-remote ""

would also give the same message that refers to "git help pull".

By the way, the "fatal" message talks about 'git help pull'; I
wonder if it should say "git help fetch" instead, although they will
refer to the same text included from Documentation/urls.txt.

Thanks.
