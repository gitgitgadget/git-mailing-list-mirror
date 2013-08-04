From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule: don't print status output with ignore=all
Date: Sun, 04 Aug 2013 20:24:09 +0200
Message-ID: <51FE9C49.4020902@web.de>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net> <1375550060-5406-3-git-send-email-sandals@crustytoothpaste.net> <20130803182420.GG2893@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 20:24:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V62yW-0006DS-1I
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 20:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab3HDSYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Aug 2013 14:24:12 -0400
Received: from mout.web.de ([212.227.15.3]:49659 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825Ab3HDSYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 14:24:11 -0400
Received: from [192.168.178.41] ([91.3.181.161]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M41Bm-1UEdND3IVG-00raw3 for <git@vger.kernel.org>;
 Sun, 04 Aug 2013 20:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130803182420.GG2893@elie.Belkin>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:x1P6dnb5sJXUbQO/kFFMXZmPfDSe6iFa5H18yxq4E8SVz5Czg/7
 LRFpxKUKlpsmEEZVx8xytBBU33y9JRAKGt9FZIUiRWRQvzdi2KlsomcDyhbgjVU4E6ebIWA
 me8eHnznjzi5ekgxkF6LqlMG5anY9YPAhdLJyNbKc7g3XpmozJfXWNsyTson53rNUHiI30n
 4XHgMC4YSMFAEBXZQIkAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231637>

Am 03.08.2013 20:24, schrieb Jonathan Nieder:
> brian m. carlson wrote:
> 
>> git status prints information for submodules, but it should ignore the status of
>> those which have submodule.<name>.ignore set to all.  Fix it so that it does
>> properly ignore those which have that setting either in .git/config or in
>> .gitmodules.

I'm a bit confused. The commit message talks about "git status", but the code
you changed handles "git submodule summary". Looks like you are trying to fix
the output of status when the status.submodulesummary option is set, right?
That's a good thing to do.

But your patch also changes the default behavior of "git submodule summary",
which is a change in behavior as that is currently not configurable via the
ignore option (and I believe it should stay that way for backward compatibility
reasons unless actual users provide sound reasons to change that). So a NACK
on this patch from me (and a note to self that tests are missing that should
have failed due to this change).

As a short term solution you could honor the submodule.<name>.ignore setting
only if --for-status is used, as that is explicitly given by "git status" when
it forks the "git submodule summary" script (to make it prepend "# " to each
line, which it could do easily itself nowadays using recently added code ;-).

If you want to fix that issue and make git status perform a lot better, you
should make the status.submodulesummary use what we already have in the diff
machinery instead of forking the submodule script (which it does for hysterical
raisins). Basically you'd need to run just what "git diff-files" and "git
diff-index HEAD" run when they are given the --submodule option, prepend "# "
to the output and limit it to the amount of lines configured via the
status.submodulesummary option. Then we could get rid of the --for-status
option of submodule summary and move some more functionality from that script
into core git.

I'll be glad to help you fixing this problem either way.

>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>>  git-submodule.sh  | 2 ++
>>  t/t7508-status.sh | 4 ++--
>>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> Thanks.  Cc-ing Jens, who wrote that test and knows this code much
> better than I do. :)
>
> [...]
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -1034,6 +1034,8 @@ cmd_summary() {
>>  		sane_egrep '^:([0-7]* )?160000' |
>>  		while read mod_src mod_dst sha1_src sha1_dst status path
>>  		do
>> +			name=$(module_name "$path")
>> +			test $(get_submodule_config "$name" ignore none) = all && continue
>>  			# Always show modules deleted or type-changed (blob<->module)
>>  			test $status = D -o $status = T && echo "$path" && continue
> 
> I'm not sure what the exact semantics should be here, though that's
> mostly because of my unfamiliarity with submodules in general.
> 
> If I have '[submodule "favorite"] ignore = all' and I then replace
> that submodule with a blob, should "git submodule status" not mention
> that path?
> 
> If I just renamed a submodule, will 'module_name "$path"' do the right
> thing with the old path?
> 
> (rest of the patch kept unsnipped for reference)
>>  			# Also show added or modified modules which are checked out
>> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
>> index ac3d0fe..fb89fb9 100755
>> --- a/t/t7508-status.sh
>> +++ b/t/t7508-status.sh
>> @@ -1316,7 +1316,7 @@ test_expect_success "--ignore-submodules=all suppresses submodule summary" '
>>  	test_i18ncmp expect output
>>  '
>>  
>> -test_expect_failure '.gitmodules ignore=all suppresses submodule summary' '
>> +test_expect_success '.gitmodules ignore=all suppresses submodule summary' '
>>  	git config --add -f .gitmodules submodule.subname.ignore all &&
>>  	git config --add -f .gitmodules submodule.subname.path sm &&
>>  	git status > output &&
>> @@ -1324,7 +1324,7 @@ test_expect_failure '.gitmodules ignore=all suppresses submodule summary' '
>>  	git config -f .gitmodules  --remove-section submodule.subname
>>  '
>>  
>> -test_expect_failure '.git/config ignore=all suppresses submodule summary' '
>> +test_expect_success '.git/config ignore=all suppresses submodule summary' '
>>  	git config --add -f .gitmodules submodule.subname.ignore none &&
>>  	git config --add -f .gitmodules submodule.subname.path sm &&
>>  	git config --add submodule.subname.ignore all &&
>> -- 
>> 1.8.4.rc1
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
