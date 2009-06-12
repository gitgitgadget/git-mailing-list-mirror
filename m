From: Allan Kelly <allankelly@gmail.com>
Subject: sub-directory repo technique
Date: Fri, 12 Jun 2009 13:07:20 +0100
Message-ID: <9586f3420906120507o194fc459l5fbdcd14a7095ae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 14:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5Xz-0006xi-Og
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 14:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379AbZFLMHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 08:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbZFLMHX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 08:07:23 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:39284 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbZFLMHW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 08:07:22 -0400
Received: by ewy6 with SMTP id 6so2922891ewy.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 05:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=9wQ5HSAwYdNw8cXPDGosDQgDA7zI+2C50kWy3tAp+Ug=;
        b=wvfyBkfZ5Pwa0bHB47hKq26lyExt4aOommCmlXcqZ9u124O+TyMrQHwSsnnuNHY99o
         5PMB+hCozVr2vnBcIkIKIuiz2akUmY2XyDGNE8yWUslQKI9WxViMqcEQwE6SH9czGIo3
         TockgcCpSpuQNxOoKuRQ6RL9lE90UneyAo/Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=JuSjgffX3v2A5glXapUk0HLmq2T/Cp3rE4zfD1PoQ+acNW4JmsSfWKRNR3CKoXVEjE
         1qiAicc/ilrjPOExj5RxF8Zshquo4WhrULdtZ1d3V/IBrNySaldZuryDnbbys31TxjrJ
         zH/LI3/OqsbzC6YbfPLFXcas2cVa9gTmcqN5c=
Received: by 10.216.0.208 with SMTP id 58mr1293764web.216.1244808440734; Fri, 
	12 Jun 2009 05:07:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121411>

Hi,

I'm quite new to git, but it is serving me well.=A0 The main scenario I
am working with is my own code bases with several centralised repos on
a server. I clone, develop and push from a various machines, rather
than working on the server. Great!

However, for one of my projects I have the following:

* xidebar repo contains perl programs & modules, and a projects/ direct=
ory
* Under projects/ are self-contained project trees, eg
projects/westbarnsgala.info
* The total size is quite large and it's undesirable to clone the
whole thing remotely
* I want to be able to remote clone, edit, and push just a specific
projects/westbarnsgala.info tree

I have a solution which works fine for me below. I wonder if this is
recommended however, or whether there's "another way to do it"?
Probably!

With xidebar as the 'parent' repo on the "rss_rand" server for
tracking all xidebar contant together, I then go into the individual
project/proj1 dirs and create a repo there. I can then remotely clone
this repo, edit and push as below.

Here's the blow-by-blow description.

(I need the top-level .gitignore to contain a line '.gitignore' to
avoid reporting the "sub-repo" .gitignore as untracked - which is
correct but not of interest. It appears that git automatically ignores
the .git dir for the westbarnsgala.info repo created below)

On rss_rand server:
With previously created xidebar/ repo:
* add line '.gitignore' in xidebar/.gitignore
1. Create westbarnsgala.info repo
* cd projects/westbarnsgala.info
* git init
* git add .
* git commit -a -m 'initial commit'
2. On other machine: Clone, edit, commit locally and push changes remot=
ely
* cd projects
* git clone rss_rand:~/xidebar/projects/westbarnsgala.info/ wbg
* cd wbg
* vi htmlgen.xml
* commit -a -m 'a smalll update'
* git push origin
3. On rss_rand: Update local files with remote changes from local repo
* =3D> The git repo is up to date with the remote edit.
* =3D> The files are not.
* =3D> A checkout reports the mis-match and bails.
* =3D> So force it.
* git checkout -f
* =3D> Now the files are up to date!
Now 'git status' on either machine shows things are up to date.
4. Now, back to the rss_rand xidebar repo: commit changes.
* cd ../..
* git status =3D> Shows changes detected correctly
* git commit -a -m 'update to westbarnsgala.info'

Routine of work is now:
Edit on laptop.
* =3D> If in doubt, start with a 'git pull' (Which does both fetch and =
merge).
* commit -a -m 'a message'
* git push
Publish from rss_rand (overnight cron script):
* cd xidebar/projects/westbarnsgala.info
* git status =3D> Just to check
* git checkout -f
* cd ../..
* ./xidebar westbarnsgala.info && ftp_dir_diff westbarnsgala.info


Cheers, al.
