Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7A5383
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751930037; cv=none; b=NC8ak7CbzIZPCKJRmtRRGh/WvlSadZg/BkT+bp7wuwMKqEveH4f/1QBGg5w/US+xU8EqSrB6UGvT/OCsR2UVAEX82F3GHIMqxZ7fTZVYWJCHvQ3k8VekCroXBcelgylJlBzgo/E8GkSe/hTdVNuJSpG7wAyW3rmeUpGc0sGI7DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751930037; c=relaxed/simple;
	bh=MvQU3n8Xl2miHS2xuQMGyK1M2A8YGJ4o8H85BYm+VQc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ssBu0w16gxKe6oLdr76mPnNyHW/JZGe/BrKEjc8fwyh6Un/KDhSWqnTM/i7ugicuAwMMwAgd3D2E7zvdU088OcTWOoKmhFrFRjtPxUsbh0YuhNSIH+cSROcnyLkB5EdJL6KeIN7PoLBZcsnT2nmABQxoukCfAC6LVKenYlIKEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 567ND3Am4107343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Jul 2025 23:13:04 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
Cc: "'M Hickford'" <mirth.hickford@gmail.com>
References: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>	<xmqqcybcrc2u.fsf@gitster.g>	<CAGJzqskj803dUcEuV+P-yuWdT0tiaidb7h3YxQSCgYHWgBfaWA@mail.gmail.com>	<xmqqzfefodje.fsf@gitster.g> <xmqqfrf73ahu.fsf@gitster.g>
In-Reply-To: <xmqqfrf73ahu.fsf@gitster.g>
Subject: RE: Suggestion: error "tag ... already exists" should distinguish between tagging different or same commit:
Date: Mon, 7 Jul 2025 19:12:58 -0400
Organization: Nexbridge Inc.
Message-ID: <00ca01dbef94$b155f380$1401da80$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQF8XigVdo8ntnZ8Am4sQqJ8t0e+hgFeBb7OAbQjWlMAuF/zSwIjYM5vtLb8d4A=
X-Antivirus: Norton (VPS 250707-4, 7/7/2025), Outbound message
X-Antivirus-Status: Clean

On July 7, 2025 6:24 PM, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>> Or simply something like this.  I am not convinced (yet) that this is
>> a good idea; I merely is showing that the implementation would look
>> like this.
>>
>> ----- >8 -----
>> Subject: tag: allow idempotent "git tag" without "--force"
>>
>> When "git tag T O" is told to create a tag pointing at an object O
>> without the "--force" option, it refuses with "tag T already exists",
>> even when T points at O (which makes it a no-op).
>>
>> Let's allow this "idempotent" case by special casing.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  builtin/tag.c  |  2 +-
>>  t/t7004-tag.sh | 12 +++++++++---
>>  2 files changed, 10 insertions(+), 4 deletions(-)
>
>As I see nobody biting, I am inclined to say that this is not such a
brilliant idea.  Let's
>chuck it.
>
>>
>> diff --git c/builtin/tag.c w/builtin/tag.c index
>> 4742b27d16..5380a46494 100644
>> --- c/builtin/tag.c
>> +++ w/builtin/tag.c
>> @@ -660,7 +660,7 @@ int cmd_tag(int argc,
>>
>>  	if (refs_read_ref(get_main_ref_store(the_repository), ref.buf,
&prev))
>>  		oidclr(&prev, the_repository->hash_algo);
>> -	else if (!force)
>> +	else if (!force && (create_tag_object || !oideq(&object, &prev)))
>>  		die(_("tag '%s' already exists"), tag);
>>
>>  	opt.message_given = msg.given || msgfile; diff --git
>> c/t/t7004-tag.sh w/t/t7004-tag.sh index 10835631ca..9a253a44a8 100755
>> --- c/t/t7004-tag.sh
>> +++ w/t/t7004-tag.sh
>> @@ -126,7 +126,7 @@ test_expect_success 'annotated tag with
--create-reflog
>has correct message' '
>>  '
>>
>>  test_expect_success '--create-reflog does not create reflog on failure'
'
>> -	test_must_fail git tag --create-reflog mytag &&
>> +	test_must_fail git tag --create-reflog mytag no-such-object &&
>>  	test_must_fail git reflog exists refs/tags/mytag  '
>>
>> @@ -183,8 +183,14 @@ test_expect_success 'listing tags using a
>> non-matching pattern should output not
>>
>>  # special cases for creating tags:
>>
>> -test_expect_success 'trying to create a tag with the name of one
existing should
>fail' '
>> -	test_must_fail git tag mytag
>> +test_expect_success 'recreating a tag without --force' '
>> +	# light-weight tag pointing at the same thing
>> +	# now succeeds
>> +	git tag mytag HEAD &&
>> +	# light-weight tag pointing at a different thing
>> +	test_must_fail git tag mytag HEAD: &&
>> +	# creating annotated tag, pointing at the same object.
>> +	test_must_fail git tag -a -m anno mytag $taggedobject
>>  '
>>
>>  test_expect_success 'trying to create a tag with a non-valid name should
fail' '

Considering that git tag T O will generally require a git push --force and
always a
git pull --force in order to update tags on the upstream and receiving an
update
to the tag locally, I think requiring git tag --force T O when O is
different from the
current tag is a reasonable idea from a consistency standpoint. I do support
the
notion of git tag T O not requiring a --force if O is already where the tag
is
pointing. The only counter case I can really see in this is when -s is used
to allow
the sign to be updated but even then, does --force really change anything
when
only signing (I think not) because O does not change. If O changes when
signing,
I think that --force is almost essential to avoid messing up the signatures.

--Randall

