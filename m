From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/17] Remove assumptions about refname lifetimes
Date: Mon, 20 May 2013 12:28:29 +0200
Message-ID: <CALKQrgfpAqWESDrjE5po+XPvK+xft=PVwDXr3E7BU28jdDRcZA@mail.gmail.com>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 20 12:28:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeNKa-0001Nw-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 12:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481Ab3ETK2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 06:28:36 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:62245 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab3ETK2f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 06:28:35 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeNKT-00092P-DC
	for git@vger.kernel.org; Mon, 20 May 2013 12:28:33 +0200
Received: from mail-oa0-f45.google.com ([209.85.219.45])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeKnR-0006xH-Q4
	for git@vger.kernel.org; Mon, 20 May 2013 09:46:17 +0200
Received: by mail-oa0-f45.google.com with SMTP id j6so7515778oag.18
        for <git@vger.kernel.org>; Mon, 20 May 2013 03:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0wYSmDgg0lNIvC9pl3TNWLQQWoACrqy/jYrcBgmuuo8=;
        b=doXCFs3w1M7+Q7S3Lg2ozm0fc9cODywkHpg+ahr7pAs7VEvdha7/5szsTLsQSumw12
         cnM/5Jo6eRAh8fU1gjxo96heGs8bCQmOWL+jc2SsGWOLG/QjDNh638XZ0VzXoEw9P0pa
         bstONPUDTQeEXnfo70+rsHEkwxKkodoG4WESx364L1DowEo58qpEL1HV/j1GIkHCZiZg
         w0slfNWFAIOCkXiMzJf9XAyldNlZ5AiB2pI7lKdqTk1Cbbu52Ef9BAB3zMMikQfuCXIm
         7AWT4xNDFhw1NQC4mGwBlOt6iWFnMsXLWonRyMV4JwH7JG5JNI5ammAgg4YCUrmCV1EQ
         sMUw==
X-Received: by 10.60.142.7 with SMTP id rs7mr15119377oeb.106.1369045709631;
 Mon, 20 May 2013 03:28:29 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Mon, 20 May 2013 03:28:29 -0700 (PDT)
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224952>

On Sun, May 19, 2013 at 10:26 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Recently a number of race conditions related to references have been
> discovered.  There is likely to be a two-pronged solution to the
> races:
>
> * For traditional, filesystem-based references, there will have to be
>   more checks that the ref caches are still up-to-date at the time of
>   their use (see, for example, [1]).  If not, the ref cache will have
>   to be invalidated and reloaded.  Assuming that the invalidation of
>   the old cache includes freeing its memory, such an invalidation will
>   cause lots of refname strings to be freed even though callers might
>   still hold references to them.
>
> * For server-class installations, filesystem-based references might
>   not be robust enough for 100% reliable operation, because the
>   reading of the complete set of references is not an atomic
>   operation.  If another reference storage mechanism is developed,
>   there is no reason to expect the refnames strings to have long
>   lifetimes.

(Sorry for going slightly off-topic and returning to the general
discussion on how to resolve the race conditions...)

For server-class installations we need ref storage that can be read
(and updated?) atomically, and the current system of loose + packed
files won't work since reading (and updating) more than a single file
is not an atomic operation. Trivially, one could resolve this by
dropping loose refs, and always using a single packed-refs file, but
that would make it prohibitively expensive to update refs (the entire
packed-refs file must be rewritten for every update).

Now, observe that we don't have these race conditions in the object
database, because it is an add-only immutable data store.

What if we stored the refs as a tree object in the object database,
referenced by a single (loose) ref? There would be a _single_ (albeit
highly contentious) file outside the object database that represent
the current state of the refs, but hopefully we can guarantee
atomicity when reading (and updating?) that one file. Transactions can
be done by:
 1. Recording the tree id holding the refs before starting manipulation.
 2. Creating a new tree object holding the manipulated state.
 3. Re-checking the tree id before replacing the loose ref. If
unchanged: commit, else: rollback/error out.

All readers would trivially have access to a consistent refs view,
since the state of the entire refs hierarchy is held in the tree id
read from that single loose ref.

It seems to me this should be somewhat less prohibitively expensive
than maintaining all refs in a single packed-refs file. That said, we
do end up producing a few new objects for every single ref update,
most of which would be thrown away by a future "gc". This might bog
things down, but I'm not sure how much.

I'm sure someone must have had this idea before (although I don't
remember this alternative being raised at the Git Merge conference),
so please enlighten me as to why this won't work... ;)

...Johan


PS: Keeping reflogs is just a matter of wrapping the ref tree in a
commit object using the previous state of the ref tree as its parent.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
