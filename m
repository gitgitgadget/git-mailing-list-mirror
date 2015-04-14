From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] add -p: demonstrate failure when running 'edit' after
 a split
Date: Tue, 14 Apr 2015 16:46:09 -0400
Message-ID: <CAPig+cQQrWUESdOdVCS_sU+muttt=P+sRJBjzrWTEUn10+aSDw@mail.gmail.com>
References: <vpq7ftfkpue.fsf@anie.imag.fr>
	<1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
	<1429011168-23216-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:46:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi7iq-0007UV-8I
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 22:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbbDNUqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 16:46:11 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33910 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbbDNUqK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 16:46:10 -0400
Received: by lbcga7 with SMTP id ga7so18622396lbc.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kk1sPMcJ/4OBQRYJG/DskvqmIlYxCFptk1XXTv7HTwo=;
        b=A8dg7E0qbrTVJr+M/M1GXoUJ5EH+S0YpMVV3qFQY50aYzOV8gho6mo04S+18qA4Vkr
         h0CFOl1KQ4LMFD3xwAlgf6AEqyvAK+66nydxUyKYBhZ1VQ3dml0rAgKZdUzPwSBRiHRf
         VvIx0F/DMkTJcT4zzk1OE5lyK5Tz699zY1Bovz3uWycUCSk5JDtgIetQ9Zbrvc9bvEe9
         g47B+YXlHvqO2RCsJbZxlzULLHVqceDBr2I6QYy+nnWNC23B0dYcRR/3ANALFS/eTy8R
         t4RwDRDGjO//B/2RicFxHOgJa8RivhXRUSW37URI6gHQBARJqQ1Dy5A6K3cHVrfNc9fX
         YtlQ==
X-Received: by 10.152.2.130 with SMTP id 2mr20175604lau.120.1429044369335;
 Tue, 14 Apr 2015 13:46:09 -0700 (PDT)
Received: by 10.114.25.193 with HTTP; Tue, 14 Apr 2015 13:46:09 -0700 (PDT)
In-Reply-To: <1429011168-23216-2-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: WqZXIOS3I_QpTX1apJKxKamCzfc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267161>

On Tue, Apr 14, 2015 at 7:32 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> The test passes if one replaces the 'e' command with a 'y' command in
> the 'add -p' session.
>
> Reported-by: Tanky Woo <wtq1990@gmail.com>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 24ddd8a..b48a75c 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -335,6 +335,31 @@ test_expect_success 'split hunk "add -p (edit)"' '
>         ! grep "^+15" actual
>  '
>
> +test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
> +       cat >test <<-\EOF &&
> +       5
> +       10
> +       20
> +       21
> +       30
> +       31
> +       40
> +       50
> +       60
> +       EOF
> +       git reset &&
> +       # test sequence is s(plit), n(o), y(es), e(dit)
> +       # q n q q is there to make sure we exit at the end.
> +       for a in s n y e   q n q q
> +       do
> +               echo $a
> +       done |

Simplified:

    printf '%s\n' s n y e q n q q |

> +       EDITOR=: git add -p 2>error &&
> +       test_must_be_empty error &&
> +       git diff >actual &&
> +       ! grep "^+31" actual
> +'
> +
>  test_expect_success 'patch mode ignores unmerged entries' '
>         git reset --hard &&
>         test_commit conflict &&
> --
> 2.4.0.rc1.42.g9642cc6
