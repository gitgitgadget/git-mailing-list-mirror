From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/4] support for ack commits
Date: Sun, 10 Apr 2016 16:54:42 +0300
Message-ID: <1460296343-17304-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bafain@gmail.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:54:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFpD-00054Y-TA
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbcDJNyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:54:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43406 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbcDJNyq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:54:46 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52CDB6446A;
	Sun, 10 Apr 2016 13:54:45 +0000 (UTC)
Received: from redhat.com (vpn1-4-6.ams2.redhat.com [10.36.4.6])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3ADshvP023832;
	Sun, 10 Apr 2016 09:54:44 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 10 Apr 2016 13:54:45 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291170>

This is a repost after rebasing, and addressing comments by Eric Sunshine and
Fabian Ruch.  I'd like to try getting this upstream so  I can stop maintaining
it. So reposting - rebased to latest master, with a better motivation in the
cover letter.

As a maintainer, I get patches by mail, then
acked-by,reviewed-by etc responses are sent by separate
mail.

The result is that I have a patch applied, and now
I need to find it and apply the ack responses to it.

The flow I use to handle this, is to record an
empty commit (which I'm calling an ack commit)
with just the ack in the log, and ack! tag
and the subject of the original patch in the
subject.

Sometimes, I would also make a small change with
that ack commit, typically using commit --amend,
for example if the ack mail says:

	Subject: Re: [PATCH] xyz

	please rename xyz to foo. With that:

	Acked-by: Michael S. Tsirkin <mst@redhat.com>

I would apply ack and make the change as part of that.

Later, once in a while I rebase and squash the ack commits
into the regular one: the rebase autosquash mechanics
find the original commit and update the commit log,
appending the ack.

from example, we start with an email:
	From: Michael S. Tsirkin <mst@redhat.com>
	Subject: [PATCH] foo.c: change b to c
	Date:   Wed Apr 6 22:07:34 2016 +0300

	    foo.c: change b to c
	    
	    Change BBBBBBBBBBBBBBBBB to CCCCCCCCCCCCCCCCC
	    
	    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

	---

	diff --git a/foo.c b/foo.c
	index 8e5be91..34654fc 100644
	--- a/foo.c
	+++ b/foo.c
	@@ -676,6 +676,6 @@ FFFFFFFFFFFFFFFFFFFFFFF(
		AAAAAAAAAAAAAAAAAAAAAAAAA
	 
	-       BBBBBBBBBBBBBBBBB
	-       BBBBBBBBBBBBBBBBB
	+       CCCCCCCCCCCCCCCCC
	+       CCCCCCCCCCCCCCCCC

		DDDDDDDDDDDDDDDDD

and I apply it using git am.


then I get an email:

	Subject: Re: [PATCH] foo.c: change b to c

        > 	    foo.c: change b to c
        > 	    
        > 	    Change BBBBBBBBBBBBBBBBB to CCCCCCCCCCCCCCCCC
        > 	    
        > 	    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
        > 
        > 	---
        > 
        > 	diff --git a/foo.c b/foo.c
        > 	index 8e5be91..34654fc 100644
        > 	--- a/foo.c
        > 	+++ b/foo.c
        > 	@@ -676,6 +676,6 @@ FFFFFFFFFFFFFFFFFFFFFFF(
        > 		AAAAAAAAAAAAAAAAAAAAAAAAA
        > 	 
        > 	-       BBBBBBBBBBBBBBBBB
        > 	-       BBBBBBBBBBBBBBBBB
        > 	+       CCCCCCCCCCCCCCCCC
        > 	+       CCCCCCCCCCCCCCCCC
        > 
        > 		DDDDDDDDDDDDDDDDD
	    
	Acked-by: Junio C Hamano <gitster@pobox.com>

I then create an empty commit using the subject and the ack line:

	commit 4d54b237d8d03323933e27119272e93cf33b4e98
	Author: Michael S. Tsirkin <mst@redhat.com>
	Date:   Wed Apr 6 22:07:34 2016 +0300

	ack! foo.c: change b to c

	Acked-by: Junio C Hamano <gitster@pobox.com>

(with no change) and then after rebase -i --autosquash it is combined
with the original commit by squashing changes (easy as the
second one has an empty change), and appending the commit log
from the second one to first one:

commit ef7b6d457c28bcd06d0118a889c7070fc800f3d5
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Wed Apr 6 14:55:59 2016 +0300

    foo.c: change b to c
    
    Change BBBBBBBBBBBBBBBBB to CCCCCCCCCCCCCCCCC
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Acked-by: Junio C Hamano <gitster@pobox.com>

diff --git a/foo.c b/foo.c
index 8e5be91..34654fc 100644
--- a/foo.c
+++ b/foo.c
@@ -676,6 +676,6 @@ FFFFFFFFFFFFFFFFFFFFFFF(
	AAAAAAAAAAAAAAAAAAAAAAAAA
 
-       BBBBBBBBBBBBBBBBB
-       BBBBBBBBBBBBBBBBB
+       CCCCCCCCCCCCCCCCC
+       CCCCCCCCCCCCCCCCC

	DDDDDDDDDDDDDDDDD


The empty ack commits can be created by hand. I have also
written a small script for that - included
as patch 4/4 but it is still rather rough so only putting it
under contrib for now - would like to try
and merge the rebase machinery in place first.
Long term, it might be cleaner to teach git-am about an --ack flag.
But it is already helpful to explain how this is intended to be used.
That script can be used in one of two ways:

	1. pipe the mail with ack to it. we extract
	   subject and prepend ack!, extract the ack
	   trailer line that needs to be appended to commit,
	   and record the result as en empty commit.
	2. pipe the mail with ack to it with flag -s,
	   this saves the ack trailer into a file.
           then pipe the original patch(es) to it
           with flag -r, now the subject is taken from
           patch, with ack! prepended, but the ack trailer
           is from the ack email.
           this is useful to handle series acks, similar to:
		   For series:
			Acked-by: Michael S. Tsirkin <mst@redhat.com>



So what is an ack commit from point of view of rebase?

1. subject is ack! <original patch>

2. commit can be empty and it does not mean it needs to be skipped

3. when squashing into parent commit, subject and empty line
   after it should be skipped, and the rest of commit log
   should be appended to commit log of parent, as is.


I have been using these patches without any problems for more than a
year now, and find the approach very convenient.

Included:
        rebase: new ack! action to handle ack commits
                this part seems ready for merge to me,
                please review and comment

        git-ack: new tool to record an ack
                this does not have proper documentation
                and tests yet, I definitely intend to
                do this but wanted to see whether people
                like the UI first.
                posting for early review and feedback


Note: people mostly using pull requests for communication
will not find this approach useful.
As it's optional, this should not be a problem.

Note: it was suggested that "squash! --noedit" would be easier
to maintain than "ack!" - I think this would be less
user-friendly, so I left this suggestion out for now.


Michael S. Tsirkin (4):
  rebase -i: add ack action
  git-rebase: document ack
  rebase: test ack
  git-ack: record an ack

 Documentation/git-rebase.txt | 45 +++++++++++++++++++---
 contrib/git-ack              | 90 ++++++++++++++++++++++++++++++++++++++++++++
 git-rebase--interactive.sh   | 36 ++++++++++++++----
 t/t3415-rebase-autosquash.sh | 15 ++++++++
 4 files changed, 173 insertions(+), 13 deletions(-)
 create mode 100755 contrib/git-ack

-- 
MST
