From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to make git diff-* ignore some patterns?
Date: Sat, 21 Nov 2009 18:31:35 +0100
Message-ID: <4B0823F7.7030607@drmicha.warpmail.net>
References: <4B0817EE.1040000@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat Nov 21 21:55:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwrq-00041R-QD
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551AbZKURbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Nov 2009 12:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756546AbZKURbi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 12:31:38 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43951 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756523AbZKURbi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Nov 2009 12:31:38 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 365A8BFC6A;
	Sat, 21 Nov 2009 12:31:44 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 21 Nov 2009 12:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=dmTHwDo2QvKaPiM8OC1E6j2ZM04=; b=CBSzrVV+C4HM54h9AbH2aL16yCLzzRkgZinuSvT3fRkmdVbB8OWjVXDexK3l0k0Qooj/2vPXjy+hRJv3KTodwCQyQ6biP9cZgF0yY0bEgFmKFLw4+D2sNZL7I15uY+3IacBNDmenJR1AUaDYHZVVTsxM+wGfuM3B1pZQVKDPZVY=
X-Sasl-enc: EKfaDX8QZ9qE/LXvK0cZK3Inb3aIBxFE7LZkBvgfg8c6 1258824703
Received: from localhost.localdomain (p5DCC12E4.dip0.t-ipconnect.de [93.204.18.228])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 78D79BA64;
	Sat, 21 Nov 2009 12:31:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091116 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <4B0817EE.1040000@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133408>

Dirk S=FCsserott venit, vidit, dixit 21.11.2009 17:40:
> Hi list,
>=20
> is there a way to tell "git diff-index" to ignore some special patter=
ns,=20
> such that /^-- Dump completed on .*$/ is NOT recognized as a differen=
ce=20
> and "git diff-index" returns 0 if that's the only difference?
>=20
>      -- Dirk
>=20
> <Background>
> I have a mySQL database which I backup daily using mysqldump (cronjob=
).
> The result is a text file (*.sql) with all the "create" and "insert"
> statements and some metadata.
> I used to use tar and gzip to backup these files and got a huge
> collection of backups in the last tree years (500+ MB).
> Then I switched to Git and recorded only the diffs between day X and =
day
> X-1. My repository shrunk to 16 MB for the very same data, which was =
great!
>=20
> My database doesn't change every day, but I backup it anway and store=
=20
> the backup files with Git and a cronjob. It does:
>=20
> ---------------
> mysqldump ... -r <backupfile> # that's the output file ;-)
> git add <backupfile>
> if ! git diff-index --quiet HEAD --; then
>      git commit -m "Backup of <database> at <timestamp>"
> fi
> ---------------
>=20
> This way, a new commit is only done when the backupfile has changed. =
So=20
> far, so perfect.
> A few days ago my web hoster (where the database actually resides)=20
> changed the mySQL version.
> mysqldump now writes "-- Dump completed on <timestamp>" to the file a=
nd=20
> Git correctly recognizes this as a change and my script creates a new=
=20
> commit. Every day, even if only that line has changed.
>=20
> I'd like to skip these commits if only the "Dump completed" line has=20
> changed.
> </Background>

Is the dump guaranteed to be in a specific order? If yes then this
procedure makes sense. (pdfs etc. are problematic because of reordering=
=2E)

You can either egrep -v through the output of git diff-index, or define
a diff driver: set an attribute, say "dumpdiff", for dump files (see
gitattributes) and define diff driver as
git config diff.dumpdiff.textconv =3D dumpdiff.sh
where dumpdiff.sh is "egrep -v ...". You may need to call diff-index
with --ext-diff. I haven't tried, though ;)

Cheers,
Michael
