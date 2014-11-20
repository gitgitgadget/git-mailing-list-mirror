From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: add a function to append a reflog entry to a fd
Date: Wed, 19 Nov 2014 18:05:34 -0800
Message-ID: <1416449134-12281-1-git-send-email-sbeller@google.com>
References: <xmqqvbma4pu3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	sahlberg@google.com
X-From: git-owner@vger.kernel.org Thu Nov 20 03:05:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrH7u-0004lT-Pr
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 03:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbaKTCFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Nov 2014 21:05:39 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34825 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbaKTCFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 21:05:38 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so1877698ier.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 18:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rN2sgblyJDICJzg62wTc7BZHfSLx9k7QabpczY8cNw4=;
        b=ARh+6JV01+G6BdLDU09tqzZsOjdaI2mk9LDKPX2K2Khk9bN7mggqzuLkCEBT7ZI46K
         RARk6+jkXs/VwNQ7qB81PZay0N8Qyve45axmGUdUQihiRsW1o+vhRIfQZ2F3SfluO+sH
         Rvj5Y130U/4bMuFqZM6GZm0cuZ697va0zQYn1/fXKjv4dYlw/g/LwP9pQyRJpPxrQibV
         EcLkUM2lpOZ+4f7MZeE9pKz4sop16qzjisYdRUju0LExHhgfg0Df3Lo9UryOCm7PTWEg
         i+t1qERsyPEbXJFkWszOYYCI141ZknIr6SQw32qxRKZPlt5n7N57uUxPkb27Yx6CiqhZ
         Ey0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=rN2sgblyJDICJzg62wTc7BZHfSLx9k7QabpczY8cNw4=;
        b=Bki9q2by/s1w+xhbn6U8KBn6acmpiMCQG+asqmhfQyY1Fz+C2/v0YzwAivuSKiIRsQ
         reHh8s2WdSk/dlNBxNcQ68Ica4z0DMcjVslvV8VgB+H+nnDGjL5lxjf7T+pAk8cB0RNp
         AYjan5mUw4iiS0xK00cU6JFzeCg9JQtqlLeaQbzFhkIFLXIjnG/fo++Flrb9SfDjVfda
         zLbSsFfvaZQ5L/hKliBqKkfWEUhucaDuVBQ0z0x31s8QnGVbFyztlQUyBq6zsq0Ig8Q7
         nbbu3x5qW+RRKwwsU4/P3sc+mJDDQkBvGG5WmSkLzFCxQimUrX7lZ8W2GW3kIthqa4/t
         UNHA==
X-Gm-Message-State: ALoCoQlwPEvgt+0vHdXdfy9fPu+B7fTGvFvHmX8XHPeE65sa56k/0cZX3e43sK3Abo845WdvV0VM
X-Received: by 10.43.99.3 with SMTP id cq3mr1654078icc.49.1416449137621;
        Wed, 19 Nov 2014 18:05:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:7876:7c52:1268:8374])
        by mx.google.com with ESMTPSA id ii3sm1781910igb.1.2014.11.19.18.05.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 18:05:37 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.23.gca0107e
In-Reply-To: <xmqqvbma4pu3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Break out the code to create the string and writing it to the file
descriptor from log_ref_write and add it into a dedicated function
log_ref_write_fd. For now this is only used from log_ref_write,
but later on we will call this function from reflog transactions too,
which means that we will end up with only a single place,
where we write a reflog entry to a file instead of the current two
places (log_ref_write and builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)
=20
Sorry for the small change w.r.t. sprintf/snprintf
Here comes a resend without changing code, but just making it a new fun=
ction,
so we come forwards with the patch.


Let's discuss the change and decide if I shouldsend a follow up patch t=
o change=20
it into snprintf.

