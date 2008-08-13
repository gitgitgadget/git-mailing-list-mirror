From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: git-filter-branch behavior
Date: Wed, 13 Aug 2008 15:41:42 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808131533320.10800@harper.uchicago.edu>
References: <e0b44a890808130914oced739cy2aaf54aebfcfcbce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Neu <david@davidneu.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:42:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTNBH-0003ci-7b
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbYHMUlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716AbYHMUlv
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:41:51 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:48176 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbYHMUlu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:41:50 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7DKfnct007937;
	Wed, 13 Aug 2008 15:41:49 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7DKfnHr011192;
	Wed, 13 Aug 2008 15:41:49 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <e0b44a890808130914oced739cy2aaf54aebfcfcbce@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92268>

Hello,

David Neu wrote:

> Running
> 
> git-filter-branch --tree-filter 'rm -rf subdir/' -- --all
> 
> as shown below seems to leave empty commits
> corresponding to subdir/ in the tree.  Is this the expected
> behavior?  If so is there a command to remove the empty
> commits?

The following is probably overkill, but it is what I would do.
It's completely untested.  If you'd prefer to do things by hand
instead, my only advice is that using grafts with filter-branch
might be easier than rebase -i.

-- snipsnip --
# prune-empty-commits - filter-branch filter to avoid boring commits
#
# Usage: git-filter-branch --tree-filter <something> \
# 		--commit-filter 'prune-empty-commits "$@"' -- <refs>
# Public domain.

interesting=

test "$#" -eq 1 && interesting=t

committree=$1
shift

for sha1 in "$@"
do
	test z"$sha1" = z-p && continue
	map "$sha1" | while read parent
	do
		parenttree=$(git log -1 --pretty=format:%T "$parent")
		test "$committree" != "$parenttree" &&
			interesting=t
		test -n "$interesting" && break
	done
	test "-n interesting" && break
done

test -n "$interesting" && git commit-tree "$@" || skip_commit "$@"
