From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Wed, 23 Mar 2016 09:55:04 -0700
Message-ID: <xmqqlh59cexj.fsf@gitster.mtv.corp.google.com>
References: <CA+DCAeQQQH59Lb43Y4Bi1xktPNoODV11KkUBbKNG1OZ7mDb-UQ@mail.gmail.com>
	<CAGZ79kYmoKX1w5X8jE5_yGb3VKricHEwxAianTyt4VUd71qH-A@mail.gmail.com>
	<CACsJy8DCk5YintK3PoO1BWdNmsiSLpAcGL4pU7QgNEG6S41CsQ@mail.gmail.com>
	<xmqqbn65dxtl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Mehul Jain <mehul.jain2029@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:55:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aim3v-0001NR-AL
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 17:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbcCWQzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 12:55:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753421AbcCWQzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 12:55:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9877B4E716;
	Wed, 23 Mar 2016 12:55:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=500cpgxDmbxwXxRAmevgfvCGGdI=; b=F2gSra
	lJ27YTQBjSVZUXHXytAmlnP8XmT5t4P2Kk69JAAd1Svhqjcka6vZyvi/iks4yH5l
	MDzPgfAngIHGau7X8cnMIMxR9Hy9tnIqmo53M0W61lK+z0LJTjgNg/5oylFLpmc/
	JXwMVSpuVUjqzr9QgNK2cPULmn+dGXxBoZ7xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HqdUdkacWEtzM3+Sx0h3chpXBvcO6n+2
	NgxcgMmooKx6E61v8JbCw2VMH9ykwsG1SET3tAPOogv5bW51JSZ7E3x8FtFg5C6R
	j0dovv/utE+8Jpv9sHM3sFDYlE0GMbzy+LnDej9CbubL1Z0aIUHk9LXSyhFyInOj
	xQQX1OlS7CA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F9204E715;
	Wed, 23 Mar 2016 12:55:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E4ACB4E714;
	Wed, 23 Mar 2016 12:55:05 -0400 (EDT)
In-Reply-To: <xmqqbn65dxtl.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 23 Mar 2016 08:21:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE68EF86-F117-11E5-951D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289668>

Junio C Hamano <gitster@pobox.com> writes:

> See
>
>   http://thread.gmane.org/gmane.comp.version-control.git/288316/focus=288321
>
> I agree it is bad that it silently ignores the path outside the
> directory.  When run with --verbose, we should say "Skipped X that
> is outside the directory." or something like that, just like we
> issue notices when we applied with offset, etc.

Another thing we may want to do is to loosen (or redo) the logic
in builtin/apply.c::use_patch()

        static int use_patch(struct patch *p)
        {
                const char *pathname = p->new_name ? p->new_name : p->old_name;
                int i;

                /* Paths outside are not touched regardless of "--include" */
                if (0 < prefix_length) {
                        int pathlen = strlen(pathname);
                        if (pathlen <= prefix_length ||
                            memcmp(prefix, pathname, prefix_length))
                                return 0;
                }

The include/exclude mechanism does use wildmatch() but does not use
the pathspec mechanism (it predates the pathspec machinery that was
made reusable in places like this).  We should be able to

    $ cd d/e/e/p/d/i/r
    $ git apply --include=:/ ../../../../../../../patch

to lift this limitation.  IOW, we can think of the use_patch() to
include only the paths in the subdirectory we are in by default, but
we can make it allow --include/--exclude command line option to
override that default.

That way, the plain-vanilla use would still retain the "when working
in subdirectory, we only touch that subdirectory" behaviour, which
existing scripts may depend on, but users can loosen the default as
necessary.
