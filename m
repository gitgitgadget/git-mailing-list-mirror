Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181212F394
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987879; cv=none; b=ClfOxrnmUxF+jYyV0+nu71IQY4JMNi/dBB19GxiquU/iRzczGnP0UR+qV0Y/IaDBJ9HDac1Xjaqp/WGGdy6gF/WOV2nEZ3mAcgfCEIlrj1A+788kLAX2BeksFfSNCKlLfuYF+q4yZ4sSND1MW9JRFwE9miVfttkWXYiOYI9QmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987879; c=relaxed/simple;
	bh=JwrSmCV09sQ0jB7XQrn+i1ZtWmtDhVXh+SXoxSapKtw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rngoeDjq1zXPJqXsdFPDkK1J9/lCO6WF9M6pIu3t7Io9NgSKXNRGu+1iDkoSLWK3UA/UUKDmU9K5KS5iQmM2Zd06oAKPAS7eZh+Uib1vo8b8kBwP0s+AArfcBz8qdKe+tiToSXqS6/IbLJFdgtr1oAywxZXBq2SOEgpJHwTTytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41QMpEVG2231692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 22:51:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>,
        "'Randall S. Becker'" <the.n.e.key@gmail.com>
Cc: <git@vger.kernel.org>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca> <20240226220539.3494-2-randall.becker@nexbridge.ca> <Zd0S7aUIG1bhGkaX@nand.local>
In-Reply-To: <Zd0S7aUIG1bhGkaX@nand.local>
Subject: RE: [PATCH v1 1/4] builtin/index-pack.c: change xwrite to write_in_full to allow large sizes.
Date: Mon, 26 Feb 2024 17:51:09 -0500
Organization: Nexbridge Inc.
Message-ID: <026b01da6906$4d96f530$e8c4df90$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFCEXZVVjijNd8r2UxZXOALnJerBgHno3IKAhKWxEKyLhcRMA==

On Monday, February 26, 2024 5:39 PM, Taylor Blau wrote:
>On Mon, Feb 26, 2024 at 05:05:35PM -0500, Randall S. Becker wrote:
>> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>>
>> This change is required because some platforms do not support file
>> writes of arbitrary sizes (e.g, NonStop). xwrite ends up truncating
>> the output to the maximum single I/O size possible for the =
destination device.
>
>Hmm. I'm not sure I understand what NonStop's behavior is here...
>
>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c index
>> a3a37bd215..f80b8d101a 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -1571,7 +1571,7 @@ static void final(const char *final_pack_name, =
const char *curr_pack_name,
>>  		 * the last part of the input buffer to stdout.
>>  		 */
>>  		while (input_len) {
>> -			err =3D xwrite(1, input_buffer + input_offset, input_len);
>> +			err =3D write_in_full(1, input_buffer + input_offset, input_len);
>>  			if (err <=3D 0)
>>  				break;
>>  			input_len -=3D err;
>> --
>> 2.42.1
>
>The code above loops while input_len is non-zero, and correctly =
decrements it by the number of bytes written by xwrite() after each
>iteration.
>
>Assuming that xwrite()/write(2) works how I think it does on NonStop, =
I'm not sure I understand why this change is necessary.

NonStop has a limited SSIZE_MAX. xwrite only handles that much so =
anything beyond that gets dropped (not in the above code but in other =
builtins); hence the critical nature of getting this fix out. This =
particular change probably could be tightened up on a re-roll to just =
call write_in_full instead of the while loop. I can fix that for v2. The =
goal suggested by Phillip W was to change xwrite to write_in_full, so I =
guess I went a little too far.=20



