From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] config.c: split some variables to $GIT_DIR/config.worktree
Date: Sun, 29 Mar 2015 08:25:33 +0700
Message-ID: <CACsJy8DqgX91KYd5m3PvYSTXYdCO8YV-5R+v6LnzerS6TOr+5A@mail.gmail.com>
References: <CACsJy8CYgMDY_zGi6o=UtD7QV+DQUcaDgwxo6tGrfktRXj+QSw@mail.gmail.com>
 <1427371464-22237-1-git-send-email-pclouds@gmail.com> <20150326221906.GA6745@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Mar 29 03:26:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yc1zV-00058J-PU
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 03:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbbC2B0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2015 21:26:07 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36398 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbbC2B0E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2015 21:26:04 -0400
Received: by iedm5 with SMTP id m5so94855703ied.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2015 18:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bAyo6AJ/6SjAAnTQ/bhiJqZ5/nnkV14s8Ihc1YoGhsE=;
        b=kiBDOhHq8WkjHJyGt+3EYq2qmokcnvpobfjPiDmbeZQx1UG1UeST+K4PQvJEuK9xcX
         GX1Jqe29M2LWsafB1JLhCrEiJjcpkFwdC6uE9TigCyTNfDeY/RZ2px2ZO1Wbm+QPUn4R
         PG6XRiWsDvU/GmJX5BYOVUTr65SJUX5cw8MXTz4W0nBIPBUI9A3VaBO62WIBQ8H5ig2b
         o8L4wYK9z7t7TeCMVTYHENn/2aGnCu3SyCXJddLaG+Ak8e/0cexYnWsDJap14GWdJTZD
         5S7oUbWS+Onrf5N33CoSkIZOK7IbX4SFlQeCEXO3ltsVY2b5hC3zFVVVWYMEyvIlrweC
         b8Ug==
X-Received: by 10.107.167.145 with SMTP id q139mr39911470ioe.16.1427592364180;
 Sat, 28 Mar 2015 18:26:04 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sat, 28 Mar 2015 18:25:33 -0700 (PDT)
In-Reply-To: <20150326221906.GA6745@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266427>

On Fri, Mar 27, 2015 at 5:19 AM, Max Kirillov <max@max630.net> wrote:
> On Thu, Mar 26, 2015 at 07:04:24PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> When you define $GIT_DIR/info/config.worktree, which contains of
>> gitignore-style patterns (*), config variables that match these
>> patterns will be saved in $GIT_DIR/config.worktree instead of
>> $GIT_DIR/config.
>
> Should it rather be in GIT_COMMON_DIR? As far as I
> understand, its meaning is "variables which we allow to use
> per-worktree because we intend to have them different in
> different worktrees, and sure no bad issues
> can happen because this. It is not hardcored in git because
> the list is going to extend, and we'd like to allow older
> versions of git (and other git implementations) to be still
> able to understand newer repositories". So there should be
> no sense to make the list worktree-specific.

I'm not sure if "it" means $GIT_DIR/config.worktree or
$GIT_DIR/info/config.worktree. At this point $GIT_COMMON_DIR is not
involved (i.e. you can still spit config even in a normal repo).
=2E../info/config.worktree may be shared, I guess.

The "older versions of git (and other git implementations)" raises an
issue with this patch. Older impl just ignore config.worktree. I think
I need to bump core.repositoryformatversion up to avoid that.

> Also, probably the per-worktree variables should be searched
> for in both common config and per-worktree config, and the
> main repository should not have config.worktree, to be able
> to work with implementations which are not aware of the
> whole multiple worktrees feature. And in worktrees, if the
> variable is not defined in config.wortree, the default
> vaalue should come from common config. This though has
> downside that worktree cannot use the more global vlue for
> variable implicitly.

The main worktree may or may not use per-worktree config (it's
technically possible): if we enforce config.worktree on the main
worktree, we don't have to worry about the same variable defined in
both common and per-worktree config. Enforcing may require more work:
imagine the worktree list is updated, some in the common config may
become per-worktree and need to be moved to config.worktree.. If we
allow per-worktree vars in the common config, other worktrees should
ignore them in common config.
--=20
Duy
