From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Subject: [PATCH] fix stg edit command
Date: Tue, 12 Feb 2008 23:47:24 +0100
Message-ID: <20080212224724.GA24993@diana.vm.bytemark.co.uk>
References: <20080210203846.17683.43153.stgit@yoghurt> <20080210204359.17683.41935.stgit@yoghurt> <200802122305.05696.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:48:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP3vG-0002kW-7v
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 23:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbYBLWrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 17:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbYBLWrl
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 17:47:41 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4333 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbYBLWrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 17:47:40 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JP3uO-0006dQ-00; Tue, 12 Feb 2008 22:47:24 +0000
Content-Disposition: inline
In-Reply-To: <200802122305.05696.kumbayo84@arcor.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73707>

On 2008-02-12 23:05:05 +0100, Peter Oberndorfer wrote:

> While testing my editor searching ordering patch i found that this
> patch(Refactor --author/--committer options) seems to break "stg
> edit" (without arguments) starting a interactive editor for me. When
> i issue "stg edit" it silently does nothing.

Thanks for the report. And yes, as far as I can tell your analysis is
spot on. In the initial patch I remember being careful to not replace
cd unless it was actually changed, but obviously I got sloppy after
that. :-(

> It seems the following comparison does not return True
>
> > # Let user edit the patch manually.
> > if cd =3D=3D orig_cd or options.edit:
>
> I can work around this by adding a comparison function to Commitdata
> but maybe __eq__ or __ne__ should be used instead(prevent similar
> bugs caused by =3D=3D comparison)?
>
> +    def is_same(self, other):
> +        return (self.__tree =3D=3D other.__tree and
> +                self.__parents =3D=3D other.__parents and
> +                self.__author =3D=3D other.__author and
> +                self.__committer =3D=3D other.__committer and
> +                self.__message =3D=3D other.__message)

Yes, you'd definitely want the common operators to work. But I usually
implement __cmp__ instead of __eq__ and __ne__ -- that gives you all
of <, <=3D, =3D, !=3D, >=3D, and > for the price of a single method. An=
d it's
usually possible to define it rather simply in terms of cmp() with
tuple arguments, like this:

    def __cmp__(self, other):
        return cmp((self.__tree, self.__parents, self.__author,
                    self.__committer, self.__message),
                   (other.__tree, other.__parents, other.__author,
                    other.__committer, other.__message))

This sidesteps the great problem of cmp -- having to remember when to
return 1 and when to return -1.

> So another way to fix this might be, to not overwrite cd
> unconditionally.

Yes, this is what we want -- if the user gives --author, we shouldn't
open the interactive editor even if the given author is the same as
the patch already had.

Updated patch on the way.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
