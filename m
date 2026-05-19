Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3133E0C6B
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178926; cv=none; b=scdJryRDu7clUVrxsEyoW+wapoZXI6MekXrzEzYAgsG8VC4DISWk255dft50K1Ow8vD9Q9hGyIM/UfoL5PRi8FcXAo7fuXCX2n7ns+U80JEuzrRdb4B/zT57jTYYhMaVQBhfvfjiB1vgunfC8d4lc0H/MAvPrVFCWQ+fEuFBxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178926; c=relaxed/simple;
	bh=UroReQyq+TS9tksc/fBfYZhMAUmD1iG2/AjtN1+yPVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSzSKjXY4L2Nl4SGZbo1cvt0Skki6SuARG07p84WRh6Y0EoUKoVc6MJaJlLzR4XG70KfUSHHcGT2xw0Ng/5HiahCxSl+qBCLHpkSJ2RDEsG+fanucNSAdxUWbHB1hGkJ0bRSm2271n+7dly5djr11S+3lpbAGaQCN9/IIgtOkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gKSM71tXwzRpKj;
	Tue, 19 May 2026 10:21:55 +0200 (CEST)
Message-ID: <3b16fbc6-074b-410d-861e-6f77794b02a0@kdbg.org>
Date: Tue, 19 May 2026 10:21:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/11] git-gui: add gui and pick as explicit
 subcommands
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-12-mlevedahl@gmail.com>
 <e336544b-941d-43ed-890f-2b8950dbaf88@kdbg.org>
 <fad43240-1089-4447-b97d-ee553c34eef1@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <fad43240-1089-4447-b97d-ee553c34eef1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.05.26 um 17:42 schrieb Mark Levedahl:
> On 5/16/26 4:18 AM, Johannes Sixt wrote:
>> Am 14.05.26 um 16:33 schrieb Mark Levedahl:
>>> diff --git a/git-gui.sh b/git-gui.sh
>>> index 3a83dd5..c56aeef 100755
>>> --- a/git-gui.sh
>>> +++ b/git-gui.sh
>>> @@ -1021,6 +1021,7 @@ proc load_config {include_global} {
>>>  ##
>>>  ## feature option selection
>>>  
>>> +set run_picker_on_error 1
>>>  if {[regexp {^git-(.+)$} [file tail $argv0] _junk subcommand]} {
>>>  	unset _junk
>>>  } else {
>>> @@ -1030,6 +1031,7 @@ if {$subcommand eq {gui.sh}} {
>>>  	set subcommand gui
>>>  }
>>>  if {$subcommand eq {gui} && [llength $argv] > 0} {
>>> +	set run_picker_on_error 0
>>>  	set subcommand [lindex $argv 0]
>>>  	set argv [lrange $argv 1 end]
>>>  }
>>> @@ -1047,6 +1049,7 @@ blame {
>>>  	disable_option multicommit
>>>  	disable_option branch
>>>  	disable_option transport
>>> +	set run_picker_on_error 0
>>>  }
>>>  citool {
>>>  	enable_option singlecommit
>>> @@ -1055,6 +1058,7 @@ citool {
>>>  	disable_option multicommit
>>>  	disable_option branch
>>>  	disable_option transport
>>> +	set run_picker_on_error 0
>>>  
>>>  	while {[llength $argv] > 0} {
>>>  		set a [lindex $argv 0]
>> Can we please use the available disable_option and enable_option feature
>> instead of a new variable. Just for consistency around repository discovery.
>>
>>> @@ -1162,14 +1166,28 @@ proc pick_repo {} {
>>>  	set picked 1
>>>  }
>>>  
>>> +# run repository picker if explicitly requested
>>> +switch -- $subcommand {
>>> +	pick {
>>> +		pick_repo
>>> +		set subcommand gui
>>> +		set run_picker_on_error 0
>>> +	}
>>> +}
>>> +
>> It just feels wrong to have a new pick_repo call before repository
>> discovery. Can we not treat this case below as if regular repository
>> discovery failed and then end up in the existing call of pick_repo?
> 
> So, your suggestion is to create an error inside the catch clause, assure GIT_VAR and
> GIT_WORK_TREE are unset so we don't throw and error message and abort, and then fall
> through to the existing pick_repo clause?


I think I would be happier with the structure

if not subcommand pick
    discover gitdir
    if error
        set subcommand pick

if subcommand pick
    pick_repo
    set subcommand gui

because this clarifies that pick_repo must erase all current traces of
GIT_DIR and GIT_WORK_TREE from the envionment and must complete with a
valid setup.

With the structure in the proposed patch

if subcommand pick
    pick_repo
    set subcommand gui

discover gitdir
if error
    pick_repo

we still need the same operation of pick_repo, but after it runs due to
a pick command, we go into "discover gitdir" mode in an already modified
environment, something that does not happen if pick_repo runs due to the
error in the gitdir discovery.

-- Hannes

