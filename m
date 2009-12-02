From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How do you best store structured data in git repositories?
Date: Wed, 2 Dec 2009 16:17:10 -0500
Message-ID: <32541b130912021317y705d1d4cj28e230a3e727df2e@mail.gmail.com>
References: <1259788097.3590.29.camel@nord26-amd64>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: sebastianspublicaddress@googlemail.com
X-From: git-owner@vger.kernel.org Wed Dec 02 22:17:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFwZs-0001op-J6
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 22:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbZLBVRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 16:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbZLBVRZ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 16:17:25 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:50864 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbZLBVRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 16:17:24 -0500
Received: by yxe17 with SMTP id 17so548753yxe.33
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 13:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Mi5eo1hHb+MxdM7gqUw6sBHxjEqt2Y8gBBrPxW9aIJk=;
        b=v6ks3D6lj5dxlaN6j6EaSV61Uq8XGDod9OjORdAKFrFkkIFus4XMsM1Z7XJqBR9XZ5
         44Z0JXipkz1h4oQofxUs14s7xHq7Oe+mwcrwMeYJLf6yAtJl7kWWiJjN76F34yJR58sX
         ALckpgBditEI3IVQIB9E0AkgAFsrqNQTpQCJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fvK5h+YTpXvmdeIKjqrBcFWEt7YZzomfV36vvx08VFtXmaPu80zAfcykzZb0M4yPb+
         TYLoN7pRCDVB4j7GCOoS1tBy1kKNHXp8ATBdbssHiK40wZ+iz/iwSjuV1XVWfYXfiqR5
         HGDZ0e+37Oe/5gvJC43VkmkjlJLK4wn/ZQwu4=
Received: by 10.150.120.8 with SMTP id s8mr1227295ybc.185.1259788650251; Wed, 
	02 Dec 2009 13:17:30 -0800 (PST)
In-Reply-To: <1259788097.3590.29.camel@nord26-amd64>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134403>

On Wed, Dec 2, 2009 at 4:08 PM, Sebastian Setzer
<sebastianspublicaddress@googlemail.com> wrote:
> Do you store everything in a single file and configure git to use
> special diff- and merge-tools?
> Do you use XML for this purpose?

XML is terrible for most data storage purposes.  Data exchange, maybe,
but IMHO the best thing you can do when you get XML data is to put it
in some other format ASAP.

As it happens, I've been doing a project where we store a bunch of
stuff in csv format in git, and it works fairly well.  We made a
special merge driver that can merge csv data (based on knowing which
columns should be treated as the "primary key").

> Do you take care that the contents of your file is as stable as possible
> when it's saved or do you let your diff tools cope with issues like
> reordering, reassignment of identifiers (for example when identifiers
> are offsets in the file), ...?

A custom merge driver is better, by far, than the builtin ones (which
were designed for source code) if you have any kind of structured data
that you don't want to have to merge by hand.

That said, however, you should still try to make your files as stable
as possible, because:

- If your program outputs the data in random order, it's just being
sloppy anyway

- 'git diff' doesn't work usefully otherwise (for examining the data
and debugging)

Of course, all bets are off if your file is actually binary; merging
and diffing is mostly impossible unless you use a totally custom
engine.  And if your file contains byte offsets, then it's a binary
file, no matter that it looks like in your text editor.  Adding a byte
in the middle would make such a file entirely nonsense, which is not
an attribute of a text file.

> Do you store one object/record per file (with filename=id, for example
> with GUID-s) and hope that git will not mess them up when it merges
> them?
>
> Do you store records as directories, with very small files which contain
> single attributes (because records can be considered sets of
> key-value-pairs and the same applies to directories)? Do you configure
> git to do a scalar merge on non-text "attributes" (with special file
> extensions)?

In git, you have to balance between its different limitations.  If you
have a tonne of small files, it'll take you longer to retrieve a large
amount of data.  If you have one big huge file, git will suck a lot of
memory when repacking.  The best is to achieve a reasonable balance.

One trick that I've been using lately is to split large files
according to a rolling checksum:
http://alumnit.ca/~apenwarr/log/?m=200910#04

This generally keeps diffs useful, but keeps individual file sizes
down.  Obviously the implementation pointed to there is just a toy,
but the idea is sound.

> When you don't store everything in a single, binary file: Do you use git
> hooks to update an index for efficient queries on your structured data?
> Do you update the whole index for every change? Or do you use git hashes
> to decide which segment of your index needs to be updated?

We keep a separate index file that's not part of git.  When the git
repo is updated, we note which rows have changed, then update the
index.

Avery
