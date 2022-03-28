Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331DFC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 06:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiC1GNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 02:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiC1GNe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 02:13:34 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008E4515A2
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 23:11:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E31418B880;
        Mon, 28 Mar 2022 02:11:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x5xQApJdYXUJOUs6c69h+PcvwhyHP2cR888QmV
        Hj9Y8=; b=gv8qP71kcfafJDPg2kzATIyg0zp47aMk7d3n/RW6N0EEt0rlfFfbKb
        jsiS7z1OF4T0s7wpEATxYHDtdW5W8+GUEg7qBBqODG9BcBmRRzKETOx3LltyzVVk
        J5fE2sXU0GO/2tJmpoBJb78Sb8vIlHZOZ1Y79+hqh29n9vMofRRms=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BFC118B87F;
        Mon, 28 Mar 2022 02:11:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D55D418B87D;
        Mon, 28 Mar 2022 02:11:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     PMEase <robin@pmease.com>
Cc:     git@vger.kernel.org
Subject: Re: How to get the original raw commit message without removing
 extra leading/trailing line breaks
References: <1BEBB3E1-0089-44CD-8D3B-3AA424C90E48@pmease.com>
        <xmqq5yny62s1.fsf@gitster.g>
        <5DAF0ABA-7905-491B-A1DC-291A2D7C2BB4@pmease.com>
Date:   Sun, 27 Mar 2022 23:11:50 -0700
In-Reply-To: <5DAF0ABA-7905-491B-A1DC-291A2D7C2BB4@pmease.com> (PMEase's
        message of "Mon, 28 Mar 2022 14:01:06 +0800")
Message-ID: <xmqqy20u4ndl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5B18F42-AE5D-11EC-A70B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PMEase <robin@pmease.com> writes:

>> On Mar 28, 2022, at 1:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> PMEase <robin@pmease.com> writes:
>> 
>> [jc: wrapped overly long lines]
>> 
>>> I am using command "git show --format=raw <commit hash>" to get
>>> raw commit object in order to verify the GPG signature in my
>>> program to customize public key loading. However in the raw commit
>>> object, extra line breaks before and after the commit message is
>>> removed, which cause the signature verification failure as git
>>> generates the signature without removing those line breaks.
>> 
>> "git show --format=raw <commit object name>" will not give "raw
>> commit object" to begin with.  It indents the message by four
>> spaces.
>> 
>> "git cat-file commit <commit object name>" is what you want, I
>> think.

[jc: wrapped overly long lines, moved response at the end to correct
top-posting]

> Thanks for your response. "git cat-file" prints the commit message
> without leading space on each line, however extra leading/trailing
> line breaks of the commit message is still removed.

I think you are creating your commit incorrectly.  If a line is
missing in what cat-file prints, then the line is *NOT* in the
commit.  If I try the following:

----- >8 --------- >8 --------- >8 --------- >8 -----

C=$(
        cat <<\EOF | git commit-tree -p HEAD HEAD^{tree}

This "first line" deliberately is on the second line.
And after the "last line" of the log message, this commit
has extra blank lines at the end.


EOF
)

echo "begin"; git cat-file commit "$C"; echo "end"

----- 8< --------- 8< --------- 8< --------- 8< -----

I get:

begin
tree 5365fd773adaac0f84c4f07532eec8809f3f6f0e
parent abf474a5dd901f28013c52155411a48fd4c09922
author Junio C Hamano <gitster@pobox.com> 1648447791 -0700
committer Junio C Hamano <gitster@pobox.com> 1648447791 -0700


This "first line" deliberately is on the second line.
And after the "last line" of the log message, this commit
has extra blank lines at the end.


end

which is very much what I expect to see.
