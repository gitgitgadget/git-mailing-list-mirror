From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC][GSoC] diff-no-index: transform "$directory $file" args to "$directory/$file $file"
Date: Sat, 21 Mar 2015 11:18:25 -0700
Message-ID: <xmqqsicyciz2.fsf@gitster.dls.corp.google.com>
References: <CAHLaBN+x3SVL9+jDzeSEMapVd2BVrwQuVx_7ENspjbUPrium_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 19:18:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZNyi-00068a-O5
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 19:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbbCUSS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 14:18:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751470AbbCUSS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 14:18:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B31E53EFC3;
	Sat, 21 Mar 2015 14:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E0Qb7ByimTKlvbzOZ7Mqc3xw14E=; b=cztp6U
	7r2NBjF5UPt5s0BddM7inJIkfHdBniwuvlMpfo0kzzpvonvURcx8ysxKjLrw8e1g
	uU9aDErrWXjDo/JEFHPgwsiHBYyLUrA0vY8FijM0HgfvHgNUktZuVTXiRM4ez0CZ
	7R6Ql44+zmzGG5lXL1SJFDa8W6zIyIjO+YgSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZMRUb+MWFTCaVbtl9oStBLZuP/qSiqxH
	f+Kbhjvj2FbaiSyEtveZA5M9eSvdaXveOPtxQedcDX0xayBL7jLhn3Bb5yGhoJcZ
	LUK6i3ECDGratXyz8iTVOHojElj7JsLsXCN2jF52Kj6kNMlusOf1g8BPqLFR1ucs
	wydy1uMXZ8c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACFC53EFC2;
	Sat, 21 Mar 2015 14:18:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 355943EFC1;
	Sat, 21 Mar 2015 14:18:26 -0400 (EDT)
In-Reply-To: <CAHLaBN+x3SVL9+jDzeSEMapVd2BVrwQuVx_7ENspjbUPrium_A@mail.gmail.com>
	(Yurii Shevtsov's message of "Sat, 21 Mar 2015 14:50:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AACAEF34-CFF6-11E4-BEEC-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266030>

Yurii Shevtsov <ungetch@gmail.com> writes:

> diff --git a/diff-no-index.c b/diff-no-index.c
> index 265709b..9a3439a 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -97,8 +97,39 @@ static int queue_diff(struct diff_options *o,
>      if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>          return -1;
>
> -    if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> -        return error("file/directory conflict: %s, %s", name1, name2);
> +    if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
> +        struct strbuf path;
> +        const char *dir, *file;
> +        char *filename, *dirname = 0;
> +        int i, ret = 0;

If you have two directories, a and b, under which there are two
files a/sub/file and b/sub (i.e. 'sub' in a/ is a directory and b/
is a file), and if you say "git diff --no-index a b", what happens?

 - the caller of this function gives a and b in name1 and name2;

 - we do not come in this codepath as both are directories;

 - we read from a/ and b/ and fill p1 and p2 with names of paths in
   the directories -- p1 and p2 will both have 'sub';

 - queue_diff() is recursively called to compare a/sub and b/sub;

   - now we have name1 = a/sub and name2 = b/sub;

   - we come in this codepath, and they are turned into comparison
     between a/sub/sub and b/sub.

The last step is simply crazy.

Hmmmm, is vger reinjecting an old message, or you sent an older and
wrong version of a patch by mistake?  We discussed why doing this in
queue_diff() is wrong in the thread that has $gmane/265543 in it,
and I was expecting to see a logic like this in the caller.

Puzzled...
