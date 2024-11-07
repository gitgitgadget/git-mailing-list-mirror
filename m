Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A1212F0E
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999919; cv=none; b=RXFWDQ4OW3v72swRpmG5CSycbz9xwmmU9Bv/4AH511oKG7ZLpXXQbZHd8CJHqeOFAhaKkR+R9h4irRPm8kUFraME1DKC1KGKsOr9vPLoH5CEqVj6iAXDhNbThYqZNi75QCbyLKrJiRi1m7EXEC31QmC/LETw9I0iatFtR3IoDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999919; c=relaxed/simple;
	bh=H27SEWdvO982Kw+9xvf61SJ9X8EuJVf46N7g8mzIDdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UR5lLfVv59Ry2Fn3HxDGuTJ6Vuq1i0WMkAX0YKnpGFHE4jiaqZWH1Y1Cbscq7QB8/0xRWDR/GisXBG1J9XZyAhpDw/MTDwsABnBQc6Vb7K68sZAZvV1ncY82EufQ0C69CqUZOvZyd5eR9/x04EyOiEfr9t3PKYWajgsCi5ldACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Xkpgv50WJz5vWY
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 18:18:35 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Xkpgk706bzRpKP;
	Thu,  7 Nov 2024 18:18:25 +0100 (CET)
Message-ID: <eb3a25c0-7f43-4811-a9ad-0388f395b26e@kdbg.org>
Date: Thu, 7 Nov 2024 18:18:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about merge & cherry pick
Content-Language: en-US
To: Julien Maurel <julien@maurel.me>
Cc: git@vger.kernel.org
References: <711a0faa-6d82-48b6-819d-9ddbeda03f6a@maurel.me>
 <eb367098-0c88-4bc6-b824-32ee6e6d273e@kdbg.org>
 <a129e967-efba-48ba-b5a0-1abbb0af5c9d@maurel.me>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <a129e967-efba-48ba-b5a0-1abbb0af5c9d@maurel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 07.11.24 um 11:32 schrieb Julien Maurel:
> Le 07/11/2024 à 07:37, Johannes Sixt a écrit :
>> A merge does not consider the individual changes on the branches, but
>> only the differences since the merge base. For the merge operation, the
>> change from Z to Y never happened on the dev side. The reversal of Y to
>> Z is not visible for the merge and cannot contribute to the result.
> 
> Ok, I didn't have this vision about how merge is apply, thanks.
> There is no option to merge by considering each commit individually ?
> Rebase do it but not applicable in my case :)

You can merge the dev branch in two steps:

          A Z Q E        initial commit
          /      \
      A Y Q E     |      dev: Z -> Y
         |\       |
         | \   A Y Q E   master: cherry-pick Z -> Y
         |  \     |
         |   A Y Q E     master: merge dev
         |        |
      A Z Q D     |      dev: revert Y -> Z and change E -> D
          \      /
          A Z Q D        merge again

The merge of dev into master changes the merge base of the final merge:
it is the second commit in the diagram. Now there is no contribution to
the merge from the master branch anymore, because its tip is identical
to the merge base, and both changes made in the second commit on dev are
visible and contribute to the merge result.

-- Hannes

