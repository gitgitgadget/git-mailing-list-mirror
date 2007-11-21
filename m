From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Using Filemerge.app as a git-diff viewer
Date: Wed, 21 Nov 2007 13:59:37 +0100
Message-ID: <1A9343EE-BB45-4CF8-9F17-E6A73C5F0B83@wincent.com>
References: <47440912.8010800@cam.ac.uk> <20071121112757.GA17231@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Toby White <tow21@cam.ac.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 14:01:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IupBn-00020w-5o
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 14:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbXKUNAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 08:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbXKUNAE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 08:00:04 -0500
Received: from wincent.com ([72.3.236.74]:54723 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbXKUNAB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 08:00:01 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALCxr9n014465;
	Wed, 21 Nov 2007 06:59:54 -0600
In-Reply-To: <20071121112757.GA17231@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65642>

El 21/11/2007, a las 12:27, Jeff King escribi=F3:

> On Wed, Nov 21, 2007 at 10:31:46AM +0000, Toby White wrote:
>
>> So I wrote a quick script (below) which does what I need. Of all
>> the available git-diff flags, it only understands "--cached", and
>> up to two commit objects, and no paths, but that's enough for me.
>> Within those constraints, it has the same semantics as git-diff.
>
> Have you looked at the documentation for GIT_EXTERNAL_DIFF (try =20
> git(7))?
> I think it is a cleaner way of doing what you want (although I think =
=20
> you
> will get each file diffed individually, which is perhaps not what you
> want).
>
> Something like:
>
> $ cat >merge.sh <<EOF
> #!/bin/sh
> opendiff "$1" "$2"
> EOF
> $ GIT_EXTERNAL_DIFF=3D./merge.sh git-diff ...

A few problems with that:

- FileMerge is broken, and crashes if you pass /dev/null as a param =20
(which happens for new/deleted files)

- you need to escape those $-signs

- the params you're interested in are actually $2 and $5, not $1 and =20
$2, according to git(7)

- you need to handle the clean tree case (no params are passed)

- and also the 1-param case, "for unmerged paths", whatever that means

- will only work when run from the top of the tree (path parameters =20
are passed in relative to that)

So here's a less-broken version of your suggestion, but it's still =20
broken; a relatively complex wrapper is required to do this right:

$ cat >merge.sh <<EOF
#!/bin/sh
[ \$# -eq 7 ] && opendiff "\$2" "\$5"
EOF
chmod +x merge.sh
GIT_EXTERNAL_DIFF=3D./merge.sh git-diff ...

Cheers,
Wincent
