From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/12] t4150: am with applypatch-msg hook
Date: Mon, 06 Jul 2015 10:46:14 -0700
Message-ID: <xmqqk2ud18nt.fsf@gitster.dls.corp.google.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
	<1435861000-25278-8-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:46:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCATH-00089V-Bi
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbbGFRqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:46:18 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33186 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbbGFRqR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:46:17 -0400
Received: by igh16 with SMTP id 16so31384790igh.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oP0KSEfUewbRX5YGF0BbAM9YVqEm1N+OX6tLAcYxUC8=;
        b=rj1jpLHINY4o2IC69NELk8twpcnao3O8KMWf5S/cfXI0P2J58fVCUK7c/s4T6mC3vz
         oFBWJyP05trBLKKzV0blCaLIYRQpe0LPpp0WtKlyfFXpsFe+ByI8nQyt4ncPQS2hBiE5
         p3qkKRu1/3JvektB6AJFJgYrfNj0X8l138Uw54emLi/IREGyP60FMD0Etz30+oA/ULwX
         emBkEy17XBPMfdxlJVZ8LkT2n8TkqnIK50VLpE3J0BEp7iUONP/dLkb5l9gE5VvmIBMW
         aU52u+WRMFvUProcbULOYD+GzGZF/Oa97TByNmhokmJdPSu5QA37+6LO2r0tAhjgfxGq
         27kQ==
X-Received: by 10.42.206.5 with SMTP id fs5mr12189598icb.19.1436204776763;
        Mon, 06 Jul 2015 10:46:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id s5sm10114881igh.6.2015.07.06.10.46.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 10:46:15 -0700 (PDT)
In-Reply-To: <1435861000-25278-8-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Fri, 3 Jul 2015 02:16:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273441>

Paul Tan <pyokagan@gmail.com> writes:

> +test_expect_success 'am with applypatch-msg hook' '
> +	test_when_finished "rm -f .git/hooks/applypatch-msg" &&
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	mkdir -p .git/hooks &&
> +	cat >.git/hooks/applypatch-msg <<-\EOF &&
> +	#!/bin/sh
> +	cat "$1" >actual-msg &&
> +	echo hook-message >"$1"
> +	EOF
> +	chmod +x .git/hooks/applypatch-msg &&

This (and the other one below) looks like a good candidate for the
write_script helper.

> +	git am patch1 &&
> +	test_path_is_missing .git/rebase-apply &&
> +	git diff --exit-code second &&
> +	echo hook-message >expected &&
> +	git log -1 --format=format:%B >actual &&
> +	test_cmp expected actual &&
> +	git log -1 --format=format:%B second >expected &&
> +	test_cmp expected actual-msg
> +'
> +
> +test_expect_success 'am with failing applypatch-msg hook' '
> +	test_when_finished "rm -f .git/hooks/applypatch-msg" &&
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	mkdir -p .git/hooks &&
> +	cat >.git/hooks/applypatch-msg <<-\EOF &&
> +	#!/bin/sh
> +	exit 1
> +	EOF
> +	chmod +x .git/hooks/applypatch-msg &&
> +	test_must_fail git am patch1 &&
> +	test_path_is_dir .git/rebase-apply &&
> +	git diff --exit-code first &&
> +	test_cmp_rev first HEAD
> +'
> +
>  test_expect_success 'setup: new author and committer' '
>  	GIT_AUTHOR_NAME="Another Thor" &&
>  	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
