From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Correctly handle transient files in shared repositories
Date: Mon, 11 Jan 2016 13:22:07 -0800
Message-ID: <xmqq60yzx14w.fsf@gitster.mtv.corp.google.com>
References: <cover.1452085713.git.johannes.schindelin@gmx.de>
	<cover.1452537321.git.johannes.schindelin@gmx.de>
	<xmqqa8obx1ll.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:22:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIjuo-0001b6-VM
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933099AbcAKVWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:22:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750981AbcAKVWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:22:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF7913A08C;
	Mon, 11 Jan 2016 16:22:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d6gbV3bJrvMRSZUYswuzVfHBBmk=; b=Id40vr
	Nx3w2KVSWCIMhkXGNfgxt+6msqpJf16+3SnaknZg6UR3ih38p+irNT10q/JuYzc9
	o+4NDXwzneKAtn7TyFepDryxzY3uwljiD5N3CcJVfYJMgRevzk5IcSgjJk9xQW5j
	odWG0WvHlIHTz0VICI7G8LnzwafwzsYNirozI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZLvaVceoIc7VxKuipvaOWMyKQ4EQLSqi
	yBq+IQO10fOccDiAV2JxendgN40hO7vv3RsSj1F/5Fh9pqcaVqA/DNDbL7KmMkAe
	qnvGEiFaun9j8Nf2DuWMotfnaWBZ94PgLzm92W2tP/2KfgE9k3si97hCdFIsj4aQ
	TWJSW4h9E4A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E62023A08B;
	Mon, 11 Jan 2016 16:22:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4BD6E3A08A;
	Mon, 11 Jan 2016 16:22:08 -0500 (EST)
In-Reply-To: <xmqqa8obx1ll.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 11 Jan 2016 13:12:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5EBEE41E-B8A9-11E5-8C26-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283721>

Junio C Hamano <gitster@pobox.com> writes:

>> The only change relative to v2 is that the second commit message
>> clarifies why apply, fsck and fast-import are left unchanged.
>
> I do not think it clarifies to make "fsck" whose lost and found are
> written to GIT_DIR and "apply"'s ".rej" share the same "we dunno"
> reasoning, though.

I'd say we should go with this one.  I think the reasoning for
"fsck" should be a lot clearer this way.

-- >8 --
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Mon Jan 11 19:35:54 2016 +0100

    Handle more file writes correctly in shared repos
    
    In shared repositories, we have to be careful when writing files whose
    permissions do not allow users other than the owner to write them.
    
    In particular, we force the marks file of fast-export and the FETCH_HEAD
    when fetching to be rewritten from scratch.
    
    This commit does not touch other calls to fopen() that want to
    write files:
    
     - commands that write to working tree files (core.sharedRepository
       does not affect permission bits of working tree files),
       e.g. .rej file created by "apply --reject", result of applying a
       previous conflict resolution by "rerere", "git merge-file".
    
     - git am, when splitting mails (git-am correctly cleans up its directory
       after finishing, so there is no need to share those files between users)
    
     - git fsck, when writing lost&found blobs (they are written in the
       file under its object name, so an existing file with tighter
       permission that you cannot write into is OK, because what you are
       failing to write is the same contents that the file already has
       anyway).
    
     - git submodule clone, when writing the .git file, because the file
       will not be overwritten
    
     - git_terminal_prompt() in compat/terminal.c, because it is not writing to
       a file at all
    
     - git diff --output, because the output file is clearly not intended to be
       shared between the users of the current repository
    
     - git fast-import, when writing a crash report, because the reports' file
       names are unique due to an embedded process ID
    
     - mailinfo() in mailinfo.c, because the output is clearly not intended to
       be shared between the users of the current repository
    
     - check_or_regenerate_marks() in remote-testsvn.c, because this is only
       used for Git's internal testing
    
    Note that this patch does not touch callers of write_file() and
    write_file_gently(), which would benefit from the same scrutiny as
    to usage in shared repositories.  Most notable users are branch,
    daemon, submodule & worktree, and a worrisome call in transport.c
    when updating one ref (which ignores the shared flag).
    
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
