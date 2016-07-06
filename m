Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF8F2070E
	for <e@80x24.org>; Wed,  6 Jul 2016 14:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbcGFO5G (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 10:57:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753650AbcGFO5F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 10:57:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9091726A32;
	Wed,  6 Jul 2016 10:57:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IJsmwD1aGYUk
	9howVMLUVc1h3jI=; b=VpyBzPuyBFH4P/7ATYp1YlU/s9fW5VGfynshWsgmeXtg
	YpafTKjEfE0fpYk3BSmdpCDR9x718T62LFRp5S/OKBYWLQDegOA8p6vnLISeOREj
	8Tk1O4epPySFhSXTEILbWa+AJzmobRolzdTldtFGdSLSswqbIYC42SiFDTQiQXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CoSTEz
	OBtRjtfv/re9sU+JIo8yJKC7ZsVmkxjFpzIvL3kx0znH5RrOV3mHKW2sS/4dH1rT
	Wj7CDLWOKTiNsgdxsinCVDLN8O1TtUGKjlx1ZtmISUQN+oPdvjS3uMh6teZXTTG5
	X4xVtAnG96z73OzbOLNbUF8t130+5RwOh1Yj4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8801E26A30;
	Wed,  6 Jul 2016 10:57:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0DB7426A2F;
	Wed,  6 Jul 2016 10:57:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
	<1467100876-2803-1-git-send-email-tboegi@web.de>
	<xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
	<62eb3d75-126e-427b-8701-d490e80e3501@web.de>
	<xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
	<574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
Date:	Wed, 06 Jul 2016 07:57:00 -0700
In-Reply-To: <574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sat, 2 Jul 2016 20:41:33
 +0200")
Message-ID: <xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E60EAF88-4389-11E6-9CCF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> At some point inside the merge, Git calls read-cache.c/ce_compare_data(),
>   to check if the path named "file" is clean.
>   According to the tree information, the path "file" has the sha1 99b633.
>   #Note:
>   #sha1 99b633 is "first line\nsame line\n"

I thought your scenario was that our side had CRLF both in the blob
and in the working tree.  So this is a different example?  Our side
has LF in the blob that is checked out with CRLF in the working tree,
and their side has CRLF in the blob?

> ce_compare_data() starts the work:
> OK, lets run index_fd(...,ce->name,...)
> # index_fd will simulate a "git add"  and return the sha1 (via the sha1 pointer)
> # after the hashing.
>
> # ce_compare_data() will later compare ce->sha1 with the result stored in
> # the local sha1. That's why a sha1 is in the parameter list.
> # To return the resulting hash:
>
> ce_compare_data() calls index_fd(sha1, ..., ce->name, ...)
>
> #Down in index_fd():
>
> sha1_file.c/index_fd() calls index_core() (after consulting the attributes)
> index_core() reads the file from the working tree into memory using
> read_in_full(), and after that index_mem() calls hash_sha1_file(buf)
> to calculate the sha1.
>
> Before the hashing is done, index_mem() runs
> convert_to_git(path, buf, size, &nbuf, SAFE_CRLF_FALSE)
> to convert  "blobs to git internal format".
>
>
> Here, convert_to_git() consults the .gitattributes (again) to find out that
> crlf_action is CRLF_AUTO in our case.
> The "new safer autocrlf handling" says that if a blob as any CR, don't convert
> CRLFs at "git add".
>
> convert.c/crlf_to_git() starts to do it's job:
> - look at buf (It has CRLF, conversion may be needed)
> - consult blob_has_cr()
>   # Note: Before this patch, has_cr_in_index(path)) was used
>
> #Again, before this patch,
> has_cr_in_index(path) calls read_blob_data_from_cache(path, &sz) to read the
> blob into memory.
>
> Now read_blob_data_from_cache() is a macro, and we end up in
> read_blob_data_from_index(&the_index, (path), (sz))
>
> read-cache.c/read_blob_data_from_index() starts its work:
> 	pos = index_name_pos(istate, path, len);
> 	if (pos < 0) {
> 		/*
> 		 * We might be in the middle of a merge, in which
> 		 * case we would read stage #2 (ours).
> 		 */
>
> # And here, and this is important to notice, "ours" is sha1 ad55e2,
> # which corresponds to "first line\r\nsame line\r\n"

Where did 99b633 come from then?  There still is something missing
in this description.

Puzzled...
