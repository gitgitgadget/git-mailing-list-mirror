From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/6] pack-objects hook for upload-pack
Date: Tue, 24 May 2016 17:59:15 -0700
Message-ID: <CAPc5daV6bdUKS-ExHmpT4Ppy2S832NXoyPw7aOLP7fG=WrBPgg@mail.gmail.com>
References: <20160518223712.GA18317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 02:59:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5NAi-0006RQ-GR
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 02:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbcEYA7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 20:59:36 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34093 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbcEYA7f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 20:59:35 -0400
Received: by mail-yw0-f178.google.com with SMTP id c127so33355074ywb.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 17:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Y/EMS3cFXh7341UW/DnjLF4BT2WwDnvrPyy3ASH3NCU=;
        b=nLcmNDbiasva0GVd7wiXhf/OLFtvNv6qhwTgu5EHuxAqlLZ3PMxJzgQH/sKTMLfyhR
         bzXBso8OwvFqTYwnkRUtcpLb19lC6e9///7Vt7cesyxSpUI3nQSV2+j+8pzjcBRwkLgo
         1hUliC2/C4ICsqAbTPwYYNLWMDZJ6zJizVgwE6EA6nsMXcPwNpZZ3MM+UiCB+QxG2d0M
         AxkIfeZQL6xpabFArKA6hW5jKM9D5d9EXnhRkalH9h/4hIoFGN3ilBCp7mfWsqNOcsno
         DQDaH1eK5odNJTBwGJRR8JZWCIvn+3SA/LL12fAiCkI41O4//c0Pj+JVLZVUTj4mnRf0
         f70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Y/EMS3cFXh7341UW/DnjLF4BT2WwDnvrPyy3ASH3NCU=;
        b=Jdd3FH/4w9/v0iKGlgSls+y89xXoYn+V39YC4xwvcYFq1vW6/WXGHxBMRhlPtDE9io
         CCmDLAIeyDLyHGPI745XFYp4UmA4dnzXAi+MqQ6sX1rQSYL76u8+muaiWmRRPE6WD1VI
         3DLrW8s0a4x9p37zN3DiHfO1U+1yyEzxpoizNnVURGWCbU7WhWDhDbsbUjax6QZLkIor
         XxVd08p8tKPEFVirtcNWD0PtXGWQdDfO71IM+/iHlM22u+7XZK5hDYi9vn4yyhHQKGBx
         Xobw6ZwQUhp2/FRvQllUDFZg1bJO8IJFY0L4a7/1N1choKU/pVpmKIcuzGhDHcBEaMZI
         BQUQ==
X-Gm-Message-State: ALyK8tKOcKsQ5p7+5bvX02KalcO6JkpgLC1G8zas9vYSysXa9qPJEjSmpvh68b4yr8cjbjUpn8/ib11rDp3HIQ==
X-Received: by 10.37.99.136 with SMTP id x130mr672999ybb.123.1464137974838;
 Tue, 24 May 2016 17:59:34 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Tue, 24 May 2016 17:59:15 -0700 (PDT)
In-Reply-To: <20160518223712.GA18317@sigill.intra.peff.net>
X-Google-Sender-Auth: yeizm2HrK3oEyq1vQKIwmzR2VZc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295549>

On Wed, May 18, 2016 at 3:37 PM, Jeff King <peff@peff.net> wrote:
> I've often wanted to intercept the call from upload-pack to
> pack-objects. The final patch in this series goes into more detail, but
> basically it's good for:
>
>   1. Capturing the output from pack-objects for debugging/inspection.
>
>   2. Capturing the input to pack-objects to replay for debugging or
>      performance analysis.
>
>   3. Caching pack-objects output.
>
> It's pretty trivial to add a hook to run instead of pack-objects (and
> the hook would just run pack-objects itself). But we don't want to run
> hooks in upload-pack, because we don't necessarily trust the repository
> we're running in.

Although I'd need to study the final step a bit more carefully than I did,
overall I think these are good changes. The way the callbacks learn
about the origin of the configuration may have to be rethought in the
long run, though. We already have been relying on a filename thing
kept separately as a global variable, and the approach taken by this
series extends it, so we are not making anything fundamentally worse,
but at some point we may need to bite the bullet and pass kv-info as
an extra callback parameter or something.

Thanks.
