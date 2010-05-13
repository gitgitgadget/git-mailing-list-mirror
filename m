From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [remote rejected] master -> master (n/a (unpacker error))
Date: Wed, 12 May 2010 19:52:19 -0500
Message-ID: <20100513005218.GA20655@progeny.tock>
References: <AANLkTinV2U6Lbbl0N7jVAESEi0mZQ_D3slMEYa68vRT4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 02:52:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCMel-00051y-QT
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 02:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252Ab0EMAv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 20:51:59 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:62912 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab0EMAv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 20:51:58 -0400
Received: by gxk27 with SMTP id 27so432429gxk.1
        for <git@vger.kernel.org>; Wed, 12 May 2010 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LXVWdp+yMTtF4IKdXc/1P8m0MTT1ph91pAs0tDTwuXE=;
        b=nzMgZDPAJ5jNylAJSlV9li1EdqjPo5WrvDEvHbx/aBgurMiG8XNUJXp88ucWeSmqXL
         wBU6QMO35IZyR1XMjZxehG2Gt8VAR451+rf7kDF5GJccl1rl7L0ZfkhkCvQ52NRINpBw
         r7aSolXl3O+4VjMZj9QBC73eOtOqkf5OJjc3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=u4huSwVpP72OsZLB0Dpequt4Uz0aV15V+lO/moniSeJpOzXzf4VkTgy0Bs3Mh3viJl
         FYmIgWv/zXkLlmxlWj0LcMCLG9Q8LUfZsjpiditDayDLJu0+/N0UqTLIRqUKA80hw2lA
         dbW8SaWdYhz9QQszVrRA8mz4gLOeMo/3ejCN4=
Received: by 10.101.184.4 with SMTP id l4mr5456233anp.222.1273711917903;
        Wed, 12 May 2010 17:51:57 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t2sm1326494ani.18.2010.05.12.17.51.56
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 17:51:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinV2U6Lbbl0N7jVAESEi0mZQ_D3slMEYa68vRT4@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146972>

Hi Robert,

Robert Buck wrote:

> error: unable to create temporary sha1 filename ./objects/e6: File ex=
ists

Yeah, this error message is not so great.

The relevant code is in sha1_file.c.

	fd =3D create_tmpfile(tmpfile, sizeof(tmpfile), filename);
	while (fd < 0 && errno =3D=3D EMFILE && unuse_one_window(packed_git, -=
1))
		fd =3D create_tmpfile(tmpfile, sizeof(tmpfile), filename);
	if (fd < 0) {
		if (errno =3D=3D EACCES)
			return error("insufficient permission for adding an object to reposi=
tory database %s\n", get_object_directory());
		else
			return error("unable to create temporary sha1 filename %s: %s\n", tm=
pfile, strerror(errno));
	}

create_tmpfile() creates a filename of the form
=2E/objects/e6/tmp_obj_<random letters> and tries to open that file.
The random value is based on the current time and the process ID of
the current process.  If the file exists, it tries again with another
collection of random letters, up to 16384 times.

In your case, all 16384 trials yielded the same result: file already
existed.  As a workaround, I=E2=80=99d suggest

 rm -f .git/objects/??/tmp_obj_*

but it might be nice to get a listing with "ls -lR .git/objects" first
for post-mortem analysis.

And presumably the directory filled with temporary files that could
not be renamed to a proper name for some reason.  Probably a permission=
s
problem, as Chris suggested.

-- 8< --
Subject: write_loose_object(): improve error message for some mkstemp f=
ailures

If the .git/objects/ab/ directory fills up with tmp_obj_ files, the
result is a cryptic error:

  error: unable to create temporary sha1 filename ./objects/e6: File ex=
ists

Replace it with the slightly less cryptic

  error: cannot write temporary file under ./objects/e6: all the good f=
ilenames are taken

Reported-by: Robert Buck <buck.robert.j@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
> As an aside, where the heck is the git bug tracker?

Here is an answer from the last time it came up[1]:

 See http://thread.gmane.org/gmane.comp.version-control.git/136500

 Short answer: the usual method is to report bugs to the list,
 preferably with a patch for t/ or even better, a fix.=20

> I've searched, and
> searched, and ... All I found is a Debian tracking system, which
> appears to have no full text search capabilities.

http://merkel.debian.org/~don/cgi/search.cgi
http://www.google.com/search?q=3Dsite:bugs.debian.org+"Package:+git"+"f=
ile+exists"

Thoughts?  Improvements?
Jonathan

[1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/68077=
8/focus=3D141598

 sha1_file.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 28c056e..a2aa301 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2288,6 +2288,10 @@ static int write_loose_object(const unsigned cha=
r *sha1, char *hdr, int hdrlen,
 	if (fd < 0) {
 		if (errno =3D=3D EACCES)
 			return error("insufficient permission for adding an object to repos=
itory database %s\n", get_object_directory());
+		else if (errno =3D=3D EEXIST)
+			return error("cannot write temporary file under %s: "
+			             "all the good filenames are taken\n",
+			             tmpfile);
 		else
 			return error("unable to create temporary sha1 filename %s: %s\n", t=
mpfile, strerror(errno));
 	}
--=20
1.7.1
