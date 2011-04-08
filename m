From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposed design of fast-export helper
Date: Fri, 8 Apr 2011 11:03:32 +0530
Message-ID: <20110408053326.GA27332@kytes>
References: <20110401061434.GA4469@kytes>
 <20110407230249.GA20226@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 07:34:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q84L3-0002wq-DB
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 07:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab1DHFe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 01:34:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50191 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1DHFe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 01:34:27 -0400
Received: by iyb14 with SMTP id 14so3146402iyb.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 22:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=s2wftDBcarFV/DFFvd2zI9I/8QFiygzgpiC3EB/ouE4=;
        b=rPMSYt8iE3+/CE8EFnZrZI6thY+ShhfM7k2c+d0XeD0YnOZXkz/phR8+AySQbp1vmz
         4JCLdKMS8DgLBbEq3jYt3tCHRc5xWRNU09IM7fPdKFVSfs5A3hZjbntDReYtdrvTcJyX
         9O9tQmMzV1+5d3PFaswV2ITcTiTRuvx+NYpII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b3h1jMxxPwNlU78CLXDYnMeqkzk8pBN3ZMtb5RA0LvaWb2KUiNnzW45LNx1f6Ei+NN
         kzr6QGtRkEQ0ok8rg8Fe05HSTvayt27oXQ28BKfesokotRTTEVc2ohv0hKb5VQeksXcz
         SF8ZVIqic/KgVAI4/H+w0PCMEckGIQZgm8UmY=
Received: by 10.42.154.131 with SMTP id q3mr2734934icw.465.1302240866249;
        Thu, 07 Apr 2011 22:34:26 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id ww2sm1476793icb.15.2011.04.07.22.34.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 22:34:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110407230249.GA20226@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171105>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> > The other two kinds of `<dataref>` that exporters can produce are:
> > 1. A mark reference (`:<idnum>`) set by a prior `blob` command
> > 2. A full 40-byte SHA-1 of an existing Git blob object.
> 
> The above is very git-specific --- arbitrary foreign vcs-es are
> unlikely to all use 40-byte hashes as <dataref>.  So far I've been
> assuming that a <dataref> is sufficiently "nice" (not containing
> spaces, NULs, quotation marks, or newlines nor starting with a colon).
> 
> It would be better to come up with a more formal rule and document it.

Actually, we need to tighten this <dataref> thing before we build
anything else- it's a nightmare to handle a stream that refers to the
same blob using the mark the first time, the SHA1 the second time, and
the MD5 the third time.  How is our store supposed to know how to
index and retrieve blobs?

Next step: We should find out all the things <dataref> can currently
be, by looking at existing frontend implementation.  Then, we should
come tighten the spec so that it doesn't clobber any of those things.
Also, we should find a way to let the backend know "how" to index/
retrieve a blob -- this is only straightforward in the case of marks.

> I assume the delimited format works as in fast-import's "data" command
> (and only supports blobs ending with LF)?

Yes.  This is actually quite an ugly to support -- We should probably
drop support for this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 2c2ea12..1fb71f7 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -826,8 +826,8 @@ of the next line, even if `<raw>` did not end with an `LF`.
 Delimited format::
 	A delimiter string is used to mark the end of the data.
 	fast-import will compute the length by searching for the delimiter.
-	This format is primarily useful for testing and is not
-	recommended for real data.
+	This format is should only be used for testing; other
+	backends are not required to support this.
 +
 ....
 	'data' SP '<<' <delim> LF


> > fetch_blob_mark and fetch_blob_sha1 can then be used to fetch blobs
> > using their mark or SHA1.  Fetching blobs using their mark should be
> > O(1), while locating the exact SHA1 will require a bisect of sorts:
> > slightly better than O(log (n)).
> 
> http://fanf.livejournal.com/101174.html

Right, but this discussion is now useless, since keys can be just
about anything.

> > How the library works
> 
> I wonder if it would be sensible to make it run as a separate process.
> The upside: writing to and from pipes is easy in a variety of
> programming languages (including the shell), even easier than calling
> C code.  So in particular that would make testing it easier.  But
> performance considerations might outweigh that.

Performance and portability considerations.  Calling semantics will
probably be highly inelegant too, since full-blown bi-directional
communication is necessary.

> I also wonder if it is possible or makes sense to make the API less
> git-specific.  If the buffers were in-memory, something like
> 
> 	set(key, value);
> 	value = get(key);
> 
> would do.  Since they are not, maybe something vaguely like
> 
> 	FILE *f = kvstore_fopen(key, O_WRONLY);
> 	fwrite(value, sz, 1, f);
> 	kvstore_fclose(f);
> 
> 	FILE *f = kvstore_fopen(key, O_RDONLY);
> 	strbuf_fread(&value, SIZE_MAX, f);
> 	kvstore_fclose(f);

I don't like this.  The caller should not have to know about whether
blobs are persisted in-memory or on-disk.  When there are a few small
frequently-used blobs, the key-value might decide to persist them in
memory, and we should allow for this kind of optimization.

> would be something to aim for.  For the getter case, fmemopen is
> portable (in case one wants to just put the value in memory) but
> fopencookie (in case one doesn't) is not, so the idea does not work as
> nicely as one might like.  And it's not quite the right abstraction
> --- for a fast-import backend, I suppose the operations needed are:
> 
>  * get length
>  * dump the value to a caller-specified FILE * or fd
>  * let the caller read the value one chunk or line at a time to
>    transform it (e.g., to escape special characters).
> 
> Is there prior art that this could mimic or reuse (so we can learn
> from others' mistakes and make sure the API feels familiar)?

Kyoto Cabinet, or just any key-value store for that matter.  All prior
discussion related to SHA1 is useless then, because the key can be
just about anything: the only option we have is to implement the
hashtable as a data structure with a very high fanout value like a B+
tree.  Obviously, this will be less efficient than a store which keys
everything using a fixed 20-byte SHA1 -- how much speed are we willing
to trade off for the sake of this simplicity?

-- Ram
