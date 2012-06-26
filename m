From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Tue, 26 Jun 2012 22:21:08 +0100
Message-ID: <20120626212108.GR3125@beczulka>
References: <20120624220835.GA4762@beczulka>
 <7v4nq0hrjb.fsf@alter.siamese.dyndns.org>
 <20120625075726.GO3125@beczulka>
 <7vehp3gwbx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:21:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjdCJ-0002bH-5t
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 23:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab2FZVVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 17:21:15 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:65436 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab2FZVVO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 17:21:14 -0400
Received: by wibhm11 with SMTP id hm11so4584960wib.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 14:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=zC9JAKIDY9DCULmcitUCfk8e6HBgWRbwnDx6etRyiY8=;
        b=Y09s2Ljt5y6Vz+8qGE4S5DH0PJbaYznWoPn/E8YN5J63iR/1aNvDCrI6ww2KdLtgFx
         sqwS3db/ve7u/Q0r+89le4WyEPAB38lFETsh5zJQQI0e/yVQSvnX9GeOaJRQ7Zu5bt2D
         +Y9gEBdl3mDdWjRz8u3TIHErCe626qKK+lki+o5Eq+Gf41gMDT2hOv9JSzfc2VqtcpsP
         8ZhFolFum9uydiYzmmlKX1SJx1vVJQv7qFztDSh3BwpqEDr7oaBt3OPM3pYyOYc8FF1n
         O9lEPIIsnyu30OSVdm6aeh0N+vQBb719yvJYHNrWXYWVuZNfV4bXPx87EoWH/zfBzIKe
         OSFg==
Received: by 10.180.84.35 with SMTP id v3mr35627036wiy.20.1340745672950;
        Tue, 26 Jun 2012 14:21:12 -0700 (PDT)
Received: from beczulka ([89.100.125.149])
        by mx.google.com with ESMTPS id k8sm11731379wia.6.2012.06.26.14.21.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jun 2012 14:21:11 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1SjdC8-0006SL-FQ; Tue, 26 Jun 2012 22:21:08 +0100
Content-Disposition: inline
In-Reply-To: <7vehp3gwbx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQlqk7DMGfVXc2lXdLsHi7GK5UqgsuuiyjffupSFjctHptIk/M1W8BRCp6W0Tu1ISQefp7YA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200683>

On Mon, Jun 25, 2012 at 10:01:06AM -0700, Junio C Hamano wrote:
> Marcin Owsiany <marcin@owsiany.pl> writes:
> 
> >>  What are you really trying
> >> to validate?  "HEAD" points at an existing branch and you do not
> >> care what branch it is?
> >
> > Yes. I think.
> 
> Why do you even care about the value of HEAD, i.e. the output from
> "rev-parse HEAD", if that is the case?

I don't!

> Wouldn't you rather be
> reading from the output "symbolic-ref HEAD" to see if it points at
> any branch?

Sure, I was simply not aware of its existence.

However after actually trying this approach I have found out that when
post_fetch_checkout runs at initial "clone", HEAD points at
refs/heads/master, but refs/heads/master does not exist! So just
checking HEAD is not enough, I need to verify that it points to
something valid. How about this:

From: Marcin Owsiany <marcin@owsiany.pl>
Date: Sun, 24 Jun 2012 22:40:05 +0100
Subject: [PATCH] git-svn: don't create master if another head exists

git-svn insists on creating the "master" head (unless it exists) on every
"fetch". While it is useful that it gets created initially (users expect this
git convention), some users find it annoying that it gets recreated, especially
when they would like the git branch names to follow SVN repository branch
names. More background in
http://thread.gmane.org/gmane.comp.version-control.git/115030

Make git-svn skip the "master" creation if HEAD points at a valid head. This
means "master" does get created on initial "clone" but does not get recreated
once a user deletes it.

Signed-off-by: Marcin Owsiany <marcin@owsiany.pl>
---
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0b074c4..2379a71 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1612,9 +1612,9 @@ sub post_fetch_checkout {
 		}
 	}
 
-	my $valid_head = verify_ref('HEAD^0');
+	return if verify_ref('HEAD^0');
 	command_noisy(qw(update-ref refs/heads/master), $gs->refname);
-	return if ($valid_head || !verify_ref('HEAD^0'));
+	return unless verify_ref('HEAD^0');
 
 	return if $ENV{GIT_DIR} !~ m#^(?:.*/)?\.git$#;
 	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
-- 
1.7.7.3


-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
