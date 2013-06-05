From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v5 5/7] add tests for rebasing merged history
Date: Tue, 4 Jun 2013 22:44:21 -0700
Message-ID: <CANiSa6hGasdoeTtBp_DRaeo++LBPXL9D61EtmVLPz-YSGT-Jgw@mail.gmail.com>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-6-git-send-email-martinvonz@gmail.com>
	<7vk3m994mu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 07:44:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk6WK-0007t6-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 07:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab3FEFoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 01:44:24 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:50784 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3FEFoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 01:44:23 -0400
Received: by mail-we0-f176.google.com with SMTP id t56so919785wes.7
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 22:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nxH6bGndI1Wj1YmDrad7rqcNqroVP6GN2bQYuFJKENw=;
        b=ijwl3H7/nS2TOa5A6zEBQ7I00zljapNyvalRN3ijA5bg/Q80wumLOhCkaC/gP+ttEV
         anaLWyJMchAmo6AwYAHZeMx6xaTfmgTw8K5Z6+ZgoUsvC2QH4XNT94a/nb4lb+8d0lrS
         DlCk9+ZkXxN6lBJBIBDXApuzu+NXVgsyKjlXAUZkb8126XrO6XJoG8wA/LH5NIwYemGj
         O2KCzPZHmd3G1IXaNNw9nF5Zjo8ZH6sYo1GOkeWQsI+5ycAITIzudbX1i6aZHHZ3NOf/
         tqB0B7KwW1gZUL99E3PunevOGAlcdhZ7CHEYhDodl53AkEl9eZXZ9oW1DSFXxqqlwtTB
         jHTg==
X-Received: by 10.194.171.65 with SMTP id as1mr27071580wjc.40.1370411061860;
 Tue, 04 Jun 2013 22:44:21 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Tue, 4 Jun 2013 22:44:21 -0700 (PDT)
In-Reply-To: <7vk3m994mu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226432>

On Tue, Jun 4, 2013 at 10:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> ---
>> +#TODO: make all flavors of rebase use --topo-order
>> +test_run_rebase success 'e n o' ''
>> +test_run_rebase success 'e n o' -m
>> +test_run_rebase success 'n o e' -i
>
> I do not quite follow this TODO.
>
> While I think it would be nice to update "rebase" so that all
> variants consider replaying the commits in the same order, in this
> history you have:
>
> +# a---b-----------c
> +#      \           \
> +#       d-------e   \
> +#        \       \   \
> +#         n---o---w---v
> +#              \
> +#               z
>
> as long as o comes after n and e is shown before n or after o, which
> all three expected results satisify, it is in --topo-order, isn't it?

True, the TODO was too specific. I intended to get the list of commits
to rebase for all kinds of rebase by using 'git rev-list
--topo-order', but it doesn't really matter how the order is decided;
my goal was just to make it consistent. I'll update the TODOs.

>> +test_expect_success "rebase -p re-creates merge from side branch" "
>> +     reset_rebase &&
>> +     git rebase -p z w &&
>> +     test_cmp_rev z HEAD^ &&
>> +     test_cmp_rev w^2 HEAD^2
>> +"
>
> Hmm, turning the left one to the right one?
>
> +#       d-------e               d-------e
> +#        \       \               \       \
> +#         n---o---w     ===>      n---o   \
> +#              \                       \   \
> +#               z                       z---W
>
> If w were a merge of o into e (i.e. w^1 were e not o), what should
> happen?  Would we get the same topology?

Yes, it seems like it does yield the same topology. That seems to be
what I tested at first. Search for "wrong" in [1]. I think Johannes's
point was that it was not realistic, not that he's against it working
in the same way independent of parent order. I don't feel strongly on
whether to include a test for each direction. Unless others do, I
guess I'll leave it as is. (But I did add a test case just now to see,
so it's very little work for me if someone does want it included.)

> In other words, when asked to replay w on top of z, how would we
> decide which parent to keep (in this case, e is kept)?

Keep any parent that is not an ancestor of the new base? Or something like that.


  [1] http://thread.gmane.org/gmane.comp.version-control.git/205796/focus=205806
