From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Sat, 03 Nov 2012 20:13:52 +0100
Message-ID: <50956CF0.3030401@web.de>
References: <5090168f.5e+7ZUFKdYL2Qnw7%szager@google.com> <CAHOQ7J-e=KBOsjoeTWsf1f+LNgaAxN974-FXNMeOy7B-FR0wyg@mail.gmail.com> <50953B52.3070107@web.de> <CABURp0pkv714k_+S2seTtdHMNJFzkgijYuNuWcfNvnF+c21cDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 20:14:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUjAX-0005cH-4S
	for gcvg-git-2@plane.gmane.org; Sat, 03 Nov 2012 20:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769Ab2KCTN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 15:13:56 -0400
Received: from mout.web.de ([212.227.15.4]:58553 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2KCTNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 15:13:55 -0400
Received: from [192.168.178.41] ([91.3.179.97]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0M89uv-1T8XXl3yWv-00wAEu; Sat, 03 Nov 2012 20:13:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <CABURp0pkv714k_+S2seTtdHMNJFzkgijYuNuWcfNvnF+c21cDg@mail.gmail.com>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:V/ibgpdJkWgOdRN0DTRzhZfkb97XP22NAPct9Jtw6Zg
 o9P7b8FhPuTVrbqHUC9Np8DwOcIKzUaXRPksxcSWeVD186EQK3
 37/5BCa5ZI6hpy/wPmNVEpqGQtfEH7UKwuSs+gKA35I92UR+JL
 HcQQs7H3G1S7MvxC7eFQcf7tpKrIg9rXZuxnxcU7XcUu+Jlc0W
 Enp4BEv0eYSRF4ETHR65Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208984>

Am 03.11.2012 19:44, schrieb Phil Hord:
> On Sat, Nov 3, 2012 at 11:42 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 30.10.2012 19:11, schrieb Stefan Zager:
>>> This is a refresh of a conversation from a couple of months ago.
>>>
>>> I didn't try to implement all the desired features (e.g., smart logic
>>> for passing a -j parameter to recursive submodule invocations), but I
>>> did address the one issue that Junio insisted on: the code makes a
>>> best effort to detect whether xargs supports parallel execution on the
>>> host platform, and if it doesn't, then it prints a warning and falls
>>> back to serial execution.
>>
>> I suspect not passing on --jobs recursively like you do here is the
>> right thing to do, as that would give exponential growth of jobs with
>> recursion depth, which makes no sense to me.
> 
> On the other hand, since $jobs is still defined when the recursive
> call to is made to 'eval cmd_update "$orig_flags"', I suspect the
> value *is* passed down recursively.

But for $jobs != 1 Stefan's code doesn't use eval cmd_update but
starts the submodule script again:

+                       xargs $max_lines -P "$jobs" git submodule update $orig_flags

That should get rid of the $jobs setting, or am I missing something?

>  Maybe $jobs should be manually
> reset before recursing -- unless it is "0" -- though I expect someone
> would feel differently if she had one submodule on level 1 and 10
> submodules on level 2.  She would be surprised, then, when  --jobs=10
> seemed to have little affect on performance.

Hmm, good point. However we implement that, it should at least be
properly documented in the man page (and in the use case you describe
a "git submodule foreach 'git submodule update -j 10'" could be the
solution if we choose to not propagate the jobs option).

>  So maybe it is best to
> leave it as it is, excepting that the apparent attempt not to pass the
> switch down is probably misleading.

I didn't test it, but I think it should work (famous last words ;-).
