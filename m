From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Tue, 16 Dec 2014 14:37:23 -0500
Message-ID: <CAPig+cQyrTT6Ejrg_e2HveJGrn6qCnRWPBuJZKY91b+SzO6vPw@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, ronniesahlberg@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:37:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xw2-0000wA-RN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbaLPThZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:37:25 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:47592 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbaLPThY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:37:24 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so6891051yhl.37
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 11:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3vLFrWCSxLpVYP3OAsr11RueHLaldAjnoB46rRcKBlk=;
        b=FHeMydX9EnMMFb7GzjLfkojJQD6P8FlCxR9OJXSwUarCjxwjVCPS+XNJKPYJ1s6urL
         fZbtxuYrPzBYErJdkqpDveSY7cGXxgurSNHGDc51j3xjaSiQIprTZyttJSj9+IBH1J2T
         23CBtao1D5A6a9s2eY2wirGgPQSzbLL287ur1S/a/ih/m4cGx/YPnwFITDF67oFDjFf3
         1W0HtG6CJYUvnWXpWJaWcachoIu4BCnmF0lFzPCY+J5OuUOyJZithdv1zanqAyIweUpg
         /gkJAqJ+CXs5f+T3QaI3gUqop/Bhchf+fsfIZtIOi2wXQ0OEqgxT9foIw0qz3OzKuDj4
         TxuQ==
X-Received: by 10.236.70.100 with SMTP id o64mr27860274yhd.94.1418758643975;
 Tue, 16 Dec 2014 11:37:23 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Tue, 16 Dec 2014 11:37:23 -0800 (PST)
In-Reply-To: <1418755747-22506-6-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: pGuLvFppKloUOhp3hIUBas4DfQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261461>

On Tue, Dec 16, 2014 at 1:49 PM, Stefan Beller <sbeller@google.com> wrote:
> This adds tests for the atomic push option.
> The first four tests check if the atomic option works in
> good conditions and the last three patches check if the atomic
> option prevents any change to be pushed if just one ref cannot
> be updated.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
> new file mode 100755
> index 0000000..6354fc0
> --- /dev/null
> +++ b/t/t5543-atomic-push.sh
> @@ -0,0 +1,176 @@
> +#!/bin/sh
> +
> +test_description='pushing to a repository using the atomic push option'
> +
> +. ./test-lib.sh
> +
> +D=`pwd`

Junio already mentioned this previously, but this should be $(pwd)
rather than `pwd`.

However, more importantly, why is this variable declared at all since
it is never used by the script?

> +mk_repo_pair () {
> +       rm -rf workbench upstream &&
> +       test_create_repo upstream &&
> +       test_create_repo workbench &&
> +       (
> +               cd upstream && git config receive.denyCurrentBranch warn

This would be slightly easier to read if split over two lines.

> +       ) &&
> +       (
> +               cd workbench && git remote add up ../upstream

Ditto.

> +       )
> +}
> +
