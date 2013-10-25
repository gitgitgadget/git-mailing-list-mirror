From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] merge-base: teach "--fork-point" mode
Date: Fri, 25 Oct 2013 17:56:10 -0400
Message-ID: <CAPig+cTYKVsS6t5XAfNDryfUgcQaizd4W780AVjgKrW6Zzs-Vw@mail.gmail.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
	<xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
	<xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
	<526A19CA.9020609@viscovery.net>
	<xmqqmwlxjnq6.fsf@gitster.dls.corp.google.com>
	<xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 23:56:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZpMe-0006X1-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 23:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab3JYV4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 17:56:12 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:65134 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab3JYV4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 17:56:12 -0400
Received: by mail-la0-f42.google.com with SMTP id ea20so3614522lab.29
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rjaQ79cjHW2liFnXEn6upPIyb7KXhKOMPOBp6QDSo1Q=;
        b=vomdsdQ78iRvgwKDq65Yhm8XIbTQ08tp+syCPjjC2vSIJjIIQHo9lMZWwecYRKZSsb
         tlQkhIUTsK9JtBxwW5RrHJ2v/GvlXm595h30ktgO/ikhrOay5xh3TwlipmNbwRditmNb
         LDPZukdKi9b7BrZbUKiOKinTzDRRPCoJtTAWgSuaZjjqD4MN1Jis1Xtt5PPzl5JECRjz
         RtvFlMRnJrcdTQVNce1rqTa1p4ApeMsZUgpsRlqFOLQipLQsCAJL1JLjsOs3/leIKpPY
         Yyfgxb+8M3ur32UsRXgI4+H08kCuNXMPkAIGIY/AYxMWjKuXoDC96wsJeOTfSBu9NF1V
         9sQg==
X-Received: by 10.152.88.74 with SMTP id be10mr6813471lab.4.1382738170326;
 Fri, 25 Oct 2013 14:56:10 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Fri, 25 Oct 2013 14:56:10 -0700 (PDT)
In-Reply-To: <xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 4DPubGyTaoBL5_5_cHbhTjVQR5k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236717>

On Fri, Oct 25, 2013 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
> index 87842e3..b383766 100644
> --- a/Documentation/git-merge-base.txt
> +++ b/Documentation/git-merge-base.txt
> @@ -137,6 +143,31 @@ In modern git, you can say this in a more direct way:
>
>  instead.
>
> +Discussion on fork-point mode
> +-----------------------------
> +
> +After working on the `topic` branch created with `git checkout -b
> +topic origin/master`, the history of remote-tracking branch
> +`origin/master` may have been rewound and rebuilt, leading to a
> +history of this shape:
> +
> +                        o---B1
> +                       /
> +       ---o---o---B2--o---o---o---B (origin/master)
> +               \
> +                B3
> +                 \
> +                  Derived (topic)
> +
> +where `origin/master` used to point at commits B3, B2, B1 and now it
> +points at B, and your `topic` branch was stated on top of it back
> +when `origin/master` was at B3. This mode uses the reflog of
> +`origin/master` to finds B3 as the fork point, so that the `topic`

s/finds/find/

> +can be rebased on top of the updated `origin/master` by:
> +
> +    $ fork_point=$(git merge-base --fork-point origin/master topic)
> +    $ git rebase --onto origin/master $fork_point topic
> +
>
>  See also
>  --------
