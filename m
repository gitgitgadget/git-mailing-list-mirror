Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1899FC11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49D224673
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pH+M+mKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgBTSsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:48:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59600 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgBTSsB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 13:48:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3730B5020F;
        Thu, 20 Feb 2020 13:47:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0VqL61oT2Clbv3eTUsCZsRVSSY8=; b=pH+M+m
        KMfIV11TnSX6UsHH4yq/DjpiX4l9Gj4JhRPYFAdh7c6idi0CpSvpDFYl+DZbvVOv
        sV1eRDUSVxZ7uRORaK3veZtddJk/lURBR/x/GDa97tkT2i4z+blTwHxN0ujDDzUC
        cxmW8mECPN80prYU68iXKI/VKCpadEEv13WSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S6btd9dKQq4O3zB4+HfANeAABAieHuAo
        5XW2ziKUAkwnpZ908l//za3W2u7cbs/bixho/IMPvjU72FXpQcD7MRsWft5yaDlO
        n49X42u1ypy7hAZTbSg7UyR/+bDS2xavJk9Nrz2CndnAXlFb2tQ2r20Qfsc53HtF
        iGi4PSerxgA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F1645020E;
        Thu, 20 Feb 2020 13:47:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D5515020D;
        Thu, 20 Feb 2020 13:47:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG: git clean -d cannot remove files from read-only directories
References: <BL0PR2101MB10898F2F84B06B1A6B23228380130@BL0PR2101MB1089.namprd21.prod.outlook.com>
        <xmqqo8ttaz3p.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 20 Feb 2020 10:47:57 -0800
In-Reply-To: <xmqqo8ttaz3p.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 20 Feb 2020 10:32:42 -0800")
Message-ID: <xmqqk14hayea.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 838545A6-5411-11EA-8A30-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Adam Milazzo <Adam.Milazzo@microsoft.com> writes:
>
>> Repro steps:
>> 1. git init 
>> 2. mkdir d
>> 3. touch d/a
>> 4. chmod -w d
>> 5. git clean -fd
>>
>> Actual result:
>> Git doesn't remove anything, saying "warning: failed to remove d/a".
>>
>> Expected result:
>> Git should remove the subdirectory 'd' along with its
>> contents. Note that git can remove a read-only file (touch b;
>> chmod -w b; git clean -f) with no problem.
>
> It is how UNIX-like filesystem works, isn't it?
>
> As long as a directory D is writable/executable, any regular file
> inside it can be removed regardless of the perm-bits of the file.
>
> 	mkdir d
> 	touch d/a
> 	chmod -w d
> 	rm d/a
>
> would not let you remove the file d/a from d/, exactly because you
> cannot modify d/ (it is not writable).

I realize that the above is probably a bit too terse for those who
are not familiar with the UNIX/POSIX-like filesystems.

A directory is a record of what files (and subdirectories) are in
it.  If you add a file to or remove a file from a directory, you
are updating that record---so you need to be able to write to the
directory.  You do not have to be able to write (or even to read for
that matter) to the file you are adding or removing to the directory,
because adding or removing a file from a directory involves only
updating the record kept in the directory about what files and
subdirectories are in that directory (hence you need to be able to
write to the directory---but perm bits on the files you are adding
or removing do not play a role in this operation).

A collorary is that modifying an existing file in a directory does
not have to change what is recorded in the directory---what files
are in the directory does not change.  You only need to be able to
write the file, so you can edit a file in a read-only directory.  

Note that some editors, however, implement an "edit" as "rename the
original file as a backup, create a new copy of a file, and edit
that new copy".  With such an editor, you cannot "edit" a writable
file in a read-only directory and the reason would by now be obvious
to you once you understand the explanation above.  Both renaming the
original and creating the new copy would be updating what files are
in the directory, requiring you to be able to write to the directory.

Hope this helps.

