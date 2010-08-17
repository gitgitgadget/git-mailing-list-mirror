From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] updating examples/git-merge (plus a builtin/merge fix)
Date: Tue, 17 Aug 2010 01:51:47 -0500
Message-ID: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 08:53:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlG3E-000548-Di
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 08:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab0HQGxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 02:53:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51023 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab0HQGxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 02:53:30 -0400
Received: by yxg6 with SMTP id 6so2281295yxg.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 23:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=orRJj8T0IbB71lMgqWNtCWNG5sKK4z76d1mCmfRSHO4=;
        b=SintI14czd0ImC7/YJhticwQy5RbW8OGVtODPxAdEiNxZLh78Ta57Z7Ab5t6wmX9tA
         hXNifVF0tbAW6KNAO1Tg4vTvcQvmbElLPhs6o204Rz0ZHQx3AIiewZGAyxv/X1YNFLrI
         cey/g5qu3uKRhuLilMgI9P1O8xjgEMhbVkaRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=nqJ9i7zj7FLUlQaPFOaQhLRkTOZI2b+PefbmVo2l2wCyStrB+TthutvKzhJOP3sMOh
         cxUGwwoch185t3spJrKGWSrjjs0fR2ldk7EG/cXNrzxOspJw4e8QaZ7sKc9OfMZjk0sj
         Wmm9UvxWwnIersKkpI3cqFCGirpJhf8lH4Kqc=
Received: by 10.150.143.8 with SMTP id q8mr6628060ybd.379.1282028009101;
        Mon, 16 Aug 2010 23:53:29 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u42sm7488587yba.0.2010.08.16.23.53.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 23:53:28 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153703>

While preparing to make some minor "git merge" changes, I noticed that
the old merge script does not pass all tests any more.  Since it can
be easier to prototype in shell and then port to C, I think that is
worth fixing.

Of course this is not urgent at all.

Patch 1 fixes a minor bug that the scripted implementation does not
suffer from, illustrated by the test "merge early part of c2" from
t7600-merge.sh.

The underlying problem is a subtlety in the resolve_ref() API (from
v0.99.8~13, Use resolve_ref() to implement read_ref(), 2005-09-30):
the "reading" argument to resolve_ref() should usually be true, but
that is not obvious to newcomers.

Patches 2-7 are minor test changes.  They are early in the series
to give flexibility about when to merge them.

Patches 8-10 expose functionality used by merge when handling octopus
merges.  merge-base --octopus is get_octopus_merge_bases(), used to
provide basis arguments when running the "git merge-octopus" command.
Of course the latter does not care about its basis arguments, but
that is a topic for another series.  merge-base --independent is
reduce_refs(), used to reduce the parent list when --no-ff is not
in use.

These are analagous to show-branch --merge-base and
show-branch --independent but are slower and can be used with more
than 25 refs.

Patch 11 exposes the functionality from fmt-merge-msg needed to
implement merge --log -m.

Patches 12 and later are ports of various patches to builtin/merge.c.
I did the bare minimum to make tests pass. :)

Patches are against jn/merge-renormalize~2 (rerere: migrate to
parse-options API) from pu, because without that,
"rerere --rerere-autoupdate" does not work.

Thoughts?

Jonathan Nieder (24):
  merge: do not mistake (ancestor of) tag for branch
  t7600 (merge): modernize style
  t7600 (merge): do not launch gitk for --debug
  t7600 (merge): check reflog entry
  t7600 (merge): test merge from branch yet to be born
  t6010 (merge-base): modernize style
  t6200 (fmt-merge-msg): style nitpicks
  Documentation: add a SEE ALSO section for merge-base
  merge-base --octopus to mimic show-branch --merge-base
  merge-base --independent to print reduced parent list in a merge
  fmt-merge-msg -m to replace subject line
  merge script: --squash, --ff from unborn branch are errors
  merge script: tweak unmerged files message to match builtin
  merge script: refuse to merge during merge
  merge script: improve log message subject
  merge script: merge -X<option>
  merge script: allow custom strategies
  merge script: forbid merge -s index
  merge script: handle -m --log correctly
  merge script: handle many-way octopus
  merge script: --ff-only to disallow true merge
  merge script: handle --no-ff --no-commit correctly
  merge script: notice @{-1} shorthand
  merge script: learn --[no-]rerere-autoupdate

 Documentation/git-fmt-merge-msg.txt |    9 +-
 Documentation/git-merge-base.txt    |   34 +++-
 builtin/fmt-merge-msg.c             |   18 ++-
 builtin/merge-base.c                |   44 ++++-
 builtin/merge.c                     |    2 +-
 contrib/examples/git-merge.sh       |  115 ++++++++---
 t/t6010-merge-base.sh               |  358 +++++++++++++++++++--------------
 t/t6200-fmt-merge-msg.sh            |  306 ++++++++++++++--------------
 t/t7600-merge.sh                    |  385 +++++++++++++++--------------------
 9 files changed, 705 insertions(+), 566 deletions(-)
