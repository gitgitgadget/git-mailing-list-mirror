From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 06:29:55 +0200
Message-ID: <20091016042955.GA9233@atjola.homenet>
References: <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
 <20091015212632.GA13180@coredump.intra.peff.net>
 <7v1vl42uid.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	James Pickens <jepicken@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 06:32:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyeUm-0003kd-Vt
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 06:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbZJPEat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 00:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZJPEat
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 00:30:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:45889 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751070AbZJPEas (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 00:30:48 -0400
Received: (qmail invoked by alias); 16 Oct 2009 04:30:00 -0000
Received: from i59F5472B.versanet.de (EHLO atjola.homenet) [89.245.71.43]
  by mail.gmx.net (mp005) with SMTP; 16 Oct 2009 06:30:00 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+Y0l0dR4OYqmkHf9NzMGeURD6DZ48vutgx1YftMF
	djrIvgc7ZuG/LF
Content-Disposition: inline
In-Reply-To: <7v1vl42uid.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130453>

On 2009.10.15 14:54:18 -0700, Junio C Hamano wrote:
> If it is very important to support:
>=20
>     $ git checkout --look-but-not-touch origin/next^
>=20
> then James's approach would not be very useful, as we do have to deta=
ch
> HEAD and implement the "do not touch" logic for detached HEAD state
> anyway, so we might just use the same logic we would use for origin/n=
ext^
> when checking out origin/next itself.

I don't have any numbers backing this up, but my gut feeling says that
most cases of "Where have my commits gone?" that I have seen on #git
were due to "git checkout HEAD~2"-like actions. Either because the user
assumed SVN-like behaviour (you can't commit until you do "svn up", lik=
e
"git reset --merge HEAD@{1}") or thought that "git checkout
<committish>" would act like "git reset --hard <committish>".

=46or the latter I fail to envision any solution except for
education (and I have no idea why the user expected checkout to work
like reset).

The former can be solved by the proposed extra information in HEAD,
forbidding changes to HEAD that make it reference a commit that's not
reachable through the head stored in the extra information[*1*] and pro=
viding
some command that acts like "svn up".

This seems quite different from the plain "forbid committing" or "detac=
h
and know how you get there", but more like "detach and know where you'r=
e
coming from".

[*1*] If certain updates to HEAD aren't forbidden, a "checkout deadbeef=
"
(or a reset or update-ref) would possibly invalidate the extra
information in HEAD, which would require implicit detaching, making the
concept useless. For example:

A---B---C---D---E (master)
         \     /
          F---G---H---I (foo)

git checkout master
git checkout master~2 # Put refs/heads/master into the extra info
git reset --hard HEAD^ # Allow?
git reset --hard foo~2 # Allow? Change extra info? It's also in master


git checkout master
git checkout foo~2

Is that checkout allowed? "foo~2" is also reachable through master. Doe=
s
"checkout" do some smart parsing and puts refs/heads/foo into the extra
info? Or should refs/heads/master end up there?


git checkout master
git checkout foo~1

Basically, same deal as above, but foo~1 is not reachable through
master.


And finally the pure commit id cases:
git checkout master
git checkout $(git rev-parse master^)

Is that to be allowed? We can't derive the extra info from the argument
given to checkout, but could check that it's reachable from master
(currently referenced HEAD at the time of the command being run)

And:
git checkout master
git checkout $(git rev-parse foo^)

Neither can we guess what the extra info should be from the argument
given to checkout, nor is the given commit reachable through master. So
this should be forbidden and should require ^0?


This whole thing is indeed a whole lot less complex with a SVN-like
model, where you basically work with the linearly growing reflog only.

Bj=F6rn
