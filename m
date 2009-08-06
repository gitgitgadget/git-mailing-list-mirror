From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Hash Tables
Date: Thu, 6 Aug 2009 10:53:37 +0200
Message-ID: <200908061053.38739.trast@student.ethz.ch>
References: <4A7A5D9C.7000604@googlemail.com> <4A7A6756.4010305@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Philip Herron <herron.philip@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 10:55:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYyjo-00040S-JN
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 10:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbZHFIxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 04:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbZHFIxw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 04:53:52 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:38160 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754474AbZHFIxv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 04:53:51 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 6 Aug
 2009 10:53:50 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 6 Aug
 2009 10:53:50 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <4A7A6756.4010305@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125054>

Philip Herron wrote:
> 
> Question still stands is the hashing function [in hash.c], which one and why?

In the spirit of teaching you to fish...

First you'll want to find out where the original users of this code
were.  So you run

  git blame -- hash.c

and see that most of the lines come from 9027f53 (Do linear-time/space
rename logic for exact renames, 2007-10-25).  So you can then look at
this commit:

  git show 9027f53c

Aha, it says

    In the expectation that we will indeed do the same hashing trick for the
    general rename case, this code uses a generic hash-table implementation
    that can be used for other things too.  In fact, we might be able to
    consolidate some of our existing hash tables with the new generic code
    in hash.[ch]

and further down in the patch

+       hash = hash_filespec(filespec);
+       pos = insert_hash(hash, entry, table);

and right above that

+static unsigned int hash_filespec(struct diff_filespec *filespec)
+{
+       unsigned int hash;
+       if (!filespec->sha1_valid) {
+               if (diff_populate_filespec(filespec, 0))
+                       return 0;
+               hash_sha1_file(filespec->data, filespec->size, "blob", filespec-
+       }
+       memcpy(&hash, filespec->sha1, sizeof(hash));
+       return hash;
+}

See?

As for the *why*, presumably because all of git assumes two objects
with the same SHA1 are indeed the same file; so we can later make the
same optimisation again:

+                       if (hashcmp(one->sha1, two->sha1))
+                               continue;

And then, as we've already computed the SHA1, any subset of it is as
good a hash as anything else; it'll be uniformly distributed.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
