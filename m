From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe --contains: default to HEAD when no commit-ish is given
Date: Fri, 21 Aug 2015 09:30:40 -0700
Message-ID: <xmqqoai07gen.fsf@gitster.dls.corp.google.com>
References: <1440072823-18024-1-git-send-email-szeder@ira.uka.de>
	<1440168632-15412-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Aug 21 18:30:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSpDO-00079i-0D
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 18:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbbHUQan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 12:30:43 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35636 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbbHUQal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 12:30:41 -0400
Received: by pacdd16 with SMTP id dd16so47576315pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 09:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=oTAPjYYTHxjSxgI+rMYVru9JgUeDXQ8T5otR9MQxstk=;
        b=JnL1rvkXDRzR/uoZOMSPlZ9UY8NFXhuOe3rve7wRHHX6jD4Pfs+EDRcLk29AWYj3ZM
         Ey3Lwt0IP8L/ijkJs16COdIoUAQijXg0PrhdKnb10CPG8ox9wr4dhImXP/JtbGDg9eOq
         tl3yCOQ4ckLypDdOA079GG9TmIm5ZVRVP/DWcbm9GVAS8jhh7Jc85MAFoXqZStKHaxo6
         67zbhCOmeSzzGV/dKCjHCzzRzZnK2BDxrMgWOZgtuJI6s2JNKpsR63vdM2wUg3jXtwgD
         UbOAs4YADYfcw+lRAYRVJLnMq6K3gyr4Z319N5Uo3KTFNMDBbeF/r/INMJlaFxqLM7OM
         +ccQ==
X-Received: by 10.68.218.65 with SMTP id pe1mr18646215pbc.2.1440174641423;
        Fri, 21 Aug 2015 09:30:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id uk6sm8382200pac.27.2015.08.21.09.30.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 09:30:40 -0700 (PDT)
In-Reply-To: <1440168632-15412-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 21 Aug 2015 16:50:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276309>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> 'git describe --contains' doesn't default to HEAD when no commit is
> given, and it doesn't produce any output, not even an error:
>
>   ~/src/git ((v2.5.0))$ ./git describe --contains
>   ~/src/git ((v2.5.0))$ ./git describe --contains HEAD
>   v2.5.0^0

Good spotting. I think defaulting to HEAD is a good move.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index ce36032b1f..0e31ac5cb9 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -443,10 +443,13 @@ int cmd_describe(int argc, const char **argv, c=
onst char *prefix)
>  			if (pattern)
>  				argv_array_pushf(&args, "--refs=3Drefs/tags/%s", pattern);
>  		}
> -		while (*argv) {
> -			argv_array_push(&args, *argv);
> -			argv++;
> -		}
> +		if (argc)

"What would this code do to 'describe --all --contains'?" was my
knee-jerk reaction, but the options are all parsed by this code and
nothing is delegated to name-rev, so 'if (!argc)' here is truly the
lack of any revisions to be described, which is good.

> +			while (*argv) {
> +				argv_array_push(&args, *argv);
> +				argv++;
> +			}
> +		else
> +			argv_array_push(&args, "HEAD");

By the way, I usually prefer a fatter 'else' clause when everything
else is equal, i.e.

	if (!argc)
        	argv_array_push(&args, "HEAD"); /* default to HEAD */
	else {
		while (*argv) {
                	...
		}
	}

because it is easy to miss tiny else-clause while reading code, but
it is harder to miss tiny then-clause.  In this case, however, the
while loop can be replaced with argv_array_pushv() these days, so
perhaps

	if (!argc)
        	argv_array_push(&args, "HEAD"); /* default to HEAD ... */
	else
		argv_array_pushv(&args, argv); /* or relay what we got */

or something?

>  		return cmd_name_rev(args.argc, args.argv, prefix);
>  	}

> =20
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 57d50156bb..bf52a0a1cc 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -115,6 +115,14 @@ check_describe e-3-* --first-parent --tags
> =20
>  check_describe $(git rev-parse --short HEAD) --exact-match --always =
HEAD
> =20
> +test_expect_success 'describe --contains defaults to HEAD without co=
mmit-ish' '
> +	echo "A^0" >expect &&
> +	git checkout A &&
> +	test_when_finished "git checkout -" &&
> +	git describe --contains >actual &&
> +	test_cmp expect actual
> +'
>  : >err.expect
>  check_describe A --all A^0
>  test_expect_success 'no warning was displayed for A' '
