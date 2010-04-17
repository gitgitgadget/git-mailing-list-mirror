From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [BUG] Git add <device file> silently fails
Date: Sat, 17 Apr 2010 16:44:05 +0200
Message-ID: <u2s81b0412b1004170744u4cc3c0e1z6d7019fe405a67ec@mail.gmail.com>
References: <201004171624.17797.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Sat Apr 17 16:44:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O39Fo-0003An-64
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 16:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab0DQOoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Apr 2010 10:44:11 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:62496 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab0DQOoJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Apr 2010 10:44:09 -0400
Received: by gxk9 with SMTP id 9so2096712gxk.8
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XOQTN4p0v7XE9eRrzGU+6TJ4OR6I19BSejjVpfzWEUk=;
        b=rWOiK568eoZkL0fAJ2bEGWLPD5oQtabIOuBoyruj7iq5Zsf0GDcOt08hS707m5Sc3p
         Th1OEiOh1pHQy8dwVlYIlw3ywr2dixn7txWCNYXKLZEVrSGy+DwHKPvGyjSrzU/mZ3jg
         D5HI1Aaz//hXGdzExBiPdf4BUH7NM1TzBnoXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ct58IZN4zta27KvgrDwpXE4Pb51Tk5v5nwTrW1+ZartCF0+GTzhI7p5KXgz41Nqs4w
         A3tDKy0YyilgLSX603zsRthKSP3A5Ezr1TirB9yEBg9+hNRgz+TMi+HxY5CqePf4FfPm
         4mZPQI8p/rj4D5oOOPX+aiYl4bhmwa1Qf6F+c=
Received: by 10.100.212.9 with HTTP; Sat, 17 Apr 2010 07:44:05 -0700 (PDT)
In-Reply-To: <201004171624.17797.agruen@suse.de>
Received: by 10.101.164.25 with SMTP id r25mr6400548ano.117.1271515446111; 
	Sat, 17 Apr 2010 07:44:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145149>

On Sat, Apr 17, 2010 at 16:24, Andreas Gruenbacher <agruen@suse.de> wro=
te:
> However, when trying to add a device special file, update_callback() =
ends up
> never getting called, no error message is produced, and git add silen=
tly
> fails:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ sudo mknod foobar c 1 3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git add foobar
> =C2=A0 $ echo $?
> =C2=A0 =C2=A0 =C2=A0 =C2=A00

I think something like this should make the accident more
noticable:

diff --git a/builtin/add.c b/builtin/add.c
index 87d2980..9c4a5f2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -347,6 +347,8 @@ static int add_files(struct dir_struct *dir, int fl=
ags)
 		die("no files added");
 	}

+	if (!dir->nr)
+		die("No files selected for addition");
 	for (i =3D 0; i < dir->nr; i++)
 		if (add_file_to_cache(dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