On Wed, Nov 19, 2014 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> + =C2=A0 =C2=A0 logrec =3D xmalloc(maxlen);
>> + =C2=A0 =C2=A0 len =3D snprintf(logrec, maxlen, "%s %s %s\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sha1_to_hex(old_sha1),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sha1_to_hex(new_sha1),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0committer);
>> + =C2=A0 =C2=A0 if (msglen)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D copy_msg(logrec=
 + len - 1, msg) - 1;
>
> In this codepath, you are allocating enough buffer to hold the whole
> message; there is no difference between sprintf() and snprintf().
> If the difference mattered, you would have chopped the reflog entry
> too short, and produced a wrong result, but you then discard the
> whole record (the code that follows the above), losing data.

Hypothetically speaking:

There should be no difference between sprintf() and snprintf(). As soon=
 as you
would have a difference, you'd risk stomping on other peoples data, whi=
ch could lead
to code insertion, iff the format of the inserted data is long enough o=
verwriting
parts of your stack? Or you could change data to alter the program flow=
 to direct
the program to another easier abusable bug.
Does this make sense? This is about protecting a user from a malicious =
attacker.

> imagine you intended to copy "rm -fr ./tmpdir" and by mistake
> you stopped at "rm -fr ./" @~@).

Yes, that's when you should check the return code of snprintf and compa=
re to=20
strlen("rm -fr ./tmpdir"). That kind of bug also has severe consequence=
s, but
it's not yet involving a malicious attacker, so I'd file this as a safe=
ty instead =20
of a security flaw.

Safety related bugs are easier to find usually as you don't need to hav=
e to
think about what weird things an attacker might do. This kind of bug ca=
n be found
directly from reading the code and its surroundings=20
("there it should print 'rm -fr ./tmpdir'... Gah! I did not check the r=
eturn value")


diff --git a/refs.c b/refs.c
index 5ff457e..f9b42e5 100644
--- a/refs.c
+++ b/refs.c
@@ -2990,15 +2990,37 @@ int log_ref_setup(const char *refname, char *lo=
gfile, int bufsize)
 	return 0;
 }
=20
+static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const char *committer, const char *msg)
+{
+	int msglen, written;
+	unsigned maxlen, len;
+	char *logrec;
+
+	msglen =3D msg ? strlen(msg) : 0;
+	maxlen =3D strlen(committer) + msglen + 100;
+	logrec =3D xmalloc(maxlen);
+	len =3D sprintf(logrec, maxlen, "%s %s %s\n",
+		      sha1_to_hex(old_sha1),
+		      sha1_to_hex(new_sha1),
+		      committer);
+	if (msglen)
+		len +=3D copy_msg(logrec + len - 1, msg) - 1;
+
+	written =3D len <=3D maxlen ? write_in_full(fd, logrec, len) : -1;
+	free(logrec);
+	if (written !=3D len)
+		return -1;
+
+	return 0;
+}
+
 static int log_ref_write(const char *refname, const unsigned char *old=
_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
-	int logfd, result, written, oflags =3D O_APPEND | O_WRONLY;
-	unsigned maxlen, len;
-	int msglen;
+	int logfd, result, oflags =3D O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
-	char *logrec;
-	const char *committer;
=20
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates =3D !is_bare_repository();
@@ -3010,19 +3032,9 @@ static int log_ref_write(const char *refname, co=
nst unsigned char *old_sha1,
 	logfd =3D open(log_file, oflags);
 	if (logfd < 0)
 		return 0;
-	msglen =3D msg ? strlen(msg) : 0;
-	committer =3D git_committer_info(0);
-	maxlen =3D strlen(committer) + msglen + 100;
-	logrec =3D xmalloc(maxlen);
-	len =3D sprintf(logrec, "%s %s %s\n",
-		      sha1_to_hex(old_sha1),
-		      sha1_to_hex(new_sha1),
-		      committer);
-	if (msglen)
-		len +=3D copy_msg(logrec + len - 1, msg) - 1;
-	written =3D len <=3D maxlen ? write_in_full(logfd, logrec, len) : -1;
-	free(logrec);
-	if (written !=3D len) {
+	result =3D log_ref_write_fd(logfd, old_sha1, new_sha1,
+				  git_committer_info(0), msg);
+	if (result) {
 		int save_errno =3D errno;
 		close(logfd);
 		error("Unable to append to %s", log_file);
--=20
2.2.0.rc2.13.g0786cdb
