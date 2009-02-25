From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
 root  directory?
Date: Wed, 25 Feb 2009 03:31:17 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngq9es5.ik0.sitaramc@sitaramc.homelinux.net>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
 <slrngq7e6c.iti.sitaramc@sitaramc.homelinux.net>
 <7vzlgbhh95.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 04:32:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcAW0-0004Br-UP
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 04:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbZBYDba convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 22:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbZBYDba
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 22:31:30 -0500
Received: from main.gmane.org ([80.91.229.2]:33583 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910AbZBYDb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 22:31:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LcAUZ-00069T-2w
	for git@vger.kernel.org; Wed, 25 Feb 2009 03:31:27 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 03:31:27 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 03:31:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111368>

On 2009-02-24, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:

>> A few days ago, 'doener' (Bj=C3=B6rn Steinbrink) came up with
>> some much simpler rules that said the same thing, and --
>> building on the insight that his rules gave me -- I came up
>> with these:
>>
>> ----->8-----
>>
>> Note that rule 1 merely *modifies* rules 2 and 3, it does not
>> supercede or preclude them.
>>
>> 1.  If you pattern ends with a slash, it matches only
>>     directories (and their contents)
>> 2.  If there is no slash otherwise, it matches that name, at
>>     any depth in the tree
>> 3.  If there is a slash anywhere else, it matches that name,
>>     relative to the .gitignore (or $GIT_WORK_TREE if the
>>     pattern is from one of the other pattern sources like
>>     `.git/info/exclude` etc)
>>
>> The wildcards (`*` and `?`) do not match slashes, but otherwise
>> the patterns are normal shell globs as defined by fnmatch(3) with
>> the FNM_PATHNAME flag set.
>>
>> ----->8-----
>
> Nicely written, except that as a non-native speaker I fear "otherwise=
" and
> "anywhere else" _might_ leave ambiguity for a pattern that has slash =
only
> at the end [*1*], but I dunno.  It certainly is much better than what=
 I
> wrote in the current documentation.
>
> Please send it in a patch form (possibly addressing my ambiguity conc=
ern
> if it is real for other people) with a one-liner log message that say=
s
> "The existing documentation is unreadable even though it may be preci=
se",
> and I'll apply.

I couldn't think of an easy way to clear that up without
making it far more verbose.

The ambiguity is partly because we're overloading the slash
to control both "what matches" (only a directory, versus
directory / file / symlink) and "where it matches" (anchored
at the directory in which the current .gitignore is found or
work tree, versus at any depth underneath).

So I came up with this (see below).  It keeps the "what" and
the "where" clearly separate, so now the "otherwise" applies
to only one preceding clause, and there is no "anywhere
else".

It's a somewhat larger change, replacing all 6 bullets and
the line preceding them.  I think it looks nicer but since I
wrote it, I can't vote ;-)

Please tell me what you think.  If you like it, I'll send in
this patch.  If you prefer the previous one, I'll send that
in.

[I've also changed $GIT_WORK_TREE in my previous attempt to
'root of the working tree' because that variable is not
normally set, and I don't want to imply that it does]

----->8-----

The files containing the patterns have the following format:

 - A blank line matches no files, so it can serve as a
   separator for readability.

 - A line starting with # serves as a comment.

This is _how_ the patterns match:

 - The wildcards (`*` and `?`) do not match slashes, but
   otherwise the patterns are normal shell globs as defined
   by fnmatch(3) with the FNM_PATHNAME flag set.

 - An optional prefix '!' negates the pattern; any matching
   file excluded by a previous pattern will become included
   again.  If a negated pattern matches, this will override
   lower precedence patterns sources.

This is _what_ the patterns match:

 - If the pattern ends with a slash, it matches only
   directories (and their contents), otherwise it matches
   regular files and symlinks also.

This is _where_ the patterns match (a trailing slash is
ignored for these rules):

 - If there is a slash at the start or within the pattern,
   it matches paths relative to the .gitignore file in which
   the pattern is found, or to the root of the working tree
   if the pattern is from one of the other pattern sources
   (i.e., `.git/info/exclude`, `core.excludesfile`)

 - Otherwise, it matches a path at any depth in the tree

----->8-----

Regards,

Sitaram
