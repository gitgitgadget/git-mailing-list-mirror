From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/9] Add treap implementation
Date: Thu, 24 Jun 2010 14:22:34 -0500
Message-ID: <20100624192234.GC1848@burratino>
References: <20100624105004.GA12336@burratino>
 <20100624105706.GD12376@burratino>
 <AANLkTinYmKl4M10l3u5V7deleqSzr7iJDqf7X6ghtwRM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 21:22:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORs0h-0000Bq-Es
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 21:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab0FXTWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 15:22:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36106 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab0FXTWo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 15:22:44 -0400
Received: by iwn41 with SMTP id 41so1142300iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iLOIXkjRW5C3pBrJ3K/q0TqenepLS7+uzq9foXMort4=;
        b=ZDcF0HuajvrbopO+CbNLeRRjVH8ylH7QOOQLK3Oa73eZtdoJSujQupnK0exUoqJGmP
         AxYpx/7yhZ1/IqitxLg9P/81sP0umJEtfHzb/pzDRDsfWMdFVF5N6JPLyXPVeR2jj6eO
         sKslvqQ09RhykuWKcZpkfA7qtBxyz7gQ5HGr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PGxJtAtn3dLkk3jWd5a58bGPwPsNFLzcQcgpHwoI2FZX6nJld53nWoeHO3aUK4wxuA
         2H9dP9OfKwN1L1aPg0/CrFXav+3BCRcyMmWZLPOibiYk3usfb9NBNJDBT62hwq+qPT9I
         iybaA3mWcD0ahGR30hWql+hmfASQWFegFsA6Y=
Received: by 10.231.124.5 with SMTP id s5mr11233688ibr.195.1277407364299;
        Thu, 24 Jun 2010 12:22:44 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm36290612ibi.20.2010.06.24.12.22.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 12:22:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinYmKl4M10l3u5V7deleqSzr7iJDqf7X6ghtwRM@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149624>

Ramkumar Ramachandra wrote:

> David is currently working on
> a Java implementation of a immutable ternary treap and will
> re-implement it as C macros. See the ternary-treap branch.

I assume his blog post from a week or so ago[1] is relevant.

The trie-based version should be interesting but less generic (which
is fine, since we only have two users and both use string keys).

>> =C2=A0$(VCSSVN_OBJS): \
>> - =C2=A0 =C2=A0 =C2=A0 vcs-svn/obj_pool.h
>> + =C2=A0 =C2=A0 =C2=A0 vcs-svn/obj_pool.h vcs-svn/trp.h
>
> Interesting how you've shown this in every patch :)

It would have been less messy to use

 $(VCSSVN_OBJS): \
	vcs-svn/obj_pool.h \
	vcs-svn/trp.h \
	... \

or

 $(VCSSVN_OBJS): vcs-svn/obj_pool.h
 $(VCSSVN_OBJS): vcs-svn/trp.h
 ...

I just can=E2=80=99t bring myself to care much. :)

> > +/*
> > + * Fibonacci hash function.
> > + * The multiplier is the nearest prime to (2^32 times (=E2=88=9A5 =
- 1)/2).
> > + * See Knuth =C2=A76.4: volume 3, 3rd ed, p518.
> > + */
>=20
> Um, is it alright to put non-ascii characters in a file containing
> code?

Yes, UTF-8 is sometimes used in comments for people=E2=80=99s names.  S=
ee
builtin/branch.c, for example.

> The documentation is good, but I don't see it merged into the tree.
> Perhaps send a patch to David?

Yes.  I should send some other patches, too, to minimize the delta.

> Also, you might want to include the
> technical explanation for using treaps from the commit message here?

Good idea, thanks!

Jonathan

[1] http://barrbrain.github.com/2010/06/19/relocatable-immutable-random=
ised-ternary-search-tree-part-2.html
