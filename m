From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] receive-pack: Create a HEAD ref for ref namespace
Date: Fri, 05 Jun 2015 10:19:32 -0700
Message-ID: <xmqqh9qmrs2j.fsf@gitster.dls.corp.google.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
	<1433523731-25172-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes =?utf-8?Q?L=C3=B6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 19:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0vHQ-0007hW-3c
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 19:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbbFERTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 13:19:35 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33950 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418AbbFERTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 13:19:34 -0400
Received: by igbhj9 with SMTP id hj9so20357809igb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=OzK0wzW8hAT9epJ8PjLw3vs7ifbAUYQ3eaiAaXxg/Ck=;
        b=H0b6E//qo5Lf0GMxdmr4YEqcsyBJuw29Zb+v8dFstnC32vjpBMo4OkOboGzTYL3jIg
         CSvJkMIDEFF+Ah/PpnXYVB+X+3HQKOGM74Q0i5Fu0WSXB4P+NATYtr9GlUuIu7OkE7Ij
         hOAUqDyGqrdOppYdRigqtQMDf5BhesOxP+Rl93GR2IOfQVs4LYJZu4vVonWPig2IHFEz
         7LM43vAAbw0EZc5296y3+T7xr0xDZjtjCHbI+JpA4XgDOHN+aizr5DGIz+WwxZT7ktdo
         RQQ4vTWfQ20vQmu7WArCslm+9E67UbTxlke/VCGV7FHx1356aH21nmWQ2uCt3g5NPWn3
         DoOw==
X-Received: by 10.107.128.134 with SMTP id k6mr3247549ioi.7.1433524774215;
        Fri, 05 Jun 2015 10:19:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id z25sm3521967ioi.20.2015.06.05.10.19.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 10:19:33 -0700 (PDT)
In-Reply-To: <1433523731-25172-1-git-send-email-johannes@kyriasis.com>
	("Johannes =?utf-8?Q?L=C3=B6thberg=22's?= message of "Fri, 5 Jun 2015
 19:02:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270863>

Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:

> diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-na=
mespaces.sh
> index cc0b31f..7bc3a1f 100755
> --- a/t/t5509-fetch-push-namespaces.sh
> +++ b/t/t5509-fetch-push-namespaces.sh
> @@ -1,6 +1,7 @@
>  #!/bin/sh
> =20
> -test_description=3D'fetch/push involving ref namespaces'
> +test_description=3D'fetch/push/clone involving ref namespaces'
> +

OK ;-)

>  . ./test-lib.sh
> =20
>  test_expect_success setup '
> @@ -82,4 +83,50 @@ test_expect_success 'mirroring a repository using =
a ref namespace' '
>  	)
>  '
> =20
> +test_expect_success 'cloning from ref namespace' '
> +	rm -rf initial bare clone &&
> +	git init initial &&
> +	git init --bare bare &&
> +	(
> +		cd initial &&
> +		echo "commit one" >file &&
> +		git add file &&
> +		git commit -m "commit one" &&
> +		git push ../bare master &&
> +
> +		echo refs/heads/master >expect &&
> +		git -C ../bare symbolic-ref HEAD >actual &&
> +		test_cmp expect actual &&
> +
> +		git rev-parse HEAD >expect &&
> +		git -C ../bare rev-parse HEAD >actual &&
> +		test_cmp expect actual &&
> +
> +		echo "commit two" >>file &&
> +		git add file &&
> +		git commit -m "commit two" &&
> +		GIT_NAMESPACE=3Dnew_namespace git push ../bare master &&
> +
> +		echo "ref: refs/namespaces/new_namespace/refs/heads/master" >expec=
t &&
> +		test_cmp expect ../bare/refs/namespaces/new_namespace/HEAD  &&

Use "symbolic-ref refs/namespaces/new_namespace/HEAD"; HEAD is not
required to be expressed as a textual symref.

> +
> +		(
> +			printf "%s commit\t%s\n" $(git rev-parse master^) \
> +			                         refs/heads/master &&
> +			printf "%s commit\t%s\n" $(git rev-parse master) \
> +			                         refs/namespaces/new_namespace/HEAD &&
> +			printf "%s commit\t%s\n" $(git rev-parse master) \
> +			                         refs/namespaces/new_namespace/refs/heads=
/master
> +		) >expect &&

Use of 'printf' is clever and I like it.  Have you considered
letting it do the iteration as well?  I.e.

	printf "%s commit\t%s\n" \
        	one two \
                three four \
                five six \
	>expect &&

might be easier to read.

> +		git -C ../bare for-each-ref refs/ >actual &&
> +		test_cmp expect actual
> +	) &&
> +	GIT_NAMESPACE=3Dnew_namespace git clone bare clone &&
> +	(
> +		cd clone &&
> +		git show

We can accept any random commit at HEAD as long as it exists at this
point?  Don't we need to make sure that a ref whose tip is still "one"
is not propagated to this new clone?

> +	)
> +'
> +
> +
>  test_done
