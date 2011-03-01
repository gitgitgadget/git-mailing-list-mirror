From: Chad Joan <chadjoan@gmail.com>
Subject: Git changes permissions on directories when deleting files.
Date: Mon, 28 Feb 2011 20:42:40 -0500
Message-ID: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 02:43:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuEcG-0001OZ-PD
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 02:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689Ab1CABnD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 20:43:03 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46268 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab1CABnB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 20:43:01 -0500
Received: by vws12 with SMTP id 12so3731049vws.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 17:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=TdGl+tKWNH6hNMA3jmoqGN1CtzfOMfHdXo7uhZrZxCs=;
        b=MZTOY3qGf2ZOQkLOziXqrfOYLggNmcX84cYfAROCnkP+M62NEt5yCb4YH8yh5c0k9j
         ZYXtjr7UNCX1FFov0/JoXCexqD6s8XLULkViaSxDIlTz8MDjHb41ERVR5D8fWE2xmnXP
         tPAHD0cmrs2BpnI0mCjLJ1Y10cNZqjbFgDoJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=DZLIcTJEXXGkltL5Tpx+ZX+l3BVldz4W6jl+IWobUWqZRs3XRruLzrMWhnbOWZXvlb
         +ETDlu9L4VhPJ2d7HjRTyypmMD57fomYfmxbPHNEtoQ0LkeAY2c/AxnIGVhlqu/x2ucS
         QB2yNP55edrnj0jelbl1zbw9x2PQGgrn4Gb+Q=
Received: by 10.220.195.195 with SMTP id ed3mr1439439vcb.180.1298943780091;
 Mon, 28 Feb 2011 17:43:00 -0800 (PST)
Received: by 10.220.94.136 with HTTP; Mon, 28 Feb 2011 17:42:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168179>

Hello,

What I'm experiencing is this:

$ cd ~/project
$ ls -dl somedir
drwxrwx--- 1 cjoan cjoan 0 Feb 28 19:57 somedir
$ echo "some text" > somedir/somefile.txt
$ git add somedir/somefile.txt
$ git rm -f somedir/somefile.txt
rm 'somedir/somefile.txt'
$ ls -dl somedir
drw------- 1 cjoan cjoan 0 Feb 28 19:57 somedir
$ echo "some text" > somedir/somefile.txt
bash: somedir/somefile.txt: Permission denied

~/project is actually a CIFS mount, with the host being an OpenVMS mach=
ine.

If I use the normal rm command without using git then the permissions
will remain the same on 'somedir'.=A0 This is why I suspect (and hope)
this isn't OpenVMS related.

It seems that execute bit is important for CIFS mounted files, because
after this happens I am no longer able to do /anything/ within the
'somedir' directory.=A0 This also affects branches via "git checkout
branchname": if the checkout happens to delete files then this will
happen, and it will salt the wound by failing to sync a bunch of files
in 'somedir' (because I can't access them anymore) while still moving
HEAD to the new branch.

The share on the CIFS host looks like this:

[homes]
=A0=A0=A0=A0=A0=A0=A0 comment =3D Home Directories
=A0=A0=A0=A0=A0=A0=A0 read only =3D No
=A0=A0=A0=A0=A0=A0=A0 create mask =3D 0770
=A0=A0=A0=A0=A0=A0=A0 browseable =3D No
=A0=A0=A0=A0=A0=A0=A0 vfs objects =3D varvfc
=A0=A0=A0=A0=A0=A0=A0 vms path names =3D No
=A0=A0=A0=A0=A0=A0=A0 case sensitive =3D Yes

The fstab entry for the mount looks like this:

//vms/homes=A0 /home/cjoan/project=A0 cifs
credentials=3D/home/cjoan/.cifs_credentials,_netdev,uid=3Dcjoan,gid=3Dc=
joan
0 0

I'd really like my directories to keep their permissions.
Any idea what might cause this?

- Chad
