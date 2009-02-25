From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
 root  directory?
Date: Wed, 25 Feb 2009 00:36:10 -0800
Message-ID: <7vab8aap6t.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
 <slrngq7e6c.iti.sitaramc@sitaramc.homelinux.net>
 <7vzlgbhh95.fsf@gitster.siamese.dyndns.org>
 <slrngq9es5.ik0.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 09:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFH4-0001H5-9M
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758260AbZBYIgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757543AbZBYIgV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:36:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbZBYIgU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:36:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 48A539D3FA;
	Wed, 25 Feb 2009 03:36:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9488B9D3F9; Wed,
 25 Feb 2009 03:36:12 -0500 (EST)
In-Reply-To: <slrngq9es5.ik0.sitaramc@sitaramc.homelinux.net> (Sitaram
 Chamarty's message of "Wed, 25 Feb 2009 03:31:17 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5DEE87BE-0317-11DE-A6A8-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111414>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Please tell me what you think.  If you like it, I'll send in
> this patch.  If you prefer the previous one, I'll send that
> in.
> ...
> The files containing the patterns have the following format:
>
>  - A blank line matches no files, so it can serve as a
>    separator for readability.
>
>  - A line starting with # serves as a comment.
>
> This is _how_ the patterns match:
>
>  - The wildcards (`*` and `?`) do not match slashes, but
>    otherwise the patterns are normal shell globs as defined
>    by fnmatch(3) with the FNM_PATHNAME flag set.

I had to read this twice and run "man 3 fnmatch" to clear my head.

 - In normal shell globs, wildcards '*' and '?' do not match slashes;

 - fnmatch(3) with FNM_PATHNAME implements the normal shell globs;

 - wildcards do not match slashes in gitignore either.

Given these three, I am very confused why you say "but otherwise".  I
would understand it if it were:

    The patterns are treated as normal shell globs defined by fnmatch(3) with
    FNM_PATHNAME; in other words, the wildcards (`*` and `?`) do not match
    slashes.

>  - An optional prefix '!' negates the pattern; any matching
>    file excluded by a previous pattern will become included
>    again.  If a negated pattern matches, this will override
>    lower precedence patterns sources.

'!' is not part of _how_ the patterns match.  It is _what happens_ when a
pattern marked as such matches (meaning, the syntax for a line in
gitignore file is "an optional '!' followed by a pattern").

    An optional prefix '!' is not a part of the pattern and it does not
    affect the match.  When a path matches such a pattern, instead of
    being ignored, it is unignored.

It would be good to clarify that '!' is not part of the pattern, as I'd
like to take J6t's patch that says gitattributes uses the same pattern as
gitignore uses.

> This is _what_ the patterns match:
>
>  - If the pattern ends with a slash, it matches only
>    directories (and their contents), otherwise it matches
>    regular files and symlinks also.

Do we want "(and their contents)" here?  Once a directory is ignored like
this, none of its contents, including .gitignore file in it, is examined
because we do not even descend into it.

> This is _where_ the patterns match (a trailing slash is
> ignored for these rules):
>
>  - If there is a slash at the start or within the pattern,
>    it matches paths relative to the .gitignore file in which
>    the pattern is found, or to the root of the working tree
>    if the pattern is from one of the other pattern sources
>    (i.e., `.git/info/exclude`, `core.excludesfile`)

"at the start or within but not at the end of the pattern"?

>  - Otherwise, it matches a path at any depth in the tree
