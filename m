From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] cleanup argument passing in submodule status command
Date: Sun, 29 Jul 2012 17:29:19 +0200
Message-ID: <501556CF.1000605@web.de>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com> <20120728102209.GA13370@book.hvoigt.net> <20120728121956.GA36429@book.hvoigt.net> <7vtxwrw0g0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Stefan Zager <szager@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 17:29:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvVQy-0000h9-7u
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 17:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab2G2P31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 11:29:27 -0400
Received: from mout.web.de ([212.227.17.12]:59605 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168Ab2G2P30 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 11:29:26 -0400
Received: from [192.168.178.48] ([91.3.154.32]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0Lc8Xx-1TcIRV2MI1-00jGup; Sun, 29 Jul 2012 17:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vtxwrw0g0.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:uZuBV0q++cqeFjeZwaWJYiQXm25xKRZJh7R2UEcg3W4
 I2L988ZV4l0YTKvWaImmWA6zwY35cLPJR1j4VY0Fjff6oU+1X6
 mdVusuKKob7JpKp/FtWrrOySvDJpIYLIuHe2RTn0wij+6HbQ94
 hZu1ikfbdNq9kDWonoO9J8Gz+y3XrqrrzI2mi1HuijHh2pGb6A
 jHYa2/cF8HaJedviM3N2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202483>

Am 29.07.2012 08:22, schrieb Junio C Hamano:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
>> Note: This is a code cleanup and does not fix any bugs. As a side effect
>> the variables containing the parsed flags to "git submodule status" are
>> passed down recursively. So everything was already behaving as expected.
> 
> If that is the case, shouldn't we stop passing anything down, if we
> want it to be a "clean-up only, no behaviour changes" patch?  While
> at it, we may want to kill that code to accumulate the original
> options in orig_flags because we haven't been using the variable.
> 
> We _know_ $orig_args has been empty, i.e. the code has been working
> fine with only cmd_status there.  Nobody has tried what happens when
> we pass the original arguments to cmd_status on that line.

I tried today. Before this change no arguments got passed down and
afterwards they are (but just the arguments, no submodule paths
were passed on in either case; which is what Kevin fixed in the
commit Heiko referenced). Three arguments are allowed for "git
submodule status":

--recursive:
It doesn't matter if we pass that on or not because $recursive is
reused when "eval cmd_status" is executed.

--quiet:
Same as recursive, GIT_QUIET is set the first time and then reused
in the recursion.

--cached:
This was dropped when recursing into submodules but isn't anymore
with Heiko's change, so we do have a change in behavior here.

>  The
> patch changes the behaviour of the code; it makes the command line
> parsing "while" loop to run again, and if the code that accumulates
> original options in orig_flags have been buggy, now that bug will be
> exposed.

Hmm, when --cached is used together with --recursive, I would expect
it to show the commit stored in the index for the deeper submodules
too (and not magically switch to show their HEAD again after the
first level of submodules). To me this looks like a bug which Kevin
accidentally introduced and nobody noticed and/or reported until now.

So I'd vote for making this a bugfix patch for "git submodule status
--cached --recursive" (and would love to see a test for it ;-).

>> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
>> ---
>>  git-submodule.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index dba4d39..3a3f0a4 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -961,7 +961,7 @@ cmd_status()
>>  				prefix="$displaypath/"
>>  				clear_local_git_env
>>  				cd "$sm_path" &&
>> -				eval cmd_status "$orig_args"
>> +				eval cmd_status "$orig_flags"
>>  			) ||
>>  			die "$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
>>  		fi
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
