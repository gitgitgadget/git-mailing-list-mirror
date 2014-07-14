From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon, 14 Jul 2014 10:43:16 -0700
Message-ID: <xmqqzjgbygy3.fsf@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<1405140276-32162-4-git-send-email-dturner@twitter.com>
	<CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
	<xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:43:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6kHq-0000RG-FH
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 19:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494AbaGNRnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 13:43:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53414 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756126AbaGNRn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 13:43:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC31326C7C;
	Mon, 14 Jul 2014 13:43:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=UoJhbaM7EGg0Giq1HT3Chj19y3M=; b=Mpl7mm66UkOpZf+a62uQ
	MsxJ8G5aG/jt7FjJybSgFguc44s5ATHmSRqR1bzEy95UJhXKKzOC+1aGjr87eQLp
	gk16ggRako3sMrkRi/URzTDeVJWF9RbrUv95RBSmzMpED2zXfZ9jK+QDlNZf3F2V
	/GoqqxUH5ikINpEWtMC8wmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DtXcM8Fkhk6hhAfDDR5HFAV+AtTtTgudPVTemmvFEcQoex
	tx2t7qudngEcT/MJIWW+zuzOJVUwI3Qm+2H1E1VWLqfheGwEhrHY63w4xJpwYKxB
	rexssAGWYExdI6NxVMUydyB0Xqc4bY9Fjh97j3NPXnCWj4FEFMcs3IeGAgf8c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 64DF526C7B;
	Mon, 14 Jul 2014 13:43:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F327426C6C;
	Mon, 14 Jul 2014 13:43:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4CCADE18-0B7E-11E4-95C6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253500>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Jul 12, 2014 at 11:44 AM, David Turner <dturner@twopensource.com> wrote:
>>> @@ -342,6 +342,15 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>>>
>>>                 discard_cache();
>>>                 read_cache_from(index_lock.filename);
>>> +               if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
>>> +                       fd = open(index_lock.filename, O_WRONLY);
>>> +                       if (fd >= 0)
>>> +                               if (write_cache(fd, active_cache, active_nr) == 0) {
>>> +                                       close_lock_file(&index_lock);
>>
>> If write_cache() returns a negative value, index.lock is probably
>> corrupted. Should we die() instead of moving on and returning
>> index_lock.filename to the caller? The caller may move index.lock to
>> index later on and officially ruin "index".
>
> Perhaps true, but worse yet, this will not play nicely together with
> your split index series, no?  After taking the lock and writing and
> closing, we spawn the interactive while still holding the lock, and
> the "open" we see here is because we want to further update the same
> under the same lock.  Perhaps write_locked_index() API in the split
> index series can notice that the underlying fd in index_lock has
> been closed earlier, realize that the call is to re-update the
> index under the same lock and open the file again for writing?
>
> Then we can update the above "open() then write_cache()" sequence
> with just a call to "write_locked_index()".

Or perhaps introduce reopen_locked_file() and have these rare
callers that want to re-update after they closed the file call it,
in order to avoid mistake?

Perhaps something like this on top of your series?

-- >8 --
Subject: [PATCH] lockfile: allow reopening a closed but still locked file

In some code paths (e.g. giving "add -i" to prepare the contents to
be committed interactively inside "commit -p") where a caller takes
a lock, writes the new content, give chance for others to use it
while still holding the lock, and then releases the lock when all is
done.  As an extension, allow the caller to re-update an already
closed file while still holding the lock (i.e. not yet committed) by
re-opening the file, to be followed by updating the contents and
then by the usual close_lock_file() or commit_lock_file().

This is necessary if we want to add code to rebuild the cache-tree
and write the resulting index out after "add -i" returns the control
to "commit -p", for example.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h    |  7 ++++---
 lockfile.c | 51 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/cache.h b/cache.h
index c6b7770..a9344cf 100644
--- a/cache.h
+++ b/cache.h
@@ -567,12 +567,13 @@ extern NORETURN void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
-extern void update_index_if_able(struct index_state *, struct lock_file *);
+extern int reopen_lock_file(struct lock_file *);
+extern int close_lock_file(struct lock_file *);
+extern void rollback_lock_file(struct lock_file *);
 
+extern void update_index_if_able(struct index_state *, struct lock_file *);
 extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
-extern int close_lock_file(struct lock_file *);
-extern void rollback_lock_file(struct lock_file *);
 extern int delete_ref(const char *, const unsigned char *sha1, int delopt);
 
 /* Environment bits from configuration mechanism */
diff --git a/lockfile.c b/lockfile.c
index b706614..618a4b2 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -120,21 +120,8 @@ static char *resolve_symlink(char *p, size_t s)
 	return p;
 }
 
-
-static int lock_file(struct lock_file *lk, const char *path, int flags)
+static int lock_file_open(struct lock_file *lk)
 {
-	/*
-	 * subtract 5 from size to make sure there's room for adding
-	 * ".lock" for the lock file name
-	 */
-	static const size_t max_path_len = sizeof(lk->filename) - 5;
-
-	if (strlen(path) >= max_path_len)
-		return -1;
-	strcpy(lk->filename, path);
-	if (!(flags & LOCK_NODEREF))
-		resolve_symlink(lk->filename, max_path_len);
-	strcat(lk->filename, ".lock");
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
 		if (!lock_file_list) {
@@ -156,6 +143,23 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	return lk->fd;
 }
 
+static int lock_file(struct lock_file *lk, const char *path, int flags)
+{
+	/*
+	 * subtract 5 from size to make sure there's room for adding
+	 * ".lock" for the lock file name
+	 */
+	static const size_t max_path_len = sizeof(lk->filename) - 5;
+
+	if (strlen(path) >= max_path_len)
+		return -1;
+	strcpy(lk->filename, path);
+	if (!(flags & LOCK_NODEREF))
+		resolve_symlink(lk->filename, max_path_len);
+	strcat(lk->filename, ".lock");
+	return lock_file_open(lk);
+}
+
 static char *unable_to_lock_message(const char *path, int err)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -221,6 +225,25 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	return fd;
 }
 
+/*
+ * After calling close_lock_file() to flush the contents to the
+ * disk, without releasing the lock, this can be called to reopen
+ * to update the contents of the file.  An expected calling sequence
+ * is
+ *
+ * hold_lock_file(lk), write(lk->fd), close_lock_file(lk),
+ * reopen_lock_file(lk), write(lk->fd), close_lock_file(lk),
+ * commit_lock_file(lk).
+ */
+int reopen_lock_file(struct lock_file *lk)
+{
+	if (0 <= lk->fd)
+		die(_("BUG: attempt to reopen an unclosed lockfile"));
+	if (!lk->filename[0])
+		die(_("BUG: attempt to reopen a committed lockfile"));
+	return lock_file_open(lk);
+}
+
 int close_lock_file(struct lock_file *lk)
 {
 	int fd = lk->fd;
-- 
2.0.1-812-g56968e3
