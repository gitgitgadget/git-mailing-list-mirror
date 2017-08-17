Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C430E208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 06:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbdHQGhc (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 02:37:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57231 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751167AbdHQGhb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 02:37:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9801F9EAF7;
        Thu, 17 Aug 2017 02:37:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7D1Tp9GCKkQmZiAnmbJ1TKRY7mc=; b=UhgwZQ
        HY9jGjoL/oTqOnTq4rNPEIZn790FUCthsPHWsFIResEHm4jPRVZyYVrR0wwPJtOj
        B/XZLJgUaKl3k3LuaoV0Mo0BlQNxyFcaUdnSUbg7JSPDgKGCs54CidPnhe5YXAYY
        yp0WwJeHhiZa56i7Zvu+GrRbXSudnKtpN79lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Me7aCNvZ3EO7H3H5NPnrISJpUCJqHrRZ
        C0OGWerocPYCNjo+hH3Je+L6F9NaxY/qJDAPUzhYg9g9h5ScT1meWjy7R3+Wdy83
        OrTw7y9pReMbxVSToiDM+qcSGk6xK9APGRIfAic/EYH6Mv/VImXemsZGTa3lcKfw
        byt0qzSFRr8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 907919EAF6;
        Thu, 17 Aug 2017 02:37:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC0169EAF4;
        Thu, 17 Aug 2017 02:37:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH v2 2/2] File commited with CRLF should roundtrip diff and apply
References: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
        <20170817060633.28491-1-tboegi@web.de>
Date:   Wed, 16 Aug 2017 23:37:27 -0700
In-Reply-To: <20170817060633.28491-1-tboegi@web.de> (tboegi@web.de's message
        of "Thu, 17 Aug 2017 08:06:33 +0200")
Message-ID: <xmqqk222itso.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A3C4B3E-8316-11E7-BECD-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> Analyze the patch if there is a) any context line with CRLF,
> or b) if any line with CRLF is to be removed.
> Thanks to Junio C Hamano, his input became the base for the changes in t4124.
> One test case is split up into 3:
> - Detect the " a\r" line in the patch
> - Detect the "-a\r" line in the patch
> - Use LF in repo and CLRF in the worktree. (*)
>
> * This one proves that convert_to_git(&the_index,...) still needs to pass
> the &index, otherwise Git will crash.

I do not understand why you think it proves anything like that.
Forget about "in repo" when you think about "git apply" without
"--index/--cache".  There is *NO* role the index should play in that
mode.

"Otherwise Git will crash" is true, because convert_to_git() tries
to dereference the istate it is given to see if there is CR in the
blob that happens to be in the index at the path.

But step back and *think*.  It only proves that convert_to_git() you
have and/or the way read_old_data() you updated calls it after
applying these two patches are still broken.

The "blob that happens to be in the index at the path" does *NOT*
have anything to do with the file in the working tree that you are
patching.  Such an index entry may not exist (and the code would see
that there is 0 CRs and 0 LFs---so what?), or it may have a blob
full of CRLF, or it may have a blob full of CR not LF, or any random
thing that has NO relation to the file you are patching.  Why should
that random blob (which may not even exist---we are discussing "git
apply" without "--index/--cache" here) affect the outcome?  If it
does not affect the outcome, why should convert_to_git() even look
at it?

It shouldn't be calling down to "has_cr_in_index(istate, path)" that
is called from crlf_to_git() in the first place.  The check for CR
was done in the caller of convert_to_git(), i.e. read_old_data(),
long before convert_to_git() is called, and the caller knows if it
is (or it is not) dealing with data that needs crlf conversion at
that point, based on the contents of the file being patched (which,
again, does not have any relation to the blob that may or may not
happen to be in the index).  

Your updated caller is already telling convert_to_git() codepath
when it needs CRLF and it refrains from peeking in the index with
SAFE_CRLF_KEEP_CRLF flag.  The bug still in the code after applying
these two patches is that the other choice, i.e. SAFE_CRLF_FALSE,
that is passed from read_old_data() to convert_to_git() does *not*
prevent the latter from peeking into the in-core index.  

And that is why "Otherwise Git will crash".
