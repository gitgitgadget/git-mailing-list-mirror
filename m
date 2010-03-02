From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Remote operations synchronization, and hooks
Date: Wed, 3 Mar 2010 01:43:21 +0200
Message-ID: <20100302234320.GA13446@Knoppix>
References: <m3r5o3ux5x.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed Mar 03 00:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmbkW-0004Rg-7Z
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 00:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757998Ab0CBXn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 18:43:27 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:33028 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988Ab0CBXnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 18:43:25 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 11CDFEBCE4;
	Wed,  3 Mar 2010 01:43:24 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A02FB405127; Wed, 03 Mar 2010 01:43:24 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 828DC27D83;
	Wed,  3 Mar 2010 01:43:21 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <m3r5o3ux5x.fsf@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141424>

On Tue, Mar 02, 2010 at 12:09:46AM -0500, Eli Barzilay wrote:
> Is there any kind of synchronization with remote operations?  That is,
> can there be any race conditions if multiple clients connect?  I'm
> assuming that such operations are safe, but I couldn't find a place
> with a concrete description.

With respect to Git itself, each ref update is atomic and happens as
client intended or does not happen at all. Ref updates within push
are independent. 

Thus, Git remote ops themselves are safe from races (with exception of
forced push, where race condition can lead to other client's changes
being lost).

> More specifically, I'm wondering about writing hooks (specifically, a
> `post-receive' hook), and it would make things convenient if I knew
> that it was called synchronously.

AFAIK, there can be multiple post-receives running simulataneously.

> And a related question: is there somewhere a summary of how the hooks
> are called for each operation?  The githooks man page specifies some
> of the relationships but a list with how each operation perform its
> work would be much more convenient to read through.  For example, if a
> remote update had a list of operations with "grab lock" in the
> beginning and a "release lock" after running the `post-receive' hook,
> then I wouldn't have the above question.

There are no such locks. I think the operation sequence goes as follows
(reading the source code):

1) List of modifications to do is received.
2) If additional objects are needed, pack is received and installed/unpacked.
3) pre-receive is run. If it fails, whole push is aborted.
4) For each ref pushed, do:
4a) update hook for that ref is run. If it fails, skip the ref.
4b) Do atomic compare-and-swap on ref.
5) Run post-receive hook.
6) Run post-update hook.

No locking there.

>  Also, it's unclear how
> `post-update' is related to `post-receive' -- there's one comment in
> the man entry for the former that makes it sound like it is supersedes
> by the latter, but there's nothing explicit about it.

They both execute after push has completed. Interfaces are different but
that's about it. post-receive gets old and new values, post-update only
ref names.

-Ilari
