From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Breakage caused by 2fe403e7 git-svn.perl: workaround
	assertions in svn library 1.5.0
Date: Wed, 16 Jul 2008 15:45:10 +0200
Message-ID: <20080716134510.GA6831@neumann>
References: <6583867F-ED86-4E3D-AE8B-39FB974C43D7@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, pape@smarden.org,
	Eric Wong <normalperson@yhbt.net>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 15:46:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ7Ke-00053o-Tv
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 15:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870AbYGPNpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jul 2008 09:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756371AbYGPNpM
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 09:45:12 -0400
Received: from francis.fzi.de ([141.21.7.5]:59497 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756844AbYGPNpL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 09:45:11 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jul 2008 15:45:09 +0200
Content-Disposition: inline
In-Reply-To: <6583867F-ED86-4E3D-AE8B-39FB974C43D7@sb.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 16 Jul 2008 13:45:09.0656 (UTC) FILETIME=[29E57980:01C8E74A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88679>

Hi,

On Tue, Jul 08, 2008 at 05:41:48PM -0700, Kevin Ballard wrote:
> Commit 2fe403e7 causes `git svn info` and `git svn info .` to break.
>
>   Use of uninitialized value in localtime at /usr/local/libexec/git-=20
> core/git-svn line 4277.
>   No such file or directory at /usr/local/libexec/git-core/git-svn li=
ne=20
> 897.
>
> If it makes a difference, I have svn 1.4.4 installed, not svn 1.5.
the same problem here, except that I have svn v1.4.6.

The patch in question adds the following line to git-svn.perl's
canonicalize_path():

+       $path =3D~ s#^\.$##;

which makes an empty string from the path ".".  This is especially
unfortunate for 'git svn info', cmd_info() begins with

        my $path =3D canonicalize_path(shift or ".");

and from that point everything is ruined, but it boils out only when
it tries to actually open() the empty path.

Removing the mentioned line from canonicalize_path() does resolve this
issue on svn v1.4.6, but I'm afraid it will brake again on svn v1.5.

G=E1bor
