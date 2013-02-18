From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v5] submodule: add 'deinit' command
Date: Mon, 18 Feb 2013 20:20:30 +0100
Message-ID: <51227EFE.6030908@web.de>
References: <5112C6F6.4030607@web.de> <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com> <511BEA75.6000002@web.de> <7vip5w6l8s.fsf@alter.siamese.dyndns.org> <5121384B.10009@web.de> <7v38wufu5t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:21:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7WGx-0006et-Bw
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993Ab3BRTUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:20:43 -0500
Received: from mout.web.de ([212.227.17.11]:55587 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756987Ab3BRTUm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:20:42 -0500
Received: from [192.168.178.41] ([91.3.158.27]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MJl1M-1U8cC53S2m-001Uvb; Mon, 18 Feb 2013 20:20:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v38wufu5t.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:gekoob8hAODg0A0q4JruakEXCu2G5i6aUtETJmhyTIY
 MQr6HGWKM3DFChiU9Uh2O5PXPAmgEYSrCXcgdm5+atgnLKbLCO
 k3jLsBZREsA4gye0unMhJxfHKsKEF8b+IcAbk0NQkfyfhPxvLc
 QvRqE7e+wFaK/Yk04zwwU0s/TU5bytrmToOvcrtN21M/n30hyr
 c44CLx7TDtWW/27QYwC6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216498>

Am 17.02.2013 23:32, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 004c034..0fb6ee0 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -547,6 +548,82 @@ cmd_init()
>>  }
>>
>>  #
>> +# Unregister submodules from .git/config and remove their work tree
>> +#
>> +# $@ = requested paths (use '.' to deinit all submodules)
>> +#
>> +cmd_deinit()
>> +{
>> +	# parse $args after "submodule ... init".
>> +	while test $# -ne 0
>> +	do
>> ..
>> +	done
>> +
>> +	if test $# = 0
>> +	then
>> +		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
> 
> I do not think I saw anybody mentioned this so far, but how is
> "deinit" supposed to work inside a subdirectory of a superproject?
> If the answer is to work on submodules appear in that subdirectory,
> '.' should probably not mean "all in the superproject" I think?

"git submodule" fails when not run in the top level directory.

>> +	module_list "$@" |
>> +	while read mode sha1 stage sm_path
>> +	do
>> +		die_if_unmatched "$mode"
>> +		name=$(module_name "$sm_path") || exit
>> +		url=$(git config submodule."$name".url)
>> +		if test -z "$url"
>> +		then
>> +			test $# -ne 1 || test "$@" = "." ||
>> +			say "$(eval_gettext "Submodule '\$name' is not initialized for path '\$sm_path'")"
>> +			continue
>> +		fi
> 
> This 'test "$@" = "."' makes readers feel uneasy.  This particular
> invocation happens to be safe only because it is protected with
> "test $# -ne 1 ||", but for all other values of $# this will result
> in a syntax error.  'test "$1" = "."' would make the intention of
> the check more clear.

I used $@ here because it makes the code more robust against
someone accidentally removing the "test $# -ne 1 ||" (as it then
will fail when $# > 1 in one of the tests). But looking at it
again I agree that "$1" might better show the intention here and
the "$@" can easily make people suspicious.

> But stepping back a bit, is the condition this test is trying to
> warn against really worth warning?
> 
> It seems that this "warn if user told us to deinitialize a submodule
> that hasn't been initialized" is from the very initial round of this
> series, and not something other people asked for during the review.
> If somebody did
> 
> 	git submodule deinit foo bar
> 
> and then later said:
> 
> 	git submodule deinit foo
> 
> would it a mistake that the user wants to be warned about?
> 
> Perhaps the user did not mean to deinitialize foo (e.g. wanted to
> *initialize* foo instead, or wanted to deinitialize *foz* instead)
> and that is worth warning about?  I am not sure, but I have a
> feeling that we can do without this check.

Hmm, if you would replace "submodule deinit" with "rm" in the above
example, the "rm" would not only warn but error out the second time.
But on the other hand doing a "git submodule init" again on already
initialized submodules will silently do nothing, which seems to be
the better analogy here. So yes, it looks like we can do without.

Ok, unless someone speaks up and argues in favor of this message
I'll remove it in v6.

> Also the value of submodule.$name.url is not used in the later
> codepath to ensure that the named submodule is in the pristine state
> in the superproject's working tree (i.e. no submodule.$name section
> in the local configuration, no working tree for that submodule), so
> it may be even a good change to remove the "does submodule.$name.url
> exist" check and always do the "deinitialize" process.  That would
> give the users a way to recover from a state where a submodule is
> only half initialized for some reason safely, no?

That is a very good point. It makes sense that if we don't nuke the
whole test to at least remove the "continue" there (in case someone
fiddled with .git/config but wants to get rid of the work tree in a
safe manner later).
