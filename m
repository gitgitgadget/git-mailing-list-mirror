From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: RFC: New reference iteration paradigm
Date: Thu, 31 Mar 2016 18:13:33 +0200
Message-ID: <56FD4CAD.3070100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:20:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfKv-0005zy-3I
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbcCaQUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:20:41 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47426 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752961AbcCaQUk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 12:20:40 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Mar 2016 12:20:40 EDT
X-AuditID: 12074412-51bff700000009f7-f3-56fd4cb04c46
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id AE.7E.02551.0BC4DF65; Thu, 31 Mar 2016 12:13:37 -0400 (EDT)
Received: from [192.168.69.130] (p548D6127.dip0.t-ipconnect.de [84.141.97.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2VGDYbl026313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 31 Mar 2016 12:13:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqLvR52+YwaNL/BbzN51gtOi60s1k
	0dB7hdniR0sPswOLx7PePYweFy8peyx4fp/d4/MmuQCWKG6bpMSSsuDM9Dx9uwTujOZ355gL
	lklXNN6sbWC8IdrFyMkhIWAi8eHUHcYuRi4OIYGtjBIn2rcwQTjnmCQudzcxglSJCOhK7Hp2
	lQ3EZhYolnix6hALiM0GFF/U08wEYgsL6EnM2v8UzOYV0JZYNG8BK4jNIqAqseT0b7C4qECI
	xLZ131ghagQlTs58wgIxU13iz7xLzBC2vMT2t3OYJzDyzkJSNgtJ2SwkZQsYmVcxyiXmlObq
	5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5ihISh0A7G9SflDjEKcDAq8fBeSP4TJsSaWFZc
	mXuIUZKDSUmU97LX3zAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzywOAX4k1JrKxKLcqHSUlz
	sCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4L3sDdQoWJSanlqRlplTgpBm4uAEGc4lJVKc
	mpeSWpRYWpIRD4qw+GJgjIGkeID2aoLtLS5IzAWKQrSeYlSUEuc1BkkIgCQySvPgxsKSyytG
	caAvhXlNQbbzABMTXPcroMFMQIO3avwCGVySiJCSamBs/sNVfvz7eZYXJ+S3diofdNoy8XAI
	68bs+zcXLrLUWnrp8VunCazf7ii3czYu8+87Iy4l8u51gaEay80ErqoPPIa6W5cve/7WaCrD
	5vtFMq3xV99r6LBYJG1b+yxz1xYvnv2My8XZxFTd/pfLRRZaBzsf4f/7q3fVvxIe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290409>

Currently the way to iterate over references is via a family of
for_each_ref()-style functions. You pass some arguments plus a callback
function and cb_data to the function, and your callback is called for
each reference that is selected.

This works, but it has two big disadvantages:

1. It is cumbersome for callers. The caller's logic has to be split
   into two functions, the one that calls for_each_ref() and the
   callback function. Any data that have to be passed between the
   functions has to be stuck in a separate data structure.

2. This interface is not composable. For example, you can't write a
   single function that iterates over references from two sources,
   as is interesting for combining packed plus loose references,
   shared plus worktree-specific references, symbolic plus normal
   references, etc. The current code for combining packed and loose
   references needs to walk the two reference trees in lockstep,
   using intimate knowledge about how references are stored [1,2,3].

I'm currently working on a patch series to transition the reference code
from using for_each_ref()-style iteration to using proper iterators.

The main point of this change is to change the base iteration paradigm
that has to be supported by reference backends. So instead of

> int do_for_each_ref_fn(const char *submodule, const char *base,
>                        each_ref_fn fn, int trim, int flags,
>                        void *cb_data);

the backend now has to implement

> struct ref_iterator *ref_iterator_begin_fn(const char *submodule,
>                                            const char *prefix,
>                                            unsigned int flags);

The ref_iterator itself has to implement two main methods:

> int iterator_advance_fn(struct ref_iterator *ref_iterator);
> void iterator_free_fn(struct ref_iterator *ref_iterator);

A loop over references now looks something like

> struct ref_iterator *iter = each_ref_in_iterator("refs/tags/");
> while (ref_iterator_advance(iter)) {
>         /* code using iter->refname, iter->oid, iter->flags */
> }

I built quite a bit of ref_iterator infrastructure to make it easy to
plug things together quite flexibly. For example, there is an
overlay_ref_iterator which takes two other iterators (e.g., one for
packed and one for loose refs) and overlays them, presenting the result
via the same iterator interface. But the same overlay_ref_iterator can
be used to overlay any two other iterators on top of each other.

If you are interested, check out my branch wip/ref-iterators on my
GitHub repo [4]. That branch is based off of a version of David Turner's
patch series (i.e., it will have to be rebased at some point). But it
all works and the early part of the patch series is pretty well polished
I think. In fact, the later patches are optional; there is no special
reason to rewrite client code wholesale to use the new reference
iteration API, because the old API continues to be supported (but is now
built on the new API).

Feedback is welcome!

Michael

[1]
https://github.com/git/git/blob/90f7b16b3adc78d4bbabbd426fb69aa78c714f71/refs/files-backend.c#L1665-L1719
[2]
https://github.com/git/git/blob/90f7b16b3adc78d4bbabbd426fb69aa78c714f71/refs/files-backend.c#L582-L608
[3]
https://github.com/git/git/blob/90f7b16b3adc78d4bbabbd426fb69aa78c714f71/refs/files-backend.c#L610-L680
[4] https://github.com/mhagger/git
