From: Jeff King <peff@peff.net>
Subject: Re: git-svn -- out of memory
Date: Mon, 16 Feb 2009 10:37:45 -0500
Message-ID: <20090216153745.GA22886@coredump.intra.peff.net>
References: <1234794220.676511.4320.nullmailer@beryx.hq.kred>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, normalperson@yhbt.net,
	git@vger.kernel.org
To: "Alfred M. Szmidt" <ams@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:39:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ5Yy-0001tp-4g
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 16:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbZBPPhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 10:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbZBPPhs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 10:37:48 -0500
Received: from peff.net ([208.65.91.99]:54493 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbZBPPhr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 10:37:47 -0500
Received: (qmail 20151 invoked by uid 107); 16 Feb 2009 15:38:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Feb 2009 10:38:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2009 10:37:45 -0500
Content-Disposition: inline
In-Reply-To: <1234794220.676511.4320.nullmailer@beryx.hq.kred>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110192>

On Mon, Feb 16, 2009 at 03:23:40PM +0100, Alfred M. Szmidt wrote:

> ams@trillian:~/# git --version
> git version 1.6.2.rc1
> ams@trillian:~/# git svn clone REPO -T trunk -b branches -t tags
> [...]
> fatal: Out of memory? mmap failed: Cannot allocate memory
> hash-object -w --stdin-paths: command returned error: 128
> 
> Nope, behaves the same way.

Hmm. It would help to know what object it is failing on. I assume you
repo is too large to be easily shared? If not, can you try instrumenting
hash-object with the patch below and seeing which file it is barfing on?

I'd be curious to see the size of the file (in case it is >2G and we
have another signed integer problem) and its position in the list (in
case we are leaking memory and you are hitting a system limit).

---
diff --git a/hash-object.c b/hash-object.c
index 37e6677..20371d0 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -44,6 +44,7 @@ static void hash_stdin_paths(const char *type, int write_objects)
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
+		fprintf(stderr, "debug: hashing %s\n", buf.buf);
 		hash_object(buf.buf, type, write_objects, buf.buf);
 	}
 	strbuf_release(&buf);
