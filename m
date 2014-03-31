From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Mon, 31 Mar 2014 22:37:39 +0200
Message-ID: <5339D213.4070303@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de> <CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com> <53374E49.9000702@gmail.com> <533874F9.3090802@web.de> <5338AC36.6000109@gmail.com> <5338B1B0.3050703@gmail.com> <5339BAE4.8020306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 22:37:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUixq-0006Sx-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 22:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbaCaUhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 16:37:46 -0400
Received: from mout.web.de ([212.227.15.14]:53060 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaCaUhp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 16:37:45 -0400
Received: from [192.168.178.41] ([79.193.64.198]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MHGN9-1WHofM1T7L-00E2fL; Mon, 31 Mar 2014 22:37:43
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5339BAE4.8020306@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:UIIQkkszLTeEewapOljtWxCi6jkuCc844bukE9q5fTmVQaUbrA2
 dMfoh8egXXg6Dcmt7Fo02CtR/ljboc1FSBQE1V3STrzB5QzbdYKutuEWBGQGs8sUYcr43Es
 EHAAlduwSUTo7DAuNr2dB55SwP6B6fJPaWCZjVbAXVQfFGLuyLiq8HMqloL1w1Y1Trb9e5b
 IKulwz6RObwb5XJnFBasQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245523>

Am 31.03.2014 20:58, schrieb Jens Lehmann:
> Am 31.03.2014 02:07, schrieb Ronald Weiss:
>> The tests immediately revealed, that the patch was not complete. It
>> didn't work with commit message given on command line (-m). To make
>> that work, I had to also patch the index_differs_from function in
>> diff-lib.c.
> 
> Which is exactly the same function I have to tweak to make my
> "status/commit: always show staged submodules regardless of
> ignore config" patch work for "git commit -m" too ;-)
> 
> I was doing that slightly differently but it seems that your way
> of adding the "ignore_submodules_arg" parameter could serve us
> both. Will update my upcoming patch accordingly.

I've been hacking on that some more (I'll post it as soon as I
have all new tests up and running) and think we might be able to
handle that even easier. Please see below:

>> diff --git a/diff-lib.c b/diff-lib.c
>> index 2eddc66..fec5ad4 100644
>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>> @@ -508,7 +508,8 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
>>  	return 0;
>>  }
>>  
>> -int index_differs_from(const char *def, int diff_flags)
>> +int index_differs_from(const char *def, int diff_flags,
>> +		       const char *ignore_submodules_arg)
>>  {
>>  	struct rev_info rev;
>>  	struct setup_revision_opt opt;
>> @@ -520,6 +521,10 @@ int index_differs_from(const char *def, int diff_flags)
>>  	DIFF_OPT_SET(&rev.diffopt, QUICK);
>>  	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
>>  	rev.diffopt.flags |= diff_flags;
>> +	if (ignore_submodules_arg) {
>> +		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);

You'll have to do this unconditionally, as this option tells the
diff machinery to ignore any submodule configurations, which is
what we want in either case. But ...

>> +		handle_ignore_submodules_arg(&rev.diffopt, ignore_submodules_arg);
>> +	}
>>  	run_diff_index(&rev, 1);
>>  	if (rev.pending.alloc)
>>  		free(rev.pending.objects);

... maybe the best way is to leave index_differs_from() unchanged
and call that function with the correct diff_flags instead:

+		int diff_flags = DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
+		if (ignore_submodule_arg &&
+		    !strcmp(ignore_submodule_arg, "all"))
+			diff_flags |= DIFF_OPT_IGNORE_SUBMODULES;
+		commitable = index_differs_from(parent, diff_flags);

Not thoroughly tested yet, but that'd also prevent any fallout for
the two callsites of index_differs_from() in sequencer.c.
