From: Nate Parsons <parsons.nate@gmail.com>
Subject: Re: git .lock file error
Date: Thu, 30 Sep 2010 14:00:52 -0400
Message-ID: <AANLkTim2sFCx8qZ-6o4tiugX3a-EBN9T8wuCSWXb5L12@mail.gmail.com>
References: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com> <AANLkTin+MRkYv7vL7eY+mdWG1vTg-E9pVpU4_QujoxdZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 20:01:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1NRZ-0005RK-TE
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 20:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab0I3SBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 14:01:14 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63903 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab0I3SBN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 14:01:13 -0400
Received: by gxk9 with SMTP id 9so888334gxk.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=RMGXcKMiuB1miYIxx2Bz9PEd21Ryzz4ylTDPiAyiNcI=;
        b=F62y0jWIa1xhpdqfXg0SSHYzY8JdaeMpxpr2rWVijMaxiTmmEoUsEESvSchZsQV6rS
         yDZJ+aLdX2HotBqYASYQy1G7hMoA7MnhraoDxhZ1hDnfjyNDu85a7ekpHFLuvQO5MT/s
         xIKmw3usZTeVJmngu988GqxgYI0EhBqDMMeQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=QmaYODCvES8aW9vl32omg4zDeH/UlDUaRGBZ5ZBO/1Ptb7bV1zgJcT2HTK89OmCVrd
         g7x/79R0pZRw0Zlh9lieZJXvkT6E138gTlAc4bJRP/vjp7Qpewvthvzmfu1YbnRQrlvx
         CEe7L5ibXqy2stvncWis8hJhN5DOM4HZCjCxw=
Received: by 10.231.154.73 with SMTP id n9mr4209327ibw.10.1285869672489; Thu,
 30 Sep 2010 11:01:12 -0700 (PDT)
Received: by 10.231.155.210 with HTTP; Thu, 30 Sep 2010 11:00:52 -0700 (PDT)
In-Reply-To: <AANLkTin+MRkYv7vL7eY+mdWG1vTg-E9pVpU4_QujoxdZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157697>

OK, so this is definitely a win32 issue. I believe that the perl
script is simply creating .lock files too fast for Windows to keep up.
Simply trying again fixes the problem for me.

--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3676,8 +3676,10 @@ sub rev_map_set {
 					    "$db =3D> $db_lock ($!)\n";
 	}

-	sysopen(my $fh, $db_lock, O_RDWR | O_CREAT)
-	     or croak "Couldn't open $db_lock: $!\n";
+   my $fh;
+   my $tries=3D10;
+   for(; !sysopen($fh, $db_lock, O_RDWR | O_CREAT) && $tries>=3D0; $tr=
ies--) { }
+   if($tries <=3D 0) { croak "Couldn't open $db_lock: $!\n"; }
 	$update_ref eq 'reset' ? _rev_map_reset($fh, $rev, $commit) :
 				 _rev_map_set($fh, $rev, $commit);
 	if ($sync) {

If this is a reasonable solution, I can go figure out how to properly
format a patch to the list.

-Nate

On Sun, Sep 19, 2010 at 10:42 PM, Nate Parsons <parsons.nate@gmail.com>=
 wrote:
>
> Hello again,
>
> I realized I have=A0git-cheetah running as well, so I killed
> explorer.exe (the only process using git_shell_ext.exe), and tried
> again. That's when I noticed that running 'git=A0svn=A0fetch' spawned=
 two
> git=A0processes and a perl process (which later spawned another perl)=
=2E
> Is this something that should be happening?
>
> Thanks,
> -Nate
>
> On Mon, Sep 13, 2010 at 11:19 AM, Nate Parsons <parsons.nate@gmail.co=
m> wrote:
> >
> > Hi everyone,
> >
> > I'm trying to switch to git, so I apologize in advance for my
> > ignorance. For this, I'm using cygwin git, version 1.7.1 to talk to=
 a
> > svn server running 1.4.2.
> >
> > When I 'git svn clone' or 'git svn clone; git svn fetch', I sometim=
es
> > run into the following error.
> > > Couldn't open .git/svn/refs/remotes/0.0.0/.rev_map.b8cad480-e46b-=
48b4-8317-a683ee46c2bd.lock: Device or resource busy
> > > =A0at /usr/lib/git-core/git-svn line 5210
> >
> > And when I 'git svn rebase'
> > >=A0Couldn't open .git/svn/refs/remotes/git-svn/.rev_map.cc05479a-e=
8ea-436f-8d71-e07493b7796c.lock: Device or resource busy
> > > at /usr/lib/git-core/git-svn line 1528
> >
> > Sometimes the line number is different (578, I think?), but when I
> > retry the fetch command, it rebuilds the file corresponding to the
> > lockfile, and then continues a little farther before dying again.
> >
> > When I watch the directory in question, I see the lock file appear,
> > and then disappearing a short time after the script gives up.
> >
> > I don't have a series of steps to reproduce the problem, sometimes =
it
> > goes for an hour, and sometimes for just a few minutes/seconds.
> >
> > I do have TortoiseGit running my machine, but this issue happens ev=
en
> > when TGitCache.exe is not running. If some other instance of git is
> > accessing the repository, I don't know which or how.
> >
> > Thanks,
> > -Nate
