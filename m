Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D738180628
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711146694; cv=none; b=MMBU6WDv3NI415Q4C92ABALre9hqwqroKzl7/UozhnnNPmaA0X3kyl1LWrI8A5tmVZ2ADqEjAOqRcidLlNbOAzWwNSmWtLeE86fSpKJDmevDPl2y3zhHmsgeNKwcIU83UTcfZNE3Fr1iWom68AkkrzP9y4SLc/DFn8RL5W8KqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711146694; c=relaxed/simple;
	bh=IKzjFceGs0rbvBVpRqbQTh7Ge23ASRDcSyWVCoAB/2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVx7FqFKT67Rr0JMVfks7MH3yLzP0Rj3/nF4twv9M/PP7micCLZpfR0PU90tgsOoNKx5ly7DfjA8QBJpYZ6VdjozICzW97+pzPMEBLwcgSx4f4IBMlO6MPxrXIKwunIFB5Er/j6wpamo2S1jmKeiJlRJK1ugpW5D49K/1zEtZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NuDBl3C/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NuDBl3C/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB1E11F729F;
	Fri, 22 Mar 2024 18:31:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IKzjFceGs0rbvBVpRqbQTh7Ge23ASRDcSyWVCo
	AB/2Y=; b=NuDBl3C/LYxsbIWpJhSO0jCa2/CyDbCCzRu0AiofgnfK3ehhZsNhf5
	zV+daSru6nDXcGrQINzTF/NuNCG3pNGAAI/KgaRZEiSuDJGbyzc5+KLjOQoVd11n
	/Yi/B5MjrOda4UnJXSsK4KtXN5JXb6JX4jnOlWOYys38OpLRzG21s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D31571F729E;
	Fri, 22 Mar 2024 18:31:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41E441F729D;
	Fri, 22 Mar 2024 18:31:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: git@vger.kernel.org
Subject: Re: Allow git bisect to auto-skip
In-Reply-To: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl> (Olliver
	Schinagl's message of "Fri, 22 Mar 2024 23:18:47 +0100")
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
Date: Fri, 22 Mar 2024 15:31:29 -0700
Message-ID: <xmqqwmptzyny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EDD61958-E89B-11EE-95A3-25B3960A682E-77302942!pb-smtp2.pobox.com

Olliver Schinagl <oliver@schinagl.nl> writes:

> In some cases, we know a commit will always break bisect. This is bad
> and evil but sometimes needed.
> ...
> git commit -m 'copy old to new' -m 'GIT_SKIP_BISECT'
> ...

If "I want a bisect to skip any commit that has 'Skip Me' in its
subject" is the case, perhaps your "git bisect run" script can say

    #!/bin/sh

    case "$(git show -s --oneline)" in
    *"Skip Me"*) exit 125 ;;
    esac

    ... your test script body comes here ...
    if test successful
    then
        exit 0
    else
        exit 1
    fi

The _clue_ to mark a commit to be skipped does not have to be
hardcoded commit title.  It often is discovered that a commit
breaks bisection after the fact and it is not feasible to rebase
all the history after the commit.  Maybe an approach more suitable
in such a situation would attach a note to such untestable commits
after the fact, and check if such a note is attached at the
beginning of "git bisect run" script and exit with 125.

And a new "git bisect --skip-when <condition>" option can be added to
manual bisection process.  The <condition> part would contain
something like

    case "$(git show -s --oneline)" in
    *"Skip Me"*) exit 125 ;;
    esac

taken from the above illustration.

But I am not sure what end result you are trying to achieve, so the
above are random collection of ideas.  Turning them into a patch is
left as an exercise to readers.



