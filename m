From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Wed, 28 Jul 2010 13:36:47 +1000
Message-ID: <AANLkTikvhi-Bm-eV9ZfjoZdugRpiCwg8n-TQ4oOVvC=G@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 05:36:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdxRt-0000nl-D7
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 05:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab0G1Dgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 23:36:49 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62655 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab0G1Dgs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 23:36:48 -0400
Received: by qyk8 with SMTP id 8so3202579qyk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 20:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=He74bSV5JMH0bCGmkJq/g/7GiRVVqw/fEPO3wKqVvpk=;
        b=cCQMFnPyMe1Nt0RK5nzUherIXgrglyhdLezmAx/X79ZIPfFIs//mD6B2RlBt0mFge0
         4XsaNwRBQw+6sqKkEBQzNIcjEIPTs6zdXM1zxGB86UhI2/j27ZefpH2g/cTrBxO91goV
         24z2zDaxB7P6ejPnVvgPrjRSth1qxUZPzDbNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b+p1pMsYp+0tOGCgU7d0VwOMSaMZ0+cPMbxYfPmVa7bH4ZcXwoo66nKIVP9KF8Vkuw
         BOH3JYM6biiplQyLXzCTqIphsMUHHjGRFJk9siJOmfykGUpDcyc5ivM8nUVIEZL1CjBP
         TH7konxjI5WRAuFARK0YkSR4CB3Ioh4702Pm8=
Received: by 10.224.74.82 with SMTP id t18mr8105443qaj.95.1280288207289; Tue, 
	27 Jul 2010 20:36:47 -0700 (PDT)
Received: by 10.220.101.201 with HTTP; Tue, 27 Jul 2010 20:36:47 -0700 (PDT)
In-Reply-To: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152033>

2010/7/28 Elijah Newren <newren@gmail.com>:
> 1) A user controls sparseness by passing rev-list arguments to clone.
>
> This allows a user to control sparseness both in terms of span of
> content (files/directories) and depth of history. =C2=A0It can also b=
e used
> to limit to a subset of refs (cloning just one or two branches instea=
d
> of all branches and tags). =C2=A0For example,
> =C2=A0$ git clone ssh://repo.git dst -- Documentation/

Does pathspec is supported to in addition to prefix?

> =C2=A0$ git clone ssh://repo.git dst master~6..master
> =C2=A0$ git clone ssh://repo.git dst -3
> (Note that the destination argument becomes mandatory for those doing
> a sparse clone in order to disambiguate it from rev-list options.)
>
> This method also means users don't need much training to learn how to
> use sparse clones -- they just use syntax they've already learned wit=
h
> log, and clone will pass this info on to upload-pack.
>
> There is a slight question as to whether users should have to specify
> "--all HEAD" with all sparse clones or whether it should be assumed
> when no other refs are listed.

So you basically kill off shallow clone too, with "master~6..master".
I wonder what happens if user does "git clone ... master~6..master~3"?

> 4) All revision-walking operations automatically use these limiting a=
rgs.
>
> This should be a simple code change, and would enable rev-list, log,
> etc. to avoid missing blobs/trees and thus enable them to work with
> sparse clones. =C2=A0fsck would take a bit more work, since it doesn'=
t use
> the setup_revisions() and revision.h walking machinery, but shouldn't
> be too bad (I hope).
>
> There are also performance ramifications: There should be no
> measurable performance overhead for non-sparse clones (something that
> might be a problem with a different implementation that did
> does-this-exist check each time it references a blob). =C2=A0It shoul=
d also
> be a significant performance boost for those using it, as operations
> will only need to deal with the subset of the repository they specify
> (faster downloads, stats, logs, etc.)

Revision walking is not the only gate to access objects. Others like
diff machinery needs also be taught about rev-list limits.

> 5) "Densifying" a sparse clone can be done
>
> One can fetch a new pack and replace the limiting rev-list args with
> the new choice. =C2=A0The sparse checkout information needs to be upd=
ated
> too.
>
> (So users probably would want to densify a sparse clone with "pull"
> rather than "fetch", as manually updating sparse checkouts may be a
> bit of a hassle.)

What information would you send to the server to request new pack in
sparse clone? Currently we send all commit tips. rev-list has a notion
to subtract commit trees. I don't know if it can "add" or "subtract"
tree prefix though.
--=20
Duy
