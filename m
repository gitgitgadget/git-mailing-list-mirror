From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] test_when_finished in subshells
Date: Fri, 04 Sep 2015 11:43:15 -0700
Message-ID: <xmqqfv2uf2kc.fsf@gitster.mtv.corp.google.com>
References: <54923cf9cc5a66bf9034051b3c2f930fa7ef88a4.1441388803.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:43:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXvxJ-0008QT-Hf
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 20:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759534AbbIDSnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 14:43:17 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35102 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbbIDSnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 14:43:17 -0400
Received: by pacfv12 with SMTP id fv12so32333419pac.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PhM2vXMUaO5zl04+nNIQcTsSPqNfj4oRMSN8i4ZSQgY=;
        b=e/211uF0IhI9LJkyxTEKwQEgzqgBk2xf2e4hZacdDj+zhmvzQXXcbpm9i63axxtElv
         AKel/UakEooZ/yisYBTWtzA2ifaW3NWwTEdIX+BPYdEWm6UdHdIhY+ljWFZ1BP6gipfa
         c4Bq7V+jvh96JYXQCygq05fDGF4HR7+tzpwfhjK2tItKUIK65VMhsgS/Tk9pLiaNFvES
         Ylrip393FtCu/qG2zHgZ6ViBDOKWX0yDKe5PfOUi/P6frqIoLoLYhRNHsJ5+p/bEfYXO
         3D909L9GIZu6AdipmXQc+l1o0cQhkyfi3fXAc9RHSOWWUInxGnK+GEeh6pca45OzYHZf
         scAQ==
X-Received: by 10.68.191.232 with SMTP id hb8mr11152853pbc.122.1441392196775;
        Fri, 04 Sep 2015 11:43:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id qe3sm3304129pbc.73.2015.09.04.11.43.15
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 11:43:15 -0700 (PDT)
In-Reply-To: <54923cf9cc5a66bf9034051b3c2f930fa7ef88a4.1441388803.git.john@keeping.me.uk>
	(John Keeping's message of "Fri, 4 Sep 2015 18:58:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277330>

John Keeping <john@keeping.me.uk> writes:

> All are harmless at the moment and t7610 and t5801 can be fixed by
> moving the test_when_finished call out of the subshell relatively
> easily.
>
> t7800 (in its final test) calls test_config in a subshell which has cd'd
> into a submodule.
>
> Is this something worth worrying about, or is it sufficiently rare that
> we can live with the current behaviour?

Fixing the instances you found is good, obviously ;-).  Thanks for
working on this.

Even though the proposed detection is BASH-ism, I think it would not
hurt other shells (they obviously do not help you catch bugs, but
they would not misbehave as long as you make sure BASH_SUBSHELL is
either unset or set to 0 at the beginning of the test), and the only
impact to them would be a invocation of (often built-in) 'test'
utility, whose performance impact should be miniscule.

I'll wait for opinion from others, of course.

>
> [0] http://article.gmane.org/gmane.comp.version-control.git/277199
>
> -- >8 --
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index e8d3c0f..d29cd7b 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -722,6 +722,8 @@ test_seq () {
>  # what went wrong.
>  
>  test_when_finished () {
> +	test "${BASH_SUBSHELL-0}" = 0 ||
> +	error "bug in test script: test_when_finished does nothing in a subshell"
>  	test_cleanup="{ $*
>  		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
>  }
