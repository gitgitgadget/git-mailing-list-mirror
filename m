Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B9CC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 20:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJMUe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 16:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJMUew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 16:34:52 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDECEE22
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 13:34:45 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oj4ug-0002QH-Fd;
        Thu, 13 Oct 2022 21:34:43 +0100
Message-ID: <aead3926-d87b-5fcd-4984-bb690f3fbf4e@iee.email>
Date:   Thu, 13 Oct 2022 21:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: About git reporting missing newline for symlinks
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
 <xmqq7d14k9uh.fsf@gitster.g> <221013.86o7uflvcv.gmgdl@evledraar.gmail.com>
 <xmqq35briuel.fsf@gitster.g> <221013.86k053lkvu.gmgdl@evledraar.gmail.com>
 <xmqqtu47fti9.fsf@gitster.g> <221013.8635brldj4.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <221013.8635brldj4.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 13/10/2022 20:33, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Oct 13 2022, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>>>> 	\ The filename pointed to by the symlink does not end in a newline
>>>> While I do not think it would break anybody, I doubt it would give
>>>> us much value.  One line above that output is a line that any user,
>>>> who is vaguely familiar with the contents being compared, can
>>>> recognize as giving a pathname, the contents of the symbolic link.
>>> Clearly it confused the initial reporter upthread :)
>> But to such a user, I highly suspect that the rephased message above
>> still looks like a warning, and will result in the same reaction.
>>
>> IOW, you want to explain why "does not end in a newline" is worth
>> expressing in the output.  Saying "does not end in a newline" alone
>> would tell the user what they already know (i.e. the symlink stores
>> the target filename without an extra LF at the end).
> Yes, but isn't the point of the report/confusion that we're inserting
> what looks like the warning you get when you forget a \n at the end of a
> source file, so a user might wonder why they're seeing it at all.
>
> Whereas what we're *really* doing there is not really about that at all,
> but just inserting a bit of magic so that the diff format & its
> consumers grok that this line we're inserting there isn't supposed to
> have a \n, as we're working with a filename.
>
> Maybe e.g.:
> 	
> 	diff --git a/RelNotes b/RelNotes
> 	index d505db645be..758368388a4 120000
> 	--- a/RelNotes
> 	+++ b/RelNotes
> 	@@ -1 +1 @@
> 	-Documentation/RelNotes/2.38.0.txt
> 	\ No newline at end of file
> 	+Documentation/RelNotes/2.39.0.txt
> 	\ No newline at end of file
>
> Would, for those users, be less confusing as:
>
> 	diff --git a/RelNotes b/RelNotes
> 	index d505db645be..758368388a4 120000
> 	--- a/RelNotes
> 	+++ b/RelNotes
> 	@@ -1 +1 @@
> 	-Documentation/RelNotes/2.38.0.txt
> 	\ The symlink above has no trailing NL in its filename
> 	+Documentation/RelNotes/2.39.0.txt
> 	\ The symlink above has no trailing NL in its filename
>
> *dunno* :)
> 	
Pondering on why it is thought of as a warning to be treated as an
error, maybe the message implies something is missing via the negative
"No" assertion, rather than simply being informative [1].

Perhaps swapping out the "No" and instead using something like "\
Without a newline at end of file" would better convey that it's just
information about the file's format, and in no way a real problem. Just
a thought.
--
Philip
[1] My comment in Git Users discussion:
https://groups.google.com/d/msgid/git-users/c4f53bb2-cff6-4a76-8fa7-cd34ca88ce63n%40googlegroups.com
<https://groups.google.com/d/msgid/git-users/c4f53bb2-cff6-4a76-8fa7-cd34ca88ce63n%40googlegroups.com?utm_medium=email&utm_source=footer>

