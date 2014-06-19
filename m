From: Jeff King <peff@peff.net>
Subject: [PATCH v2] dropping manual malloc calculations
Date: Thu, 19 Jun 2014 17:16:59 -0400
Message-ID: <20140619211659.GA32412@sigill.intra.peff.net>
References: <20140618200000.GA22994@sigill.intra.peff.net>
 <20140618200133.GA23057@sigill.intra.peff.net>
 <xmqq7g4dj1cn.fsf@gitster.dls.corp.google.com>
 <20140619090532.GB1009@sigill.intra.peff.net>
 <xmqq38f0j13u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:17:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxjhk-0002Q5-G5
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965566AbaFSVRD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2014 17:17:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:47762 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965515AbaFSVRB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:17:01 -0400
Received: (qmail 16356 invoked by uid 102); 19 Jun 2014 21:17:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:17:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:16:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38f0j13u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252183>

On Thu, Jun 19, 2014 at 09:49:41AM -0700, Junio C Hamano wrote:

> If we twist the logic behind the 'mkpathdup' name a little bit,
> perhaps we can call it sprintf_dup or something.  That is, "sprintf
> wants a fixed preallocated piece of memory to print into, and we
> relieve the callers of having to do so", perhaps?

Right, that is the "dup" I was thinking of. Anyway, I think Ren=C3=A9's
"xstrfmt" is my favorite of the suggestions, and you seemed to like it,
too. Here is a re-roll using that name.

The first two patches are the same except for the name change. The rest
are more applications of it (and other techniques) found by grepping fo=
r
"malloc.*strlen". The diffstat is very encouraging, and I think the
results are much more readable (in addition to being more obviously
correct). The last two also fix real "bugs", but I doubt either is a
problem in practice.

    builtin/apply.c         |  4 +--
    builtin/fetch.c         |  9 ++----
    builtin/fmt-merge-msg.c |  7 ++---
    builtin/name-rev.c      |  5 +---
    builtin/receive-pack.c  |  5 +---
    builtin/show-branch.c   | 10 +++----
    environment.c           | 12 +++-----
    http-push.c             | 24 +++++-----------
    http-walker.c           |  6 ++--
    match-trees.c           |  9 ++----
    merge-recursive.c       | 53 ++++++++++++++++++++---------------
    merge.c                 | 42 +++++++++------------------
    remote.c                |  6 +---
    sequencer.c             |  9 ++----
    sha1_name.c             |  5 +---
    shell.c                 |  6 +---
    strbuf.c                | 19 +++++++++++++
    strbuf.h                |  9 ++++++
    unpack-trees.c          | 17 ++++-------
    walker.c                | 18 ++++++------
    20 files changed, 117 insertions(+), 158 deletions(-)

  [01/10]: strbuf: add xstrfmt helper
  [02/10]: use xstrfmt in favor of manual size calculations
  [03/10]: use xstrdup instead of xmalloc + strcpy
  [04/10]: use xstrfmt to replace xmalloc + sprintf
  [05/10]: use xstrfmt to replace xmalloc + strcpy/strcat
  [06/10]: setup_git_env: use git_pathdup instead of xmalloc + sprintf
  [07/10]: sequencer: use argv_array_pushf
  [08/10]: merge: use argv_array when spawning merge strategy
  [09/10]: walker_fetch: fix minor memory leak
  [10/10]: unique_path: fix unlikely heap overflow
