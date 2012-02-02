From: =?ISO-8859-1?Q?R=FCdiger_Kessel?= <ruediger.kessel@gmail.com>
Subject: Problem pushing to a Novell share
Date: Thu, 2 Feb 2012 23:54:44 +0100
Message-ID: <CAJ4nRM0-3GWN=OYOXDdGtktU0mc8mhcoKqbo=U4Jm5AmSbPAyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 23:54:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt5YI-0006BK-59
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 23:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab2BBWyp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 17:54:45 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54836 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab2BBWyp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 17:54:45 -0500
Received: by ghrr11 with SMTP id r11so1449907ghr.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 14:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=T0zPswBNEGEgNh8sstYggV+aFjWc4j1w+R3uv0X6Ks0=;
        b=ue05EOgo9XOoQAJhvGnUDdHrPczbuZfFh7pjHadXdBxrmSaOsYcjFiOK+I9hdEOkUT
         xRfOiUorsos1HMVwMIzktTAIKJKL6rgZA3DW4uLzjWsVKb2G4VS2hiNTc9doS7yMFX2i
         GixYPJqI49uTA4262ZkJhVSHEsU0M/Y3EPHhE=
Received: by 10.236.186.98 with SMTP id v62mr7844745yhm.22.1328223284735; Thu,
 02 Feb 2012 14:54:44 -0800 (PST)
Received: by 10.236.50.3 with HTTP; Thu, 2 Feb 2012 14:54:44 -0800 (PST)
X-Google-Sender-Auth: POL_YV1tlD4rsNeFCDzjqotR3CM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189719>

Hi

a push to an .git-repository on a Novell network-share using msysgit
fails with the following error message:

error: unable to create temporary sha1 filename : File exists

The problem has been found in git version 1.7.9

The problem is caused by a non-existing sub-directory in the file path
which is not automatically created on Novell shares.

A quick fix is to improve the create_tmpfile() function in sha1_file.c:

static int create_tmpfile(char *buffer, size_t bufsiz, const char *file=
name)
{
    static struct stat sb;
    int fd, dirlen =3D directory_size(filename);

    if (dirlen + 20 > bufsiz) {
        errno =3D ENAMETOOLONG;
        return -1;
    }

    memcpy(buffer, filename, dirlen);
    buffer[dirlen-1] =3D 0;
    if (stat(buffer, &sb) !=3D 0 && errno =3D=3D ENOENT) {
        if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
            return -1;
    }

    memcpy(buffer, filename, dirlen);
    strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
    fd =3D git_mkstemp_mode(buffer, 0444);
    return fd;
}

The function will create one missing directory level if it does not
exist prior to creating the tmp-file.

This method seems to work, but it works only if one directory level is
missing which might not be the case in general. A better solution
would be to create the whole directory tree if needed.

The best solution would be if MINGW would handle this issue.

I recommend including this patch into GIT since it does no harm on
posix systems but it improves compatibility on others.

R=FCdiger
