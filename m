From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Proposed design of fast-export helper
Date: Thu, 7 Apr 2011 18:03:19 -0500
Message-ID: <20110407230249.GA20226@elie>
References: <20110401061434.GA4469@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 01:03:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7yEl-0007Ph-Bx
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 01:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664Ab1DGXDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 19:03:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37917 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab1DGXDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 19:03:30 -0400
Received: by yxs7 with SMTP id 7so1228232yxs.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 16:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2YrMcZfApXz2b1gpSIYk92kxkFawOBsJ+OaX7qYkVPA=;
        b=n6IlJdpZV3FjPzXMGl6d5OLn6ZCGflcXqRQaa0QZe1FIK7+/XII5xdMn2KAvZcStpA
         UfQOWQEEmvzpu8Soa3dNAyEYWXwCuCHu6Hraxjz0GMHFZdjcYVqs5FCF9bPUYJNN5fPP
         2A48tyfD+74h31dspD7I4MZntq3LhMsc8lQak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ur46oBpA5AeTuNID/O7LpG5rSBmh8nLPpI7kqWKtWdI840nKNy83nU9noEOZhOX0bf
         HbdCj2uocCarhivT08fraBspoAcjemJfRJN730F+TBe35MRYgFOQnkoYD9pslCkBvXgs
         Q6feaqQ/xEiZjbORiTmzPs9paBGJl9ztFMXwE=
Received: by 10.236.155.163 with SMTP id j23mr1741596yhk.357.1302217409467;
        Thu, 07 Apr 2011 16:03:29 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.sbcglobal.net [69.209.53.77])
        by mx.google.com with ESMTPS id 33sm943192yhl.84.2011.04.07.16.03.26
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 16:03:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110401061434.GA4469@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171091>

Hi,

Ramkumar Ramachandra wrote:

> The other two kinds of `<dataref>` that exporters can produce are:
> 1. A mark reference (`:<idnum>`) set by a prior `blob` command
> 2. A full 40-byte SHA-1 of an existing Git blob object.

The above is very git-specific --- arbitrary foreign vcs-es are
unlikely to all use 40-byte hashes as <dataref>.  So far I've been
assuming that a <dataref> is sufficiently "nice" (not containing
spaces, NULs, quotation marks, or newlines nor starting with a colon).

It would be better to come up with a more formal rule and document it.

> The most naive solution will involve modifying svn-fi to persist blobs
> in-memory as soon as it sees one after a `blob` command (this is the
> approach that git2svn uses).  However, this solution is both expensive
> in memory and highly unscalable.

I suppose it also means trouble with large (>4 GiB) files on 32-bit
architectures.  Of course git proper does not support those anyway.

[...]
> The other alternative that svn-fi currently uses: --inline-blobs [2].
> This is a modification to the git-fast-export so that it only ever
> produces inlined blobs.  However, this has severe drawbacks
[... explanation of drawbacks to relying on "inline" data only ...]
> In the best
> case, this can simply be a way to hint the git-fast-export to minimize
> the work that the helper has to do.

Yes.

> The library's API
> -----------------
> I've thought of building a sort of library which applications can link
> to. The API is as follows:
> int write_blob(unit32_t, char *, size_t, FILE *);
> int fetch_blob_mark(unit32_t, struct strbuf *);
> int fetch_blob_sha1(char *sha1, struct strbuf *); /* sha1[20] */

Hmm.

What the first function does is not obvious without argument names.
I had guessed it would write a blob to file.  More nits:

 - the type of marks in fast-import is uintmax_t (yech) --- they're
   not restricted to 32-bit integers as far as I know.

 - missing "const" before char *. :)

 - lengths of subsets of files should be of type off_t, if we want
   to allow 64-bit lengths on 32-bit architectures.  If this is
   git-specific, it would be more consistent to use "unsigned long".

 - the size that toggles between size of a delimiter and length of
   file seems strange to me.  I'd rather have two separate functions.

 - this requires the frontend to think in terms of git blob object
   names, which doesn't fit well with most applications I'm thinking
   of (think: fast-import backends in C that if written in python
   would use python-fastimport).

I assume the delimited format works as in fast-import's "data" command
(and only supports blobs ending with LF)?

[...]
> The library then parses this data and dumps it into a storage backend
> (described later) after computing its SHA1.

Right, so a nice aspect of this exercise is that the nature of the
key/value store is hidden from the caller.

> fetch_blob_mark and fetch_blob_sha1 can then be used to fetch blobs
> using their mark or SHA1.  Fetching blobs using their mark should be
> O(1), while locating the exact SHA1 will require a bisect of sorts:
> slightly better than O(log (n)).

http://fanf.livejournal.com/101174.html

> How the library works

I wonder if it would be sensible to make it run as a separate process.
The upside: writing to and from pipes is easy in a variety of
programming languages (including the shell), even easier than calling
C code.  So in particular that would make testing it easier.  But
performance considerations might outweigh that.

I also wonder if it is possible or makes sense to make the API less
git-specific.  If the buffers were in-memory, something like

	set(key, value);
	value = get(key);

would do.  Since they are not, maybe something vaguely like

	FILE *f = kvstore_fopen(key, O_WRONLY);
	fwrite(value, sz, 1, f);
	kvstore_fclose(f);

	FILE *f = kvstore_fopen(key, O_RDONLY);
	strbuf_fread(&value, SIZE_MAX, f);
	kvstore_fclose(f);

would be something to aim for.  For the getter case, fmemopen is
portable (in case one wants to just put the value in memory) but
fopencookie (in case one doesn't) is not, so the idea does not work as
nicely as one might like.  And it's not quite the right abstraction
--- for a fast-import backend, I suppose the operations needed are:

 * get length
 * dump the value to a caller-specified FILE * or fd
 * let the caller read the value one chunk or line at a time to
   transform it (e.g., to escape special characters).

Is there prior art that this could mimic or reuse (so we can learn
from others' mistakes and make sure the API feels familiar)?

Hope that helps,
Jonathan
