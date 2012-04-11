From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] fast-import doc: deadlock avoidance in bidirectional mode
Date: Wed, 11 Apr 2012 12:17:07 -0500
Message-ID: <20120411171707.GD4248@burratino>
References: <20120411143249.GA4140@burratino>
 <7v1ununtb2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:17:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI1Ae-0004tw-10
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 19:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714Ab2DKRRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 13:17:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47172 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020Ab2DKRRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 13:17:22 -0400
Received: by iagz16 with SMTP id z16so1522237iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZMm0JreudX7MnWuasKFOYeQPh4AAK4PrhmrvR2Tlojs=;
        b=aIiAtthL7C8wz8WRB/2sFZljEr5GTFIXnceKzOluotHTUNTlznEv+wM5Kka6SlItoc
         fYjqQW5SHQ6Ykm7cLwuq2HaNBFI4BdkeJ29aIbWHBumdUoeEX0EBhMxXeGAo254W5gJp
         4nuMwvLHA+kIOKVnf5nqyg3LL97mCtNafvKgTW8y+ObxqRKJFOd+PYZCYHjs/cyqGH33
         UB6NVfbauRIrje0Z9Ub7AUIdNr5Owc7QDbHnE7cB1DodQ0ytUp/PEEDJpdAlfJrLTuT8
         T3IAeNpz4gVAL/JHgi8QTnB67uOepreSr4z4GYfWxU+z7Q1nNENUv+bun8Tx4qAiuDJw
         0NSw==
Received: by 10.50.197.132 with SMTP id iu4mr6714069igc.4.1334164641918;
        Wed, 11 Apr 2012 10:17:21 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id en3sm9215050igc.2.2012.04.11.10.17.09
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 10:17:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1ununtb2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195219>

If fast-import's command pipe and the frontend's cat-blob/ls response
pipe are both filled, there can be a deadlock.  Luckily all existing
frontends consume any pending cat-blob/ls responses completely before
writing the next command.

Document the requirements so future frontend authors and users can be
spared from the problem, too.  It is not always easy to catch that
kind of bug by testing.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Does this essentially connect the frontend and fast-import via
> bidirectional pipes?  How is the flow control and deadlock avoidance
> supposed to happen

fast-import never asks the frontend for information, which makes life a
little simpler.

Typically the interaction works just as you described:

 1. Frontend sends "ls" or "cat-blob" request and flushes it, and then
    blocks waiting for the response.

 2. Once fast-import catches up with pending commands, it sends its
    response to the "cat-blob response" pipe.

    (If the pipe does not have enough room, it fills the pipe and then
    blocks until some more room is available.  If the reader has
    closed the pipe, it assumes the import was botched and just exits.)

 3. Only once the frontend has received its response, it moves on and
    starts to send new commands.

A frontend can be more clever than that and use slack to queue some
extra commands, as long as the author understands:

 i.  fast-import is not guaranteed to make any progress in consuming
     its input until the "cat-blob response" pipe has been drained.

 ii. the command pipe is not guaranteed to be able to hold extra
     commands when fast-import is not consuming its input.  Probably
     512 bytes (_POSIX_PIPE_BUF) will fit but I don't know how
     portable that is to other fast-import backends so let's say the
     limit is 1 byte.

In other words, in practice it's best not to rely on the extra space
at all.

How about this?

 Documentation/git-fast-import.txt |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index ec6ef311..0ea649f4 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -942,6 +942,12 @@ This command can be used anywhere in the stream that comments are
 accepted.  In particular, the `cat-blob` command can be used in the
 middle of a commit but not in the middle of a `data` command.
 
+While in some cases the 'cat-blob' result will fit in the pipe buffer,
+allowing fast-import to continue processing additional commands, this
+is not guaranteed.  Frontends must consume the cat-blob response
+completely before performing any writes to fast-import that might
+block.
+
 `ls`
 ~~~~
 Prints information about the object at a path to a file descriptor
@@ -975,7 +981,12 @@ Reading from a named tree::
 
 See `filemodify` above for a detailed description of `<path>`.
 
-Output uses the same format as `git ls-tree <tree> {litdd} <path>`:
+While in some cases the 'ls' response will fit in the pipe buffer,
+allowing fast-import to continue processing additional commands, this
+is not guaranteed.  Frontends must consume the ls response completely
+before performing any writes to fast-import that might block.
+
+The 'ls' response uses the same format as `git ls-tree <tree> {litdd} <path>`:
 
 ====
 	<mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT <path> LF
-- 
1.7.10
