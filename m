From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: How do I get the contents of a directory in fast-import
Date: Fri, 15 Jan 2016 20:59:59 -0500
Message-ID: <jwvd1t270zv.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <jwvio3d7152.fsf-monnier+gmane.comp.version-control.git.user@gnu.org>
	<20160115223922.GB32081@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 03:01:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKGAv-0005Fl-Bk
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 03:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbcAPCA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 21:00:57 -0500
Received: from plane.gmane.org ([80.91.229.3]:35845 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbcAPCAP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 21:00:15 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aKG9x-0004Ub-IR
	for git@vger.kernel.org; Sat, 16 Jan 2016 03:00:09 +0100
Received: from 23-91-143-239.cpe.pppoe.ca ([23.91.143.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Jan 2016 03:00:09 +0100
Received: from monnier by 23-91-143-239.cpe.pppoe.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Jan 2016 03:00:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 23-91-143-239.cpe.pppoe.ca
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cancel-Lock: sha1:hgLlcKZMJD6YPKjt3u1Rn7nTaVI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284237>

>> So how do I get a directory listing from fast-import, i.e.
>> like I can get with "git cat-file -p", but without having to fork
>> a separate git process?
> I'm not sure I understand your use case exactly, but is the directory
> listing you want part of the newly-added objects from fast-import, or
> does it already exist in the branches you are collecting from?

For the most important cases, the relevant revision already exists
before fast-import, yes.

> If the latter, I wonder if a separate "cat-file --batch" process could
> give you what you need (it's a separate process, but you can start a

I'm not sure exactly how "git cat-file --batch" works internally
(whether it tries to keep active revisions, like fast-import does), but
I've indeed used it successfully (tho for files).

> single process and make many queries of it; I assume your desire not to
> add an extra process is to avoid the overhead).

The overhead of starting a new process is one part, but another is the
overhead of re-reading the refs (I can have tens of thousands of
branches in my repository), etc..

> But I think it won't pretty-print trees for you; it will give you the
> raw tree data

Indeed.

> (which I imagine is what you are getting from cat-blob, too).

Actually no, "cat-blob" gives an error instead:

    fatal: Object 2ca1672d50c9dbfe582dc53af3c7ce9891a7a664 is a tree but a blob was expected.

> I'm not sure that's actually documented anywhere (it was part of
> the original revisions of git, and hasn't changed since). But it is
> basically:

>   tree = tree_entry*
>   tree_entry = mode SP path NUL sha1
>   mode = ascii mode, in octal (e.g., "100644")
>   path = <any byte except NUL>*
>   sha1 = <any byte>{20}
>   SP = ascii space (0x20)
>   NUL = 0-byte

Ah, thanks.  It'd be great if cat-blob could return this instead of
signalling an error.

> So it is pretty simple to parse.

My program is written in /bin/sh so parsing the above is actually rather
inconvenient, but it's much better than just getting an error.


        Stefan
