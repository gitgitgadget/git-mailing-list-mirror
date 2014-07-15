From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/4] cache-tree: Create/update cache-tree on checkout
Date: Tue, 15 Jul 2014 14:55:50 -0700
Message-ID: <xmqqr41mthg9.fsf@gitster.dls.corp.google.com>
References: <1405283299-25636-1-git-send-email-dturner@twitter.com>
	<53C5828F.2050005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 23:56:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Ahg-00047t-7b
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 23:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933861AbaGOV4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2014 17:56:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53760 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933246AbaGOVz6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2014 17:55:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F2648270AC;
	Tue, 15 Jul 2014 17:55:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aTzsU8/MfODk
	9Z3seONiso0MlwE=; b=AWRDqNB1KmNZirviwkKHeutdfVW7T2Sdx4G5ewH4qY0C
	R+TZE5iEZYkh6FAZgrv7fNbqGaQomduqRn7kUDKudys9fOSLGd0cLbgqfl/YmhQN
	DydiY2OYesr+WcWZMkaD/kamJbfhVFfdgQZgRvEYsjlzPegH/5gU8a4ne2SzMOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qpUJKU
	bMe4mRjLT6ypHW8WoN9dFj97ndMzzQUZXNRHMVZQe7MLIOJbe8kbMmfjcHZFz4Fp
	rndXXSUbnMraOGd4T/CT0b3LG6Uusnj2NZAV0BBQRDkd2Zk084QO9azW3iBf0Tq1
	hc/uYjilSDo7fNLVCyRie7UV8Rmp7v8Pxqa7E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7B79270AB;
	Tue, 15 Jul 2014 17:55:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2D2DF2709A;
	Tue, 15 Jul 2014 17:55:34 -0400 (EDT)
In-Reply-To: <53C5828F.2050005@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 15 Jul 2014 21:35:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BF356EAE-0C6A-11E4-B9D2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253607>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 07/13/2014 10:28 PM, David Turner wrote:
>> From: David Turner <dturner@twopensource.com>
> []
>> diff --git a/cache-tree.c b/cache-tree.c
>> index 7fa524a..f951d7d 100644
>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -239,9 +239,12 @@ static int update_one(struct cache_tree *it,
>>   	struct strbuf buffer;
>>   	int missing_ok =3D flags & WRITE_TREE_MISSING_OK;
>>   	int dryrun =3D flags & WRITE_TREE_DRY_RUN;
>> +	int repair =3D flags & WRITE_TREE_REPAIR;
>>   	int to_invalidate =3D 0;
>>   	int i;
>>   +	assert(!(dryrun && repair));
> I think something in the spirit of
> die("dryrun and repaiir can not be used together"\n)
> Would be nicer to the user as well as being more reliable (as assert
> may be a no-op in some systems)

While it is a good suggestion *not* to attempt validating the
end-user input with assert() for the reason you state, I think for
this particular case, these flags only come from the code and assert()
to catch programming errors would be sufficient.

Besides, as discussed elsewhere, WRITE_TREE_DRY_RUN should not be
used, and the support for it should be dropped.  It is broken in
that the code path that leads to update_one() may correctly compute
tree object names and stuff them in the cache-tree, higher layer
code would then complain on such a cache-tree that records tree
objects that do not exist.
