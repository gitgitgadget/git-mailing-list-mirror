From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Why the default action for pull is merge, but not rebase?
Date: Thu, 28 Oct 2010 08:17:07 +0200
Message-ID: <20101028061707.GB3009@atjola.homenet>
References: <AANLkTinLbaE6He-bxA_+CT6J5uWmZSgodGs6SXO7eqnr@mail.gmail.com>
 <20101027165723.GC11069@burratino>
 <AANLkTimoSH2C4dBDDN1KMaFAp_nwAtLy5_uNFfiuz5GR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 08:19:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBLpt-0005xC-3L
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 08:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab0J1GRR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 02:17:17 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:43688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753436Ab0J1GRP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 02:17:15 -0400
Received: (qmail invoked by alias); 28 Oct 2010 06:17:12 -0000
Received: from i59F549CE.versanet.de (EHLO atjola.homenet) [89.245.73.206]
  by mail.gmx.net (mp007) with SMTP; 28 Oct 2010 08:17:12 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+wGDRJZ6qwEIcbnv2oPFJdoYYeEvM+uQsnhy80py
	eZVZtpnwy1STbY
Content-Disposition: inline
In-Reply-To: <AANLkTimoSH2C4dBDDN1KMaFAp_nwAtLy5_uNFfiuz5GR@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160157>

On 2010.10.27 13:21:18 -0400, Eugene Sajine wrote:
> On Wed, Oct 27, 2010 at 12:57 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
> > Eugene Sajine wrote:
> >
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 So, why not to rebase?
> >
> > An interesting question.
> >
> > Rebasing results in untested commits. =A0If this is a patch series
> > for submission, that's fine, because you will be extensively
> > testing each patch anyway or indicating to reviewers that that
> > needs to be done (right?). =A0But if it's a long-lived branch then
> > such repeated testing work can be a serious hassle.
> > https://git.wiki.kernel.org/index.php/GitFaq#What_is_the_difference=
_between_a_merge_and_a_rebase.3F
> >
> > A public branch that is regularly rebased is hard to follow
> > ("git log foo@{1}..foo") and build on.
> > http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html#_re=
covering_from_upstream_rebase
> >
> > Code consumers often want clean history, but that really means
> > (a) clean and (b) history.
> > http://thread.gmane.org/gmane.comp.video.dri.devel/34739/focus=3D34=
744
>=20
> Thanks for prompt answer. But let me clarify:
>=20
> When you do pull git performs:
>=20
> fetch of the remote branch to the FETCH_HEAD
> and then merge of FETCH_HEAD into the local branch
>=20
> What I'm saying is that your local branch should be rebased on top of
> FETCH_HEAD instead
>=20
> In this case there is no such thing as "often rebased public branch".

How do you know? Right before the pull, you could have run push, so you
would be rebasing a public branch.

> if the history got diverged then pull will result in new state that
> should be tested anyway, so why not to rebase local branch on top of
> the upstream instead of merging upstream into local branch?

Merging results in either 0 (fast-forward) or 1 (mege) new commit,
rebase results in 0-N new commits.

Let's say you have this history:

A---B---C (master)
 \
  D---E---F (topic)

If you merge topic to master, you get:

A---B---C---M (master)
 \         /
  D---E---F (topic)

So there's one new commit to test.

If you instead rebase topic onto master, you get:

          D'--E'--F' (topic)
         /
A---B---C (master)
 \
  D---E---F

So there are three new commits, all untested. And it's not enough to
test just F'. Even if that is ok, D' and E' might still be broken.

Simple example:
 - In A there was a function "int foo(int a)".
 - In D you added a call to that function.
 - In F you removed that call.
 - B changed the function signature to "int foo(int a, int b)"

The new F' commit will be fine, as there is no call to that function.
But D' and E' are broken as they still contains the call to foo with
just one argument.

HTH
Bj=F6rn
