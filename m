From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 12:01:41 +0200
Message-ID: <200609141201.41711.jnareb@gmail.com>
References: <200609140839.56181.jnareb@gmail.com> <200609140959.04061.jnareb@gmail.com> <7vvenq4wgp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Sep 14 12:01:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNo2A-0000LR-MJ
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 12:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWINKBY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 14 Sep 2006 06:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWINKBY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 06:01:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37935 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750709AbWINKBX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 06:01:23 -0400
Received: by ug-out-1314.google.com with SMTP id o38so46813ugd
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 03:01:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nOqF/li7igE3SfCfrBGTJgQYH5nDlKHHBByT559nGxbHnQ79DC+iwIz3WrL22qT+Z2cyKoi3QK8pQ35vS1DsOTAhmiUp5E9kNRLM5Wn0G1rNDgkDjdwXcOTFv0lAyWwwnI/UyC7uhnHmojuWYfs2Wa3fajatP1UiXCrnsp394mo=
Received: by 10.66.244.10 with SMTP id r10mr4651628ugh;
        Thu, 14 Sep 2006 03:01:21 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k1sm478659ugf.2006.09.14.03.01.20;
        Thu, 14 Sep 2006 03:01:21 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <7vvenq4wgp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26996>

Dnia czwartek 14. wrze=B6nia 2006 11:40, napisa=B3e=B6:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > ... But I have realized that for gitweb
> > for only one project one could have ".git" as a project name,
> > e.g. by putting $projectroot to be live git repository (working
> > directory of git repository).
>=20
> I do not understand this comment.  I have /git/{git,linux-2.6}
> and run test gitweb with projectroot set to /git to see it can
> display them both.  Both are with working tree, so there are
> /git/git/.git and /git/linux-2.6/.git directories.
>=20
> Do you mean to say "project name" is always taken from the last
> component of the directory name and the above setup would result
> in ambiguity?  If that is the case that sounds awful, but I
> haven't noticed it.

Sorry, this comment was leftover from before, when no_chdir was not=20
used. Then $_ was the last part of directory, and 'return if (/^\./);'
would not take into consideration git/.git nor linux-2.6/.git as
valid project names ($projectroot / $projects_list is stripped from
project name).

Now the test should read "if (m!^.*/\.!)" if we want to skip
dot files and dot directories.

> > It was intended I think to avoid adding '.' and '..' as git=20
> > repositories, not stray directories. Well, perhaps index file
> > if it was used.
>=20
> Having and not having index are both valid, so there is no value
> in checking the index, even if we wanted to be more paranoid.
> Existence of HEAD, refs/heads, and/or objects/ would be a more
> meaningful alternative, but again only if we wanted to be more
> paranoid.

Sorry for the confusion. By index I meant alternate way of specyfying=20
projects, and up till now the only way to specify hierarchical=20
repository structure, namely $projects_list being file with encoded
directories and encoded owners (it was named index.aux or=20
index/index.aux by default).

> >> > +		File::Find::find({
> >> > +			no_chdir =3D> 1, # do not change directory
> >> > +			follow_fast =3D> 1, # follow symbolic links
> >>=20
> >> What is the reason behind choosing follow_fast?  By saying
> >> follow_anything, you choose to care about cases where there are
> >> symlinks under projectroot to point at various projects.  If
> >> that is the case, don't you want to make sure you include the
> >> same project only once?
> >
> > First, it is faster. Second, for testing if it works I used copy
> > of a one "live" git repository I have (git.git repository), by
> > making second symlink to it.
>=20
> That was not what I wanted to ask; slower and correct is always
> preferred over fast and incorrect.  I did not see anything that
> compensates the duplicates follow_fast might give you in the
> code, so I wondered there were some other trick you used to avoid
> it.
>=20
> In other words, "because I have such and such check to avoid
> duplicates, so I can safely use 'follow_fast', without using
> slower 'follow'" was the answer I was after.

=46irst of all, why duplicated repositories are considered error?
It is perhaps error/mistake (besides testing of course) in doing the=20
layout of repositories (projectroot), but it is not that something bad=20
would happen if there are duplicated repositories.

Second, follow_fast is faster, especially that in gitweb we would=20
have to set "follow_skip =3D> 2" to not spew errors to web server log w=
hen=20
there are duplicated repositories.=20

--=20
Jakub Narebski
Poland
