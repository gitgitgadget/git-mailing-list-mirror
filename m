From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] lockfile: allow reopening a closed but still locked file
Date: Mon, 14 Jul 2014 13:19:42 -0700
Message-ID: <xmqqr41ny9pd.fsf_-_@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<1405140276-32162-4-git-send-email-dturner@twitter.com>
	<CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
	<xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
	<xmqqzjgbygy3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 22:19:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6mj8-0001yC-1y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293AbaGNUTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:19:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62382 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757151AbaGNUTu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:19:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B91CF27653;
	Mon, 14 Jul 2014 16:19:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kIfTABcO7Dn01xwK/qf94Xqkp5o=; b=fu0zmW
	msj5ZwEdjtPHWDuRMA9QB05w8IpsZFvflT7HH2bcSP1YBfT9qS1RsRsbCpVgT4Wm
	zjKs7cNR8L0UPayqOVjEIKluQgy4MluA2qovCKcAq7R9nGz17wlgRBWdljvSjcKV
	rftlDLbq/m5TMBKnffB+LECFUzPJUzWqXsVLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RVqkopszEDb26vKhh94dPJlEEL0dAeZ+
	akDmSS4L9xz0LTEamViSZGqIaJ1lS6CU+5iyGW+lkUv+bCI65swDmpUIWBkJPYVl
	E6ECsytSosL9Hk9NXlW6RdbGwcn4UYBZSjI2M7GSXIW8AE0ekhgtW+T5b7wdjwYw
	/YWu3hphnr4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AEB2427650;
	Mon, 14 Jul 2014 16:19:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CE19A27648;
	Mon, 14 Jul 2014 16:19:26 -0400 (EDT)
In-Reply-To: <xmqqzjgbygy3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 14 Jul 2014 10:43:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 27318524-0B94-11E4-A7F8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253512>

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

 * I was being silly in the first attemt as usual ;-)  There is not
   much to be shared between the reopen and initial open code path
   in that we do not want to give O_EXCL to open(), we know the file
   exists so O_CREAT is not necessary, we know we have added it to
   the unlocked-atexit list and we already know that we have futzed
   with its permission bits.

   With this added on top of the nd/split-index series, the conflict
   resolution for the "interactive" codepath in builtin/commit.c
   with dt/cache-tree-repair topic would become like this:

  @@ -340,6 +340,13 @@ static char *prepare_index(int argc, const char

                  discard_cache();
                  read_cache_from(index_lock.filename);
  +               if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
  +                       if (reopen_lock_file(&index_lock) < 0)
  +                               die(_("unable to write index file"));
  +                       if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
  +                               die(_("unable to update temporary index"));
  +               } else
  +                       warning(_("Failed to update main cache tree"));

                  commit_style = COMMIT_NORMAL;
                  return index_lock.filename;

 cache.h    |  1 +
 lockfile.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/cache.h b/cache.h
index c6b7770..b780794 100644
--- a/cache.h
+++ b/cache.h
@@ -567,6 +567,7 @@ extern NORETURN void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
+extern int reopen_lock_file(struct lock_file *);
 extern void update_index_if_able(struct index_state *, struct lock_file *);
 
 extern int hold_locked_index(struct lock_file *, int);
diff --git a/lockfile.c b/lockfile.c
index b706614..9c12ec5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -228,6 +228,16 @@ int close_lock_file(struct lock_file *lk)
 	return close(fd);
 }
 
+int reopen_lock_file(struct lock_file *lk)
+{
+	if (0 <= lk->fd)
+		die(_("BUG: reopen a lockfile that is still open"));
+	if (!lk->filename[0])
+		die(_("BUG: reopen a lockfile that has been committed"));
+	lk->fd = open(lk->filename, O_WRONLY);
+	return lk->fd;
+}
+
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
-- 
2.0.1-814-g49d294e
