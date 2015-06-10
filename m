From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/19] pull: teach git pull about --rebase
Date: Wed, 10 Jun 2015 07:44:17 -0700
Message-ID: <xmqqmw07oc72.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-16-git-send-email-pyokagan@gmail.com>
	<xmqqk2vcuy10.fsf@gitster.dls.corp.google.com>
	<CACRoPnR5shi800KZ_Do5V469ZgZYAzUZKy9mNYNNRPF6HFqs_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hFD-0007Nu-BO
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 16:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbbFJOof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 10:44:35 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36654 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbbFJOoT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 10:44:19 -0400
Received: by igbpi8 with SMTP id pi8so37176101igb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oQrCyNUKLvCACo8OGmfzaqrbsAytMtn9hJX0NtH5V18=;
        b=CmDZxVZ44gG7F7qpd/TEBovebUDIIKkdc9EuY/aFH4hStoUiueQ3D5hS3QXUHSIEGI
         O4ap53nuk7DCkWOcOIzDToqGUkrEFhm7BeXQDzSwVNLReB+/QzMmXL7amjZNKCl3Y1as
         8KtZ24sYicSTsgZbkbfjSj9p0JPVSlnYkrCR0w607IoQ7gCNqT8VUyuQOmIbElaiWrDC
         J3agd7wnDhFVxefbwIYLT8y36kCXpFuMpq6upiDiYKzNdoZqGKKbGgehq8s42F9m+iPL
         LSnzG2Tk68jUURVhp7n+RX+zlFXqb8+Oa31oOzLwajSWswFIzxDVyKIfytWjEadoQA1i
         hb+A==
X-Received: by 10.50.108.7 with SMTP id hg7mr2238381igb.37.1433947458737;
        Wed, 10 Jun 2015 07:44:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id j20sm3387683igt.5.2015.06.10.07.44.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 07:44:18 -0700 (PDT)
In-Reply-To: <CACRoPnR5shi800KZ_Do5V469ZgZYAzUZKy9mNYNNRPF6HFqs_w@mail.gmail.com>
	(Paul Tan's message of "Wed, 10 Jun 2015 15:55:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271291>

Paul Tan <pyokagan@gmail.com> writes:

>> Hmph, it is somewhat surprising that we do not have such a helper
>> already. Wouldn't we need this logic to implement $branch@{upstream}
>> syntax?
>
> Right, the @{upstream} syntax is implemented by branch_get_upstream()
> in remote.c. It, however, does not check to see if the branch's remote
> matches what is provided on the command-line, so we still have to
> implement this check ourselves, which means this helper function is
> still required.
>
> I guess we could still use branch_get_upstream() in this function though.

It is entirely expected that existing function may not do exactly
what the new caller you introduce might want to do, or may do more
than what it wants.  That is where refactoring of existing code
comes in.

It somewhat feels strange that you have to write more than "shim"
code to glue existing helpers and API functions together to
re-implement what a scripted Porcelain is already doing, though.
It can't be that git-pull.sh implements this logic as shell script,
and it must be asking existing code in Git to do what the callers
you added for this function would want to do, right?  That suggests
that we must have enough logic already in C.
