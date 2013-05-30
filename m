From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 20:02:50 +0530
Message-ID: <CALkWK0=bgM+fYcVEwjHHF8k2Q8wMmjdbM5bxXdPH6s9StDH_Ng@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
 <CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com> <CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu May 30 16:33:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3v6-0000oq-K3
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 16:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405Ab3E3Odd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 10:33:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57435 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757037Ab3E3Odc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 10:33:32 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so189811bkb.33
        for <git@vger.kernel.org>; Thu, 30 May 2013 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lNqYlVhViwxg/6LN2AuPRinPpZ5eTQPmKdnIxSpsVic=;
        b=wbDBNlTQ153i2laW13gMEcHnmgD/JMkYU+1GR0mLfGGM24k3NvlRXFvoWBHAOHOUYk
         AA4VimTnPkSgLzbiKdl2emP3GlIjbxjMaTuBsmWbmXrHabslsyZESg8NY01nunlG9OtP
         ZjEJxu5Erofc74YO01NMjswA/WRmF0kRXgvX3kM2mNTipeYtjfC1iZD47jiR2ksjKYbz
         cClpkkLsIpscHGYXCmYIVj6A7f5LQ1gRQyEkG02f7rmzGAJfDzs6fLPX4ulh95YnT9AM
         aJTxYWUDGF8M/Y7x+jX5/TJ24FRn+d0l8MFxkikS/xC/kheUPgxmYuG6jzD6Yyn2Fn6I
         GosQ==
X-Received: by 10.204.109.200 with SMTP id k8mr1962284bkp.82.1369924410534;
 Thu, 30 May 2013 07:33:30 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Thu, 30 May 2013 07:32:50 -0700 (PDT)
In-Reply-To: <CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226002>

Alex Benn=C3=A9e wrote:
> And through my "special" repo:
>
>  41.58%   git  libcrypto.so.1.0.0  [.] sha1_block_data_order_ssse3
>  33.62%   git  libz.so.1.2.3.4     [.] inflate_fast
>  10.39%   git  libz.so.1.2.3.4     [.] adler32
>   2.03%   git  [kernel.kallsyms]   [k] clear_page_c
>
>  I'm not sure why libcrypto features so highly in the results

While Duy churns on the delta chain, let me try to make a (rather
crude) observation:

What does it mean for libcrypto to be so high in your perf report?
sha1_block_data_order is ultimately by object.c:parse_object.  While
it indicates that deltas are taking a long time to apply (or are
somehow not optimally organized for IO), I think it indicates either:

1. Your history is very deep and there are an unusually high number of
deltas for each blob.  What are the total number of commits?

2. You have have huge (binary) files checked into your repository.  Do
you?  If so, why isn't the code in streaming.c kicking in?
