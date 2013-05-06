From: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Mon, 06 May 2013 17:22:02 +0200
Organization: Universitas Osloensis
Message-ID: <15tfvy0cew5.fsf@tux.uio.no>
References: <15tsj20cizd.fsf@tux.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 06 17:22:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZNEy-0006SN-9o
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 17:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425Ab3EFPWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 11:22:06 -0400
Received: from mail-out4.uio.no ([129.240.10.15]:40595 "EHLO mail-out4.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714Ab3EFPWF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 11:22:05 -0400
Received: from mail-mx6.uio.no ([129.240.10.40])
	by mail-out4.uio.no with esmtp (Exim 4.80.1)
	(envelope-from <t.h.amundsen@usit.uio.no>)
	id 1UZNEp-0007Kq-3q
	for git@vger.kernel.org; Mon, 06 May 2013 17:22:03 +0200
Received: from tux.uio.no ([129.240.6.13])
	by mail-mx6.uio.no with esmtp  (Exim 4.80.1)
	(envelope-from <t.h.amundsen@usit.uio.no>)
	id 1UZNEo-0000rv-J5; Mon, 06 May 2013 17:22:03 +0200
Received: by tux.uio.no (Postfix, from userid 45150)
	id 7D470981; Mon,  6 May 2013 17:22:02 +0200 (CEST)
In-Reply-To: <15tsj20cizd.fsf@tux.uio.no> (Trond Hasle Amundsen's message of
	"Mon, 06 May 2013 15:53:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-UiO-Ratelimit-Test: rcpts/h 3 msgs/h 2 sum rcpts/h 5 sum msgs/h 2 total rcpts 5510 max rcpts/h 30 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.7, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-0.653,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 4671F53C75B3B5D9892DEAE5A562EC20E43B7D9E
X-UiO-SPAM-Test: remote_host: 129.240.6.13 spam_score: -56 maxlevel 80 minaction 1 bait 0 mail/h: 2 total 1447 max/h 9 blacklist 0 greylist 1 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223461>

Trond Hasle Amundsen <t.h.amundsen@usit.uio.no> writes:

> The included patch attempts to improve post-receive-email. It's a
> trivial change, but one that helps us Gitolite users. Comments are
> welcome, and this is my first attempt at contributing to the Git
> project. Please keep me on CC as I'm not on the list.

Bah.. It seems I attached this as MIME, sorry about that. Here it is,
properly inlined this time:

>From 878a7af9088e2bcc3afc9b09b9023f1f188c844b Mon Sep 17 00:00:00 2001
From: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
Date: Mon, 6 May 2013 15:41:25 +0200
Subject: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config

When getting the project description, we first try gitweb.description
entry in repo.git/config, but repo.git/description takes precedence if
it exists. This behaviour mimics that of Gitweb, and is what we want
when using Gitolite, which deletes repo.git/description upon repo
creation and rather maintains a gitweb.description entry in
repo.git/config if a description is configured.

Signed-off-by: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
---
 contrib/hooks/post-receive-email |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 0e5b72d..6ce046a 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -714,7 +714,14 @@ if [ -z "$GIT_DIR" ]; then
 	exit 1
 fi
 
-projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
+# Get the repo's description. First try gitweb.description entry in
+# repo.git/config, but repo.git/description takes precedence if it
+# exists. This behaviour mimics that of Gitweb.
+projectdesc=$(git config gitweb.description)
+if [ -f "$GIT_DIR/description" ]; then
+        projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
+fi
+
 # Check if the description is unchanged from it's default, and shorten it to
 # a more manageable length if it is
 if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
-- 
1.7.1


Cheers,
-- 
Trond H. Amundsen <t.h.amundsen@usit.uio.no>
Center for Information Technology Services, University of Oslo
