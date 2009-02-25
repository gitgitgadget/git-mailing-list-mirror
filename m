From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
 root  directory?
Date: Wed, 25 Feb 2009 11:17:11 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngqaa5n.mp1.sitaramc@sitaramc.homelinux.net>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
 <slrngq7e6c.iti.sitaramc@sitaramc.homelinux.net>
 <7vzlgbhh95.fsf@gitster.siamese.dyndns.org>
 <slrngq9es5.ik0.sitaramc@sitaramc.homelinux.net>
 <7vab8aap6t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 12:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcHmt-0005MI-RK
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 12:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760958AbZBYLRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 06:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760846AbZBYLRY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 06:17:24 -0500
Received: from main.gmane.org ([80.91.229.2]:33182 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760766AbZBYLRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 06:17:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LcHlQ-0006wP-73
	for git@vger.kernel.org; Wed, 25 Feb 2009 11:17:20 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 11:17:20 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 11:17:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111447>

On 2009-02-25, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:

>> This is _how_ the patterns match:
>>
>>  - The wildcards (`*` and `?`) do not match slashes, but
>>    otherwise the patterns are normal shell globs as defined
>>    by fnmatch(3) with the FNM_PATHNAME flag set.
>
> I had to read this twice and run "man 3 fnmatch" to clear my head.
>
>  - In normal shell globs, wildcards '*' and '?' do not match slashes;
>
>  - fnmatch(3) with FNM_PATHNAME implements the normal shell globs;
>
>  - wildcards do not match slashes in gitignore either.
>
> Given these three, I am very confused why you say "but otherwise".  I
> would understand it if it were:
>
>     The patterns are treated as normal shell globs defined by fnmatch(3) with
>     FNM_PATHNAME; in other words, the wildcards (`*` and `?`) do not match
>     slashes.

I'll use that.

This confusing statement existed in the previous (shorter)
version also.  My fault; I use [[ path == patt ]] far more
often than plain globs so I had a thinko.  (Perversely, that
one does *not* use FNM_PATHNAME... go figure!)

>>  - An optional prefix '!' negates the pattern; any matching
>>    file excluded by a previous pattern will become included
>>    again.  If a negated pattern matches, this will override
>>    lower precedence patterns sources.
>
> '!' is not part of _how_ the patterns match.  It is _what happens_ when a
> pattern marked as such matches (meaning, the syntax for a line in
> gitignore file is "an optional '!' followed by a pattern").
>
>     An optional prefix '!' is not a part of the pattern and it does not
>     affect the match.  When a path matches such a pattern, instead of
>     being ignored, it is unignored.

I can use this.  Can we keep it in the same section, despite
being technically not a '_how_'?  It fits the other sections
even less, and the sectioning is the main thing in all this.

> It would be good to clarify that '!' is not part of the pattern, as I'd
> like to take J6t's patch that says gitattributes uses the same pattern as
> gitignore uses.
>
>> This is _what_ the patterns match:
>>
>>  - If the pattern ends with a slash, it matches only
>>    directories (and their contents), otherwise it matches
>>    regular files and symlinks also.
>
> Do we want "(and their contents)" here?  Once a directory is ignored like
> this, none of its contents, including .gitignore file in it, is examined
> because we do not even descend into it.

Do we not want to specify that we don't descend?  The
original text does say '...will match a directory foo and
paths underneath it'.

>> This is _where_ the patterns match (a trailing slash is
>> ignored for these rules):
>>
>>  - If there is a slash at the start or within the pattern,
>>    it matches paths relative to the .gitignore file in which
>>    the pattern is found, or to the root of the working tree
>>    if the pattern is from one of the other pattern sources
>>    (i.e., `.git/info/exclude`, `core.excludesfile`)
>
> "at the start or within but not at the end of the pattern"?

Isn't that confusing?  'if there is a slash ... not at the
end of the pattern' can easily sound like "there *should
not* be a trailing slash", which is quite different from "we
don't care if there *is* a trailing slash; it's the *other*
slashes that matter here".

And it'll _seem to_ contradict what we say, just above, that
a trailing slash is ignored for these rules.

>
>>  - Otherwise, it matches a path at any depth in the tree
