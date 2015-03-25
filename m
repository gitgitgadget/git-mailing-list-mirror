From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC] git submodule purge
Date: Wed, 25 Mar 2015 10:06:31 +0100
Message-ID: <20150325090631.GA370@pks-pc.localdomain>
References: <20150316134407.GA31794@pks-tp.elego.de>
 <20150316200353.GB5186@google.com>
 <20150317075636.GA354@pks-pc>
 <5510866B.40501@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 10:07:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YahHT-0006w6-0W
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 10:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbbCYJHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 05:07:14 -0400
Received: from sender1.zohomail.com ([74.201.84.155]:30159 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbbCYJHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 05:07:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; 
  b=S0F/0ijgCN1mwxT4fQqjVVuRNh5i7kZP2wsJjwiAxL0+JYjH9cdqrrPGQ1kxR7JwlyHm7J0qA8rL
    bnrhQph6IG8EUKGUc39tRN9KXqr5Q4csGXJTkrLzCKfDVGoDu3Tii1w+4GSLhJwfAzQmJZIfRxIa
    mVW1zCbI+NtXq8bugtQ=  
Received: from localhost (e179175178.adsl.alicedsl.de [85.179.175.178]) by mx.zohomail.com
	with SMTPS id 1427274427047715.9649282926415; Wed, 25 Mar 2015 02:07:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5510866B.40501@web.de>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266275>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2015 at 10:32:27PM +0100, Jens Lehmann wrote:
> Am 17.03.2015 um 08:56 schrieb Patrick Steinhardt:
> > On Mon, Mar 16, 2015 at 01:03:53PM -0700, Jonathan Nieder wrote:
> >> (+cc: Jens and Heiko, submodule experts)
> >> Hi,
> >>
> >> Patrick Steinhardt wrote:
> >>
> >>> This proposal is just for discussion. If there is any interest I
> >>> will implement the feature and send some patches.
> >>>
> >>> Currently it is hard to properly remove submodules. That is when
> >>> a submodule is deinitialized and removed from a repository the
> >>> directory '.git/modules/<SM_NAME>' will still be present and
> >>> there is no way to remove it despite manually calling `rm` on it.
> >>> I think there should be a command that is able to remove those
> >>> dangling repositories if the following conditions are met:
> >>>
> >>> - the submodule should not be initialized
> >>>
> >>> - the submodule should not have an entry in .gitmodules in the
> >>>    currently checked out revision
> >>>
> >>> - the submodule should not contain any commits that are not
> >>>    upstream
> >>>
> >>> - the submodule should not contain other submodules that do not
> >>>    meet those conditions
> >>>
> >>> This would ensure that it is hard to loose any commits that may
> >>> be of interest. In the case that the user knows what he is doing
> >>> we may provide a '--force' switch to override those checks.
> >>
> >> Those conditions look simultaneously too strong and too weak. ;-)
> >>
> >> In principle, it should be safe to remove .git/modules/<name> as
> >> long as
> >>
> >>   (1) it (and its submodules, sub-sub-modules, etc) doesn't have any
> >>       un-pushed local commits.
> >>
> >>   (2) it is not being referred to by a .git file in the work tree of
> >>       the parent repository.
> >>
> >> Condition (1) can be relaxed if the user knows what they are losing
> >> and is okay with that.  Condition (2) can be avoided by removing
> >> (de-initing) the copy of that submodule in the worktree at the same
> >> time.
> >>
> >> The functionality sounds like a useful thing to have, whether as an
> >> option to 'git submodule deinit' or as a new subcommand.  In the long
> >> term I would like it to be possible to do everything 'git submodule'
> >> can do using normal git commands instead of that specialized
> >> interface.  What command do you think this would eventually belong in?
> >> (An option to "git gc", maybe?)
> >>
> >> Thanks,
> >> Jonathan
> >
> > Thanks for your feedback.
> >
> > Considering that purging the submodule is tightly coupled with
> > de-initializing it, it might make sense to provide this
> > functionality as part of `git submodule deinit`. Maybe something
> > like `git submodule deinit --purge` would work for the user.
> > Problem is if the user first removes the submodule and does not
> > first deinitialize it he is not able to purge the repository
> > afterwards as deinit will complain about the submodule not being
> > matched anymore. We could just make `deinit --purge` work with
> > removed submodules, but that does not feel very natural to me.
>=20
> Hmm, cmd_deinit() seems to cope with submodules removed by the
> user just fine (as long as they are still present in the index).
> To me it feels natural to extend deinit to remove the repo from
> .git/modules too when --purge is given (as long as no unpushed
> commits are present or -f is given).
>=20
> > `git gc` feels saner in that regard, but I don't think it would
> > be easy to spot for users as this command is in general not used
> > very frequently by them. One could argue though that it does not
> > need to be discoverable.
>=20
> The error message of "git submodule deinit --purge" for a
> submodule that isn't recorded in the index anymore could point
> the user to the appropriate gc command. But how do we tell gc
> which submodule it should purge? "--purge=3D<submodule-name>"
> maybe?

This might work, but at least the option would need to provide a
hint to the user that it has something to do with submodules. So
if the feature was implemented by `git gc` I'd rather name the
parameter "--purge-submodule=3D<submodule-name>" which in my
opinion clearly states its intention, even though it is longer to
type. But with working bash-completion this should be non-issue,
especially as this command would not need to be run frequently.

That said, I think by now I agree with the common (?) opinion
that the command is best placed in `git submodule deinit --purge`
and I will likely implement it there. Optionally I could
implement `git gc --purge-submodule=3D<submodule-name>` as a second
way to access the feature so that we have a way of purging them
without using the submodules-interface. I doubt though that this
will provide much of a benefit as the user still has to be aware
that he is working with submodules as he has to provide the
`--purge-submodule` option, so there is not much to be gained by
this.

Regards
Patrick

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVEnqXAAoJEBF8Z7aeq/EsmakQAIlkzFhBBnT9Cz0XSaydMHyY
byQ603gSEV+/0TJEUtCe8BO1Abi6qtsfM5R+sowUlPTskI+cB4JbZCJlYSMn+75P
zbamV8pNzKVi1RcjiYGzVu87qGRfgkwPSlOcidbdQNBOF4vc2+Xer5sDq82yrZn0
wMAuAQd6xO8Q/GEzPTpwFO76a1eDIau9lF29X5+/tXNplrUypMygiNP5TGlN8upk
0GKYjXdFONpk7oeZVjTqVHXdSvnC8dXOfsFUcE02FYQGfRVgYjUjYtn3r1Q6M742
caR5HPWhtIH1M/56MdExcZupSHSys4XAQBSeapqVCEdbxuM49bfAR17wae9GGRe5
XtkHAXOjHcWphavNGURb1LWJTjxUBlkneZUatBlKitv9iifmDc1gegWTRmhxVhh6
+u1HndX4qxB6TCqSPgliec2TCOknVgZuMTDU1SPBKlDobfGuUINMeTL20lGujlyU
1QXErAyxoiMAfizpvA60MSqeUT3GWvgsP1gnDKU1vkGLZfU0wu5nFeFNRRHJa7sX
apB4F4MNVj/2N8Zs2VrpemQVjgfmBWtej8Q/AHmnDDhJ3m1n3AGbNBzuWvi0+MuG
M7QNRsJgK1LG51e7UgRRhQeiv1RieYdE57YPoOjcKTMKaigeplneubUu0ktOAmtH
9tQFfE9ceiaBWtG06vd+
=uA41
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
