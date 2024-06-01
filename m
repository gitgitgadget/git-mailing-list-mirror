Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDA1E520
	for <git@vger.kernel.org>; Sat,  1 Jun 2024 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717257228; cv=none; b=QoERRmPP1qPbOPJiLpGn35orVZyIxLSdsLdYJYhA/mSgy0HRLAfgLaTxG1nzbBAEOCJ7ugvMcXS9sScG65s3HIlw52wEbHe3vGLfdLri/ajSNNV5FO4HkEX20euR/WqKvsu5bi0JmDm5N/4q8HVv/yn+5iV8wpMiad4MoPD65wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717257228; c=relaxed/simple;
	bh=nPjChijFv+nIZejSUpgjRyiqOta7WlND53vbvoKBHDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MpAQSJUfLzF93r7z9s/qNYcARSdEv2w+ERxRIhF+qtT++WNFTgli/9a2WvlfsBodXJKun1yjO0k41gCBjZkr+MxsLnZoOEeNW3KRhTYbNwVt1ByN0fmcGv2cBwc92APkMtRiFYQ0CQcVlnnH/Id1E4bThU0xDcFmg1XmZ9pReC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mb8BZgTN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mb8BZgTN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98C1A23815;
	Sat,  1 Jun 2024 11:53:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nPjChijFv+nIZejSUpgjRyiqOta7WlND53vbvo
	KBHDU=; b=Mb8BZgTNRgrGEla5cDunHJKqlWK7/YYJQv/6KgTvfK1ZO4nYbc1dGx
	w6hHNQObvFrFN+XdfIutPFRiAh63piwi22nwEpNnYB2e0skj+H+n7BTd/NqYss0Q
	DSaz9e0KlI3fc46ZtgIYGeQtUL+K4CfM2n4OJbO7Ww4/GDrnk0/ik=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9112823814;
	Sat,  1 Jun 2024 11:53:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 081D723813;
	Sat,  1 Jun 2024 11:53:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Curley Joe'" <m48cv7wg9w@liamekaens.com>,  <git@vger.kernel.org>
Subject: Re: git fetch --prune fails with "fatal: bad object"
In-Reply-To: <000501dab3b3$51779400$f466bc00$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 31 May 2024 19:36:04
	-0400")
References: <16919-1717194882-875013@sneakemail.com>
	<xmqqplt1d0k0.fsf@gitster.g>
	<000501dab3b3$51779400$f466bc00$@nexbridge.com>
Date: Sat, 01 Jun 2024 08:53:43 -0700
Message-ID: <xmqqo78kbqwo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 205FF950-202F-11EF-BD12-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

<rsbecker@nexbridge.com> writes:

>> - Why did the repository got into this state in the first place?
>>   It seems that it would be much better solution to prevent refs
>>   from having garbage values in them or to prevent objects that are
>>   necessary from going away than any "prune invalid refs" feature.
>
> I agree. However, there are some configurations where disk write
> caches are enabled and require a sync or some other flush
> operation to force a complete write to disk. In such situations,
> corruptions are always possible despite the best efforts by the
> application.

The question was posed to see where the current "best efforts" are
still inadequate.

>> - "fetch" still feels a wrong place to have the feature, if it is
>>   about fixing a local repository corruption.  You should be able
>>   to recover from such a broken ref even if you are only working
>>   locally without fetching from anybody.
>
> I think fsck would be a better place for this.
>
>>If you can somehow _enumerate_ such broken refs, you could drive update-ref to
>>remove them.

Interesting.  "git fsck" certainly can be used to help you find out
about them.  In a throw-away repository, after manually crafting
some "broken refs" (because update-ref will refuse to create a ref
pointing at a missing object):

    $ git for-each-ref
    9e830ad6c4f43159cef50cb1c2205f513c79bc8b commit refs/heads/master
    $ echo 9e830ad6c4f43159cef50cb1c2205f513c79bc8a >.git/refs/heads/broken-missing
    $ git rev-parse master: >.git/refs/heads/broken-tree
    $ git rev-parse "master:foo /baz" >.git/refs/heads/broken-blob

running "git fsck" does tell you about them, ...

    $ git fsck
    Checking object directories: 100% (256/256), done.
    error: refs/heads/broken-blob: not a commit
    error: refs/heads/broken-missing: invalid sha1 pointer 9e830ad6c4f43159cef50cb1c2205f513c79bc8a
    error: refs/heads/broken-tree: not a commit

... and using the information, you can

    $ for r in refs/heads/broken-{blob,missing,tree}
      do git update-ref -d "$r"
      done

to unbreak the repository.
