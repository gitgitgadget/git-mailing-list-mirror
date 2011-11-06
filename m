From: Eric Herman <eric@freesa.org>
Subject: Re: [PATCH] grep: detect number of CPUs for thread spawning
Date: Sun, 06 Nov 2011 19:00:00 +0100
Message-ID: <4EB6CB20.5060309@freesa.org>
References: <1320502568-14085-1-git-send-email-avarab@gmail.com> <20111106145050.GA4219@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 19:07:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN77g-0002XV-Oq
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 19:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab1KFSHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 13:07:05 -0500
Received: from dsl017-020-053.chi1.dsl.speakeasy.net ([69.17.20.53]:44509 "EHLO
	chirm.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751670Ab1KFSHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 13:07:04 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Nov 2011 13:07:04 EST
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by chirm.localdomain (Postfix) with ESMTP id 147E2217B99;
	Sun,  6 Nov 2011 13:01:14 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111106145050.GA4219@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184919>

Hello Pete,

Thank you for the feedback.

On 11/06/2011 03:50 PM, Pete Wyckoff wrote:

>> From: Eric Herman<eric@freesa.org>
>>
>> Change the number of threads that we spawn from a hardcoded value of
>> "8" to what online_cpus() returns.


> I agree with the need to exploit>8 CPUs, but I lose a lot of
> performance when limiting the threads to the number of physical
> CPUs.

Ah, yes, Being focused on big machines, I did not actually test with low 
CPU machines, certainly not with NFS mounts.

>
> Tests without your patch on master, just changing "#define
> THREADS" from 8 to 2.  On a 2-core Intel Core2 Duo.
>
> Producing lots of output:
>
>      8 threads:
>
> 	$ time ~/u/src/git/bin-wrappers/git grep f>  /dev/null
> 	0m14.02s user 0m3.64s sys 0m11.93s elapsed 148.07 %CPU
> 	$ time ~/u/src/git/bin-wrappers/git grep f>  /dev/null
> 	0m13.86s user 0m3.70s sys 0m11.82s elapsed 148.57 %CPU
>
>      2 threads:
>
> 	$ time ~/u/src/git/bin-wrappers/git grep f>  /dev/null
> 	0m15.14s user 0m3.52s sys 0m24.22s elapsed 77.05 %CPU
> 	$ time ~/u/src/git/bin-wrappers/git grep f>  /dev/null
> 	0m14.85s user 0m3.79s sys 0m24.20s elapsed 77.05 %CPU
>
> Producing no output:
>
>      8 threads:
>
> 	$ time ~/u/src/git/bin-wrappers/git grep unfindable-string
> 	0m1.14s user 0m3.68s sys 0m5.17s elapsed 93.22 %CPU
> 	$ time ~/u/src/git/bin-wrappers/git grep unfindable-string
> 	0m1.28s user 0m3.56s sys 0m5.15s elapsed 94.22 %CPU
>
>      2 threads:
>
> 	$ time ~/u/src/git/bin-wrappers/git grep unfindable-string
> 	0m1.36s user 0m3.64s sys 0m16.82s elapsed 29.75 %CPU
> 	$ time ~/u/src/git/bin-wrappers/git grep unfindable-string
> 	0m1.38s user 0m3.66s sys 0m16.81s elapsed 30.04 %CPU
>
> My workdir is on NFS, where even though the repository is fully
> cached, the open()s must go to the server.  Using more threads
> than CPUs makes it more likely that some thread isn't blocked.

This is good data.
It gives me ideas for how I can do some more testing.

>
> You could add a #threads knob,

Sure, adding a knob is not a bad idea.


> but then we'd have to get
> everybody on NFS to set that properly.

Indeed, I think you agree that it would be better if there was no need 
for most people to fiddle with yet another knob.


>  Or take a look at
> preload_index() to see how it guesses at how many threads it
> needs.

Good tip.
A quick peek at preload_index suggests that it was a bit of guesswork:

/*
  * Mostly randomly chosen maximum thread counts: we
  * cap the parallelism to 20 threads, and we want
  * to have at least 500 lstat's per thread for it to
  * be worth starting a thread.
  */

However, your comments make me wonder if a rule-of-thumb like "3 + 
online_cpus()" would yield better results across both large and small 
numbers of cores with either blazing fast or very slow storage.

I will create a setup similar to the one you describe and do some 
exploration.

Cheers,
  -Eric

-- 
http://www.freesa.org/ -- mobile: +31 620719662
aim: ericigps -- skype: eric_herman -- jabber: eric.herman@gmail.com
