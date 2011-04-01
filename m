From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Proposed design of fast-export helper
Date: Fri, 1 Apr 2011 11:44:38 +0530
Message-ID: <20110401061434.GA4469@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 08:16:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5XeR-0005pv-Jz
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 08:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab1DAGQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 02:16:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62958 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab1DAGPz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 02:15:55 -0400
Received: by iwn34 with SMTP id 34so3155671iwn.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=PwhABO/B0CwriKMox0cTAJhickrUilVS/nwSf+vbBps=;
        b=ZRZIPhGDIyMjM0u9v+0ihVOD/WkMhk0HEbEOsDUljf1lhUdlSPiXqZ04g8qPzo2Ep6
         dlQwf/GfDG6IIa6Fxsq4RqtfR367QKWHfTiZJfKouq+/3fG4gJ9GSsv1T/xroPG0pIHt
         UEQ21aEG+5kHPC8F4WDbXQRiGA0BcpE+m1i34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=GNfp8hcEbZQief7TUCMVU4XUOTYkAmZUQPxf42gL0X8LFy7vRck4+0rnlKHv6mIF6d
         uIiYn7xzGAraWwDPWWTu6FPe0SJ+J4lG9Zu+4b6/boRDDkeQJ16BU3mn44OUDcrBawsQ
         Wxb+3g3U3irXpwW+MVlawLU6FuaOv8uMV/pWU=
Received: by 10.43.64.9 with SMTP id xg9mr4815020icb.102.1301638554455;
        Thu, 31 Mar 2011 23:15:54 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id g16sm1236594ibb.54.2011.03.31.23.15.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 23:15:53 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170551>

Hi Jonathan,

(+CC: Git List, Junio)

This is the proposed design for a new "fast-export helper library".
Normally, this would be an RFC patch; however, I'm not happy with the
design, and I'd like some input before starting off.

The Problem
-----------
svn-fi, a program to convert a git-fast-import stream to
a Subversion dumpfile, has hit a dead-end [1].  This is because it
doesn't know how to handle any `<dataref>` except 'inline' (this
appears inside `filemodify`, `notemodify`, `ls` and `cat-blob`
commands).

The other two kinds of `<dataref>` that exporters can produce are:
1. A mark reference (`:<idnum>`) set by a prior `blob` command
2. A full 40-byte SHA-1 of an existing Git blob object.

The most naive solution will involve modifying svn-fi to persist blobs
in-memory as soon as it sees one after a `blob` command (this is the
approach that git2svn uses).  However, this solution is both expensive
in memory and highly unscalable.  Also, svn-fi's job is lightweight
parsing and conversion from one format to another- I don't want to
clutter it up with this additional complexity.

The other alternative that svn-fi currently uses: --inline-blobs [2].
This is a modification to the git-fast-export so that it only ever
produces inlined blobs.  However, this has severe drawbacks, the main
one being that every exporter must implement it for it to become
accepted.  You also pointed out another problem: One blob may be
referenced multiple times in the same stream, especially when dealing
with cherry-picks and rebases (when branch support is added to
svn-fi); writing it out explicitly that many times will pollute the
stream unnecessarily large with a lot of redundant data.  In the best
case, this can simply be a way to hint the git-fast-export to minimize
the work that the helper has to do.

Junio suggested using a fast-import-filter that can convert a
fast-import stream from the current format to one that contains only
inlined blobs [3].  The final proposal for the implementation differs,
because I don't like the idea of having to parse the data twice and do
the same error handling in two different places (svn-fi and the
fast-import-filter).

The library's API
-----------------
I've thought of building a sort of library which applications can link
to. The API is as follows:
int write_blob(unit32_t, char *, size_t, FILE *);
int fetch_blob_mark(unit32_t, struct strbuf *);
int fetch_blob_sha1(char *sha1, struct strbuf *); /* sha1[20] */

The svn-fi parser should call write_blob when it encounters some data
that it wants to persist. The arguments are:

1. A mark using which the blob can be recalled using fetch_blob_mark
(optional: use 0 to omit).
2. A terminator character in the case of delimited format. Should be
NULL when the format is non-delimited.
3. In the case of the delimited format, the size of the delimeter
itself.  Otherwise, the size of the blob itself.
4. The FILE * to parse the blob from, which is already seeked to the
right position and ready to parse.

The library then parses this data and dumps it into a storage backend
(described later) after computing its SHA1.

fetch_blob_mark and fetch_blob_sha1 can then be used to fetch blobs
using their mark or SHA1.  Fetching blobs using their mark should be
O(1), while locating the exact SHA1 will require a bisect of sorts:
slightly better than O(log (n)).

How the library works
---------------------
It maintains an sorted list of (SHA1, off_t, off_t) triplets in a
buffer along with a 256-entry fanout table (call this blob_index) --
this is mmap'ed, and only munmap'ed at the end of the program.  When
write_blob is invoked, the blob is read from the FILE, and its SHA1 is
computed.  Then it is written to another big buffer (call this
blob_buffer) after an inexpensive zlib deflate along with its deflated
size, and its (SHA1, offset1, offset2) is written to the blob_index --
the first number refers to the blob_buffer number (there are many
blob_buffers), and the second offset refers to the offset within that
blob_buffer.  No dobut, this is an expensive table to maintain, but we
don't have a choice in the matter -- there's nothing in the spec
preventing a dataref from referring to blobs using their marks and
SHA1s interchangably.

For marks, there is another marks_buffer which stores (uint32_t,
off_t, off_t) triplets.

So, what do you think?

-- Ram

[1]: http://thread.gmane.org/gmane.comp.version-control.git/170290
[2]: http://thread.gmane.org/gmane.comp.version-control.git/170290/focus=170292
[3]: http://thread.gmane.org/gmane.comp.version-control.git/165237/focus=165289
