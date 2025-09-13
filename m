Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC481A3142
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774561; cv=none; b=JdQvyPBt27JcLBv79vf6etaxWtdO6nQKjreCWVMW7mzi54vck8cSdwue+KLXsyo3d69ZyoqL98hVCgJOTr/nGcpPj8v53KRipvyhLmaCwRKvQSqaQZAoTZ2KwWsXepejlGXUdse+//lQHqN/IQWhvwMnGlCD3fAOZg8wF8xRGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774561; c=relaxed/simple;
	bh=S+6NCe0XEKYqg0Q52mOLjnCpKUeOUsGbYrqD8vf6iCg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=PKxvI9xCINSVZnKgAGdoulYiykM569/yHCb4FAKNpA7jH1xVDEbFLtErUSwhf1oVJxa92QnL07Gjn52EYntVxwlro+UwnxLsSHHoLfuI6b2d5ZVBVEM51ng9rgKTz+IXlPcBrFnYh5sgrAzsXGSM3q2KzIfaJf6c1kQTS8pJMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58DEgSfd4141695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Sep 2025 14:42:29 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Johannes Sixt'" <j6t@kdbg.org>
Cc: <git@vger.kernel.org>
References: <074901dc2422$2039a910$60acfb30$@nexbridge.com> <a5e01f0f-1789-427c-83c3-90644fa234c9@kdbg.org>
In-Reply-To: <a5e01f0f-1789-427c-83c3-90644fa234c9@kdbg.org>
Subject: RE: [QUESTION] mergetool environment variables
Date: Sat, 13 Sep 2025 10:42:24 -0400
Organization: Nexbridge Inc.
Message-ID: <000201dc24bc$a1b8d9d0$e52a8d70$@nexbridge.com>
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
Thread-Index: AQIIYP6OPNj0v3uszpSJmTqcmvS4YAMVDl7/tCAM3DA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250913-2, 9/13/2025), Outbound message
X-Antivirus-Status: Clean

On September 13, 2025 3:05 AM, Johannes Sixt wrote:
>Am 12.09.25 um 22:16 schrieb rsbecker@nexbridge.com:
>> I am trying to integrate a custom mergetool with a shell wrapper.
>> What I get from the online help is the following description =
referring
>> to the command and environment variables.
>>
>> mergetool.<tool>.cmd
>> Specify the command to invoke the specified merge tool.
>> The specified command is evaluated in shell with the following
>> variables available: BASE is the name of a
>
>Take note: this talks about "variables", not "environment variables".
>
>> temporary file containing the common base of the files to be merged,
>> if available; LOCAL is the name of a temporary file containing the
>> contents of the file on the current branch; REMOTE is the name of a
>> temporary file containing the contents of the file from the branch
>> being merged; MERGED contains the name of the file to which the merge
>> tool should write the results of a successful merge.
>>
>> When I try to use this from a shell, simply with:
>> #!/bin/sh
>> env
>> exit 1
>>
>> the described environment variables: BASE, LOCAL, REMOTE, and MERGED,
>> are not present.
>
>Look at the scripts in the directory mergetools/ and note that they are =
only (large)
>shell code fragements without a shbang line. They are not even =
executable.

Let me try to infer what is happening and please correct me if my =
assumptions
are wrong:

Git includes an existing shell fragment with the appropriate tool name =
from
git-core/mergetools/tool-name instead of creating a dedicated shell in =
which to
run the merge tool script.

It then uses ${merge-tool-path} to execute the tool based on whether =
diff_cmd() or
merge_cmd() is invoked. Because BASE, LOCAL, REMOTE, and MERGED are not
exported, they are not visible to sub-shells.

This does not apply if the tool is unknown to the mergetools directory, =
so must be
contributed and packaged into git to work according to the =
documentation.

So a custom mergetool will not have access to these variables and has to =
hack
through what is in the working index based on file_BASE_num, etc. =
instead of
having direct information on what is being merged.

That about right?

