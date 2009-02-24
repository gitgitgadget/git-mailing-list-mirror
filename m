From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
 root  directory?
Date: Tue, 24 Feb 2009 09:07:24 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngq7e6c.iti.sitaramc@sitaramc.homelinux.net>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbtHp-0005EO-MW
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbZBXJHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 04:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbZBXJHm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:07:42 -0500
Received: from main.gmane.org ([80.91.229.2]:53550 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbZBXJHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:07:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LbtGJ-0000Wu-Lt
	for git@vger.kernel.org; Tue, 24 Feb 2009 09:07:35 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 09:07:35 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 09:07:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111242>

On 2009-02-24, Junio C Hamano <gitster@pobox.com> wrote:
> I think you are looking for "/foo/".  From Documentation/gitignore.tx=
t:

[lots of very clear and detailed explanation snipped for
brevity...]

I'd been sort of struggling with the part of 'man gitignore'
that describes the rules for the exclusion patterns; it just
didn't seem as clear as it could have been.  It's very
accurate, but I (and I noticed a few others on irc) had to
read very carefully to do anything moderately complex.

A few days ago, 'doener' (Bj=C3=B6rn Steinbrink) came up with
some much simpler rules that said the same thing, and --
building on the insight that his rules gave me -- I came up
with these:

----->8-----

Note that rule 1 merely *modifies* rules 2 and 3, it does not
supercede or preclude them.

1.  If you pattern ends with a slash, it matches only
    directories (and their contents)
2.  If there is no slash otherwise, it matches that name, at
    any depth in the tree
3.  If there is a slash anywhere else, it matches that name,
    relative to the .gitignore (or $GIT_WORK_TREE if the
    pattern is from one of the other pattern sources like
    `.git/info/exclude` etc)

The wildcards (`*` and `?`) do not match slashes, but otherwise
the patterns are normal shell globs as defined by fnmatch(3) with
the FNM_PATHNAME flag set.

----->8-----

Those rules are meant to clarify the following lines from
the gitignore man page:

 - If the pattern ends with a slash, it is removed for the
   purpose of the following description, but it would only find
   a match with a directory.  In other words, `foo/` will match a
   directory `foo` and paths underneath it, but will not match a
   regular file or a symbolic link `foo` (this is consistent
   with the way how pathspec works in general in git).

 - If the pattern does not contain a slash '/', git treats it as
   a shell glob pattern and checks for a match against the
   pathname without leading directories.

 - Otherwise, git treats the pattern as a shell glob suitable
   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
   wildcards in the pattern will not match a / in the pathname.
