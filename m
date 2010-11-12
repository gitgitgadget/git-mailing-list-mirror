From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 1/3] fetch/pull: Add the --recurse-submodules option
Date: Fri, 12 Nov 2010 21:22:13 +0100
Message-ID: <4CDDA1F5.4090504@web.de>
References: <4CDB3063.5010801@web.de> <20101111000538.GB14189@burratino> <4CDD391C.2000905@web.de> <20101112195453.GA25248@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 21:22:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH08w-0003a0-F9
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 21:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205Ab0KLUWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 15:22:37 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:53342 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541Ab0KLUWg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 15:22:36 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id C4651182CF9DE;
	Fri, 12 Nov 2010 21:22:13 +0100 (CET)
Received: from [93.240.101.21] (helo=[192.168.178.29])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PH08T-0005dT-00; Fri, 12 Nov 2010 21:22:13 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101112195453.GA25248@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1953fWVVe4liSxHpobt3oaI7gMAgJJdhqk4uHRt
	qJQnTr31Y9RTwH3C9MhCO9j6Hin0hkHufFj2XLwmpNHoqnb/s4
	ORbHkwSPwYVefpOfMt0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161360>

Am 12.11.2010 20:54, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
> 
>> Ok, here is the updated version of patch 1/3 making "--submodule-prefix" a
>> hidden option which is not documented in Documentation/fetch-options.txt .
> 
> Oh, I missed that you were proposing leaving it undocumented.  On one hand,
> it is nice when debugging if all options are documented; but on the other
> hand, there is precedent in --rebasing for hiding implementation details
> like this.  Unlike -h output, the manual is not so space-constrainted, so...

Whoops, my question was about hiding the option and so I have been a bit
overeager to remove the documentation too ...

>> --- /dev/null
>> +++ b/t/t5526-fetch-submodules.sh
>> @@ -0,0 +1,109 @@
>> +#!/bin/sh
>> +# Copyright (c) 2010, Jens Lehmann
>> +
>> +test_description='Recursive "git fetch" for submodules'
>> +
>> +. ./test-lib.sh
>> +
>> +pwd=$(pwd)
>> +
>> +add_upstream_commit() {
>> +	(
>> +		cd submodule &&
>> +		head1=$(git rev-parse --short HEAD) &&
>> +		echo new >> subfile &&
>> +		test_tick &&
>> +		git add subfile &&
>> +		git commit -m new subfile &&
>> +		head2=$(git rev-parse --short HEAD) &&
>> +		echo "From $pwd/submodule" > ../expect.err &&
>> +		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
>> +	)
>> +	(
> 
> Missing &&?

Good eyes!

> Hope that helps.  These are just tiny nitpicks; I am happy with the patch
> with or without them.

Thanks!

Junio, do you want me to send an updated version of this patch or are you ok
with squashing this in?


> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 594f7ce..a9cb8ab 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -67,6 +67,13 @@ endif::git-pull[]
>  --recurse-submodules::
>  	Use this option to fetch new commits of all populated submodules too.
>  
> +ifndef::git-pull[]
> +--submodule-prefix=<path>::
> +	Prepend <path> to paths printed in informative messages
> +	such as "Fetching submodule foo".  This option is used
> +	internally when recursing over submodules.
> +endif::git-pull[]
> +
>  -u::
>  --update-head-ok::
>  	By default 'git fetch' refuses to update the head which
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 107317a..9c1d3a0 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -18,7 +18,7 @@ add_upstream_commit() {
>  		head2=$(git rev-parse --short HEAD) &&
>  		echo "From $pwd/submodule" > ../expect.err &&
>  		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
> -	)
> +	) &&
>  	(
>  		cd deepsubmodule &&
>  		head1=$(git rev-parse --short HEAD) &&
> 
