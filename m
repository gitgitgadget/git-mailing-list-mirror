From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/6] worktree.c: retrieve lock status (and optionally reason) in get_worktrees()
Date: Wed, 01 Jun 2016 08:23:52 -0700
Message-ID: <xmqq4m9d0w6v.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-5-pclouds@gmail.com>
	<xmqq8tyq5czn.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CjeqwKWbV==wSuwH3eVghSEMFv01tTd9dCE5m14RQo1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Reto =?utf-8?Q?Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 17:24:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8801-0007Zr-2R
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 17:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683AbcFAPX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 11:23:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752901AbcFAPXz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 11:23:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 38AE921ED5;
	Wed,  1 Jun 2016 11:23:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T8zbV46Rmbqb
	e9YN90WJvzH7H7Q=; b=CxkT+MiiwBu39/dH9aVUru3Sg66vyEkw1/7QUls/YEfC
	GZIXkiphb0FTBwPmZktBdSXbjT1z4MSwml32qbhJsRNkayZzQsinCxw2mt7+BrkF
	tgTHeeUIGJ5ykDj2yApOpFSKBuy9XraYCQdJ2he6rotWbZaQ25JkX6wj4+zW6ug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BWEYtJ
	Yrg2oDiKV9uEAwsujRhUrUii8YECm3hn1UKk6wXTFSZ55HuPMFfi5zEj355BtDP1
	CKWx7nddSd7LwIJGU8VhXyv5DSNsUZYNyF67AG7OFxsLk0WCzTDKqsZgaEFabdO7
	xfengilyylvG8FsQ/PegYk2j+hpfN/xG5kkiM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E9D121ED3;
	Wed,  1 Jun 2016 11:23:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96E5421ED2;
	Wed,  1 Jun 2016 11:23:53 -0400 (EDT)
In-Reply-To: <CACsJy8CjeqwKWbV==wSuwH3eVghSEMFv01tTd9dCE5m14RQo1w@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 1 Jun 2016 20:02:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D99C0194-280C-11E6-8415-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296089>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jun 1, 2016 at 12:55 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> We need this later to avoid double locking a worktree, or unlocking=
 one
>>> when it's not even locked.
>>
>> Shouldn't this be done lazily?
>>
>> If a user is working in worktree B and is not doing anything funky,
>> she would not care why worktree A and C are locked, even though she
>> might care the fact that they are locked.
>
> You and Eric will have to settle this. It was done lazily in v2, but
> Eric convinced me this lock thing will be needed for many worktree
> commands (list, lock, unlock, move, remove and maybe even prune) that
> it makes more sense to make it a field in struct worktree instead. Fo=
r
> a dozen worktrees, it does not really matter. But get_worktrees() is
> also being used outside "git worktree" command, some of those new
> callers may get picky. Maybe a common ground is adding a flag to
> get_worktrees() to select what fields to be filled?

NO.

When you tell callers that they have DIRECT access to fields, then
they need to keep track of what flag they (or their callers) passed
when get_worktrees() was called, which is a road to insanity.

By "lazily", I didn't mean "do not have a field there; instead every
time read from the file and return the value".  A lazy interface would
give a function to read the "is it locked and if so why" information
as the sole interface, whose implementation would _not_ do the reading
when a worktree structure is instantiated, the first call would do
the reading, and it is up to the implementation to cache the result
of that first call's work in the structure and answer the subsequent
calls from the cache, or do the same reading for subsequent calls.
