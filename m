From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/8] t5520: prevent field splitting in content comparisons
Date: Mon, 18 May 2015 11:07:26 -0700
Message-ID: <xmqqa8x1dajl.fsf@gitster.dls.corp.google.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
	<1431955978-17890-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 20:07:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPS0-0002rO-10
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbbERSHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:07:30 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34550 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbbERSH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:07:28 -0400
Received: by igbhj9 with SMTP id hj9so15028764igb.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xFKDTUtD/jqvWpxsmAC0P0gYjxCSyxZJBug/n6hcTxs=;
        b=nGB/+pP9wZBc24ZgXZ+At3OjHU3xIkT/o0XO0y+m4a0V4H5eJ4Aja7N5m3MRMM3tC/
         WT1gn1i/pU4lHuwNaYt7vdA0G9BxGhH1kRR0ka6d6ngE/QcqBPifxs31sObcDmSz4NPr
         Hm8EWus1OgZACpK38D2Wpgpf0CnlgJ0wbh/JgmfzJGFL3dljz1gWEpbjDKg290Hivjzj
         2lqWWcMPCWkhjA5v3oPZ2Yw/i1YbHo/OWbcBh9mK99IJ1VPk8MmAUaQ6/kc8spRS0kNE
         v5xqhN6NNibGxjtdl9sjz6Pb5IBuWcSAdQpMMDBStcCEyabUqX2iBlhy0k+Y0qp3ZXPK
         sl2A==
X-Received: by 10.50.79.196 with SMTP id l4mr16303834igx.48.1431972448088;
        Mon, 18 May 2015 11:07:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2120:a5f3:f7b6:7da9])
        by mx.google.com with ESMTPSA id p196sm8170890iop.15.2015.05.18.11.07.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 11:07:27 -0700 (PDT)
In-Reply-To: <1431955978-17890-2-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Mon, 18 May 2015 21:32:51 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269289>

Paul Tan <pyokagan@gmail.com> writes:

> Many tests in t5520 used the following to test the contents of files:
>
> 	test `cat file` = expected
>
> or
>
> 	test $(cat file) = expected
>
> These 2 forms, however, will be affected by field splitting and,
> depending on the value of $IFS, may be split into multiple arguments,
> making the test fail in mysterious ways.
>
> Replace the above 2 forms with:
>
> 	test "$(cat file)" = expected
>
> as quoting the command substitution will prevent field splitting.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
> * Removed use of "verbose"
>
> * The use of "wc -l" is not quoted, as the output of "wc -l" on a Mac contains
>   leading whitespace. See [1].
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/268950/focus=269052
>
>  t/t5520-pull.sh | 70 ++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)

Overall the series was a pleasant read.

Some common patterns (my mind is still continuing the verbose_test
topic) I noticed were

 (1) comparing output from two rev-parse output for object names. We
     have test_cmp_rev we can use for better readability (but its
     implementaiton may want to be updated not to contaminate the
     working tree unnecessarily). e.g

	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)"
     => test_cmp_rev HEAD^ copy
 
 (2) checking contents of a file, either from a working tree, from
     the index or from a rev, with a fixed short string.

	test_contents () {
                case "$1" in
                *:*)	git cat-file blob "$1" ;;
                *)	cat "$1" ;;
                esac >actual &&
		printf "%s" "$2" >expect &&
		if ! cmp -s expect actual
                then
			echo "Unexpected contents in '$1'"
			test_cmp expect actual
		else
			: good ;
		fi
	}

     or something.


I think it is a good idea *not* to address these patterns within
this series, and have people come back to them _after_ the series
settles, to reduce code churn and unnecessary conflicts.

Thanks.
