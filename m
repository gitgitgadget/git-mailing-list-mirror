From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Preserving branches after merging on ancestor
Date: Fri, 6 Nov 2009 00:28:48 +0100
Message-ID: <20091105232848.GA1939@atjola.homenet>
References: <26217077.post@talk.nabble.com>
 <20091105223004.GA3224@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Lee <richard@webdezign.co.uk>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 00:29:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6BlY-0001ad-NK
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 00:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758387AbZKEX2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 18:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758390AbZKEX2t
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 18:28:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:39079 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753566AbZKEX2s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 18:28:48 -0500
Received: (qmail invoked by alias); 05 Nov 2009 23:28:52 -0000
Received: from i59F56212.versanet.de (EHLO atjola.homenet) [89.245.98.18]
  by mail.gmx.net (mp063) with SMTP; 06 Nov 2009 00:28:52 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19DogQgIwJDGvtEMSl+sfRRpDWZNqGPM5TQVcg/aA
	TCuS+qo3iXXTw4
Content-Disposition: inline
In-Reply-To: <20091105223004.GA3224@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132252>

On 2009.11.05 16:30:04 -0600, Jonathan Nieder wrote:
> But doing this misses some of the main benefits of feature branches
> imho.
>=20
> If you base each feature branch on the stable release or features it
> depends on instead, this gives you the freedom to merge one feature w=
ithout
> the others to another branch.

I guess Richard took the "branch topic1, merge topic1, branch topic2,
merge topic2" thing just as an example because that ends up with two
fast-forwards. And your example _still_ has such a fast-forward.

> For example:
>=20
> # wouldn=E2=80=99t feature1 be neat? let me try it.
> git checkout -b feature1 v1.0
> hack hack hack
> # looks good.
> git commit -a
>=20
> # how about an unrelated feature2?
> git checkout -b feature2 v1.0
> hack hack hack
> # looks good.
> git commit -a
>=20
> # but do they work?
> git checkout v1.0; # detach head for testing [1]
> git merge feature1 feature2
> make check
> # hmm, these don=E2=80=99t seem to work well together
> ... (investigating some more)
>=20
> # looks like feature1 is not ready for prime time
> # so let=E2=80=99s just use feature2 for now.
> git checkout master
> git merge feature2
> git branch -d feature2
> make check
> # looks good; better publish it.
> git push origin master
>=20
> v1.0 --- feature1
>     \
>      \-- feature2 [master]

And here you got a fast-forward of master to feature2, i.e. linear
history, which is what Richard was trying to avoid.

Instead of:

A---B---C---D---E (topic2) (master)
     \
      F---G---H (topic1)

He wants:

      F---G---H (topic1)
     /
A---B-----------M (master)
     \         /
      C---D---E (topic2)

So he can see at which point topic2 got merged. This allows to ask "whi=
ch
commits got merged here" (and for a merge-once topic branch this means:
Which commits are related to that topic), by using for example:

git log M^1..M^2 # Will show C, D and E

In the fast-forward case, there's no way to get that without manually
figuring out where the topic branch started.

Bj=C3=B6rn
