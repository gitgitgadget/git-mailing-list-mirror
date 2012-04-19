From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Improve repository verification
Date: Thu, 19 Apr 2012 21:46:09 +0200
Message-ID: <201204192146.09853.jnareb@gmail.com>
References: <20120403132735.GA12389@camk.edu.pl> <201204191807.32410.jnareb@gmail.com> <xmqq397zwp4c.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Junio C Hamano <jch@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 21:46:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKxJ4-0001bO-RK
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 21:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251Ab2DSTqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 15:46:12 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43510 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421Ab2DSTqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 15:46:11 -0400
Received: by wejx9 with SMTP id x9so5626776wej.19
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=BzUAttMK6ktpMBW+zfLGhX3tp5vJSeDuT292Pvix2fM=;
        b=v2Y97XqDSbDOI9ViMraQCVte64zvEQGYf6DmQpOinTzTt/0JUNQu4k3EsJDfHcGU75
         tKWoYRJFaPONfJkhnErnpZkOo2/VBcZuBms5Nrae1XV01XO09WvCOqKPQLtVHhNJ4D1G
         aFAJxYx2IwAgIQYpuveFLcrNePt4HM8V+Vb9N4QnKqP0FBZ+TftTmHFc9FZma18EUMAD
         htWkcFaDD6m7PEupREJT/ox5ThOAQPvr55dNH2+b2FcFb+i6hmJXHpaky62jJ5BUuLat
         y4XWXAuMJ0lCcFa7BPBijZC3OUFkH9AprVwEwL7wsT6Yg8y39ElW+ixzZxkAiq4wCI5y
         wpcg==
Received: by 10.180.102.100 with SMTP id fn4mr8347540wib.1.1334864770424;
        Thu, 19 Apr 2012 12:46:10 -0700 (PDT)
Received: from [192.168.1.13] (epp52.neoplus.adsl.tpnet.pl. [83.20.57.52])
        by mx.google.com with ESMTPS id e6sm44425243wix.8.2012.04.19.12.46.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 12:46:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <xmqq397zwp4c.fsf@junio.mtv.corp.google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195965>

On Thu, 19 April 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Bring repository verification in check_export_ok() to standards of
> > is_git_directory function from setup.c (core git), and validate_headref()
> > to standards of the same function in path.c,... and a bit more.
> >
> > validate_headref() replaces check_head_link(); note that the former
> > requires path to HEAD file, while the late latter path to repository.
> >
> > Issues of note:
> > * is_git_directory() in gitweb is a bit stricter: it checks that
> >   "/objects" and "/refs" are directories, and not only 'executable'
> >   permission,
> > * validate_headref() in gitweb is a bit stricter: it checks that
> >   reference symlink or symref points to starts with "refs/heads/",
> >   and not only with "refs/",
> > * calls to check_head_link(), all of which were meant to check if
> >   given directory can be a git repository, were replaced by newly
> >   introduced is_git_directory().
> >
> > This change is preparation for removing "Last change" column from list
> > of projects, which is currently used also for validating repository.
> >
> > Suggested-by: Kacper Kornet <draenog@pld-linux.org>
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > Here is how such first step could look like...
> 
> Do you mean by "could look like" that this is still an RFC, or is this
> something we want to apply and see how well it makes people's lives in
> the field?

"Here is how such first step could look like" was directed to Kacper... :-)

Kacper Kornet (who started this thread with "[PATCH] gitweb: Option
to omit column with time of the last change") wants to have an option
to remove "Last Change" column from projects list page, and "Owner"
column and field from all gitweb views.  This will allow to generate
projects list page with 1 call to git command rather than 2*N+1, where
N is number of repositories shown...

...but we use the fact that "git --git-dir=$GIT_DIR for-each-ref ..."
succeed or fails to verify that given path points to git repository.
That is why I proposed this commit to be first patch in hopefully
upcoming Kacper's new version of patch series.

But in current gitweb (without Kacper's planned patches) this change
doesn't bring much, as git repositories are verified outside of
is_git_directory() check... well, perhaps with exception of possible
corner case when one is using path_info gitweb URL...
 
> By the way, I wonder (1) if it is worth adding support for the textual
> ".git" file that contains "gitdir: $path", and (2) if so how big a
> change would we need to do so.

I don't think that it would be big changeto add support for "gitlink"
files, assuming that 'git --git-dir=<gitlink file> ...' works correctly.
I would put that addition in a separate commit, though.

BTW. does core git limit number of redirections, or have some loop
detection?
-- 
Jakub Narebski
Poland
