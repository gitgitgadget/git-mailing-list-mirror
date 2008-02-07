From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 7 Feb 2008 10:43:12 +0100
Message-ID: <8c5c35580802070143g697d82b7s3b04019664892f74@mail.gmail.com>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
	 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
	 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
	 <20080207050548.GA32242@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:43:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN3IL-0003kT-W5
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 10:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbYBGJnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 04:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbYBGJnO
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 04:43:14 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:38914 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbYBGJnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 04:43:13 -0500
Received: by wa-out-1112.google.com with SMTP id v27so996988wah.23
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1A+t87P8dp6FmM2fSVA5fjavc6j6XidfzOEQJWFvjFY=;
        b=IY8Bp9H5hxuRq9gCWLRUL+uSzdPLnrB/4DpNZPu0AHJQtAu+yEPN3Fsyu4mLSBI9EhrgbUiJH+a/SJGNbNN/+vLYSZubVx1MRuGxvZU/OBzjidvoah1ndGS62Ur+ojsUUZwYjgpxL7ewKebBjj1d5wa/y8+TaaYx7Fhuv7jPO+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lenQV5zvdr0Vb6Zdw7O6v81xfcLf1NYf5/5HV6SLDDuf2rLFUt+6J6U14Uu+JPoa4F+VrVjj3lYUxkazUvB3goQFHpuZPi8J27LXpPATEyDmZcXSkzyFzVmKF7Suk7w0Q24xo04t883d2MJXkjsK3RSDqEKALj9VOhrrs7yHWbA=
Received: by 10.114.38.2 with SMTP id l2mr5940586wal.106.1202377392671;
        Thu, 07 Feb 2008 01:43:12 -0800 (PST)
Received: by 10.115.73.7 with HTTP; Thu, 7 Feb 2008 01:43:12 -0800 (PST)
In-Reply-To: <20080207050548.GA32242@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72917>

On Feb 7, 2008 6:05 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 06, 2008 at 06:03:51PM -0800, Junio C Hamano wrote:
>
> > * lh/gitdir (Mon Feb 4 21:59:21 2008 +0100) 4 commits
> >  - git-submodule: prepare for the .git-file
> >  - Add tests for .git file
> >  - Document the .git-file
> >  - Add platform-independent .git "symlink"
> >
> > Seems to have funny interaction with Jeff King's test script
> > updates.
>
> I think this is a bug in Lars' code. The problem is that even though we
> set GIT_DIR to the contents of the '.git' file, we may already have run
> setup_git_env, which creates and remembers paths like '.git/objects'.

Yeah, we need to run set_git_dir() to get all the paths set correctly:

diff --git a/setup.c b/setup.c
index 2cbda91..64b069f 100644
--- a/setup.c
+++ b/setup.c
@@ -339,7 +339,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
        for (;;) {
                gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
                if (gitfile_dir) {
-                       setenv(GIT_DIR_ENVIRONMENT, gitfile_dir, 1);
+                       if (set_git_dir(gitfile_dir))
+                               return NULL;
                        break;
                }
                if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))

But this isn't enough either, git-sh-setup.sh needs a patch when
setting GIT_DIR and I just noticed merge-recursive failing (it needs
to call setup_git_directory() in it's main()).

I'll work on this tonight.

-- 
larsh
