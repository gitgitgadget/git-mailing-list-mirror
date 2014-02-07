From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP/PATCH 3/9] Teach checkout the --[no-]recurse-submodules
 option
Date: Fri, 07 Feb 2014 22:12:54 +0100
Message-ID: <52F54C56.5020604@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de>	<xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>	<52EFF25E.6080306@web.de> <52EFF2EA.9060709@web.de> <xmqq8utrdcuh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:13:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBsjN-0002HW-AT
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbaBGVM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 16:12:57 -0500
Received: from mout.web.de ([212.227.17.12]:62601 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbaBGVM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:12:56 -0500
Received: from [192.168.178.41] ([84.132.186.180]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LudP2-1VCOBz05Fg-00zjmP for <git@vger.kernel.org>;
 Fri, 07 Feb 2014 22:12:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqq8utrdcuh.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:uAdse4rngHyVBOsIGkcMzKGZBuVn4esc9OZd4rTu/xBfh0cWKdQ
 EJ8KxVheZR9W36aEtMgQrW1w1inr3LhCWY22abBojGaZOdD1Tp/g3wY6M7vDVsVh7paFFPO
 1QzHx571d+Ck55hTR1yg58Aar53uTsqWaAz1MV1xAgwarXxOymadbHQSpg2PbRH97Ubg55r
 0FEOFraIveYDFRBjTfPmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241801>

Am 03.02.2014 23:56, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> +	set_config_update_recurse_submodules(
>> +		parse_update_recurse_submodules_arg("--recurse-submodules-default",
>> +						    recurse_submodules_default),
>> +		recurse_submodules);
> 
> I think I saw these exact lines in another patch.  Perhaps the whole
> thing can become a helper function that lets the caller avoid typing
> the whole long strings that needs a strange/unfortunate line break? 

Right, that'd be better.

>> diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
>> index 06b18f8..bc3e1ca 100755
>> --- a/t/t2013-checkout-submodule.sh
>> +++ b/t/t2013-checkout-submodule.sh
>> @@ -4,17 +4,57 @@ test_description='checkout can handle submodules'
>>
>>  . ./test-lib.sh
>>
>> +submodule_creation_must_succeed() {
> 
> Style: SP before (), i.e.
> 
> 	submodule_creation_must_succeed () {
> 
>> +	# checkout base ($1)
>> +	git checkout -f --recurse-submodules $1 &&
>> +	git diff-files --quiet &&
>> +	git diff-index --quiet --cached $1 &&
> 
> Please make it a habit to quote a parameter that is intended not to
> be split at $IFS (e.g. write these as "$1" not as $1).  Otherwise
> the reader has to wonder if this can be called with a "foo bar" and
> the expects it to be split into two.
> 
>> +	# checkout target ($2)
>> +	if test -d submodule; then
> 
> Style: no semicolons in standard control structure, i.e.
> 
> 	if test -d submodule
> 	then
> 
>> +		echo change>>submodule/first.t &&
> 
> Style: SP before but not after redirection operator, i.e.
> 
> 	echo foo >>bar
> 
>> +submodule_removal_must_succeed() {
> 
> Likewise.
> 
>> +	# checkout base ($1)
>> +	git checkout -f --recurse-submodules $1 &&
> 
> Likewise.
> 
>> +	echo first > file &&
> 
> Likewise.
> 
>> +test_expect_success '"checkout --recurse-submodules" replaces submodule with files' '
>> +	git checkout -f base &&
>> +	git checkout -b replace_submodule_with_dir &&
>> +	git update-index --force-remove submodule &&
>> +	rm -rf submodule/.git .gitmodules &&
>> +	git add .gitmodules submodule/* &&
>> +	git commit -m "submodule replaced" &&
>> +	git checkout -f base &&
>> +	git submodule update -f &&
>> +	git checkout --recurse-submodules replace_submodule_with_dir &&
>> +	test -d submodule &&
>> +	! test -e submodule/.git &&
>> +	test -f submodule/first.t &&
>> +	test -f submodule/second.t
>> +'
> 
> Hmmmm.  Is it sufficient for these files to just exist, or do we
> want to make sure they have expected contents?

Thanks, will consider all you remarks above in the ongoing work for
testing framework which should replace these tests.
