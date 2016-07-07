Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD23E2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 18:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbcGGSnp (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 14:43:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752799AbcGGSng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2016 14:43:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 820052A63A;
	Thu,  7 Jul 2016 14:43:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ojVQCMrITnDn
	TpTIbgQmT8qt504=; b=Xx4TQv6L+zOzf+VLrUN7YEaPa7sPH3+bTbZotae3XeEe
	Jz5SvL04HxZt8eiK/7trgX4jvE3sH6flsYulZ3K8mVtZiz6bHNej5xVEgEcTc6Wg
	1pMdzZ0Luh/UZpA9fdO5f3C+hUIu0zpb9Jz+ZNbR6sjlL11bqXSMM3CswgAQya0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PhZrK7
	qIjuZolqBUcgDJYu7z1Yj/I+q1kcp7Ca1eJsQ0XSd7dhLKn7lYVLlBi5ERav2DKv
	8LOoYuRpHq2kPLF7gyr3fd3MnXIH6OZZendoNoaaaMMpp4XrjXvWHeMG5BQSYPLq
	11FdjNlLNVtZM6etRsSHMyXVA/zGULFfQteuU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A99D2A639;
	Thu,  7 Jul 2016 14:43:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F16912A638;
	Thu,  7 Jul 2016 14:43:33 -0400 (EDT)
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
	<xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
	<c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
Date:	Thu, 07 Jul 2016 11:43:31 -0700
In-Reply-To: <c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Thu, 7 Jul 2016 19:16:09
 +0200")
Message-ID: <xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B54BE976-4472-11E6-B8B8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> This is the callstack:
>
> merge-recursive.c/add_cacheinfo(unsigned int mode, const unsigned char *sha1,
> 		const char *path, int stage, int refresh, int options)
> {
> 	struct cache_entry *ce;
> 	ce = make_cache_entry
> 	if (!ce)
> 		return error(_("addinfo_cache failed for path '%s'"), path);
> 	return add_cache_entry(ce, options);
> }
> #Calls
> read-cache.c/make_cache_entry(path=file sha1=0x99b633 stage=0)
>
>
> struct cache_entry *make_cache_entry(unsigned int mode,
> 		const unsigned char *sha1, const char *path, int stage,
> 		unsigned int refresh_options)
> {
>         [snip]
> 	ret = refresh_cache_entry(ce, refresh_options);
> 	if (ret != ce)
> 		free(ce);
> 	return ret;
> }
>
> #Calls
> refresh_cache_ent(&the_index, ce, options, NULL, NULL);
>
> #Calls
> ie_modified()
>
> #Calls
> read-cache.c/ie_match_stat()
>
> #Calls
> changed |= ce_modified_check_fs(ce, st);
>
> #Calls
> ce_compare_data(path=file sha1=0x99b633)
>
> #Calls
> index_fd(..., ..., ce->name, ...)
> #Note the sha is lost here, the parameter sha is the output.
>
> Deep down, has_cr_in_index(path) will look at ad55e2 instead,
> which is wrong.

The call to add_cacheinfo() is made with 99b633 to record the 3-way
merge result to the index in this callchain:

 merge_trees()
 -> git_merge_trees()
 -> process_renames() # does nothing for this case
 -> process_entry()
    -> merge_content()
       -> merge_file_special_markers()
          -> merge_file_1()
             -> merge_3way()
                -> ll_merge() # correctly handles the renormalization
             -> write_sha1_file() # this is what gives us 99b633
    -> update_file() # this is fed the 99b633 write_sha1_file() computed
       -> update_file_flags()
          -> read_sha1_file() # reads 99b633
          -> convert_to_working_tree()
          -> write_in_full() # updates the working tree
          -> add_cacheinfo() # to record 99b633 at "file" in the index

So refresh() may incorrectly find that 99b633 does not match what is
in the filesystem if it looks at _any_ entry in the index.  We know
we have written the file ourselves, so by definition it should match
;-) Even though I am not sure why that should affect the overall
correctness of the program (because we have written the correct
result to both working tree and to the index), this needs to be
fixed.

I am however not convinced passing the full SHA-1 is a good
solution.  The make_cache_entry() function may be creating a cache
entry to stuff in a non-default index (i.e. not "the_index"), but
its caller does not have a way to tell it which index the resulting
cache entry will go, and calls refresh_cache_entry(), which always
assumes that the caller is interested in "the_index", so what
add_cacheinfo() does by calling make_cache_entry() feels wrong in
the first place.  Also, the call from update_file_flags() knows that
the working tree is in sync with the resulting cache entry.

Perhaps update_file_flags() should not even call add_cacheinfo()
there in the first place?  I wonder if it should just call
add_file_to_index()---after all, even though the current code
already knows that 99b633 _is_ the result it wants in the index, it
still goes to the filesystem and rehashes.

I dunno.  I really do not like that extra sha1 argument added all
over the callchain by this patch.

Or did you mean other calls to add_cacheinfo()?
