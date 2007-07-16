From: Carlos Rica <jasampler@gmail.com>
Subject: Changes in function read_pipe
Date: Mon, 16 Jul 2007 18:13:45 +0200
Message-ID: <469B9939.5050800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 18:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IATCy-00083i-Lw
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 18:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708AbXGPQN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 16 Jul 2007 12:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759145AbXGPQN5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 12:13:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:29532 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612AbXGPQN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 12:13:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1009919ugf
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 09:13:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=g8iFt4x90hvNfvgagAx6Cqvf9/3FNIOHToXVF5C2jy1aZeUMakKPA/3XgqsTSVvNCxxe8xYiQzKYAvnkeiSuV/n22DuEmrokcgkemdmhrUJniMWhqb0jxYOIEf2ptnz9ez1dTjB31xjubtP5DKrEfJT1UkcreZJSzlQfmVweTiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=tWYQYXc74xmJVZstdb2pwtyKudiVx/q7qFeKA+LFmGP8LAgncSwxGKb07jswif8PE4wKk+W7vrPCGXqqdMxazQxcMkcb4wbLTTzJDKG+1TGbTGtlVVxdbTZ3zxNn7ff0KrgVESNo8IiBGv22fnwVVkaQKHME/dEp9GMBS2IxOkE=
Received: by 10.66.222.9 with SMTP id u9mr4414652ugg.1184602435237;
        Mon, 16 Jul 2007 09:13:55 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id j34sm1464833ugc.2007.07.16.09.13.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jul 2007 09:13:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52681>

Some people talked recently about renaming the function read_pipe
(sha1_file.c) to the better name read_fd.
Here I discuss other possible changes to the current version:

1. It now requires to allocate memory for the buffer before calling it,
you cannot pass it a pointer set to NULL or not initializated at all.

2. The function doesn't terminate the data with NUL, and if you
need that, you must to realloc before adding the '\0', because
the function only returns the size of the data, not the buffer size.

3. When function fails in reading (xread returns < 0), buffer is not
freed.

I'm not sure which of those issues are really important,
so I thought it was better to ask this in the list.
This is the current implementation of the function:

/*
 * reads from fd as long as possible into a supplied buffer of size byt=
es.
 * If necessary the buffer's size is increased using realloc()
 *
 * returns 0 if anything went fine and -1 otherwise
 *
 * NOTE: both buf and size may change, but even when -1 is returned
 * you still have to free() it yourself.
 */
int read_pipe(int fd, char** return_buf, unsigned long* return_size)
{
	char* buf =3D *return_buf;
	unsigned long size =3D *return_size;
	ssize_t iret;
	unsigned long off =3D 0;

	do {
		iret =3D xread(fd, buf + off, size - off);
		if (iret > 0) {
			off +=3D iret;
			if (off =3D=3D size) {
				size *=3D 2;
				buf =3D xrealloc(buf, size);
			}
		}
	} while (iret > 0);

	*return_buf =3D buf;
	*return_size =3D off;

	if (iret < 0)
		return -1;
	return 0;
}

Kristian H=F8gsberg recently sent some changes to the function
to replace the function with another one easier to call, but
with a different behavior:

 /*
- * reads from fd as long as possible into a supplied buffer of size by=
tes.
- * If necessary the buffer's size is increased using realloc()
+ * reads from fd as long as possible and allocates a buffer to hold
+ * the contents.  The buffer and size of the contents is returned in
+ * *return_buf and *return_size.  In case of failure, the allocated
+ * buffers are freed, otherwise, the buffer must be freed using xfree.
  *
  * returns 0 if anything went fine and -1 otherwise
- *
- * NOTE: both buf and size may change, but even when -1 is returned
- * you still have to free() it yourself.
  */
-int read_pipe(int fd, char** return_buf, unsigned long* return_size)
+int read_fd(int fd, char** return_buf, unsigned long* return_size)
 {
-	char* buf =3D *return_buf;
-	unsigned long size =3D *return_size;
+	unsigned long size =3D 4096;
+	char* buf =3D xmalloc(size);
 	ssize_t iret;
 	unsigned long off =3D 0;

@@ -2328,21 +2327,22 @@ int read_pipe(int fd, char** return_buf, unsign=
ed long* return_size)
 	*return_buf =3D buf;
 	*return_size =3D off;

-	if (iret < 0)
+	if (iret < 0) {
+		free(buf);
 		return -1;
+	}
+
 	return 0;
 }

Any other ideas? read_pipe is really handy to reuse on builtins,
so we need to decide how we should call to it now before starting
to reuse it in many places.

Comments will be appreciated.
