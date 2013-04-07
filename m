From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: commit-message attack for extracting sensitive data from rewritten
 Git history
Date: Mon, 8 Apr 2013 00:17:51 +0100
Message-ID: <CAFY1edbNPjs5JGOPRxzB+ie4w=SvR+rUeePhsEnpr0tWtZpeHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5qP-0000sy-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934491Ab3DGXRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 19:17:52 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38031 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934482Ab3DGXRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 19:17:52 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so6199847iec.13
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 16:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=2EoFyXj6dQfjsnlt1WNwTSXRQTaEKRXJKBLbtywWd44=;
        b=x+/AJhtBu2ufjl+1p9izHufG1cfpReCKdZJWLIMktWRvEFVXetSLH6ImeygG6Yw1lk
         rEzsVvQPlOIOTxpmLABxrJkr4jg3HRnFWtDQn5RbBXeABb1CkqLxezS4SPeQGG5HBU3f
         di/01w9evfi3gjYD/JGRwoz92tfZjryr3DGW3MEBNtlk9hgpECwKb0rQPjc5RwfiIwK0
         zcgHwS7J5h9U3GJ36Q4bUnC+K1EIKBrX8QkLAlUkUFdOEFDdcD2VfiNouXVE2PzqbuEO
         dz8VCyRJZXR3KmmmmoeMuBF+TiBuBUTMQYmZonn4xy9fuA2JDsyMH0u0LZKrEjMuBdH1
         o71g==
X-Received: by 10.50.149.233 with SMTP id ud9mr5307562igb.92.1365376671610;
 Sun, 07 Apr 2013 16:17:51 -0700 (PDT)
Received: by 10.64.170.68 with HTTP; Sun, 7 Apr 2013 16:17:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220387>

This is a demonstration of a mildly-interesting security concern
relating to Git & git-filter-branch - not a vulnerability in Git
itself, just in the way it can be used. I thought it was interesting
to demonstrate that there is sometimes an avenue of attack for
recovering sensitive data that's been removed from Git history using
git-filter-branch. I think it's a low-severity issue, you may wish to
ignore this, and indeed I've been very politely told already that it's
clearly nonsense :)

Here's an unmodified repo, in which the user unwisely committed a
database password:

https://github.com/bfg-repo-cleaner-demos/gma-demo-repo-original/commit/8c9cfe3c

The unwise commit is reverted with a second commit using 'git revert',
which obviously leaves the password in Git history, and - some time
later - it's decided to properly clean the repo history with
git-filter-branch & git gc, purging the password so the repo can be
more widely shared (open-sourced, or just externally hosted).

git-filter-branch works exactly as intended, purging the password, but
the one thing it does not- typically - do is update the commit
message. So in the cleaned repo, the commit message for the revert
commit still looks like this:

https://github.com/bfg-repo-cleaner-demos/gma-demo-repo-git-filter-branch-cleaned/commit/bf0637a5

It contains a commit id (8c9cfe3) which is no longer in the repo, but
can very easily be associated with an existing commit simply by
examining the subject line of the reverted commit ("Carelessly
checking password into source control"). It's also obvious, from
examining the repo, where the excised data was removed (ie at the
"db.password=" line). At this point it's possible to do a brute-force
attack where you generate possible passwords, insert them into the
available commit's tree, and compare them against the leaked commit
id. When the the commit id matches, the sensitive data has been
recovered.

A proof-of-concept implementation of this attack was indeed able to
recover the purged password:

--
$ java -jar gma-0.1.jar 8c9cfe3c attack-pinpoint
gma-demo-repo-git-filter-branch-cleaned

Brute-force search using these characters : 0123456789abcdefghijklmnopqrstuvwxyz
Available commit, presumed cleaned : 8ebbf661
File path : src/main/resources/config.properties
Template blob : dca1a2fb
Exhausted strings of length 1 or less
...
Exhausted strings of length 4 or less
Match with '0g6rw'
--

So all of this amounts to a fairly low severity issue - people should
always change credentials when they mistakenly commit them to a repo -
but I guess the point is that from a paranoia point of view, you want
to remove all information - including old commit hashes buried in
commit messages - that relate to sensitive data when you clean a repo
for sharing. The git-filter-branch command has a --msg-filter option
which could be used for this purpose, with the application of some
judicious bash-scripting, grep&sed-ing. However, I must confess that I
believe users would be better advised to use The BFG:

http://rtyley.github.io/bfg-repo-cleaner/

The BFG already addresses this issue by replacing all old Git
object-ids found in commit/tag messages with the updated id. For
instance, here's that exact same commit message when cleaned with the
BFG:

https://github.com/bfg-repo-cleaner-demos/gma-demo-repo-bfg-cleaned/commit/35840201

In the case that the users specifies a filtering operation is not
removing 'private' data, the BFG replaces old ids with text of the
form '"newid [formerly oldid]", but if the operation is in fact to
strip private data, the replacement value is simply the newid - and
without the old commit id, the attack described above is not possible.

I believe it's worth educating users to give them a more realistic
understanding of their exposure, and would like to update the
documentation of git-filter-branch to give them a better idea of their
options for removing private data - that would include noting the BFG
as alternative.

- Roberto Tyley

https://github.com/rtyley/bfg-repo-cleaner/blob/v1.2.0/src/main/scala/com/madgag/git/bfg/cleaner/ObjectIdSubstitutor.scala#L33-L60
