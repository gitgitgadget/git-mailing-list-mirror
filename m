From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/6] Stop producing index version 2
Date: Tue, 7 Feb 2012 11:50:54 +0700
Message-ID: <CACsJy8Ayqea75xeFKJNm6iT7GSUGDEfvZD17uEv7ihr4SS2LMg@mail.gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 <1328507319-24687-3-git-send-email-pclouds@gmail.com> <7v4nv4a131.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvtRnmvALcn3vKpYTr3j6ada8iboPjWN3cQnwwKzRvrDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 05:51:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rud1e-0004SH-TI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 05:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538Ab2BGEv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 23:51:26 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44238 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537Ab2BGEvZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 23:51:25 -0500
Received: by wgbdt10 with SMTP id dt10so6921731wgb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 20:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XVlRybWGul2oohoiZ5oDnWu5/YkH5FyqeOnhRej7AlE=;
        b=Z+bvVoRs+luGYe5j/nkWXKCaHeKM+pdKOG9KwgDxRN6NsZj/ar9pQ3rjmhOtKmK0CJ
         qsbOgu8+m94lD1Ntuq230HRZ2CCa8Jsu2n2oQbhZ3KisOxw1WMXkiCWLVrpl66tCi/rk
         u2GeqRdXaW+lu5EBdgrKGhZA1uzSKE8AigBsU=
Received: by 10.181.13.113 with SMTP id ex17mr31668952wid.15.1328590284351;
 Mon, 06 Feb 2012 20:51:24 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Mon, 6 Feb 2012 20:50:54 -0800 (PST)
In-Reply-To: <CAJo=hJvtRnmvALcn3vKpYTr3j6ada8iboPjWN3cQnwwKzRvrDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190138>

On Tue, Feb 7, 2012 at 10:09 AM, Shawn Pearce <spearce@spearce.org> wro=
te:
> 2012/2/5 Junio C Hamano <gitster@pobox.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>>
>>> read-cache.c learned to produce version 2 or 3 depending on whether
>>> extended cache entries exist in 06aaaa0 (Extend index to save more =
flags
>>> - 2008-10-01), first released in 1.6.1. The purpose is to keep
>>> compatibility with older git. It's been more than three years since
>>> then and git has reached 1.7.9. Drop support for older git.
>>
>> Cc'ing this, as I suspect this would surely raise eyebrows of some p=
eople
>> who wanted to get rid of the version 3 format.
>
> Version 3 was a mistake because of the variable length record sizes.
> Saving 2 bytes on some records that don't use the extended flags make=
s
> the index file *MUCH* harder to parse. So much so that we should take
> version 3 and kill it, not encourage it as the default!

Probably too late for that, but it's good to know there are strong
user base for v2.

> <thinking type=3D"wishful" probability=3D"never-happen"
> probably-inflating-flame-from=3D"linus">
>
> I have long wanted to scrap the current index format. I unfortunately
> don't have the time to do it myself. But I suspect there may be a lot
> of gains by making the index format match the canonical tree format
> better by keeping the tree structure within a single file stream,
> nesting entries below their parent directory, and keeping tree SHA-1
> data along with the directory entry. For one thing the index would be
> able to register an empty subdirectory, rather than ignoring them. It
> would also better line up with the filesystem's readdir() handling,
> giving us more sane logic to compare what readdir() tells us exists
> against what the index thinks should be in the same file. And the
> overall index should be smaller, because we don't have to repeat the
> same path/to/a/file/for/every/file/in/that/same/directory/tree.
> Reconstructing the path strings at read time into a flat list should
> be pretty trivial, and still keep the parallel lstat calls running of=
f
> a flat list working well for fast status operations.
>
> </thinking>

Haven't really thought through, but I suppose we could create extended
tree object format (there is info in cache entry that's not in tree
entry), store index in this format, then pack together and store the
pack as part of index file. Append-only access to index would be
possible by appending a new pack of new trees to index) I think with
tree-based index, we could kill a big chunk of code (merging trees and
index together) in unpack_trees(). With further efforts to remove
list-based index usage, we could even kill match_pathspec_depth(),
making tree_entry_interesting() the only function to match patchspec.
But dreams probably never come true.
--=20
Duy
