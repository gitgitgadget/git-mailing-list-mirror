From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/6] Stop producing index version 2
Date: Mon, 6 Feb 2012 19:09:15 -0800
Message-ID: <CAJo=hJvtRnmvALcn3vKpYTr3j6ada8iboPjWN3cQnwwKzRvrDA@mail.gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 <1328507319-24687-3-git-send-email-pclouds@gmail.com> <7v4nv4a131.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 04:09:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RubR9-0003vW-H3
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 04:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab2BGDJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 22:09:37 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43533 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab2BGDJg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 22:09:36 -0500
Received: by daed14 with SMTP id d14so21845dae.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 19:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2IlBWBsDKXX2Y4iq57J2ECJIiP/eta2f+mBEDjCa08E=;
        b=G3Iw1sSMAVywA308jVtqHgYT+zhRKGf7rtPc+B4VvuW1voKCxZZAzIsUjxQdszYzS1
         DwWn3dwO5g359nLCGCyUFYsgNYN8jYxSy1W3ps3e2wFmOJfEN4ya8Et97cCdSwtALveM
         wBS1MWI6nZsmTeHQcRPMObbjuc8gmZfNJFPJQ=
Received: by 10.68.234.199 with SMTP id ug7mr53271547pbc.6.1328584176079; Mon,
 06 Feb 2012 19:09:36 -0800 (PST)
Received: by 10.68.50.10 with HTTP; Mon, 6 Feb 2012 19:09:15 -0800 (PST)
In-Reply-To: <7v4nv4a131.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190132>

2012/2/5 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> read-cache.c learned to produce version 2 or 3 depending on whether
>> extended cache entries exist in 06aaaa0 (Extend index to save more f=
lags
>> - 2008-10-01), first released in 1.6.1. The purpose is to keep
>> compatibility with older git. It's been more than three years since
>> then and git has reached 1.7.9. Drop support for older git.
>
> Cc'ing this, as I suspect this would surely raise eyebrows of some pe=
ople
> who wanted to get rid of the version 3 format.

Version 3 was a mistake because of the variable length record sizes.
Saving 2 bytes on some records that don't use the extended flags makes
the index file *MUCH* harder to parse. So much so that we should take
version 3 and kill it, not encourage it as the default!

IMHO, when these extended flags were added to make version 3 the
following should have happened:

- All records use the larger structure format with 4 bytes for the
flags, not 2 bytes.

- Change the trailing padding after the name to be a *SINGLE* \0 byte,
and do not pad out to an 8 byte boundary.

Both make it really hard to process the file, and the latter happens
only for direct mmap usage, which we don't do anymore.


We also have to consider the EGit and JGit user base as part of the
ecosystem. We can't just kill a file format because git-core has been
capable of reading its alternative since some arbitrary YYYY-MM-DD
release date. We need to also consider when did some other major tools
catch up and also support this format?

=46WIW JGit released index version 3 support in version 0.9.1, which
shipped Sep 15, 2010. JGit/EGit were more than 2 years behind here.


<thinking type=3D"wishful" probability=3D"never-happen"
probably-inflating-flame-from=3D"linus">

I have long wanted to scrap the current index format. I unfortunately
don't have the time to do it myself. But I suspect there may be a lot
of gains by making the index format match the canonical tree format
better by keeping the tree structure within a single file stream,
nesting entries below their parent directory, and keeping tree SHA-1
data along with the directory entry. For one thing the index would be
able to register an empty subdirectory, rather than ignoring them. It
would also better line up with the filesystem's readdir() handling,
giving us more sane logic to compare what readdir() tells us exists
against what the index thinks should be in the same file. And the
overall index should be smaller, because we don't have to repeat the
same path/to/a/file/for/every/file/in/that/same/directory/tree.
Reconstructing the path strings at read time into a flat list should
be pretty trivial, and still keep the parallel lstat calls running off
a flat list working well for fast status operations.

</thinking>
