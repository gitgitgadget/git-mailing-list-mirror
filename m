From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add fetch.recurseSubmoduleParallelism config option
Date: Mon, 12 Oct 2015 16:50:31 -0700
Message-ID: <xmqqa8rnbq9k.fsf@gitster.mtv.corp.google.com>
References: <1444690350-6486-1-git-send-email-sbeller@google.com>
	<xmqqeggzbrx5.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuZZivs8czV2P6uHWaU6ay1hG21k-_G9tgN5KbV6jW8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:50:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlmrd-0004X7-AB
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 01:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbbJLXul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 19:50:41 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33195 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbbJLXuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 19:50:40 -0400
Received: by pabrc13 with SMTP id rc13so1765386pab.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NKV4Ih0Y/AmKCrr2Iqxc/bxhL5vLbvoBwG4H3109AkY=;
        b=MvWdhTlNsb1RRKL4wmq67hWxjlqTYJb8tjQo/79ArO0v3KtjZJov7k8p38ueD9ZwoA
         7xMXA+RZTOWch/I+VAgOTP1FUzwiIq8XSDMdcmn2kYo6fzItALxSwq28nX3i5Xp+abzr
         EGbgnJLzw9NxFzZSArOS8XFq3ukdLpMNdLp4EZs0V/g9fev9YnwPCXBoUCm/GyPcl60p
         s/L0NfwlSOGoI5V64xkbl8KnaoxAMV7N17ZvG8CA7Ryeb6EwDTDeiJiEUOtv6L+bLWfE
         JROlii7TX/gIYHOEeOiV8MeU8FYXS4UTwzwDNGbwAg3RBsdsCFuDuYpGiHzrtr3K+zj1
         Z3ZA==
X-Received: by 10.68.230.6 with SMTP id su6mr6377432pbc.80.1444693840009;
        Mon, 12 Oct 2015 16:50:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:495:58e7:6a27:bf4d])
        by smtp.gmail.com with ESMTPSA id kv9sm87540pab.39.2015.10.12.16.50.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 16:50:38 -0700 (PDT)
In-Reply-To: <CAGZ79kZuZZivs8czV2P6uHWaU6ay1hG21k-_G9tgN5KbV6jW8w@mail.gmail.com>
	(Stefan Beller's message of "Mon, 12 Oct 2015 16:31:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279473>

Stefan Beller <sbeller@google.com> writes:

> There is core.preloadIndex to enable parallel index preload, but
> that is boolean and not giving fine control to the user. We want to give
> fine control to the user here I'd assume.

I'd approach this as "fetching multiple submodules at a time", if I
were deciding its name.

> ... We could also make it a
> submodule specifc thing (submodule.jobs), but that would collide
> with submodule.<name>.<foo> maybe?

I do not think so.  You can have

	area.attr1
	area.attr3
        area."userthing1".attr1
        area."userthing2".attr1

and the parser can differenciate them just fine.

So if you want

    [submodule]
        fetchParallel = 16
	updateParallel = 4

I do not think that would interfere with any

    [submodule "name"]
    	var = val

You can choose to even allow an attribute that is fundamentally per
"userthing" (e.g. the branch, the remote, the submodule) defined
with area."userthing".attr, but make area.attr to be the fallback
value for unspecified area."userthing9".attr (I think http.*.*
hierarchy takes that approach), but I do not think the parallelism
of fetching is something that should be specified per submodule.

>> The parallel_process API could learn a new "verbose" feature that it
>> by itself shows some messages like
>>
>>     "processing the 'frotz' job with N tasks"
>>     "M tasks finished (N still running)"
>
> I know what to fill in for M and N, 'frotz' is a bit unclear to me.

The caller would pass the label to pp_init(); in this codepath
perhaps it will say 'submodule fetch' or something.
