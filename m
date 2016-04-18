From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Mon, 18 Apr 2016 15:04:18 -0700
Message-ID: <CA+P7+xrisA0qqQ01GoSUdNm+O85NN9H7arovzqDD2e5GUv2GAw@mail.gmail.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com> <1461013950-12503-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:04:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asHHf-0001tQ-12
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 00:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbcDRWEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 18:04:39 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35110 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcDRWEj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 18:04:39 -0400
Received: by mail-vk0-f49.google.com with SMTP id t129so237720536vkg.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yk1bL1+J+k8UUMmnWBijhFP+oCVvhJjhCuzIbE7fx8s=;
        b=k1YQ/Ct0zly6tjX2Xz4/evAZrGmnPJeCZbs2q7cQ+5PeCg4v4bKsIUd7GeLM6eiP5N
         JoKpwEApUqpzeXnJAFFjyEzQX8SyIgDGxy62zHlIwrB2Cr9XvmL6QCFfjctZ3tj7PICH
         ngIZBW/GUkXFbkNQFU9Q1HFA6K71W1WLkWrc70DeFiMhv9A5vqkeqwhoQ7zjBMXRFIFU
         jqskzk46v32fS7WPT9M+V8ANIIPm59dxu4HHKdVOaUtCGYB0UItkKX2MlEYOwT9awBtJ
         DJKlVFkMwYVHg6DGL2WNFeqRp7plC1gPCruuC9Q0+P5MSSw5gOpDCP8zRXS5apkda4Nf
         t/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yk1bL1+J+k8UUMmnWBijhFP+oCVvhJjhCuzIbE7fx8s=;
        b=XfA5WTULYDLGIwSKGSclIZvV0vZJay3PJyoZrHpxFo6z3+qcFmrRcT/atpQDKrMbxL
         M2oEo1YfF4Jvvb4JuGQM9fYO6nYUxD7nY2NjLRWitktSx2Zzi+ptNLPIZ4Xyz1Ck//O7
         i08ZyIasLMqlj2LbU+uL4AmaDeCLI+IzNd5H5n8RMqg1M0urvUsr4TXny+yiEr1wHriC
         JXp9yOd0xeLiAOrSTOMcTYJ0Ssw9K+etc44jmLWCF6V4Yf+Jnv9ILzR7WsIjKEY4k/zP
         TjCsZEkWnlzPJd+1aKamKNfAc65cNMKTA6JCoBkL6Qhhq3cxhNhBEaNg60dDaW3BWf4Z
         OUCQ==
X-Gm-Message-State: AOPr4FWqIol2UB7mFhfVA94i6FeWG8gvJzn7B7QfGyRfYJPPEt/f0Nc5QJTGmsPvEpS8Ersu3mkB4Hrcgya1iw==
X-Received: by 10.31.147.15 with SMTP id v15mr10086467vkd.58.1461017077459;
 Mon, 18 Apr 2016 15:04:37 -0700 (PDT)
Received: by 10.159.53.112 with HTTP; Mon, 18 Apr 2016 15:04:18 -0700 (PDT)
In-Reply-To: <1461013950-12503-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291832>

On Mon, Apr 18, 2016 at 2:12 PM, Stefan Beller <sbeller@google.com> wrote:
> In order to produce the smallest possible diff and combine several diff
> hunks together, we implement a heuristic from GNU Diff which moves diff
> hunks forward as far as possible when we find common context above and
> below a diff hunk. This sometimes produces less readable diffs when
> writing C, Shell, or other programming languages, ie:
>
> ...
>  /*
> + *
> + *
> + */
> +
> +/*
> ...
>
> instead of the more readable equivalent of
>
> ...
> +/*
> + *
> + *
> + */
> +
>  /*
> ...
>
> Implement the following heuristic to (optionally) produce the desired
> output.
>
>   If there are diff chunks which can be shifted around, shift each hunk
>   such that the last common empty line is below the chunk with the rest
>   of the context above.
>
> This heuristic appears to resolve the above example and several other
> common issues without producing significantly weird results. However, as
> with any heuristic it is not really known whether this will always be
> more optimal. Thus, it can be disabled via diff.compactionHeuristic.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Thanks Stephan and Junio, this looks pretty good. I think before it's
merged we'd probably want to implement some sort of attributes which
allows per-path configuration, incase it needs to be configured at
all.

I've got it applied to my local git, and I'm going to try to run a
diff between enabled vs disabled on a large section of the Linux
kernel history and a few other projects to see if I spot anything odd.

Thanks,
Jake
