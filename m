From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] Improve push performance with lots of refs
Date: Tue, 23 Dec 2014 10:40:54 -0800
Message-ID: <xmqqd27a2oqx.fsf@gitster.dls.corp.google.com>
References: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:41:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3UOF-0003x8-Hj
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbaLWSk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:40:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751354AbaLWSk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:40:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD9EE28EDB;
	Tue, 23 Dec 2014 13:40:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gEf3gKssn3xA3eh9FmTfrv9r5JM=; b=ENlQuA
	uMifpmExSa4VqF2mrIrC2DAv7vwEKuBRyg/Tf8tVrMRe2eNwSpa6vi39L477gKRM
	fEdMhy4aOWCkCPP8kt0LxFX2xru8D5ehPjpBOSnF/b6i11obQiLEwCv8WXHRqHtm
	/xBIfnDjYG3uEFQaqpqmKoz4fjQCWkk/9UnVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OXb1Cr8z+TxUNJh4aDC2EKdvQsvSCFE/
	zrkbcS3Z8PBEh3u2rmnewqBqwARO9iXHkISg7gcAOn0oFZW+5x4IgNksKwO/lFKe
	td2AMSRMN0xmKSnu1SBXL/nW6IVKncEpmPkj+kCTW1zP3ipkrIkYiqXI3kn6RktJ
	A7nbedT3on4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B435528EDA;
	Tue, 23 Dec 2014 13:40:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EC1A28ED9;
	Tue, 23 Dec 2014 13:40:57 -0500 (EST)
In-Reply-To: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Tue, 23 Dec 2014 12:01:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3BA536CC-8AD3-11E4-90CF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261761>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The only change from v2 is the addition of a fourth patch, which fixes
> t5500.  It's necessary because the test wants packs for fetches to
> shallow clones to be minimal.
>
> I'm not especially thrilled with having to provide a --shallow command
> line argument, but the alternative is to buffer a potentially large
> amount of data in order to determine whether the remote side is shallow.

You spell "--thin-aggressive" as two words, "--thin" "--shallow", in
this series, essentially, no?

I think this is going in the right direction.  The "shallow"
propagated on the wire from the fetcher is the right thing to use
to make this decision.

I wonder if the call to is_repository_shallow() is still necessary
(read: I would prefer to see it go away) where we decide between
"--objects-edge" and "--objects-edge-aggressive".

Here is the relevant part from 4/4:

@@ -2711,7 +2714,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
-		argv_array_push(&rp, is_repository_shallow()
+		argv_array_push(&rp, is_repository_shallow() || shallow
 				? "--objects-edge-aggressive"
 				: "--objects-edge");
 	} else
