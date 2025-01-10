Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFA24B254
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547034; cv=none; b=CUEvTB7ChyH1UO7vJWrWknHkso34y9kFANSG7tMO5T05wU6uD8o7B1RLQDeEdQ803b43v+jf7b5f2fdWYDqWJdCRur92FCF1oqUFeMBI7i1baQRX0Ek2x742NBMm5+lPzHRnAdZHmJpo84cU4H14eIJPIU9fe9rPDV7W8V67os4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547034; c=relaxed/simple;
	bh=ZGMN5GVdZlcXBkCo7ZH4m4IVZDt9tJZVuM1aYwXRx0I=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=pr/3R8SYl5QZZ8FmhAufCa5iV0P8xDHI4rOobanX6iN2pONrL2gx08wmnbLyM9xSs7/W0o4JolE5ETMXuOXqLmF+PBpLpotO51bp2cygdD8fhAdP29RHNso6REjJ5/odOQkjA5Anbm6Lv36KR+Gc9VTMLgI+r1xDOhn0dQshnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50AMAQve2316937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 22:10:26 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'M Hickford'" <mirth.hickford@gmail.com>
Cc: <git@vger.kernel.org>, <derrickstolee@github.com>, <stolee@gmail.com>
References: <20250110210500.675629-1-mirth.hickford@gmail.com> <xmqqh6665p8j.fsf@gitster.g>
In-Reply-To: <xmqqh6665p8j.fsf@gitster.g>
Subject: RE: transfer.credentialsInUrl should warn about personal access tokens in user field #leftoverbits
Date: Fri, 10 Jan 2025 17:10:21 -0500
Organization: Nexbridge Inc.
Message-ID: <01a301db63ac$73fb85f0$5bf291d0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHSQkeJdJwayZiGd7YmQhUjFFLawgKT1uCzsw4zuaA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250110-6, 1/10/2025), Outbound message
X-Antivirus-Status: Clean

On January 10, 2025 4:33 PM, Junio C Hamano wrote:
>M Hickford <mirth.hickford@gmail.com> writes:
>
>> It would be neat to warn similarly if the user includes a personal =
access token in
>the *user* field of the remote URL:
>>
>>     git clone https://<pat>@github.com/...
>>
>> This is a popular practice according to StackOverflow
>> https://stackoverflow.com/a/70320541/284795 (800k views).
>>
>> GitHub personal access tokens are easily recognised by their prefixes
>> "ghp_" and "github_pat_"
>
>Curious.  I do not think we have *any* code to special case such a =
"token", so to Git
>itself, https://<pat>@github.com/... should look as it (assuming <pat> =
does not
>have any colon in it) is trying to access the site with <pat> as the =
username.
>
>How do we _know_ that this request with <pat> do not need a password?  =
I ask
>because I'd prefer not to see us hardcoding any hosting-site specific =
heuristics in the
>code, and these users apparently are doing fine without any such =
hardcoding.  If we
>can reuse the mechanism that is letting them do so when deciding if we =
should
>warn, it would be great.
>
>Are users expected to configure their credential helpers know that it =
is a <pat>
>(perhaps with authtype=3DBearer)?

This is why I implemented my own credential layer - sorry, cannot share,
but can describe if asked (maybe at a Git Merge? =F0=9F=98=89 ). Git =
should not need to
know about GitHub specific access methods for HTTPS, where PAT is =
required
for git push. There is no password for PAT use, which makes it highly =
insecure
if persisted on disk - I do not know why GitHub went down that path, I =
guess
they did not want any potential CVEs associated with SSH-like =
passphrases.
PAT became a real annoyance for my community, so I had to do something =
quick
and adding my own credential manager seemed expedient (and works pretty
well - but if someone wants to do this, they must be very careful =
managing
access to the cached PAT's memory use). The primary use case in my =
situation
is not actually git push, but the creation of Pull Requests on GitHub =
from
scripts or a CLI since NonStop has no GUI adapter to access their =
website.

>
>Sorry for not giving any answer and piling more questions on top.

