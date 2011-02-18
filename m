From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] cherry-pick: when pick fails, explain how to cancel
Date: Thu, 17 Feb 2011 19:24:35 -0600
Message-ID: <20110218012435.GA16893@elie>
References: <AANLkTingcnvm6rLnWdweAKdeOWAVjh+F+6BMWzfJxhKi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 02:24:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqF5U-0004gY-9I
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 02:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758207Ab1BRBYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 20:24:44 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46029 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab1BRBYm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 20:24:42 -0500
Received: by qyj19 with SMTP id 19so5506450qyj.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 17:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=nbdH1coxBKbnjFf7fb8ExcDHEY5xElraPkrJoVuSQO8=;
        b=jUNkkuid+4RU2fGfHjNzx1vfuhm/rljcBBfaTgaHT+c77kSJj30xR4zG+a4Qad/Ymj
         lKFo35ZA+CdqR7+UdXpQTAE201HvVlKslWve3ALZ39DFbMiGgM8sQTGhV7bWG49oZFXW
         M641NZLjmfyiJVLWKhLOkfxbdNCt74GkSGX+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wQIYU7UxiaQ0NpfFZBQKmB2e5R8R/uiP3iobh4wM/aVBA/u+mZ+ygTat4EAPR/4+j2
         hyqwtiLHXyIGlBglYmZUbq4kQduQH3n56kaUo/bb6HcVA+JGlBcN91KBkVRrF4Xa469R
         RYszH9qCf2meQ44bsblDOesMwgBvBx+8rlGW0=
Received: by 10.224.61.3 with SMTP id r3mr97812qah.134.1297992281213;
        Thu, 17 Feb 2011 17:24:41 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.sbcglobal.net [69.209.72.148])
        by mx.google.com with ESMTPS id nb15sm1156722qcb.38.2011.02.17.17.24.39
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 17:24:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTingcnvm6rLnWdweAKdeOWAVjh+F+6BMWzfJxhKi@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167151>

If you tried a cherry-pick or revert resulting in complex conflicts
and want to start over, "git reset --merge HEAD" might help.

Requested-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
(+cc some relevant people. Johan wrote merge --abort, Jay is adding
a status hint during cherry-pick, Christian wrote reset --merge and
much related cherry-pick functionality)

Piotr Krukowiecki wrote:

> Example of cherry-pick conflict:
>
>    $ git cherry-pick  c64e8caa56fd76577bbaea37592f4a9df10ab1b8
>    error: could not apply c64e8ca... <<commit message>>
>    hint: after resolving the conflicts, mark the corrected paths
>    hint: with 'git add <paths>' or 'git rm <paths>'
>
>    $ git status
>    # On branch master
>    # Unmerged paths:
[...]
> I see following possibilities:
>
> 1. add hint to cherry-pick how to abort merge, for example:
>    hint: use 'git reset --merge ORIG_HEAD' to abort merge

Good idea.  "git cherry-pick" does not set ORIG_HEAD, so I
put "git reset --merge HEAD" instead.

> 2. add hint to status how to abort merge, for example:
>    #   (use 'git reset --merge ORIG_HEAD' to abort merge)

"git reset --merge" will remove local changes marked with "git add",
under the assumption that they were part of the conflict resolution
and thus should be cleared away.

This leaves me afraid of the following scenario:

	git pull
	# conflict?  agh!

	# ... two days later ...
	... hack hack hack ...
	... add add add ...
	git commit;	# fails because of unmerged files

	# whoops, forgot about that merge.
	# Let's do what it says to do:
	git reset --merge ORIG_HEAD

It seems safest to only recommend "reset --merge" immediately
after a mergy operation.

> The ORIG_HEAD is specified in man page example.

I assume you mean on the git-reset page?  It might be nice to add
more examples and to update the current ones with current best
practice (e.g., using reset --keep more often).

The use of ORIG_HEAD there also allows the following:

	git pull
	# success?  But I didn't want that
	git reset --merge ORIG_HEAD

and protects against situations in which ORIG_HEAD is not present
(though merge --abort does that better, I think).

> git-cherry-pick uses word "cancel" in man page (in example) and
> git-merge uses word "abort" for (as I understand) the same action.

Hmm, where is this example in the cherry-pick manpage?

Thanks for the suggestions.  Generally speaking, I like them.

 builtin/revert.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index dc1b702..78baae7 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -267,11 +267,13 @@ static void print_advice(void)
 	}
 
 	advise("after resolving the conflicts, mark the corrected paths");
-	advise("with 'git add <paths>' or 'git rm <paths>'");
+	advise("with 'git add <paths>' and 'git rm <paths>'");
 
 	if (action == CHERRY_PICK)
 		advise("and commit the result with 'git commit -c %s'",
 		       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+
+	advise("or use 'git reset --merge HEAD' to abort");
 }
 
 static void write_message(struct strbuf *msgbuf, const char *filename)
-- 
1.7.4.1
