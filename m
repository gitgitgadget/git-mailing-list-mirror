From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Preserve cwd in setup_git_directory()
Date: Fri, 25 Jul 2008 01:37:55 +0700
Message-ID: <fcaeb9bf0807241137h65292d7egad8cc5f797114607@mail.gmail.com>
References: <20080724031441.GA26072@laptop>
	 <alpine.DEB.1.00.0807241324040.8986@racer>
	 <fcaeb9bf0807240540i400fe0d1s7ea8efe72203471d@mail.gmail.com>
	 <alpine.DEB.1.00.0807241506340.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Geoff Russell" <geoffrey.russell@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:39:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5iM-0000fV-Mm
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYGXSh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbYGXSh6
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:37:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:45711 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbYGXSh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:37:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1469898fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XuG7rxK/ESRuT2tVEUM6yjQ5PXIu4moTM+r/XIhk44o=;
        b=eZqB3DLvSUCrVIcssgSu/bwFFeywXnicv7gKzNVT8KlQX9sD6iv+5pR5ff8JLda/yC
         ckkbYoZgzl+FXlnO8xMcRrFIlhcPm/iNJedfMsfcemH7DbtvCpg8Tc8W/J7tmAu+B8zb
         sG/B5fT+J4NOH2rFy25wN63ZsIIMOWW8jcpU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Isiez21mqvERLl/fUs0KSYWscnPT8Rm8pHATgrvAOsX2XrjQpWPYDKwzZSV/4QzDMT
         aLo3DO89b4NF0p6u7DhPm6mbjRx/U51NDcxHdj7y8rL/9J52V/UXb2IIYmk4RnCFboq3
         bjfOZtzgNTTqVMyF5H/SR28Hvx9EdeeU+lXN0=
Received: by 10.86.70.11 with SMTP id s11mr1097049fga.79.1216924675503;
        Thu, 24 Jul 2008 11:37:55 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 11:37:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807241506340.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89932>

On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:
>
>  > On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  >
>
> > >  On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:
>  > >
>  > >  > When GIT_DIR is not set, cwd is used to determine where .git is. If
>  > >  > core.worktree is set, setup_git_directory() needs to jump back to
>  > >  > the original cwd in order to calculate worktree, this leads to
>  > >  > incorrect .git location later in setup_work_tree().
>  > >
>  > > I do not understand.  core.worktree is either absolute, in which case
>  > > there is no problem.  Or it is relative to where the config lives, no?
>  >
>  > The problem is GIT_DIR is not absolute in this case. So cwd must stay
>  > where git dir is until it is absolute-ized by setup_work_tree().
>
>
> I do not see GIT_DIR being set in your test case at all.
>
>  I do not see how get_git_work_tree() ro get_relative_cwd() should ever be
>  allowed to chdir().
>
>  _If_ they were (which I strongly doubt), they should chdir() back
>  themselves.
>
>  I now wasted easily 30 minutes just trying to make sense of your patch and
>  your response.  And I am still puzzled.
>
>  Your commit message was of no help.

Alright, let's look at the code.

 1. cwd is moved to toplevel working directory by setup_git_directory_gently()
 2. setup_git_env() by default will set git_dir variable as ".git" as
part of check_repository_format_gently()
 3. now in setup_git_directory() finds out core.worktree, it chdir()
to get relative prefix
 4. setup_work_tree() sees that git_dir is not absolute path, it makes
git_dir absolute

If in step 3, it does not chdir(), step 4 will be right. In this case,
step 3 does chdir() and not going back, access to git repository will
fail as Geoff Russell discovered.
-- 
Duy
