From: Eric Wong <normalperson@yhbt.net>
Subject: Re: GCC Git mirror no longer updating
Date: Thu, 13 Aug 2009 14:51:31 -0700
Message-ID: <20090813215130.GB7950@dcvr.yhbt.net>
References: <20090811173006.GB4578@redhat.com> <1250017013.8074.376.camel@giskard> <20090811191642.GA5806@redhat.com> <4aca3dc20908111333i49195ec5h9b91ab5f6445f701@mail.gmail.com> <4A822440.40207@redhat.com> <1250074569.8074.671.camel@giskard> <4A82C786.5060602@redhat.com> <1250123299.8074.1593.camel@giskard> <20090813033738.GA7950@dcvr.yhbt.net> <4aca3dc20908130743g28a32229s194e9caa7a44fa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bernie Innocenti <bernie@codewiz.org>,
	Jason Merrill <jason@redhat.com>,
	Daniel Berlin <dberlin@dberlin.org>,
	"Frank Ch. Eigler" <fche@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 23:51:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbiD4-00026O-VP
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 23:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbZHMVvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 17:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbZHMVvc
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 17:51:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40327 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbZHMVvb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 17:51:31 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B941F509;
	Thu, 13 Aug 2009 21:51:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4aca3dc20908130743g28a32229s194e9caa7a44fa2@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125881>

Daniel Berlin <dberlin@dberlin.org> wrote:
> On Wed, Aug 12, 2009 at 11:37 PM, Eric Wong<normalperson@yhbt.net> wr=
ote:
> > Bernie Innocenti <bernie@codewiz.org> wrote:
> >> El Wed, 12-08-2009 a las 09:45 -0400, Jason Merrill escribi=F3:
> >> > On 08/12/2009 06:56 AM, Bernie Innocenti wrote:
> >> > > The git repository format should support concurrent access, bu=
t perhaps
> >> > > it only applies to git-receive-pack, not fancy operations such=
 as
> >> > > repacking.
> >> >
> >> > The git repository format, yes, but maybe not the stuff in .git/=
svn. =A0It
> >> > seems like a temporary index file was referring to an object tha=
t got
> >> > garbage collected away. =A0Or maybe the index file was left over=
 from the
> >> > initial import, and not there due to a collision; there don't se=
em to be
> >> > index files there normally.
> >>
> >> git-svn might be keeping extra information in files that the other=
 git
> >> tools don't know about. =A0This would explain why some objects loo=
ked
> >> like orphans and were thus culled. =A0[cc'ing the git list to catc=
h the
> >> attention of the git-svn maintainer(s)].
> >
> > Hi,
> >
> > As far as I can remember, no version of git svn has ever relied on
> > orphanable objects.
> >
> > Of course there are unavoidable race conditions that happen while g=
it
> > svn is running.
> >  =A0It is never safe to run repack concurrently while git
> > svn is running (I wouldn't repack/gc simultaneously with _any_ writ=
e
> > activity on the repo).
>=20
> Sounds like you guys need a write lock then for certain operations.
> How do you square this with the auto-repacking the repository does (b=
y
> default i thought it runs git gc every so often).
> We have no control over people pushing branches back at the repo, it
> may be happening when git-svn is running

Actually, I think the prune operation in git gc is the only potentially
unsafe part (and not repack).  Double-checking with pruning during gc,
it seems to only expire things older than two weeks by default (when
used with gc).

So I think git svn is safe in the face of repack/gc after all.
Manually running git prune without the --expire argument isn't safe,
but we don't recommend that anyways.

> Where does it say anything about this in the docs so that people know=
 this?

Junio: can you confirm my observations above?  I think everything is
safe by default as-is.  Thanks

> >=A0 git svn itself can/will run "git gc" in-between
> > revisions if needed. =A0You can safely repack manually whenever git=
 svn is
> > not running.

--=20
Eric Wong
