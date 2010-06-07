From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Mon, 7 Jun 2010 10:59:47 +0200
Message-ID: <20100607085947.GA3924@pvv.org>
References: <cover.1275309129.git.grubba@grubba.org> <7vfx16oxmz.fsf@alter.siamese.dyndns.org> <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com> <20100604005603.GA25806@progeny.tock> <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com> <20100604194201.GB21492@progeny.tock> <Pine.GSO.4.63.1006061143000.27465@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 11:00:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLYBa-0003dC-V4
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 10:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab0FGI7x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 04:59:53 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:55925 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab0FGI7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 04:59:52 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OLYBP-0000at-Iv; Mon, 07 Jun 2010 10:59:47 +0200
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1006061143000.27465@shipon.roxen.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148588>

On Sun, Jun 06, 2010 at 12:50:08PM +0200, Henrik Grubbstr=F6m wrote:
[...]
>
> Currently (as I believe you know), git has no detection of when the =20
> conversion mode for a file has changed, and it might even take a whil=
e =20
> before the users notice that the repository is not normalized. eg:
>
>   0) There's a repository with some files containing crlf line ending=
s.
>
>   1) User A notices that git now has native support for crlf
>      line endings, and adds the attribute eol=3Dcrlf for the
>      affected files.
>
>   2) User A does a git status, sees that .gitattributes is
>      modified, and commits it.

I think it would be best if git at this time could decide that the
affected files also become dirty. The ideal commit is one that
both alters the .gitattributes _and_ the affected files at the same
time, and git should make it easy to create that commit.

> [...]
>   6) User C is new to the project and does an initial git clone,
>      and ends up with a dirty index.

And the reason for this is mostly that unless you perform some special
actions, you will commit attributes and contents that are mismatched.

In your suggested mode, whay would happen if you did this:

$ git clone ......  (which has files that are "wrong" wrt line endings =
and
attributes for some .c files)
$ touch *.c

Would it still believe all *.c files were clean? Does it require an
actual other change at the same time to allow you to normalize the
file? That would be detrimental I think.  Changing newlines is best
done as a separate commit, intermingling newline changes and real
changes in the same commmit is not where you want to go.

However, for your ID string you obviously want this behaviour. I'm
guessing that hook is alreasy set up so that if you just touch the
file, it will still be treated as unmodified?

>
> What my patch set achieves is that user C above also gets a clean ind=
ex.
>
> What it seems you want is that user A above should have all files tha=
t=20
> got denormalized by the attribute change marked dirty at 2 (and 3).

That would indeed be a very welcome change.

> As I believe both behaviours may be desireable a config option and/or=
 =20
> attribute is needed. Any suggestions for a name (and default value)?

I think the default behaviour should be to mark files dirty if there
are ANY attribute changes that could cause content changes done to
them at all. I'm not sure that is exactly what your patch series is
allowing us to track though?

Just to be clear:

If you add this to your .gitattributes

*.c eol=3Dlf

I think it would be very helpful if git then would treat all .c files
as "stat-dirty" the next time it updates its index.

A for config variables, what about:

core.rereadOnAttributeChanges =3D [true]/false    (default =3D true)

Which makes some sense for detecting it in 2, but not so much for
ignoring it in 6.

- Finn Arne
