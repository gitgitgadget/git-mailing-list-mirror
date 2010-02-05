From: Jon Nelson <jnelson@jamponi.net>
Subject: git gc / git repack not removing unused objects?
Date: Fri, 5 Feb 2010 13:45:41 -0600
Message-ID: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 20:46:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdU86-0005iW-V7
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 20:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab0BETqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 14:46:05 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:65301 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab0BETqC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 14:46:02 -0500
Received: by ey-out-2122.google.com with SMTP id 25so227834eya.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 11:46:01 -0800 (PST)
Received: by 10.216.163.81 with SMTP id z59mr1823626wek.95.1265399161249; Fri, 
	05 Feb 2010 11:46:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139070>

[Using git 1.6.4.2]

In one repo I have (136G objects directory, fully packed) I'm having
some trouble.
I've run git-gc --prune=now, git repack -Adf, and so on a half-dozen
times and each time I do so it gets bigger, not smaller.
Setting that aside for the moment, however, I've run into a stranger problem.

So I use "git verify-pack -v > gvp.out" and "sort -k3nr < gvp.out |
head -n 20" to find the top 20 largest blobs.
So I have a blob, b32c3d8e8e24d8d3035cf52f606c2873315fe2b8, and now I
want to know what tree (or trees) it is in, so I try this:


for i in $( git branch -a | sed -e 's/\*//g' | grep -v branch ); do if
git ls-tree -l -r -t $i | grep
b32c3d8e8e24d8d3035cf52f606c2873315fe2b8 > /dev/null; then echo $i;
fi; done

The results: no branch or tree appears to contain that blob.

So I tried a different approach:

for i in $( grep tree gvp.out  | awk '{ print $1 }' ); do if git
ls-tree $i | grep b32c3d8e8e24d8d3035cf52f606c2873315fe2b8 >
/dev/null; then echo $i; fi ; done

This time, I find (at least) one tree
(d813af1537358496ca34958bbff08b87590607bf) with the blob.
But which branches might that tree appear in? None.

For each branch, I ran "git ls-tree -l -r -t" and saved the output in
a file (one per branch).
Then I grepped each file for the tree (
(d813af1537358496ca34958bbff08b87590607bf) - no luck.
I grepped each file for the blob (b32...) - no luck.

The results seem to suggest that I have packed trees which reference
blobs, but that the trees themselves are not referenced in any branch
and therefore I would expect that they would be pruned.


-- 
Jon
