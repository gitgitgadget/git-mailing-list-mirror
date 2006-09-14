From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 09:59:03 +0200
Message-ID: <200609140959.04061.jnareb@gmail.com>
References: <200609140839.56181.jnareb@gmail.com> <7v8xkm6gr6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 14 09:58:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNm7Y-0001Fu-9y
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 09:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWINH6t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 14 Sep 2006 03:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWINH6t
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 03:58:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:810 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751427AbWINH6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 03:58:48 -0400
Received: by ug-out-1314.google.com with SMTP id o38so39455ugd
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 00:58:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lN5HcqbwaXxN672wW3HquDr75YvzzdILhZGFV1VoZGh2ryjB/OccUIFgxZ6ttMU909anUaaTpXU8shGSBL6oc/gaHNMoDP/HmqWLJc4eJ+XbT6DaV0R6djg2vKUHW8MKyelAS7p8msVDZB7Q+xx75X8iMj3iILIRpaD2beVdz0w=
Received: by 10.67.89.5 with SMTP id r5mr4602434ugl;
        Thu, 14 Sep 2006 00:58:47 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id 54sm409120ugp.2006.09.14.00.58.46;
        Thu, 14 Sep 2006 00:58:46 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <7v8xkm6gr6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26992>

Dnia czwartek 14. wrze=B6nia 2006 09:37, napisa=B3e=B6:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > +		sub wanted {
> > +			# skip dot files (hidden files), check only directories
> > +			#return if (/^\./);
>=20
> Leftover comment?

Leftover comment, from copying anonymous 'wanted' subroutine
from git_get_refs_list. But I have realized that for gitweb
for only one project one could have ".git" as a project name,
e.g. by putting $projectroot to be live git repository (working
directory of git repository).

> > +			my $subdir =3D substr($File::Find::name, $pfxlen + 1);
> > +			# we check related file in $projectroot
> > +			if (-e "$projectroot/$subdir/HEAD") {
> > +				push @list, { path =3D> $subdir };
> > +				$File::Find::prune =3D 1;
>=20
> We might want to do an extra cheap check to make what we found
> is sane, to prevent us getting confused by a random file whose
> name happens to be HEAD.

That is what we did before. Simplest check, also to avoid now to=20
claim top directory as git repository, and to know when to cut-off=20
(prune) finding.

It was intended I think to avoid adding '.' and '..' as git=20
repositories, not stray directories. Well, perhaps index file
if it was used.

> For example, it is a regular file whose contents is a single
> line and begins with "ref: refs/heads/" (16 bytes) or it is a
> symlink and readlink result begins with "refs/heads/" (11
> bytes).

We can do that, but I think it is unnecessary. Let's assume that
$projectroot contains _only_ git repositories, perhaps in subdirs=20
(directory hierarchy), and perhaps some stray files like not used
now index file.

> If you feel opening and reading the file is an added overhead,
> checking for $project/$subdir/{objects,refs}/ directories might
> be a good alternative.

Probably overkill.

> > +		File::Find::find({
> > +			no_chdir =3D> 1, # do not change directory
> > +			follow_fast =3D> 1, # follow symbolic links
>=20
> What is the reason behind choosing follow_fast?  By saying
> follow_anything, you choose to care about cases where there are
> symlinks under projectroot to point at various projects.  If
> that is the case, don't you want to make sure you include the
> same project only once?

=46irst, it is faster. Second, for testing if it works I used copy
of a one "live" git repository I have (git.git repository), by making
second symlink to it.

> > +			#follow_skip =3D> 2, # ignore duplicated files and directories
>=20
> Leftover comment?

Leftover from benchmarking what set of options is faster.

By the way, if we choose to use 'follow' instead of 'follow_fast' we=20
might want to uncomment it, to not spew errors in the log.

> About these two leftover comments, if you decided you did not
> want them, please do not leave them behind.

O.K.

> If on the other hand you wanted to hint others that you are not
> sure about your decision, it would probably be better to say
> that honestly in the comment, perhaps mark the message as RFC,
> and describe what the issues are, like so:
>=20
> 	sub wanted {
> 		# We might want to also ignore dot files, by
>                 # saying "return if /^\./;" here, but there is
>                 # no inherent reason for us to forbid a repository
>                 # name from starting with a dot.

True.

>                 # We check only if a directory looks like a git
>                 # repo and do not care about non directories.
>                 # Note that this cannot be done with "-d _"
>                 # because we are using follow_fast and the last
>                 # stat was done with lstat(); we want to catch a
>                 # symlink that points at a directory.
>                 return unless -d $_;
>                 ...

Not true. Link to directory is both -d $_ and -l $_, so

	return unless (-d $_ || (-l $_ && -d readlink($_)));

is not needed.
--=20
Jakub Narebski
Poland
