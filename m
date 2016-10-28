Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1A8203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 19:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755815AbcJ1TNW (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 15:13:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51541 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753174AbcJ1TNW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 15:13:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E631449001;
        Fri, 28 Oct 2016 15:13:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VuDmypWtuV5HqXcS5bWXUzMs5fQ=; b=p0/xTj
        IekPSqQzsMeAwxIIG1pyQovbXvJqb3uOIvbsKSTCWz3LSplGxFcpuF6mNpZK5JO0
        kgY44/M5frHzYo9Wbz9FOmFgDqbWNeIV8jOGaqUOR19Y8kQvaNB+1VdHRBKxVXdn
        3c1o4X3UOaLTY35VIey68O2qjT7JXQ8NEn0Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GnKz+EYqkrJ35V6r/50XOZwSaHuq6R9f
        //AEz9SzM6vgJTERjzU3avM9zmtaQ6C8Bx+EDELihjn+o2YgHMJcpVyJ7/03MD6q
        2LZWmzCQKdSV942Is6V1sN7xF53hhg1uwsDfQEJD8wvrJcnb6qBBwaSXLeGx49AG
        +R+T38iTwu0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDFAE4A000;
        Fri, 28 Oct 2016 15:13:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A17349FFF;
        Fri, 28 Oct 2016 15:13:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kannan Goundan <kannan@cakoose.com>
Cc:     git@vger.kernel.org
Subject: Re: "git push" says "src refspec XYZ matches more than one" even without explicit XYZ argument.
References: <CAM7aVoUOxx6Fa+yG2JzQhoX-mE4Lgp9ejvwncx5bdL+1tuQQFg@mail.gmail.com>
Date:   Fri, 28 Oct 2016 12:13:18 -0700
In-Reply-To: <CAM7aVoUOxx6Fa+yG2JzQhoX-mE4Lgp9ejvwncx5bdL+1tuQQFg@mail.gmail.com>
        (Kannan Goundan's message of "Thu, 27 Oct 2016 20:00:40 -0700")
Message-ID: <xmqq1sz01e41.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96B41582-9D42-11E6-B4B1-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kannan Goundan <kannan@cakoose.com> writes:

> 1. My repo has a branch named 'v1' that is tracking 'origin/v1'.
> 2. My repo has a tag named 'v1'.
> 3. I have "push.default" set to "upstream".
>
> I made a commit on branch 'v1' and tried doing a push:
>
>     # git push
>     error: src refspec v1 matches more than one.
>     error: failed to push some refs to 'git@github.com:whatever/ns1-go.git'
>
> If I rename the branch to 'v1-dev', then the push goes through.
>
> I understand why the command "git push origin/v1 v1" is ambiguous.
> But if I do a plain "git push", I thought Git would know to push my
> current branch.
>
> [Git version 2.10.1 from Homebrew on Mac OS 10.11.6.]

Thanks.  

You are right that the refspec Git internally create for this case
should not be v1:refs/heads/v1, which would notice that the source
side (e.g. "v1") is ambiguous.  Instead we should spell that out.

Perhaps something like this would fix it for you?

 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3bb9d6b7e6..02fd235742 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -194,7 +194,7 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 			die_push_simple(branch, remote);
 	}
 
-	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
+	strbuf_addf(&refspec, "%s:%s", branch->refname, branch->merge[0]->src);
 	add_refspec(refspec.buf);
 }
 
