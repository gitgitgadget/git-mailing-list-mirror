From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Wed, 26 Aug 2009 14:16:00 +0200
Message-ID: <20090826121600.GA29098@atjola.homenet>
References: <1251228341-29434-1-git-send-email-catap@catap.ru>
 <1251228467-29638-1-git-send-email-catap@catap.ru>
 <20090825223637.GA20523@atjola.homenet>
 <87ljl694fd.wl%catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Wed Aug 26 14:16:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgHQK-00016c-DD
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 14:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbZHZMQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 08:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbZHZMQJ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 08:16:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:46370 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932305AbZHZMQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 08:16:08 -0400
Received: (qmail invoked by alias); 26 Aug 2009 12:16:08 -0000
Received: from i59F555FB.versanet.de (EHLO atjola.homenet) [89.245.85.251]
  by mail.gmx.net (mp047) with SMTP; 26 Aug 2009 14:16:08 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/ohNNrB/voOMbHnZ0Y03KQ/FadGJtP0b765rPeyT
	JQ3Galq/h7kQGc
Content-Disposition: inline
In-Reply-To: <87ljl694fd.wl%catap@catap.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127091>

On 2009.08.26 15:53:58 +0400, Kirill A. Korinskiy wrote:
> At Wed, 26 Aug 2009 00:36:37 +0200,
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
>=20
>=20
> > > @@ -518,7 +521,21 @@ int cmd_clone(int argc, const char **argv, c=
onst char *prefix)
> > > =20
> > >  		mapped_refs =3D write_remote_refs(refs, refspec, reflog_msg.bu=
f);
> > > =20
> > > -		remote_head =3D find_ref_by_name(refs, "HEAD");
> > > +		if (option_branch) {
> > > +			strbuf_addf(&branch_head, "%s%s", src_ref_prefix, option_bran=
ch);
> > > +
> > > +			remote_head =3D find_ref_by_name(refs, branch_head.buf);
> > > +		}
> > > +
> > > +		if (!remote_head) {
> > > +			if (option_branch)
> > > +				warning("Remote branch %s not found in upstream %s"
> > > +					", using HEAD instead",
> > > +					option_branch, option_origin);
> > > +
> > > +			remote_head =3D find_ref_by_name(refs, "HEAD");
> > > +		}
> > > +
> > >  		head_points_at =3D guess_remote_head(remote_head, mapped_refs,=
 0);
> >=20
> > This would still pick refs/heads/master if refs/heads/master and
> > refs/heads/<branch> reference the same commit. That's due to the ch=
eck
> > in guess_remote_head() which prefers refs/heads/master over all oth=
er
> > refs. While this is acceptable for the HEAD lookup, I'd treat that =
as a
> > bug for this new option.
> >=20
>=20
> My english is not a good and I don't understand it, sorry.

guess_remote_head() compares the object ids from remote_head and all of
the remote's refs to guess which is the right one.

Let's say that the repo has:

refs/heads/master: object1
refs/heads/foo: object2
refs/heads/bar: object1

If you do "git clone -b foo ...", then remote_head->old_sha1 will be
"object2". guess_remote_head() compares that to all the remote heads. I=
n
this case, it will find refs/heads/foo (as expected).

But when you do "git clone -b bar", then remote_head->old_sha1 will be
"object1". And guess_remote_head() will then take refs/heads/master,
as it prefers that one.

doener@atjola:h $ mkdir a; cd a; git init
Initialized empty Git repository in /home/doener/h/a/.git/
doener@atjola:a (master) $ git commit --allow-empty -m init
[master (root-commit) a7a0b54] init
doener@atjola:a (master) $ git branch bar
doener@atjola:a (master) $ git checkout -b foo
Switched to a new branch 'foo'
doener@atjola:a (foo) $ git commit --allow-empty -m on_foo
[foo 375047e] on_foo
doener@atjola:a (foo) $ cd ..
doener@atjola:h $ (git clone -b foo a foo; cd foo; git branch)
Initialized empty Git repository in /home/doener/h/foo/.git/
* foo
doener@atjola:h $ (git clone -b bar a bar; cd bar; git branch)
Initialized empty Git repository in /home/doener/h/bar/.git/
* master


That said, I actually wonder why you don't simple set HEAD in the
original repo so that you get whichever branch you want by default
anyway.

Bj=F6rn
