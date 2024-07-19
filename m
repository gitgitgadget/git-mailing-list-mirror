Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E713A276
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400625; cv=none; b=KyLWk3k0mlhO7PsonQD+vN8o26IOFt+A5vNavs3+i5s2OsRHe2vVH1ZBVTRc0gEHQvat/0Ryb8574pt1L8MZWLVu7N2MHtJ4Jtogpx8z+mixskeqolGXEFeyhFfsHD85i6EVbTVbtKMIKrTT411bCXulrWnbEIpNepA/B1o4tOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400625; c=relaxed/simple;
	bh=Swl4lQxRFMcAAJPOJYHO2k39om70uIKA+x0UVIVaNlo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bk19+/qjWaJhmYsihwrtKB2ASuKpKjUdq2/pFFzeqTtelmUx2kn6yWSK5nZT53Tn9cicCsi9PwNXia7rsBVqSqTWZ5cdrH/B8DB/K7qXfxTsNn+w2IcjEznMQWk2qke0gWmok8IvDWDNiFLcKcThl6cf1yrMJy12azdycypQWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46JEoApT1237295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 14:50:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Ryan Zoeller'" <rtzoeller@rtzoeller.com>
Cc: <git@vger.kernel.org>
References: <wglGbP7resY1dIKhfKqMcs6Xxu7f8iWSZ76k-MFC91eKTEWN2Aw4D6TqNAEndu5b1VZMVnOIS8m9HNoZPFxd6NZjKKmW0OmM8h5bAEuwoVY=@rtzoeller.com> <xmqqa5idmops.fsf@gitster.g>
In-Reply-To: <xmqqa5idmops.fsf@gitster.g>
Subject: RE: Equivalent of difftool.prompt per tool?
Date: Fri, 19 Jul 2024 10:50:05 -0400
Organization: Nexbridge Inc.
Message-ID: <016801dad9ea$f50d5fc0$df281f40$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKvPt7d23A/AtYpvY4z8MqRf9l0hAFFPhIXsEstmXA=
Content-Language: en-ca

On Friday, July 19, 2024 10:38 AM, Junio C Hamano wrote:
>Ryan Zoeller <rtzoeller@rtzoeller.com> writes:
>
>> Is there a way to specify difftool.prompt on a per-tool basis, without
>> manually passing --prompt or --no-prompt to override the global
>> difftool.prompt setting?
>>
>> I generally want `difftool.prompt = false` set, but one specific tool
>> I use has a high startup time and I'd like confirmation before
>> launching it.
>>
>> If this isn't possible today, is difftool.<tool>.prompt something
>> others would find useful?
>
>I do not use difftool (nor mergetool) myself, but given how
difftool.<tool>.cmd and
>difftool.<tool>.path behave, it does not sound like an unreasonable feature
wish.
>
>I'd imagine the feature itself should be trivial to add, but we'd probably
want to add
>test to t/t7800-difftool.sh, where there are already existing tests for
inteactions
>between difftool.prompt and various command line options.
>
>Thanks.
>
> git-difftool--helper.sh | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git c/git-difftool--helper.sh w/git-difftool--helper.sh index
>dd0c9a5b7f..872d787b09 100755
>--- c/git-difftool--helper.sh
>+++ w/git-difftool--helper.sh
>@@ -12,7 +12,9 @@ TOOL_MODE=diff
> # and is overridden with $GIT_DIFFTOOL*_PROMPT.
> should_prompt () {
> 	prompt_merge=$(git config --bool mergetool.prompt || echo true)
>-	prompt=$(git config --bool difftool.prompt || echo $prompt_merge)
>+	prompt=$(git config --bool "difftool.$merge_tool.prompt" ||
>+		 git config --bool difftool.prompt ||
>+		 echo $prompt_merge)
> 	if test "$prompt" = true
> 	then
> 		test -z "$GIT_DIFFTOOL_NO_PROMPT"

Is it possible that a textconv configuration might be able to assist here by
declaring a tool under user control for displaying content of files? This
might give finer grain control prior to launching the diff so that the user
can set up their desired shell environment with the above to select the
prompting software?
Just a thought.
--Randall

