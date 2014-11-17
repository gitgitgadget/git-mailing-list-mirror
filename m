From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Re: [PATCH] gc: support temporarily preserving garbage
Date: Tue, 18 Nov 2014 10:59:14 +1100
Message-ID: <CADoxLGMFzujP6kKNpExsCSzQrUrpsgPOcgLmFA_yU7S=NhQorQ@mail.gmail.com>
References: <1415927805-53644-1-git-send-email-brodie@sf.io>
 <xmqqlhnd1j66.fsf@gitster.dls.corp.google.com> <20141117213442.GD15880@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	Git Mailing List <git@vger.kernel.org>,
	Bryan Turner <bturner@atlassian.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 01:00:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqWDB-0005O8-Du
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 01:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbaKQX75 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2014 18:59:57 -0500
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:41335 "HELO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751982AbaKQX74 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 18:59:56 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]) (using TLSv1) by na3sys009aob126.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVGqL++j0x2DdhdVadY+4zeplXfpHIvNH@postini.com; Mon, 17 Nov 2014 15:59:56 PST
Received: by mail-wg0-f52.google.com with SMTP id a1so2618304wgh.39
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 15:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=jiSgQlIFCzQrBL88eRMIBwoxowDvfLcOgzLgX9HqMXc=;
        b=hG0kjAhit/J4yRWXpo0/8Vtvcsjm/hLKskZ+jhotwVQMu2BK6hKf1klwW+3x0f7nMp
         Hgpdx6c0SLsq+5A9RJDByFZNpBVwJK0+qrVcQzVoT2gQdMV6CH6VEGIGfRSjFqi3KeeQ
         RsjOvJnjMmAjTSpP/fxuJUivZaz9BreZ7YGjxje7ew8CSeTdkUXs0AzAI7c2J/LjeJcf
         Cgc6s0pXxK3Hc+8AZ+TA9ue9n3gsMUfFMiUA7AM2LA0ms5WOp9iQfuFRPAvdL21rZfqy
         qMDZS4u+tfh67Qnc9KJUkD/Yh7U10pDw7Mx5oa5WW+l/RBtXjCBFwcr67p22hzp+69c2
         +hMA==
X-Gm-Message-State: ALoCoQn/n1AS9qe8aSX927JWzBOrtqsA6lBFuFIIc871z/y9wKOsnRfq+LZXE3UUYoWrX8rCTCSJ8MjKH7fzIic/Y7L3o5MSX6T+x3JqQcubM6OVQjxKUBgDUPNC0/sBc4iZa7oIGr+EK5Db2iTDXKnMH1UiEODitg==
X-Received: by 10.180.20.163 with SMTP id o3mr9803185wie.12.1416268794694;
        Mon, 17 Nov 2014 15:59:54 -0800 (PST)
X-Received: by 10.180.20.163 with SMTP id o3mr9803172wie.12.1416268794617;
 Mon, 17 Nov 2014 15:59:54 -0800 (PST)
Received: by 10.27.211.66 with HTTP; Mon, 17 Nov 2014 15:59:14 -0800 (PST)
In-Reply-To: <20141117213442.GD15880@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 November 2014 08:34, Jeff King <peff@peff.net> wrote:

>>
>> I am not sure if this much of code churn is warranted to work around
>> issues that only happen on repositories on NFS servers that do not
>> keep open-but-deleted files available.  Is it an option to instead
>> have a copy of repository locally off NFS?
>
> I think it is also not sufficient. This patch seems to cover only
> objects. But we assume that we can atomically rename() new versions o=
f
> files into place whenever we like without disrupting existing readers=
=2E
> This is the case for ref updates (and packed-refs), as well as the in=
dex
> file.  The destination end of the rename is an unlink() in disguise, =
and
> would be susceptible to the same problems.

I=E2=80=99m going out on a limb here as my NFS knowledge is rather shal=
low but a
rename should be atomic even on NFS.

"The RENAME operation must be atomic to the client.=E2=80=9D
(https://www.ietf.org/rfc/rfc1813.txt: 3.3.14)

Does git do something differently here for that not to be the case?
