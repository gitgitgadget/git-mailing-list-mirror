From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 0/3] merge -Xindex-only
Date: Mon, 8 Jul 2013 17:44:26 +0200
Message-ID: <87k3l1gip1.fsf@linux-k42r.v.cablecom.net>
References: <cover.1373219466.git.trast@inf.ethz.ch>
	<51DAD8F2.5070008@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:44:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwDcL-00020U-Kr
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441Ab3GHPoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 11:44:30 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:43371 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab3GHPo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 11:44:29 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 8 Jul
 2013 17:44:25 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 8 Jul 2013 17:44:26 +0200
In-Reply-To: <51DAD8F2.5070008@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 08 Jul 2013 17:21:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229869>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> [Resend because of address confusion in replied-to email.]
>
> On 07/07/2013 08:00 PM, Thomas Rast wrote:
>> I recently looked into making merge-recursive more useful as a modular
>> piece in various tasks, e.g. Michael's git-imerge and the experiments
>> I made in showing evil merges.
>> 
>> This miniseries is the extremely low-hanging fruit.  If it makes a
>> good first step for git-imerge, perhaps it can go in like this.  It's
>> not a big speedup (about 2.2s vs 2.4s in a sample conflicting merge in
>> git.git), but it does feel much cleaner to avoid touching the worktree
>> unless actually necessary.
>> 
>> Otherwise it's probably not worth it just yet; for what I want to do
>> with it, we need some more reshuffling of things.
>
> Interesting.
>
> For git-imerge, it would be nice to speed up merges by skipping the
> working tree updates.  10% might not be so noticeable, but every little
> bit helps :-)
>
> But the killer benefit would be if git-imerge could do some of its
> automatic merge-testing and autofilling in the background while the user
> is resolving conflicts in the main index and working tree.
>
> Is it possible to use this option with an alternate index file (e.g.,
> via the GIT_INDEX_FILE environment variable)?  Can it be made to leave
> other shared state (e.g., MERGE_HEAD) alone?  If so, maybe it's already
> there.

GIT_INDEX_FILE yes, that one works out of the box.

I think for the shared state, the following is a (probably) ridiculously
unsupported yet magic way of achieving this:

  mkdir -p unshared/.git
  cd unshared/.git
  for f in ../../.git/*; do
    case "$f" in
      *HEAD | index)
        cp "$f" .
        ;;
      *)
        ln -s "$f" .
        ;;
    esac
  done

That gives you a repository that propagates ref changes and object
writing, but does not propagate changes to index, HEAD, FETCH_HEAD or
MERGE_HEAD.  Which might just be what you need?

Note that as far as I'm concerned, this is a live handgrenade.  It could
blow up in your face at any time, but it probably has its applications...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
