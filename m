From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 00/28] Store references hierarchically in cache
Date: Fri, 28 Oct 2011 18:37:13 +0530
Message-ID: <CALkWK0=Hsq_yg1Vyr-3_jf9n=WcB_XNYRQa0SEhSWD5VxKBXQg@mail.gmail.com>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Oct 28 15:07:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJm9t-0005mR-6a
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 15:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273Ab1J1NHh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 09:07:37 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48001 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab1J1NHf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 09:07:35 -0400
Received: by eye27 with SMTP id 27so3494487eye.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=iugUGTVCRkhrDPxyVVB5LoRqXSwRvQwlIFPzmLei5ds=;
        b=jwIDnxgQOosrFKLffL0xVJ3CGfDx8k1TruhkaJITZwc5tEr5Ogb7+wcjGNRGTHm8z9
         PZDUCY+hVICDc7Ho///vBZnSfvXIV4groJaq/083CADeS8nXbuNnOLeQTa+sCoFUL7sn
         o7r/FKbaVUnt9DlS6+aEW92XfS5JpXCNHXW9M=
Received: by 10.216.160.72 with SMTP id t50mr950824wek.10.1319807254194; Fri,
 28 Oct 2011 06:07:34 -0700 (PDT)
Received: by 10.216.52.197 with HTTP; Fri, 28 Oct 2011 06:07:13 -0700 (PDT)
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184405>

Hi Michael,

Michael Haggerty writes:
> Therefore, this patch series changes the data structure used to store
> the reference cache from a single array of pointers-to-struct into a
> tree-like structure in which each subdirectory of the reference
> namespace is stored as an array of pointers-to-entry and entries can
> be either references or subdirectories containing more references.

Very nice! I like the idea. Can't wait to start reading the series.

> =C2=A0* refs/replace is almost *always* needed even though it often
> =C2=A0 =C2=A0doesn't even exist. =C2=A0Thus the presence of many loos=
e references
> =C2=A0 =C2=A0slows down *many* git commands for no reason whatsoever.

Was this one of your primary inspirations for writing this series?

> =C2=A0* When a new reference is created, is_refname_available() is ca=
lled
> =C2=A0 =C2=A0to see whether there is another another reference whose =
name
> =C2=A0 =C2=A0conflicts with the new one. =C2=A0Currently this loads a=
nd iterates
> =C2=A0 =C2=A0through *all* references. =C2=A0But there are only a few=
 refnames that
> =C2=A0 =C2=A0can possibly conflict; for example, given the refname
> =C2=A0 =C2=A0"refs/heads/foo/bar", the only possible conflicts are wi=
th
> =C2=A0 =C2=A0"refs/heads/foo" and "refs/heads/foo/bar/*". =C2=A0There=
fore it is
> =C2=A0 =C2=A0silly to load and iterate through the whole refname hier=
archy.

Hm, the original design does sound quite sub-optimal.  I suppose it
was written when Git didn't have so many refs in so many
subdirectories.

> =C2=A0* "git for-each-ref" is capable of searching a subtree of the
> =C2=A0 =C2=A0references. =C2=A0But currently this causes all referenc=
es to be
> =C2=A0 =C2=A0loaded.

Ah.  I was using git for-each-ref to write a filter-branch like thing
earlier, and I was wondering why it was so slow.

> * the time to create a new branch goes from 180 ms to less than 10 ms
> =C2=A0(my test resolution only includes two decimal places) and the t=
ime
> =C2=A0to checkout a new branch does the same.

I'm interested in seeing how the callgraph changed.  Assuming you used
Valgrind to profile it, could you publish the outputs?

> * the time for a "git filter-branch" of all commits (which used to
> =C2=A0scale like N^2) goes from 4 hours to 13 minutes. =C2=A0(Since
> =C2=A0filter-branch necessarily *creates* lots of loose references, t=
he
> =C2=A0savings are also there if the references are originally packed.=
)

This is seriously awesome.

> The efficiency gains are such that some operations are now faster wit=
h
> loose references than with packed references; however, some operation=
s
> with packed references slow down a bit.

Curiously, why do operations with packed references slow down?  (I'll
probably find out in a few minutes after reading the series, but I'm
asking anyway because it it's very non-obvious to me now)

> These changes do not increase the amount of space per reference neede=
d
> for the reference cache, but they do add one similarly-sized entry fo=
r
> each subdirectory (for each of loose and packed). =C2=A0I don't think=
 that
> the space increase should be significant in any reasonable situation.
>
> After these changes, there is a benefit to sharding the reference
> namespace, especially for loose references.

Hm, I wonder what this means for Git hosting services.

> Patches 11-24 change most of the internal functions to work with
> "struct ref_entry *" (namely the kind of ref_entry that holds a
> directory of references) instead of "struct ref_dir *". =C2=A0The rea=
son
> for this change it to allow these functions access to the "flag" and
> "name" fields that are stored in ref_entry and thereby avoid having t=
o
> store redundant information in "struct ref_dir" (which would increase
> the size of *every* ref_entry because of its presence in the union).

Hm, I was wondering why the series was looking so intimidating.  Is it
not possible to squash all (or atleast some) of these together?

> From: Michael Haggerty <mhagger@alum.mit.edu>

Nit: Can't you configure your email client to put this in the "From: "
header of your emails?

Thanks for the interesting read.

-- Ram
