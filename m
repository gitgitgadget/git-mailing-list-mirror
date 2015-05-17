From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Sun, 17 May 2015 10:37:08 -0700
Message-ID: <xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
	<1431806796-28902-1-git-send-email-gjthill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 19:37:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yu2V9-0002W4-GZ
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 19:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbbEQRhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 13:37:12 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35844 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbbEQRhL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 13:37:11 -0400
Received: by iepj10 with SMTP id j10so6700802iep.3
        for <git@vger.kernel.org>; Sun, 17 May 2015 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oU8NtKaBWIOQpCMLs3Ak3bwnOmoM2VFsEQy75ecGUp0=;
        b=klI25pe0Dy/KVHJxznstWwrkzWRqNPcPRdwN/qT5FmZhBr2N6s222s7qkPLfHymSYz
         HgynE1lklv1i9qc+zcFVy9wh6lxMx7zKTK7ZPjkVY1EjMNPaZTUhsxOSwU2EQdRLJoYh
         4PHvOLT5FQ6EKjeNQfzYMkrSWaYvLH8ttMxYyIwh1tI+I1ykni2RbFzqJPgKk6Q3daTi
         q441nJsJZgRTrq1DXOhvAx1FhHnA5Ybogmu8kQEGo76vbRw+FIH57Hk37jAVJZ2ZMfdX
         Zvb85SQaQxxfpAOKuiQyL4M7AhkFf8U0sFrEk/ZVNAABV0WTy4qQGLjD2YNgriv9Fxt1
         tIMA==
X-Received: by 10.107.17.29 with SMTP id z29mr19959750ioi.69.1431884230449;
        Sun, 17 May 2015 10:37:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1b0:922b:6b11:b020])
        by mx.google.com with ESMTPSA id c20sm5930161ioc.40.2015.05.17.10.37.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 17 May 2015 10:37:09 -0700 (PDT)
In-Reply-To: <1431806796-28902-1-git-send-email-gjthill@gmail.com> (Jim Hill's
	message of "Sat, 16 May 2015 13:06:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269218>

Jim Hill <gjthill@gmail.com> writes:

> +test_expect_success "filter: smudge empty file" '
> +	git config filter.empty-in-repo.clean true &&

But this one is correct but tricky ;-)

If the contents to be cleaned is small enough (i.e. the one-liner
file used in this test) to fit in the pipe buffer and we feed the
pipe before 'true' exits, we won't see any problem.  Otherwise we
may get SIGPIPE when we attempt to write to the 'true' (non-)filter,
but because we explicitly ignore SIGPIPE, 'true' still is a "black
hole" filter.

"cat >/dev/null" may have been a more naive and straight-forward way
to write this "black hole" filter, but what you did is fine.

> +	git config filter.empty-in-repo.smudge "echo smudged && cat" &&
> +
> +	echo "empty-in-repo filter=empty-in-repo"  >>.gitattributes &&
> +	echo dead data walking >empty-in-repo &&
> +	git add empty-in-repo &&
> +
> +	echo smudged >expected &&
> +	git checkout-index --prefix=filtered- empty-in-repo &&
> +	test_cmp expected filtered-empty-in-repo

This is also correct but tricky.

    rm -f empty-in-repo && git checkout empty-in-repo

may have been more straight-forward, but this exercises the same
codepath and perfectly fine.

Will queue and let's merge this to 'next' soonish.

Thanks.

> +'
> +
>  test_done
