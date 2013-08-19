From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 10:28:03 -0700
Message-ID: <CA+55aFxYRspM+FNyXX8v7WTeCfSAzPdFWSYCzC16J3iJvygRhA@mail.gmail.com>
References: <1376900499-662-1-git-send-email-prohaska@zib.de>
	<1376926879-30846-1-git-send-email-prohaska@zib.de>
	<CA+55aFzQhJqE4QDwJDKtkTtJpMNbz3_Aw5_Q3yTk5DnhLJyjCQ@mail.gmail.com>
	<xmqqeh9p8ut3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 19:28:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBTFU-0007Rk-Uq
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 19:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346Ab3HSR2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 13:28:07 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:38637 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3HSR2E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 13:28:04 -0400
Received: by mail-ve0-f179.google.com with SMTP id c13so3290716vea.10
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H1aZqD+FGNP3K/PfK6CPERd5ViwiPxGsq0phaNQOVQo=;
        b=Epdis9nlc5UGmYR6Vgh1guejleJCySW15igThitg3MRUzlwhqkfOh6bI8n9V/bGJIX
         1bU0zDeVmyrlxAstm/nZ6DhwN9BiOzbzOaNtKUQulMf+ug2y6Kbpdr/wAuamb0EGgIq3
         15ib8I4dEXxswfpVVHkhxvb/cDBWbJhw1IjhtfSNmMka36Z7kPvoUqksO9VljOTTr/TX
         nsJPhTqc0Ww1q4bOBv000m8niXFcDoduI789w6xmTnYyzBicCP0RjAlqpDcorCuQ7fWz
         pScIkXhU29y6H3yC3/+6MgltjmCBPyDw5RedmG1YLOfKs/YXFCDr2bipSs7JHQqxwj8P
         oagg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H1aZqD+FGNP3K/PfK6CPERd5ViwiPxGsq0phaNQOVQo=;
        b=Vj7I9gWgmw5simj71vn6LCvuiTxHNOaDm6HLL20tyQS9X5FtIaXLsjBkDgkqXd/45r
         2UmpHDgoyjnqyg3MHLgd4a/qoFSp3TfcCqvTKIaJ2Hy8Ofvn62JaQnoMHmKU6VFqu5/8
         ES3+wsg7X2Uiy+BM+mqhTA9pbGzyzpUlB1P5o=
X-Received: by 10.220.145.75 with SMTP id c11mr1039412vcv.30.1376933283257;
 Mon, 19 Aug 2013 10:28:03 -0700 (PDT)
Received: by 10.220.3.137 with HTTP; Mon, 19 Aug 2013 10:28:03 -0700 (PDT)
In-Reply-To: <xmqqeh9p8ut3.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 5O0q1Sm6FB6H92OOB3vv8DLN-B4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232556>

On Mon, Aug 19, 2013 at 10:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> The same argument applies to xwrite(), but currently we explicitly
> catch EINTR and EAGAIN knowing that on sane systems these are the
> signs that we got interrupted.
>
> Do we catch EINVAL unconditionally in the same codepath?

No, and we shouldn't. If EINVAL happens, it will keep happening.

But with the size limiter, it doesn't matter, since we won't hit the
OS X braindamage.

> Could
> EINVAL on saner systems mean completely different thing (like our
> caller is passing bogus parameters to underlying read/write, which
> is a program bug we would want to catch)?

Yes. Even on OS X, it means that - it's just that OS X notion of what
is "bogus" is pure crap. But the thing is, looping on EINVAL would be
wrong even on OS X, since unless you change the size, it will keep
happening forever.

But with the "limit IO to 8MB" (or whatever) patch, the issue is moot.
If you get an EINVAL, it will be due to something else being horribly
horribly wrong.

                 Linus
