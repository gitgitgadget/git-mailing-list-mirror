From: =?UTF-8?B?55m944GE54aK?= <ShiroiKuma@ShiroiKuma.org>
Subject: tar-tree.c dereferencing pointer to incomplete type
Date: Sat, 19 Jan 2013 16:31:38 +0300
Message-ID: <CAPy7p-45-E-vWcjBTXSLpjoQLic54JdAoKqB3jz4RA6GzAkw8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 14:32:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwYWf-00005T-E3
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 14:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab3ASNbk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 08:31:40 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:32997 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab3ASNbj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 08:31:39 -0500
Received: by mail-qc0-f176.google.com with SMTP id n41so2937855qco.21
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 05:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=DVlqaCPe1qX+SCSjfhq5nugrywd7KZmnh+rlQzXn8Xk=;
        b=VeicrmS/m3CjQLg+BDzQbFK7dkVa+ZnTLymuvYZqI24x5acke32mtPd9Ypnrzu4Il2
         jMM22i1ZDT6gkfgAuuZ4qstpjkSz/G7OYzhC/h1fINa1NsLIzBehcmN8mzWEOBdXOU9w
         ZcRxmnt7fd1zl6v2WI7ufSq0Vb42S7FJ37YehcYe0XQj86i+UXgL71bHSiEmp9LRGmtw
         Kuuv/ee6A2fe5jHAjlsWZLLGOAujVjyeIWuFcnhpZIV89CDxT7PzWtTx4ncAZ12bCec0
         ppvhZDWfQt+2QWk9PdGRBhspdpQugocfswVrCvtl2YWYzG8mdeMIOMF4CYCKN4CvyqM6
         b6nQ==
X-Received: by 10.224.76.208 with SMTP id d16mr13181083qak.46.1358602298984;
 Sat, 19 Jan 2013 05:31:38 -0800 (PST)
Received: by 10.229.130.163 with HTTP; Sat, 19 Jan 2013 05:31:38 -0800 (PST)
X-Google-Sender-Auth: GHH4cQqXy1eBowJCfPNTDS8szDU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213975>

Hello:

I'm building v 1.8.1.1 on Android. The build chokes on the builtins
phase on tar-tree.c with:

    CC builtin/tar-tree.o
builtin/tar-tree.c: In function 'cmd_get_tar_commit_id':
builtin/tar-tree.c:93:12: error: dereferencing pointer to incomplete ty=
pe
make: *** [builtin/tar-tree.o] Error 1

The line that's causing this in tar-tree.c is:

if (header->typeflag[0] !=3D 'g')

from

int cmd_get_tar_commit_id(int argc, const char **argv, const char *pref=
ix)
{
	char buffer[HEADERSIZE];
	struct ustar_header *header =3D (struct ustar_header *)buffer;
	char *content =3D buffer + RECORDSIZE;
	ssize_t n;

	if (argc !=3D 1)
		usage(builtin_get_tar_commit_id_usage);

	n =3D read_in_full(0, buffer, HEADERSIZE);
	if (n < HEADERSIZE)
		die("git get-tar-commit-id: read error");
	if (header->typeflag[0] !=3D 'g')
		return 1;
	if (memcmp(content, "52 comment=3D", 11))
		return 1;

	n =3D write_in_full(1, content + 11, 41);
	if (n < 41)
		die_errno("git get-tar-commit-id: write error");

	return 0;
}

But why?

What's messed up with my setup.

I can compile no probs on other machines. I'm trying to get my head
round this, but don't see the problem?
--=20
=E7=99=BD=E3=81=84=E7=86=8A
