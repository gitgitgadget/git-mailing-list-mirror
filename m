From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 15:59:43 -0800
Message-ID: <7viq9wzq8g.fsf@alter.siamese.dyndns.org>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
 <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
 <7vljetlx8r.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1002160914140.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:00:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXKj-0000Z3-LT
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 01:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933546Ab0BPX75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:59:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933117Ab0BPX74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:59:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FD5F9A002;
	Tue, 16 Feb 2010 18:59:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=kWzgoEXeV5ziW2R+hVvdHThqZ7c=; b=lnYhbI6+hLiic75F32EFse9
	M58y7/h7n05MMgmZALa/EYlngKk+TyitPLaGF50hDDsCp/q1rJGFqS/wyud2Mjqv
	ZTBJiJ2Puq6EedVC6yL7lRfGwNApwJPXoRfOCRgvLfuUc41kQutxT/nVASy36KNE
	4XQTricEp21SgaUqQsrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=slKDO0FqUU846Sv2d9E0Pc3sRJEh87k72Cjghsf/brOBa1UjU
	9FIN0L2Rwgn9LzgvEXBrO5bWmD58pAbRfg8mCprsRVNZrklRlqjfjpZbw/30i4nS
	mV06KTRmJ/rtxnDZKOlU6AXdudSIdDfAARKcIFDc0l3o80UunGv/y0L9q0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50D039AFFE;
	Tue, 16 Feb 2010 18:59:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CE539AFFA; Tue, 16 Feb
 2010 18:59:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5EEA65C6-1B57-11DF-985B-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140184>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/builtin-grep.c b/builtin-grep.c
>> index 26d4deb..5c1545e 100644
>> --- a/builtin-grep.c
>> +++ b/builtin-grep.c
>> @@ -81,8 +81,8 @@ static pthread_mutex_t read_sha1_mutex;
>>  
>>  #define grep_lock() pthread_mutex_lock(&grep_mutex)
>>  #define grep_unlock() pthread_mutex_unlock(&grep_mutex)
>> -#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
>> -#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
>> +#define read_sha1_lock() do { if (use_threads) pthread_mutex_lock(&read_sha1_mutex); } while (0)
>> +#define read_sha1_unlock() do { if (use_threads) pthread_mutex_unlock(&read_sha1_mutex); } while (0)
>
> This is inconsistent. Just look at the code above and tell me why it is so 
> different.

It is because grep_mutex is protected by "use_threads" very high in the
callchain and do not need nor want extra if().

But I think this is much cleaner.  The patch replaces the one you are
replying to (i.e. read_sha1_{lock,unlock}() are unconditional).

-- >8 --
Subject: Fix use of mutex in threaded grep

The program can decide at runtime not to use threading even if the support
is compiled in.  In such a case, mutexes are not necessary and left
uninitialized.  But the code incorrectly tried to take and release the
read_sha1_mutex unconditionally.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Acked-by: Fredrik Kuivinen <frekui@gmail.com>
---

 builtin-grep.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 26d4deb..8cec8b6 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -408,15 +408,25 @@ static int pathspec_matches(const char **paths, const char *name, int max_depth)
 	return 0;
 }
 
+static void *read_sha1_file_locked(const unsigned char *sha1, enum object_type *type, unsigned long *size)
+{
+	void *data;
+
+	if (use_threads) {
+		read_sha1_lock();
+		data = read_sha1_file(sha1, type, size);
+		read_sha1_unlock();
+	} else {
+		data = read_sha1_file(sha1, type, size);
+	}
+	return data;
+}
+
 static void *load_sha1(const unsigned char *sha1, unsigned long *size,
 		       const char *name)
 {
 	enum object_type type;
-	char *data;
-
-	read_sha1_lock();
-	data = read_sha1_file(sha1, &type, size);
-	read_sha1_unlock();
+	void *data = read_sha1_file_locked(sha1, &type, size);
 
 	if (!data)
 		error("'%s': unable to read %s", name, sha1_to_hex(sha1));
@@ -605,10 +615,7 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 			void *data;
 			unsigned long size;
 
-			read_sha1_lock();
-			data = read_sha1_file(entry.sha1, &type, &size);
-			read_sha1_unlock();
-
+			data = read_sha1_file_locked(entry.sha1, &type, &size);
 			if (!data)
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
