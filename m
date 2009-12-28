From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Fix core.worktree being used when GIT_DIR is not set
Date: Mon, 28 Dec 2009 12:41:24 +0700
Message-ID: <fcaeb9bf0912272141j1def76e7v6f581636188e65f0@mail.gmail.com>
References: <200912071115.48085.robin.rosenberg.lists@dewire.com>
	 <1261920513-25189-1-git-send-email-pclouds@gmail.com>
	 <7viqbsw2vn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 06:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP8MP-00013d-VM
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 06:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbZL1Fl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 00:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbZL1Fl0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 00:41:26 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:54439 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbZL1FlZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 00:41:25 -0500
Received: by pxi27 with SMTP id 27so5398066pxi.4
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 21:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UWqcHEXwiPGkFN4pIkSLrj/Sw/BqMMgocMibJrDIC+U=;
        b=QsvSvNM03UuRzhoq5uvurbHQqcHLhWxQyRloYNMc1n2Ex532cJ+RcAAFa2HGIial+g
         1U6KTHbNBDLpr3H5sQ544YzZrRLxVAzuvfLA9JEUTn8IbPEdy57XtMeUmNmpO6xLXL4V
         maCmPy8Y7JHe+N1CZIbgB22JaO4SkH6CLp9yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TOxomvzTBSOXg9S4HJJ0cozUq/1m9iXs4HxFHann0JdgDXEOJzOauy0NW0o2Mwmyhg
         Kc+jBU2QiSe+UJEK9pZqm7X4mDqGe0FXOEVd/ZnwlaNXFDWqDFWdQ8/hqEcDsWpDtEwd
         ixHkT+7FeaUE17IJUPRmlHMlOwbNXvR3lZgJ4=
Received: by 10.114.189.24 with SMTP id m24mr10465333waf.29.1261978884349; 
	Sun, 27 Dec 2009 21:41:24 -0800 (PST)
In-Reply-To: <7viqbsw2vn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135729>

On 12/28/09, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>  > According to config.txt:
>  >> core.worktree::
>  >>         Set the path to the working tree.  The value will not be
>  >>         used in combination with repositories found automatically=
 in
>  >>         a .git directory (i.e. $GIT_DIR is not set).
>  >
>  > This behavior was changed after e90fdc3 (Clean up work-tree handli=
ng -
>  > 2007-08-01) and 9459aa7 (Do check_repository_format() early (re-fi=
x) -
>  > 2007-12-05). If core.worktree is set, even if git_dir automaticall=
y
>  > found (and git_work_tree_cfg set), git_work_tree_cfg will be reset=
 to
>  > core.worktree. This makes core.worktree effective even if GIT_DIR =
is
>  > not set, in contrast to config.txt.
>  >
>  > This patch makes sure it only checks for core.worktree if GIT_DIR =
is set.
>
>
> The work-tree area got too complicated over time for a small Panda br=
ain
>  to grasp, so let me think aloud here.
>
>  ...
>
>  Given these background, I am not sure the "fix" is addressing the ri=
ght
>  issue.  What does it mean to have "core.worktree" in a configuration=
 file,
>  but that configuration file was found in a "git directory" that was =
found
>  thorough the repository discovery process due to lack of $GIT_DIR?  =
There
>  are only two cases I can see:
>
>   - The user is in the "git directory" itself, which is bare (iow,
>    /srv/git/proj.git in the above example).  This is not the case the
>    documentation snippet you quoted is about, and I don't think your =
patch
>    changes (nor should change) the behaviour for;
>
>   - The "git directory" is a ".git/" subdirectory of some work tree, =
and
>    the value of core.worktree may or may not match that work tree.  T=
his
>    is the case the documentation talks about, and your patch addresse=
s.
>
>  For the former case, while I don't see much point, we do seem to sup=
port
>  this use case (continuing the example scenario):
>
>     $ unset GIT_DIR GIT_WORK_TREE
>     $ cd /srv/git/proj.git
>     $ git checkout -b newbranch master
>
>  We find that "." is our "git directory", and through its config file=
, we
>  know core.worktree points at /scratch/proj/, and the checkout update=
s
>  files over there, not in /srv/git/proj.git/.  While it is not obviou=
s why
>  anybody finds this useful to me, I think the behaviour makes _some_ =
sense,
>  and I don't think your patch breaks it by changing the behaviour for=
 this
>  case [*1*].
>
>  The latter, unless core.worktree matches the parent directory of the=
 "git
>  directory" in question, seems to me a misconfiguration and nothing e=
lse.
>  Shouldn't it be diagnosed as an error, instead of matching the
>  documentation to the letter?

I had not read that part of the documentation until Robin pointed out
and always thought core.worktree was in effect if set. I thought the
author intention was not to let core.worktree get in the way if not
requested, but given that the worktree is moved to somewhere else
already, that does not make sense as it could use parent directory of
the "git directory" as worktree (unless core.worktree matches the
parent directory as you said). Probably best fixing documentation.
--=20
Duy
