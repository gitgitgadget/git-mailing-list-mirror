From: Jeff King <peff@peff.net>
Subject: Re: Fast enumeration of objects
Date: Mon, 22 Jun 2015 04:35:44 -0400
Message-ID: <20150622083543.GA12259@peff.net>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 10:35:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6xCq-0000Rk-MT
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 10:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbbFVIft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 04:35:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:49703 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754836AbbFVIfr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 04:35:47 -0400
Received: (qmail 9429 invoked by uid 102); 22 Jun 2015 08:35:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 03:35:47 -0500
Received: (qmail 6644 invoked by uid 107); 22 Jun 2015 08:35:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 04:35:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 04:35:44 -0400
Content-Disposition: inline
In-Reply-To: <1434914431-7745-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272318>

On Sun, Jun 21, 2015 at 08:20:30PM +0100, Charles Bailey wrote:

> I performed some test timings of some different commands on a clone of
> the Linux kernel which was completely packed.

Thanks for timing things. I think we can fairly easily improve a bit on
what you have here. I'll go through my full analysis, but see the
conclusions at the end.

> 	$ time git rev-list --all --objects |
> 		cut -d" " -f1 |
> 		git cat-file --batch-check |
> 		awk '{if ($3 >= 512000) { print $1 }}' |
> 		wc -l
> 	958
> 
> 	real    0m30.823s
> 	user    0m41.904s
> 	sys     0m7.728s
> 
> list-all-objects gives a significant improvement:
> 
> 	$ time git list-all-objects |
> 		git cat-file --batch-check |
> 		awk '{if ($3 >= 512000) { print $1 }}' |
> 		wc -l
> 	958
> 
> 	real    0m9.585s
> 	user    0m10.820s
> 	sys     0m4.960s

That makes sense; of course these two are not necessarily producing the
same answer (they do in your case because it's a fresh clone, and all of
the objects are reachable). I think that's an acceptable caveat.

You can speed up the second one by asking batch-check only for the parts
you care about:

  git list-all-objects |
  git cat-file --batch-check='%(objectsize) %(objectname)' |
  awk '{if ($1 >= 512000) { print $2 }}' |
  wc -l

That dropped my best-of-five timings for the same test down from 9.5s to
7.0s. The answer should be the same. The reason is that cat-file will
only compute the items it needs to show, and the object-type is more
expensive to get than the size[1].

Replacing awk with:

  perl -alne 'print $F[0] if $F[1] > 512000'

dropped that to 6.0s. That mostly means my awk sucks, but it is
interesting to note that not all of the extra time is pipe overhead
inherent to this approach; your choice of processor matters, too.

If you're willing to get a slightly different answer, but one that is
often just as useful, you can replace the "%(objectsize)" in the
cat-file invocation with "%(objectsize:disk)". That gives you the actual
on-disk size of the object, which includes delta and zlib compression.
For 512K, that produces very different results (because files of that
size may actually be text file). But for most truly huge files, they
typically do not delta or compress at all, and the on-disk size is
roughly the same.

That only shaves off 100-200 milliseconds, though.

[1] If you are wondering why the size is cheaper than the type, it is
    because of deltas. For base objects, we can get either immediately
    from the pack entry's header. For a delta, to get the size we have
    to open the object data; the expected size is part of the delta
    data. So we pay the extra cost to zlib-inflate the first few bytes.
    But finding the type works differently; the type in the pack header
    is OFS_DELTA, so we have to walk back to the parent entry to find
    the real type.  If that parent is a delta, we walk back recursively
    until we hit a base object.

    You'd think that would also make %(objectsize:disk) much cheaper
    than %(objectsize), too. But the disk sizes require computing a
    the pack revindex on the fly, which takes a few hundred milliseconds
    on linux.git.

> skipping the cat-filter filter is a lesser but still significant
> improvement:
> 
> 	$ time git list-all-objects -v |
> 		awk '{if ($3 >= 512000) { print $1 }}' |
> 		wc -l
> 	958
> 
> 	real    0m5.637s
> 	user    0m6.652s
> 	sys     0m0.156s

That's a pretty nice improvement over the piped version. But we cannot
do the same custom-format optimization there, because "-v" does not
support it. It would be nice if it supported the full range of cat-file
formatters.

I did a hacky proof-of-concept, and that brought my 6.0s time down to
4.9s.

I also noticed that cat-file doesn't do any output buffering; this is
because it may be used interactively, line by line, by a caller
controlling both pipes. Replacing write_or_die() with fwrite in my
proof-of-concept dropped the time to 3.7s.

That's faster still than your original (different machines, obviously,
but your times are similar to mine):

> The old filter-objects could do the size filter a little be faster, but
> not by much:
> 
> 	$ time git filter-objects --min-size=500k |
> 		wc -l
> 	958
> 
> 	real    0m4.564s
> 	user    0m4.496s
> 	sys     0m0.064s

This is likely caused by your use of sha1_object_info(), which always
computes the type. Switching to the extended form would probably buy you
another 2 seconds or so.

Also, all my numbers are wall-clock times. The CPU time for my 3.7s time
is actually 6.8s. Whereas doing it all in one process would probably
require 3.0s or so of actual CPU time.

So my conclusions are:

  1. Yes, the pipe/parsing overhead of a separate processor really is
     measurable. That's hidden in the wall-clock time if you have
     multiple cores, but you may care more about CPU time. I still think
     the flexibility is worth it.

  2. Cutting out the pipe to cat-file is worth doing, as it saves a few
     seconds. Cutting out "%(objecttype)" saves a lot, too, and is worth
     doing. We should teach "list-all-objects -v" to use cat-file's
     custom formatters (alternatively, we could just teach cat-file a
     "--batch-all-objects" option rather than add a new command).

  3. We should teach cat-file a "--buffer" option to use fwrite. Even if
     we end up with "list-all-objects --format='%(objectsize)'" for this
     task, it would help all the other uses of cat-file.

-Peff
