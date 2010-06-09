From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Wed, 9 Jun 2010 16:03:28 +0200
Message-ID: <20100609140327.GA19828@pvv.org>
References: <7vfx16oxmz.fsf@alter.siamese.dyndns.org> <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com> <20100604005603.GA25806@progeny.tock> <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com> <20100604194201.GB21492@progeny.tock> <Pine.GSO.4.63.1006061143000.27465@shipon.roxen.com> <20100607085947.GA3924@pvv.org> <Pine.GSO.4.63.1006071726170.22466@shipon.roxen.com> <20100607195013.GA27362@pvv.org> <Pine.GSO.4.63.1006081731550.22466@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 16:03:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMLsZ-0005Ox-3G
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 16:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab0FIODd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 10:03:33 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:42552 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab0FIODd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 10:03:33 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OMLsO-0008Dp-1i; Wed, 09 Jun 2010 16:03:28 +0200
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1006081731550.22466@shipon.roxen.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148779>

On Tue, Jun 08, 2010 at 05:52:37PM +0200, Henrik Grubbstr=F6m wrote:

> [...]
> True, there's no problem before the attribute change, but there is fo=
r=20
> commits between the attribute change and when the repository got =20
> normalized (which can be a while with the current git).

As you say, the current git makes it easy to commit something where
the attributes and the contents do not match. I think this needs to be
fixed, and that your proposed patch in relaxed mode makes the problem
_worse_, since it will then take even longer before these commits are
fixed. But see below.

>
> Re: configuration option naming:
>
>   I've settled for core.normalizationPolicy, with the values
>   'strict' (default) for the behaviour requested by you and Jonathan,
>   and 'relaxed' for my initial behaviour.

The name might be a bit vague, maybe there are other things that could
be normalized? Maybe adding the word "index" is an improvement -
e.g. core.indexNormalizationPolicy or just core.indexNormalization.=20

>
> Teaser:
> [...]
>   $ git status
>   # On branch master
>   nothing to commit (working directory clean)
>   $ cat >.gitattributes
>   * ident
>   $ git status
> [...]
>   #       modified:   expanded-keywords
> [...]
>
>   $ git config core.normalizationPolicy relaxed
>   $ git status
>   # On branch master
> [No longer modified]

THIS behaviour is what I find scary. In this case, "ident" is clearly
a newly added attribute, and git should not hide this from you. If you
add a mode where git will hide this permanently, chances are the
repositories will never be fixed.

The ident attribute may be a bit special since in your case it is only
supposed to change if some other contents in the file change as well,
but please also think how this will work with the text/eol
attributes. Setting the text attribute and then having to CHANGE a
file before getting it normalized is not good.

Still, I think your original problem description of cloning something
and ending up with a dirty tree is indeed an annoying problem.  So
what about having the relaxed mode behave as follows:

If both of these are true:
 - the current attributes for a file are the same as it is registered a=
s
   in the index with your new patch
 - a checkout of the file would result in identical contents to what is=
=20
   currently in the working directory
Then behave as if the file is not modified.

Or, in other words: If attributes are unchanged, a file is unmodified
not only if it would result in the same contents after being added,
but also if it would result in the current working directory
contents after being checked out again.

This should work for both text and ident on clone at least.

- Finn Arne
