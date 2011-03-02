From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: git-svn with big subversion repository
Date: Wed, 2 Mar 2011 17:09:56 +0100
Message-ID: <AANLkTikWDGAYt4SL0r9JR1Wt-vabY4O6vfVyJeDeZjqU@mail.gmail.com>
References: <C992EE5B.CBFB%jkristian@linkedin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Kristian <jkristian@linkedin.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 17:10:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puocl-0003FN-02
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 17:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab1CBQJ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 11:09:58 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33175 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab1CBQJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 11:09:57 -0500
Received: by qwd7 with SMTP id 7so124394qwd.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 08:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CG12PYGsEpJPIn3Dbq2I6XEQJ8D3kmjgcE5xP6+e2cw=;
        b=RkIqOYXoGRezycSj0Vqs0rEJ8B74QC3+8NRh1IDxEpW1rzoj6iAOev63juE+FekUbo
         LByT3olqx1nBGL4c7xp7jztsGEuLB1/CemU3qbyoSPo5iXSj/EqcT+f461oDVGnfxrpy
         laGQNgxvDlYypKSkWhqQto0QQ9b/kN8jBGNsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PsjuIxwBOfg/YX32Nd1q2RmZBHIbifS14o5F38vowzd74giH3cZOWD4MBSzW3LR5kd
         IGgvjnLhMyxSJNIoi3nAq+DlGQrrlQ/1uRURPrmkmVysCqkNHe0l5cAPBX/QF8qaQdUr
         xjOVviMS3dvdR7AkuG/HdVCpejU8b8Qn8DxVs=
Received: by 10.52.70.82 with SMTP id k18mr8311850vdu.194.1299082196835; Wed,
 02 Mar 2011 08:09:56 -0800 (PST)
Received: by 10.220.60.139 with HTTP; Wed, 2 Mar 2011 08:09:56 -0800 (PST)
In-Reply-To: <C992EE5B.CBFB%jkristian@linkedin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168320>

Hi John,

I've successfully run git svn clone on a repository with about 100k
revisions. The clone was not of the whole repository, but rather a
subdirectory for a project using the trunk/tags/branches structure.
The project is about 200k files and about 4GB.

The initial clone took hours and hours (on my macbook). I basically
had to leave it on over night (the svn server is here on the LAN,
running over https).

The only problem I had was that the clone would occasionally exit (not
stall, as you say). This is a know problem described here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D526989

The solution is to just run git svn fetch, as the cloning will pick up
where it stopped. To keep from having to do this yourself, loop the
fetch in a shell script. I blogged about it here:
<http://blog.tfnico.com/2010/07/living-with-subversion-and-git-in.html>

And there are also some more tricks and tips for living with git+svn
here: <http://www.tfnico.com/presentations/git-and-subversion>

You could also investigate how the Apache folks have made their git
mirrors here: http://git.apache.org/ - at least they have an SVN repo
with over a million revisions. I think they did something like
svn-dump + git fast-import, but I couldn't find any details on the
fly.


On Wed, Mar 2, 2011 at 3:43 AM, John Kristian <jkristian@linkedin.com> =
wrote:
> How do you recommend using git to work with branches of a large, busy
> subversion repository? In general, how can small teams use git for th=
eir
> tasks, and use subversion to coordinate with a larger organization?
>
> git-svn has some trouble, I find. For example, this tries to copy the=
 entire
> repo starting with revision 1:
>
> git svn clone --stdlayout svn+ssh://server/repo/project
>
> This would take weeks, I estimate for my subversion repository.
>
> Choosing a subset of the repository enables git svn clone to cope, bu=
t then
> git svn fetch will stall after processing a few revisions. =A0For exa=
mple:
>
> git svn clone --no-follow-parent --no-minimize-url \
> =A0--branches=3Dbranches \
> =A0--ignore-paths=3D"^(?!branches/(TEAM_|RELEASE_))" \
> =A0-r $BASE svn+ssh://server/repo/project
> git svn fetch --no-follow-parent # stalls
>
> I don't why it stalls. I guess it's doing something that requires pro=
cessing
> the entire subversion repository.
>
> The best I can do is clone each subversion branch into a separate svn=
-remote
> section of the .git/config file, for example:
>
> git svn clone --no-follow-parent --no-minimize-url \
> =A0--svn-remote=3DTEAM_FOO --id=3DTEAM_FOO \
> =A0-r $BASE svn+ssh://server/repo/project/branches/TEAM_FOO
> git svn fetch --no-follow-parent
>
> The clone runs about as long as svn checkout, and the fetch replays t=
he
> later revisions briskly. Sadly, the relationship between branches isn=
't
> fetched: git log won't tell me how a given subversion branch was copi=
ed from
> another. I use svn for that.
>
> I'm using git version 1.7.4, git-svn version 1.7.4 (svn 1.6.5), svn v=
ersion
> 1.6.0 (r36650) and Mac OS X version 10.6.5. I got git from MacPorts.
>
> - John Kristian
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
