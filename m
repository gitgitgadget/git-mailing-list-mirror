From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Work around performance bug in subprocess.Popen.communicate()
Date: Fri, 31 Jul 2009 12:27:53 +0100
Message-ID: <b0943d9e0907310427r7e59aa5fi5e5ff5e3f3c03819@mail.gmail.com>
References: <20090731093632.7018.24435.stgit@october.e.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mandolaerik@gmail.com, git@vger.kernel.org
To: Karl Wiberg <kha@virtutech.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 13:28:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWqHL-0007P9-Sk
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 13:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbZGaL1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 07:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbZGaL1z
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 07:27:55 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:42400 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbZGaL1y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 07:27:54 -0400
Received: by bwz19 with SMTP id 19so1132266bwz.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1m2UdwvZMh0N5j/qCynJDtIxveG6JPURrkBYbF5Chio=;
        b=ESxuj+h75DdoQwsw0K7w4+bPDleJZzNJqth3UH4hnvKAfFl05nL0GcxfFrN/AT3KDm
         VTNl+qZqSI2x7zhJC5lXn/vJdBeYWqJvMUIt0fNQEGblburOorqCfW3wQeLRvPhAPH/b
         VHytLt43Nbm7Iqm1yn8cxPx5r2E3cHy3AL5kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e/r+BstrF7Vu/uN54aOuuCOEDLVdpNxzzmn0hE2s8fuaZ5E55Zh7oyGorKSSZvJnz3
         zthcOb5hChO7siuIkNxOJBnEzhpq4WyIwQxWgTeFgzbxtpcT7vvVrcmHryeBEvranR4Q
         QPLftFL4VvJ/YnUPXMJWpg2yLhLStEvrFNbV0=
Received: by 10.223.119.198 with SMTP id a6mr1392060far.42.1249039673622; Fri, 
	31 Jul 2009 04:27:53 -0700 (PDT)
In-Reply-To: <20090731093632.7018.24435.stgit@october.e.vtech>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124546>

2009/7/31 Karl Wiberg <kha@virtutech.com>:
> @@ -110,7 +110,9 @@ class Run:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0st=
din =3D subprocess.PIPE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0st=
dout =3D subprocess.PIPE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0st=
derr =3D subprocess.PIPE)
> - =A0 =A0 =A0 =A0 =A0 =A0outdata, errdata =3D p.communicate(self.__in=
data)
> + =A0 =A0 =A0 =A0 =A0 =A0if self.__indata:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p.stdin.write(self.__indata)
> + =A0 =A0 =A0 =A0 =A0 =A0outdata, errdata =3D p.communicate()
> =A0 =A0 =A0 =A0 =A0 =A0 self.exitcode =3D p.returncode
> =A0 =A0 =A0 =A0 except OSError, e:
> =A0 =A0 =A0 =A0 =A0 =A0 raise self.exc('%s failed: %s' % (self.__cmd[=
0], e))

But can this not lead to a deadlock if the __indata is big? The stdout
of the created process is only processed once the whole __indata is
written. I thought communicate() was created to avoid this issue.

--=20
Catalin
