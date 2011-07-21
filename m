From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git commit generation numbers
Date: 21 Jul 2011 16:27:22 -0400
Message-ID: <20110721202722.3765.qmail@science.horizon.com>
References: <m3mxg7sasa.fsf@localhost.localdomain>
Cc: anthonyvdgent@gmail.com, david@lang.hm, git@vger.kernel.org,
	hordp@cisco.com, nico@fluxnic.net, spearce@spearce.org,
	torvalds@linux-foundation.org
To: jnareb@gmail.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Thu Jul 21 22:27:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjzqE-0002wd-4o
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 22:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab1GUU1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 16:27:24 -0400
Received: from science.horizon.com ([71.41.210.146]:32594 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752991Ab1GUU1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 16:27:24 -0400
Received: (qmail 3766 invoked by uid 1000); 21 Jul 2011 16:27:22 -0400
In-Reply-To: <m3mxg7sasa.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177620>

> There is also another issue that I have mentioned, namely incomplete
> clones - which currently means shallow clone, without access to full
> history.

As far as history walking is concerned, you can just consider "missing
parent" the same as "no parent" and start the generation numbers at 0.
As long as you recompute

> Nb. grafts are so horrible hack that I would be not against turning
> off generation numbers if they are used.

Yeah, but it's not too miserable to add support (the logic is very similar
to replace objects), and then you would be able to have the history walking
code depend on the presence of generation numbers.  (The "load the cache"
function would regenerate it if necessary.)

Only do this if you already have support for "no generation numbers" in
the history walking code for (say) loose objects.

> In the case of replace objects you need both non-replaced and replaced
> DAG generation numbers.

Yes, the cache validity/invalidation criteria are the tricky bit.
Honestly, this is where the code gets ugly, not computing and storing
the generation numbers.


One thought on an expanded generation number cache:

There are many git operations that use ONLY the commit DAG, and do not
actually use any information from the commits other than their hashes
and parent pointers.  The ones that come to mind are rev-parse, rev-list,
describe, name-rev, and merge-base.

These could be sped up if, instead of just generation numbers, we kept
a complete cached copy of the commit DAG, so the commit objects didn't
have to be uncompressed and parsed.

This could be provided by an extended form of generation number cache.
In addition to listing the generation number of each commit, it
would list all the ancestors (by file offset rather than hash, for
compactness).  Then simple commit walking could load this cache and
avoid unpacking commit objects from packs.

A compact implementation would abuse the flexibility of generation numbers
to make them serve double duty.  They would be used as offsets into a
table of parent pointers.  By keeping the table topologically sorted,
the offsets would satisfy the requirements for generation numbers, but
would be unique, and there would be additional gaps when a commit had
multiple parents.

The parent pointers would themselves be 31-bit offsets into the table of
SHA-1 hashes, with the msbit meaning "this commit has multiple parents,
also look at the following table entry".  (If we use offset 0 to mean
"no parents", it might be more convenient to have the offset point to
the *end* of the run of parents rather than the beginning, so "following"
would be earlier in the file, but that's an implementation detail.)

I'm assuming that 2^31 commits having (in aggregate) 2^32 parents would
be enough for the time being.  As a local cache, it can be extended
with a software upgrade.  There's no need to ever have support for two
formats in any given release; just notice that the cache format is wrong,
blow it away, and regenerate it.
