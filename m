From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
	root  directory?
Date: Thu, 26 Feb 2009 01:45:30 +0100
Message-ID: <20090226004530.GA11730@atjola.homenet>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com> <7v1vtomhz1.fsf@gitster.siamese.dyndns.org> <slrngq7e6c.iti.sitaramc@sitaramc.homelinux.net> <7vzlgbhh95.fsf@gitster.siamese.dyndns.org> <slrngq9es5.ik0.sitaramc@sitaramc.homelinux.net> <7vab8aap6t.fsf@gitster.siamese.dyndns.org> <slrngqaa5n.mp1.sitaramc@sitaramc.homelinux.net> <7vvdqyyzsr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 01:47:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcUP8-0000Si-MK
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 01:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbZBZApn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 19:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbZBZApm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 19:45:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:53554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751435AbZBZApm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 19:45:42 -0500
Received: (qmail invoked by alias); 26 Feb 2009 00:45:39 -0000
Received: from i577BB0ED.versanet.de (EHLO atjola.local) [87.123.176.237]
  by mail.gmx.net (mp043) with SMTP; 26 Feb 2009 01:45:39 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19EoY5j7l1EdWYztxAv+/FkKSxzmeYgmpz16Rmpyf
	73H80A4TRl9MMq
Content-Disposition: inline
In-Reply-To: <7vvdqyyzsr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111515>

On 2009.02.25 13:25:24 -0800, Junio C Hamano wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
> > Do we not want to specify that we don't descend?  The
> > original text does say '...will match a directory foo and
> > paths underneath it'.
>=20
> Ok.  If we unignore a directory that does not mean all paths inside i=
t are
> now unignored --- they are still subject to .gitignore rules read fro=
m it
> and its subdirectories.  So "will match it and paths inside it" is co=
rrect
> but "will ignore it and paths inside it" is not.

I don't think that's good enough. The case in which we ignore
directories is impressively hard to describe correctly. Consider this:

=2Egitignore     # Contains foo
foo/.gitignore # Contains !bar
foo/bar

The current man page says that for "foo/bar" foo/.gitignore has the
highest precedence, overriding the patterns from .gitignore. So without
further information, one could think that while foo/bar is matched by
the "foo" pattern, this is invalidated by the "!bar" rule and thus
foo/bar would not be ignored. But of course we don't bother looking int=
o
foo at all, so the foo/.gitignore has no effect.

And it gets more interesting:

=2Egitignore # Contains "foo" and "!foo/bar"
foo/bar

Even in this case, foo/bar is ignored. Because again, we don't look int=
o
foo at all, so we never even see foo/bar and thus we won't notice that
it is to be unignored. So saying "match it and paths inside it" is
misleading, because we'll never even see any path inside it that could
match, and it might lead to failing gitignore setups like the above.

So maybe instead of "... and paths inside it", we could have something
like this:

    If a directory is ignored, git won't look into it at all when
    searching for untracked files. This means that all paths inside it
    are implicitly ignored and that you cannot unignore these paths.

Bj=F6rn
