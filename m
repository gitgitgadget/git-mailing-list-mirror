From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add fetch.recurseSubmoduleParallelism config option
Date: Fri, 16 Oct 2015 10:26:21 -0700
Message-ID: <xmqqh9lqg1xe.fsf@gitster.mtv.corp.google.com>
References: <1444690350-6486-1-git-send-email-sbeller@google.com>
	<xmqqeggzbrx5.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuZZivs8czV2P6uHWaU6ay1hG21k-_G9tgN5KbV6jW8w@mail.gmail.com>
	<xmqqa8rnbq9k.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZDMawq6f3Jet0o-93-vSamy3skji63brdT3puzaLty5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:26:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn8lw-0008Na-J9
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 19:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbbJPR0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 13:26:24 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33906 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbbJPR0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 13:26:23 -0400
Received: by pacez2 with SMTP id ez2so10196956pac.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=u1aBWipOiZL/gfKatFkvRfjZURXkj+b3+RB9QtM/rbY=;
        b=rOLlsYgNdqRmCGikHfEorML19y0XQfYH5RNMDh7SHsYu7pPqitG+dPG9wi1vzU/zqv
         lT/1u1OAoXGt7HQ4RrvsnJgSuINqs4qWRaOSwmtZlCYeP2tt03ECTpWXkxUl27kXDjTc
         K7znzk4uGsXP212DTTQaz9ErNGj8c6J/0qTQEBXDciwEJUHDVoqslevEVcdDA3xIwQlA
         FVztTrXeZt9p4NVn1pBmRryV4RBxUyDXsPxt4admZTe0vNlmhlwZo+zKSrHuugPfU1GM
         Gi9O1kdXh7gItM6fyxcmlPpGea5Z91L9VgiRPkqBiT6Wa8PlLEWWuWBSdTHHyPHmKO43
         Ywww==
X-Received: by 10.66.100.166 with SMTP id ez6mr17788725pab.78.1445016383289;
        Fri, 16 Oct 2015 10:26:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id sn9sm22415878pac.16.2015.10.16.10.26.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 10:26:22 -0700 (PDT)
In-Reply-To: <CAGZ79kZDMawq6f3Jet0o-93-vSamy3skji63brdT3puzaLty5Q@mail.gmail.com>
	(Stefan Beller's message of "Fri, 16 Oct 2015 10:04:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279756>

Stefan Beller <sbeller@google.com> writes:

> so maybe
>     fetch.recurseSubmoduleJobs
>     fetch.submoduleJobs
>     fetch.jobs
>     fetch.connectionsToUse

"git remote update" is another example that may want to run multiple
independent 'git fetch' in parallel.  I think "When the operation I
ask involves fetching from multiple places, I want N instances of
them to be executed", regardless of the kind of operation ("remote
update" or "submodule update", etc.), would match the end-user's
point of view the best, if you want to give them "set this single
thing to apply to all of them" fallback default.

If you want to give them a finer-grained control, you would need to
differentiate what kind of fetch would use N tasks (as opposed to
other kind of fetch that uses M tasks) and the name would need to
have "submodule" in it for that differentiation.

>> So if you want
>>
>>     [submodule]
>>         fetchParallel = 16
>>         updateParallel = 4
>
> So you would have different settings here for only slightly different things?

I was just showing you that it is _possible_ if you want to give
finer control.  For example, you can define:

 * 'submodule.parallel', if defined gives the values for the
   following more specific ones if they aren't given.

 * 'submodule.fetchParallel' specifies how many tasks are run in
   'fetch --recurse-submodules'.

 * 'submodule.fetchParallel' specifies how many tasks are run in
   'submodule update'.

so that those who want finer controls can, and those who don't can
set a single one to apply to all.

If you want to start with a globally single setting, that is
perfectly fine.
