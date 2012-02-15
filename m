From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v5 3/3] push: teach --recurse-submodules the on-demand
 option
Date: Wed, 15 Feb 2012 23:28:02 +0100
Message-ID: <4F3C3172.8030505@web.de>
References: <20120213092541.GA15585@t1405.greatnet.de> <20120213093008.GD15585@t1405.greatnet.de> <7v7gzq9jg2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 23:28:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxnKi-0003dm-5Q
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 23:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab2BOW2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 17:28:11 -0500
Received: from mout.web.de ([212.227.15.3]:51121 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab2BOW2L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 17:28:11 -0500
Received: from [192.168.178.48] ([91.3.175.191]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MPGym-1RtNTf07KS-005FQU; Wed, 15 Feb 2012 23:28:03
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
In-Reply-To: <7v7gzq9jg2.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:DcGYpvDRWHZ+FMRG/ov9EE31a7v7laJO7c2DMBW4t/Z
 rf2Y+CvkagMQfZAvXa95phVowX7pEU6Fp6VK/JJqSvHu01o2tC
 X9aHOReZ2kxCW6KUVvzhHMtqP/fvZ59QRd+szpM5R1wNtx2IL5
 Zm3F30YkKJd7m2v6SA+0CpD9QpyFUG/phwxo8mUApoyin7+cgA
 BnXuB1QdnarVuP2s1hX7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190864>

Am 14.02.2012 04:34, schrieb Junio C Hamano:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
>> diff --git a/submodule.c b/submodule.c
>> index 3c714c2..ff0cfd8 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -411,6 +411,54 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20],
>>  	return needs_pushing->nr;
>>  }
>>  
>> +static int push_submodule(const char *path)
>> +{
>> +	if (add_submodule_odb(path))
>> +		return 1;
>> +
>> +	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
>> +		struct child_process cp;
>> +		const char *argv[] = {"push", NULL};
>> +
>> +		memset(&cp, 0, sizeof(cp));
>> +		cp.argv = argv;
>> +		cp.env = local_repo_env;
>> +		cp.git_cmd = 1;
>> +		cp.no_stdin = 1;
>> +		cp.dir = path;
>> +		if (run_command(&cp))
>> +			return 0;
>> +		close(cp.out);
>> +	}
>> +
>> +	return 1;
>> +}
> 
> Hmm, this makes me wonder if we fire subprocesses and have them run in
> parallel (to a reasonably limited parallelism), it might make the overall
> user experience more pleasant, and if we did the same on the fetching
> side, it would be even nicer.

Yeah, I had the same idea and did some experiments when working on
fetch some time ago.

> We would need to keep track of children and after firing a handful of them
> we would need to start waiting for some to finish and collect their exit
> status before firing more, and at the end we would need to wait for the
> remaining ones and find how each one of them did before returning from
> push_unpushed_submodules().  If we were to do so, what are the missing
> support we would need from the run_command() subsystem?

We would not only have to collect the exit status but also the output
lines. You don't want to see the output of multiple fetches or pushes
mixed together, so it makes sense to just defer that until the command
exited and then print everything at once. The interesting part I couldn't
come up with an easy solution for is to preserve the output order between
the stdout and stdin lines, as they contain different parts of the
progress which would look strange when shuffled around.

And I saw that sometimes parallel fetches took way longer than doing them
sequentially (in my case because of strange DNS behavior of my DSL router),
so we would definitely want a config option for that (maybe setting the
maximum number of simultaneous threads to be used).

But don't get me wrong, I'm all for having that feature! :-)
