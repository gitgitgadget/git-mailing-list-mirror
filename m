Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8761D1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936482AbcJTPz5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 11:55:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52809 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757358AbcJTPzz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 11:55:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8469461B0;
        Thu, 20 Oct 2016 11:55:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DqJ3XolbwPr5zKGE/EKKp1vUQi0=; b=pMO9x6
        74imGo6A5+juHjFtVUcSB9f5MTeJb3xjX7V6y3Koh/4YzCniw8R/52cIpxqcy2zZ
        MQn2JqhWVSvrWeDHpWbZz8XIH1Dp9Dqs3iV0T2SwLY3SDRh830s8YgZ0toSfvBy2
        JzmiMehT5NmB6T+uXaCSIhIskbZM3OM8fibck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CZf0uJpGBFS8D8NepB4w8woHMfJxtvry
        t5gvXgoMwMpiSf1j7DswvrHJ5kC6SVhAuDoZx2CqRXFSWueX9wS9P+dB3BvAZybN
        GikzEBH2stYbe4Nc+BwyHAiVAJbtX7xCMtxrCDp0ALfAGuZt6VdLqj078h+m8XEZ
        vXNf4cQF3Fg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FFE5461AE;
        Thu, 20 Oct 2016 11:55:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1959C461AD;
        Thu, 20 Oct 2016 11:55:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Cc:     git@vger.kernel.org
Subject: Re: How to rename remote branches if I only have "client access"?
References: <nuamc4$uvk$1@blaine.gmane.org>
Date:   Thu, 20 Oct 2016 08:55:51 -0700
In-Reply-To: <nuamc4$uvk$1@blaine.gmane.org> (Manuel Reimer's message of "Thu,
        20 Oct 2016 17:03:35 +0200")
Message-ID: <xmqqr37bhv5k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADEB6CE8-96DD-11E6-A515-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Manuel Reimer <Manuel.Spam@nurfuerspam.de> writes:

> I have the following branches on my remote repo:
>
> new_version
> master
>
> I now want the "new_version" branch to be the "master" and the old
> "master" has to be renamed to the old version number (in my case
> 0.2.0).
>
> How to do this? 

I assume you have "git push" access into this remote repository.

You are correct that there is no way for you to tell "git push" (or
any Git native method) to rename "master" to "maint-0.2.0".

What you can do is to push the commits at the tip of "master" and
"new_version" to "maint-0.2.0" and "master" respectively, and then
delete "new_version".  If the 'master' and 'new_version' you locally
have are already the 'master' and 'new_version' you have over there
that you want to see sit at the tips of updated 'maint-0.2.0' and
'master' branches, then:

    git push $remote master:refs/heads/maint-0.2.0 new_version:master
    git push $remote :new_version

would do this.

Note that in the <source>:<dest> syntax in "git push", the <source>
side refers to the names in your local repository; if your local
'master' is different from what you want to see at the tip of
'maint-0.2.0' at the remote after this, replace it with whatever
name you give to that commit locally in the above example.

Also note that the this push may not succeed if your new_version is
not a descendant of the current 'master' at the remote.  You'd need
to use +<source>:<dest> to force it if that is the case.

The second command that has an empty <source> is to delete <dest>.

Lastly, the remote side can be configured to forbid deletion of
branches, and/or to forbid forced pushes.  If your remote is
configured that way (which is not default), then there is no way for
you to do any of the above (and that is by design---the server
operators use these configuration variables to forbid you from doing
something, so you shouldn't be able to override that choice).

> Currently this causes me much trouble as I can't
> delete the remote "master" repository as this is the "remote current
> repository"...

Sorry, but you lost me here. You were talking about two branches in
a single repository that is remote earlier.  I do not know what this
"remote master repository" you bring up in this paragraph is, and
why you can't remove it.  Not that I want to know the answers to
these questions myself.  I just do not understand these as a reason
behind your wanting to rename branches at a remote repository.
