From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'error: unable to set permission to './objects/...'
Date: Mon, 23 Nov 2009 02:54:37 -0800
Message-ID: <7vhbsl5x5e.fsf@alter.siamese.dyndns.org>
References: <9bbf67fa0911221202r605de38coc2496b1f09123725@mail.gmail.com>
 <7vd43acf7y.fsf@alter.siamese.dyndns.org>
 <9bbf67fa0911230135j7cfe5bcem991e750b6754f344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafal Rusin <rafal.rusin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 11:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCWZS-0000dn-6u
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 11:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173AbZKWKyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 05:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757169AbZKWKyn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 05:54:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757166AbZKWKyk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 05:54:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B088A03F0;
	Mon, 23 Nov 2009 05:54:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KqIgXMAZ3XhvONo+7kpQwirXDVs=; b=q0HVcm
	UmNTzWl4LPpSqF/YbHu08LrugY+UafWNBNW6zRvGRjE3GcU2ZPHzM3cja2SfGLxv
	8dxdbtEvf0vXoEyQ9FO05sVDtLhmdj3a/GGJH8zHBySqPEsYH6XoQS2t5evcheIh
	osPKJEI9psuPjEo5b540ipWDgq179t37EQQrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TybFjo1YB9sXaD1R25IgDhYKFU7E5boc
	fp97uzz9GNGz0MZLZmEOfuVyHknoZpHlknADXgyubIfWRhn5bi2uQBZPI6gP6BHO
	LG12JcUT+akLPTO/hRUb5sw3Q9t6e9ffVAlQU9VKk0xu90MZmPlh49mGGdYuMIBD
	WTJIHVPtRmA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB259A03EB;
	Mon, 23 Nov 2009 05:54:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D889A03E8; Mon, 23 Nov 2009
 05:54:39 -0500 (EST)
In-Reply-To: <9bbf67fa0911230135j7cfe5bcem991e750b6754f344@mail.gmail.com>
 (Rafal Rusin's message of "Mon\, 23 Nov 2009 10\:35\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9AE812F2-D81E-11DE-9E5E-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133497>

Rafal Rusin <rafal.rusin@gmail.com> writes:

> As for detecting this particular case, I think it's not possible.

Why not?

> I think the best solution is to add repository config switch like
> 'usefilepermissions' true by default. If set to false, git would skip
> chmod during push.
> Does that make sense to you?

Not at all.  That is like creating an "allow broken behaviour" option and
hoping for the best.

You shouldn't have to invent such a configuration variable to begin with,
as "let umask set whatever permission and leave it be" should already be
the case for !core.sharedrepository.  There is something wrong in your
set up and you need to get to the bottom of it, instead of coming up with
an even worse breakage as a unworkable workaround.

There are some things I noticed while looking at the codepaths that are
involved.

move_temp_to_file() is designed to move a temporary file that was created
by odb_mkstemp().  As the latter eventually uses mkstemp(), some
implementations of which ignore umask and create a file that is readable
only by the user, move_temp_to_file() must loosen the permission, even in
a private repository that honors umask (i.e. not in a shared repository)..

    Side note.  The creation of the temporary files in http.c that are
    given to move_temp_to_file() is not quite correct; they are created by
    fopen() without proper locking with mkstemp().  But that is a separate
    issue.

But the codepath tries to loosen it a bit too much.  Even if user's umask
is 077, files created in this codepath end up with world-readable because
we pretend that lstat() on the file returned 0444 (that is what a non-zero
value given as the second parameter to set_shared_perm() means).  We
should tighten it perhaps like the attached patch does.

In case it is not obvious, this patch is _not_ meant to help you work
around the chmod() failure you are seeing on your filesystem.  You need to
first see _why_ it fails for you, in order to come closer to the real
solution.

-- >8 --
Subject: [PATCH] move_temp_to_file(): don't loosen permission too much

We always feed 0444 as the second parameter to set_shared_perm() when
finalizing a temporary file we created using mkstemp(), as some versions
of glibc creates a temporary file with too tight a permission, ignoring
the user's umask.  As the second parameter tells set_shared_perm() to
pretend that it is the permission bits the file currently has (i.e. what
should have been set by the user's umask), we should make it just as
restrictive as user's umask suggests.

---
 sha1_file.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 63981fb..f0b8969 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2233,6 +2233,21 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
 	git_SHA1_Final(sha1, &c);
 }
 
+static int fix_tempfile_mode(const char *filename)
+{
+	static mode_t user_mode;
+
+	if (!user_mode) {
+		user_mode = umask(0);
+		umask(user_mode);
+		user_mode = S_IFREG | ((user_mode ^ 0777) & 0666);
+	}
+
+	if (!set_shared_perm(filename, user_mode))
+		return 0;
+	return error("unable to set permission to '%s'", filename);
+}
+
 /*
  * Move the just written object into its final resting place.
  * NEEDSWORK: this should be renamed to finalize_temp_file() as
@@ -2274,9 +2289,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 	}
 
 out:
-	if (set_shared_perm(filename, (S_IFREG|0444)))
-		return error("unable to set permission to '%s'", filename);
-	return 0;
+	return fix_tempfile_mode(filename);
 }
 
 static int write_buffer(int fd, const void *buf, size_t len)
