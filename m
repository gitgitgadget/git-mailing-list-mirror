From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to manage merges from one line while excluding its merges
 from another
Date: Fri, 25 Jun 2010 19:03:58 -0500
Message-ID: <20100626000358.GA11473@burratino>
References: <4C252D1C.4010702@brooks.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Lane Brooks <lane@brooks.nu>
X-From: git-owner@vger.kernel.org Sat Jun 26 02:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSIsh-00074Z-Pa
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 02:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab0FZAEO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 20:04:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34695 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0FZAEN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 20:04:13 -0400
Received: by iwn41 with SMTP id 41so2520070iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 17:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CDVHATRk/BC/vuxiWI+Ki2BgYURp8gwnNxdfR+K+J8I=;
        b=lWO6P3cTstk5Wp0ZNUhrWynaDeU3+2sqVggj/Y+BXsrTp7id3p8CXevfLqlFBBZDxL
         5fMN/7wr3fOVBBxu2brtnfztE+XzPpYQy1ey6ofosG8tS/7ZujGWf6ZYzS+v2nSRSDZ0
         x5HUOp1/8mosilRQFwoHCTdlDw+6AYu3LI8Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LmQQNgg+5DWwCbHW23BjixcUZBXlaHLZwuJ4fTHsS0kayFrZAjiZyNwqcnOrSlPJYq
         BusDY77CT10Ctls1E6tZv7qan42eSySu6Ndz0tH+Nzs0L64xyKz1L4Uycvl7putsTc8k
         xv+1V1TnsvUfPstKbGluZjAurF8RLuJsbxwI4=
Received: by 10.231.14.136 with SMTP id g8mr1479008iba.146.1277510651127;
        Fri, 25 Jun 2010 17:04:11 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm1386390ibh.20.2010.06.25.17.04.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 17:04:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C252D1C.4010702@brooks.nu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149722>

Hi Lane,

Lane Brooks wrote:

> I have a tree like this:
>=20
>      G---H---I---J---K   devel
>     /       /       /
> A---B---C---D---E---F    main
>         \
>          L---M---N---O   my

Nice diagram.

What is missing is a picture of what you want the result to be.

> The 'my' branch forked off the 'main' line and for reasons out of my
> control cannot merge the 'main' changes (D,E,F) back.
[...]
> I want to continue to merge from the devel line as additional commits
> are made that are not on the main branch, but I do not want any of
> the future merge commits.

(I) I am guessing that the 'main' line is not part of the published
history, in which case you what you want might look like this:

         ... devel
      /
 A---B---C- ... main
          \
           L---M---N---O---H'---J' my

The J commit itself could not be included in the history of the 'my'
branch because its ancestor D is not meant to be published.

(II) In an alternative scenario, the 'main' changes (D, E, F) are
forbidden because they introduce bugs.  In this case, a solution might
look something like this:

       ...                  K devel
     /               /       \
A---B---C---D---E---F main    \
         \                     \
          L---M---N---O---------P---Q---R---S

where Q, R, and S are commits (created with =E2=80=98git revert=E2=80=99=
) that
undo the effect of F, E, and D.  From then on, you can just merge
from devel as usual.

> Is there an automated way to do this or do I have to cherry pick
> everything by hand?

In git 1.7.2, you will be able to automate (I) as follows:

 git cherry-pick --no-merges ^my ^main devel

Until then, you might want to try experimenting with something
like this:

 git rev-list --no-merges ^my ^main devel |
 while read rev
 do
	git cherry-pick $rev ||
	{
		echo >&2 cherry-pick failed
		break
	}
 done

Hope that helps,
Jonathan
