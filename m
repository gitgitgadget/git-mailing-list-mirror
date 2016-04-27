From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] mmap(win32): avoid copy-on-write when it is
 unnecessary
Date: Wed, 27 Apr 2016 08:43:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604270834440.2896@virtualbox>
References: <cover.1461335463.git.johannes.schindelin@gmx.de> <3e2a45e60e2905f52f962604cf19a0e5e39b9b1b.1461335463.git.johannes.schindelin@gmx.de> <571FB923.9040808@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sven Strickroth <email@cs-ware.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 08:43:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avJBr-0007hj-GG
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 08:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbcD0GnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 02:43:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:55326 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbcD0GnK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 02:43:10 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LmNHK-1bVByB4Axm-00ZtlS; Wed, 27 Apr 2016 08:43:02
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <571FB923.9040808@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Cc/ZlQj8Y0HmLlGvSZ2cnLwe8o5RkUElSdNxELDcGnhPJba5nHW
 r7NZdwyy/y9QgbQE5wW1KsM1j3C0C6VbgP6d8FDZSwOH7MW3YZQvKbbmEdXjcjJdRYmJE8P
 LEPPYBPbz892LwP8CE1sQkhvCt6l+F+GgGLj20w1BFqAjOqLzxuNIgNRCk4Ik1inJwSq+tL
 AkC7rslrAZwQ8Ytv+EH/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g8K/ZoBkHSI=:nuLBHhTbnGlInx/nJSQ9IH
 eIMOlX9Ndkg6m8Tuwgl75fRqDQNyZB5Sue/XXuLI/SztDPWepoELYG8kXhjXuYB+ri6k8Txc3
 6gI0FvWX5n23K8Ftn1gGk+J036JG0ksiz085v5THV/PpyzdjyxBc3RbW7KjrOH6lR5u4h+BZJ
 OfgHC1GhDWHuW+ch2TXgzcNtAqfl3bN/sBzUYwTFjCEdn45oKZ8wZZ44nRSTpjOAE/Tqcnl2P
 KbNPZJOtZWi6/3TIPO3RYBnBHVQZ6siyTWtUkYxk5D1PxFq0ov5B3POTS6GJ76vlw+vO4oIbZ
 Eo27cGb5rK7oktzfhvM/9M3RmLXQY9mGWgHluG4UGxaeZdlimoNLf3aN1NrgCLuASdlPX8mOy
 MeKDv/RjdNioTU2yoTM0z4Ismp4d2MBsU6EVfNV3g8n+DnpBGY008ngnUsuXUf/igqJlVULtG
 5DTMBEPU6CBLO2AOnaOS3XXYyCflYM++gpCukLXjGNn4cQCygdWo/a9mOQ/iwlZ+0QV49FZsu
 Pohs/7VERfxPaRJ1pbUagxSjVhZfbzzt6RlWYymqqkSAXQok2PjvTuDrW/PTfUqMqWX91AfNn
 2KcTJwkf8/j/OdqSlQKB/ONNUX7N3YpB42GrfyHrDKKAMDrgrQ8i1WDuIEFhG6FoxwSNVK2Pn
 DnYDYl2EG8hgB830j4r2shnyOb8T4Vup6213a/7oSDppcqKOHwTPsb61lmH4tRHWEkxnBy1D5
 /5Dhe2Bh4oZuBGeGo3kR1l5zL5nZJqvZ0RKgXfbk6yAKCkZZ9GXJeDdy358nYa+68YybxNrZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292709>

Hi Hannes,

On Tue, 26 Apr 2016, Johannes Sixt wrote:

> Am 22.04.2016 um 16:31 schrieb Johannes Schindelin:
> > Often we are mmap()ing read-only. In those cases, it is wasteful to map in
> > copy-on-write mode. Even worse: it can cause errors where we run out of
> > space in the page file.
> >
> > So let's be extra careful to map files in read-only mode whenever
> > possible.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   compat/win32mmap.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/compat/win32mmap.c b/compat/win32mmap.c
> > index 3a39f0f..b836169 100644
> > --- a/compat/win32mmap.c
> > +++ b/compat/win32mmap.c
> > @@ -22,14 +22,15 @@ void *git_mmap(void *start, size_t length, int prot, int
> > flags, int fd, off_t of
> >     die("Invalid usage of mmap when built with USE_WIN32_MMAP");
> >
> >   	hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
> > -		PAGE_WRITECOPY, 0, 0, NULL);
> > +		prot == PROT_READ ? PAGE_READONLY : PAGE_WRITECOPY, 0, 0,
> > NULL);
> 
> As long as we use this implementation with MAP_PRIVATE, PAGE_WRITECOPY
> is the right setting. Should we insert a check for MAP_PRIVATE to catch
> unexpected use-cases (think of the index-helper daemon effort)?

I agree, we should have such a check. The line above the `die("Invalid
usage ...")` that you can read as first line in above-quoted hunk reads:

	if (!(flags & MAP_PRIVATE))

So I think we're fine :-)

And yes, I am worrying about the index-helper support, too: I need this
myself, so I will have to make mmap() work for that use case, too. But
that is a story for another day ;-)

> >    if (!hmap) {
> >     errno = EINVAL;
> >     return MAP_FAILED;
> >    }
> >
> > -	temp = MapViewOfFileEx(hmap, FILE_MAP_COPY, h, l, length, start);
> > +	temp = MapViewOfFileEx(hmap, prot == PROT_READ ?
> > +			FILE_MAP_READ : FILE_MAP_COPY, h, l, length, start);
> 
> Same here: FILE_MAP_COPY is the right choice for MAP_SHARED mmaps.

I agree ;-)

> >    if (!CloseHandle(hmap))
> >     warning("unable to close file mapping handle");
> >
> 
> Except for these mental notes, I've no comments on this series. Looks good.

Thanks for reviewing!

Do you think we should add a note to the commit message that we'll have to
do something about this when MAP_PRIVATE is not the only way mmap() will
be used?

I am torn: on the one hand, it is the appropriate thing to do, on the
other hand, it is easy to forget such notes in commit messages. On the
third hand, I hope to find time to work on the index-helper this week,
meaning that I will still know about this when touching
compat/win32mmap.c.

So maybe I can just leave things as are here, and focus on the
index-helper?

Ciao,
Dscho
