From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Re: [PATCH] gc: support temporarily preserving garbage
Date: Sat, 15 Nov 2014 12:49:25 +1100
Message-ID: <CADoxLGM3HLo-33LgWjuPKiS1s2XS6Z6ozpW1QskuqqbyR3Ng2A@mail.gmail.com>
References: <1415927805-53644-1-git-send-email-brodie@sf.io> <xmqqlhnd1j66.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brodie Rao <brodie@sf.io>, Git Mailing List <git@vger.kernel.org>,
	Bryan Turner <bturner@atlassian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 02:58:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpSdL-0005fj-5h
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 02:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbaKOB62 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2014 20:58:28 -0500
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:56489 "HELO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751619AbaKOB61 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 20:58:27 -0500
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Nov 2014 20:58:27 EST
Received: from mail-wi0-f172.google.com ([209.85.212.172]) (using TLSv1) by na3sys009aob116.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVGazQzqFpK/y1Yu68wBE9MSXltxvOMeg@postini.com; Fri, 14 Nov 2014 17:58:27 PST
Received: by mail-wi0-f172.google.com with SMTP id bs8so1042779wib.17
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 17:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Ol3rdVEnYmIrdRDmBE/7dDfKcjqcmnMWNFslsazkYh8=;
        b=D0zxZr7BpG3WjfzT41VTPJHjPtCYdboSIu0uTm9AwqjyofgmgoCE1wQvvzBqyrpz7M
         RA5e88IJ8cYAzr4IKd9YK7e5s+JDsPGKmA9BthLZix8PZLoepYmLTmVjHyuQoYEf9XTn
         yzosdHSYYUhmo1WzF1OCNPBlW21gAko1/yyOTLxD8Y4xdo0H8sF1Kp+vCPMb1LVvC9qJ
         7cQe0WwvNYWA//4EKdHcFgG+SP0TDni37m/X3+Rn6U2Hf3YzSCDWmZ8T+ug9SgUzPRvh
         9OXk/9OBdaQx12RLtCSqRp306gEN2VHQmezgKpm6gjCUKzVe93Kaq+BLWt4w/CFXvwBk
         rC+A==
X-Received: by 10.180.91.70 with SMTP id cc6mr12712097wib.5.1416016205968;
        Fri, 14 Nov 2014 17:50:05 -0800 (PST)
X-Gm-Message-State: ALoCoQlp0wd7d5cohyhzE8ArqwSw7xmQZruhMUeasdHSYxEm2rcpwJ1VexN+X03aIwh5otKzs4dUbQ4NLJebYJmDZnOcriuIRrzWXohNuV0vhP9jR68SVwTkt1uQZLVZNUpRgB7rK4Dj2zl58dLMLPtSbB95N3DZvw==
X-Received: by 10.180.91.70 with SMTP id cc6mr12712081wib.5.1416016205807;
 Fri, 14 Nov 2014 17:50:05 -0800 (PST)
Received: by 10.27.178.6 with HTTP; Fri, 14 Nov 2014 17:49:25 -0800 (PST)
In-Reply-To: <xmqqlhnd1j66.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 November 2014 10:01, Junio C Hamano <gitster@pobox.com> wrote:

>>  23 files changed, 375 insertions(+), 7 deletions(-)
>
> I am not sure if this much of code churn is warranted to work around
> issues that only happen on repositories on NFS servers that do not
> keep open-but-deleted files available.  Is it an option to instead
> have a copy of repository locally off NFS?

Unfortunately not providing delete-on-last-close semantics is true for
most (all?) NFS servers that are accessed by multiple clients. NFS v3
is stateless so the server has no way of tracking open files accross
clients and the silly rename work around only works within a single
client. NFS v4 could support delete-on-last-close semantics but I=E2=80=
=99m
not sure if there are actual implementations providing that.
(This is based on my admittedly limited understanding of NFS, I=E2=80=99=
d love
to learn that I=E2=80=99ve got this wrong).

We are susceptible to the same problem accessing shared repositories
from multiple clients so we certainly appreciate the use case.
Unfortunately copying repositories to the local nodes is not something
that=E2=80=99d be feasible.

Is there another/better approach solving this problem?
