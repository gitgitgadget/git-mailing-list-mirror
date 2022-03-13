Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA3C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiCMTsv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 13 Mar 2022 15:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiCMTsu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:48:50 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E1B50455
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:47:42 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22DJlQD8034732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 13 Mar 2022 15:47:27 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <rsbecker@nexbridge.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Sean Allred'" <allred.sean@gmail.com>
Cc:     <git@vger.kernel.org>, <sallred@epic.com>, <grmason@epic.com>,
        <sconrad@epic.com>
References: <878rtebxk0.fsf@gmail.com> <Yi4oO+ifSK8OH0Mt@camp.crustytoothpaste.net> <020501d83703$2f8785f0$8e9691d0$@nexbridge.com>
In-Reply-To: <020501d83703$2f8785f0$8e9691d0$@nexbridge.com>
Subject: RE: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 15:47:22 -0400
Organization: Nexbridge Inc.
Message-ID: <020901d83713$2b446ac0$81cd4040$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDHpNtgb5IcYOGFILwDPZIseKDDCgLKGfUhAnsfUr2utLAuYA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 13, 2022 1:53 PM, I wrote:
>To: 'brian m. carlson' <sandals@crustytoothpaste.net>; 'Sean Allred'
><allred.sean@gmail.com>
>Cc: git@vger.kernel.org; sallred@epic.com; grmason@epic.com;
>sconrad@epic.com
>Subject: RE: Dealing with corporate email recycling
>
>On March 13, 2022 1:22 PM, brian m. carlson wrote:
>>On 2022-03-12 at 22:38:56, Sean Allred wrote:
>>> * Proposal: UUIDs
>>>
>>> To get what we want (i.e., the ability to run `git show HEAD~1`, know
>>> that Ada wrote it, and report her current contact information), we
>>> need some way of tracking identity over time.  A naive solution could
>>> be to extend the mailmap format as recognized by Git:
>>>
>>>     $ git cat-file blob HEAD~1:.mailmap
>>>     A. U. Thor <foo@example.com> [uuid A] <ada@example.com>
>>>
>>>     $ git cat-file blob HEAD:.mailmap
>>>     A. U. Thor <ada@example.com> [uuid A]
>>>     Roy G. Biv <foo@example.com> [uuid B] <roy@example.com>
>>>
>>> Now, when I run `git show HEAD~1`, Git would determine the UUID of
>>> the email on the commit using the mailmap version in that tree:
>>>
>>>     $ git -c mailmap.blob=HEAD~1:.mailmap check-mailmap --uuid
>>"<foo@example.com>"
>>>     A
>>>
>>> Then, we can use that UUID to resolve to the current contact information:
>>>
>>>     $ git check-mailmap --uuid=A
>>>     A. U. Thor <ada@example.com>
>>>
>>> Mailmap-sensitive commands can use this logic internally -- possibly
>>> guarded under some new config setting.
>>
>>It's my intention to implement an approach where people's emails are
>>identified by a key fingerprint of some sort and then converted into
>>the proper email address by a mailmap that lives outside of the main
>>history.  That is, my email address might be
>>ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad@ssh-
>>sha256.ns.git-scm.com,
>>and then we have a mailmap that converts between the two.  If you
>>wanted to have a UUID-based one, you could do 77c747a3-1599-4c8c-9569-
>>f729c17632e6@uuid.ns.git-scm.com (assuming that namespace were registered).
>>
>>The benefit to the key part is that you can essentially prove that you
>>are who you say you are.  A UUID doesn't have the possibility.
>>
>>This was discussed briefly at some sort of contributor summit we had at
>>some point, but I've been busy and haven't gotten to it yet.  It is on
>>my list of projects, however.
>
>This could require a global and security hardened tokenization or signing approach.
>Email fingerprints from one organization would have to be able to move to
>another organization easily - potentially as part of the git repo's metadata. I would
>not use the same key as is used for signing fingerprints (mostly out of paranoia),
>but this is conceptually similar to the public side of a key-pair. One would have to
>have access to the private key in order to be a committer/author. Unfortunately,
>as it stands today, that may be easily spoofed (--committer, --author), so that part
>of the code would have to change with safeguards on what can be supplied -
>something I think would be welcome. Keeping with a distributed philosophy is
>probably essential. Just my take on it.

What about abstracting this into a map-email or map-identity hook of some kind? So, whenever there is a need to write an identity (committer, author, signed-off-by, etc.). That way, anyone who wants to, can implement whatever policy they want for replacing emails with some other value in the repo, and back again. It might be good to optimize it so that the hook is only invoked once per identity per request so that git log does not become insanely expensive.

Something like map-identity from <internal-value>  and map-identity to <external-value>, for example:

map-identity from "Randall S. Becker <rsbecker@nexbridge.com>"      > A056AAB2123

And

map-identity to A056AAB2123      >  Randall S. Becker <rsbecker@nexbridge.com>

Again, just a notion.

