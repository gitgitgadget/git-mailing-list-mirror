From: Junio C Hamano <gitster@pobox.com>
Subject: Re: integrity of a repository
Date: Sat, 15 Mar 2008 20:54:51 -0700
Message-ID: <7v4pb7migk.fsf@gitster.siamese.dyndns.org>
References: <20080315132645.GC17579@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 16 04:56:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jajyt-0000Sr-2d
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 04:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbYCPDzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 23:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbYCPDzJ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 23:55:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbYCPDzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 23:55:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA745198E;
	Sat, 15 Mar 2008 23:55:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7BE50198D; Sat, 15 Mar 2008 23:55:01 -0400 (EDT)
In-Reply-To: <20080315132645.GC17579@ins.uni-bonn.de> (Ralf Wildenhues's
 message of "Sat, 15 Mar 2008 14:26:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77346>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> I am aware that git provides integrity of a commit (and thus, a branch
> head) via its sha, which covers both the tree and its history.
>
> But what about the integrity of a git repository as a whole?
>
> For example, if I have a set of branches, create a file listing
>   branchname  sha-of-head
>
> for each such branch, and hash that file, and also 'git gc --prune',
> can I then be sure that not only does the repository contain exactly
> what I want (namely all history of all branches), but also that it does
> not contain any other material (say, stuff that may not be disclosed)?
>
> Would I need the in file listing all local and remote branches?
> What about all heads in .git/*HEAD (such as FETCH_HEAD)?

That's an incoherent question ;-)  First you talk about snapshotting all
the refs, as if you would want to make sure you can detect anybody moving
the tips of branches after that happens, but then you talk about something
completely unrelated.

A freestanding git repository with a work tree consists of a set of refs
(that includes your local branches in refs/heads, tags in refs/tags, and
remote tracking branches refs/remotes but not limited to these three
categories.  Anything under refs/ is a ref by definition, and it includes
the stash), reflogs, the index, HEAD (which is typically a pointer into
refs/heads/ somewhere but can directly be pointing at a commit), and an
object store.  An object store of a repository that is not corrupt
contains all objects that are reachable from refs, reflogs, the index and
the HEAD, and "gc --prune" will remove everything else.

So the answer to the question in your later part of the message is that:

 - FETCH_HEAD, ORIG_HEAD and MERGE_HEAD do not protect anything from
   getting pruned;

 - Objects that are not reachable from the tip of branches will remain in
   the object store after pruning, if they are reachable from non-branch
   refs (e.g. tags and the stash), reflogs, or the index.
