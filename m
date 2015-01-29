From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] apply: refuse touching a file beyond symlink
Date: Thu, 29 Jan 2015 12:45:22 -0800
Message-ID: <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Thu Jan 29 21:45:41 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YGvy6-0005B4-06
	for glk-linux-kernel-3@plane.gmane.org; Thu, 29 Jan 2015 21:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757747AbbA2Upd (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Jan 2015 15:45:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757356AbbA2Upb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2015 15:45:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C1AA32FCD;
	Thu, 29 Jan 2015 15:45:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s0h0cwU9FRI4tlrkEoKRdsfAfGw=; b=qgJCdM
	vnIl8dzo/tFFyM55Eec8bXOvS0cmQSICc0/lFMaOFkVyN/UBRt9ur6XYSoy7HLgK
	MXFlEasncac934FtnkaAv5fwBcFd5W8blLSqnwAtYfmjdhh7t9O9iyo3NEyaDWj5
	g7iKs8hjPnOVEfS7BuYLDsrRHTD+EOg+/F6XU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hUSV0Hrb4MQIsO5xi1BXrvHUfI0CuyJr
	HMpHbW/ngXOHykq1YFVZqejI7GvT2iqqs97uZGASEzY7Jysm0rEWCHYRqtFVxy+B
	MhZ6KzdRpu5mPmhdqEWcC9ZpKolYhwzvabtrnFtS6647qiDtP9dyt6eHbQ5s2OOb
	VmHNFKQmt+U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EE0032FCB;
	Thu, 29 Jan 2015 15:45:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48A0F32FC0;
	Thu, 29 Jan 2015 15:45:24 -0500 (EST)
In-Reply-To: <xmqqtwzadrj8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 28 Jan 2015 22:34:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BFBFD638-A7F7-11E4-A922-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263161>

Because Git tracks symbolic links as symbolic links, a path that has
a symbolic link in its leading part (e.g. path/to/dir/file, where
path/to/dir is a symbolic link to somewhere else, be it inside or
outside the working tree) can never appear in a patch that validly
applies, unless the same patch first removes the symbolic link to
allow a directory to be there.

Detect and reject such a patch.  Things to note:

 - Unfortunately, we cannot reuse the has_symlink_leading_path()
   from dir.c, as that is only about the working tree, but "git
   apply" can be told to apply the patch only to the index or to
   both the index and to the working tree.

 - We cannot directly use has_symlink_leading_path() even when we
   are applying only to the working tree, as an early patch of a
   valid input may remove a symbolic link path/to/dir and then a
   later patch of the input may create a path path/to/dir/file, but
   "git apply" first checks the input without touching either the
   index or the working tree.  The leading symbolic link check must
   be done on the interim result we compute in-core (i.e. after the
   first patch, there is no path/to/dir symbolic link and it is
   perfectly valid to create path/to/dir/file).

   Similarly, when an input creates a symbolic link path/to/dir and
   then creates a file path/to/dir/file, we need to flag it as an
   error without actually creating path/to/dir symbolic link in the
   filesystem.

Instead, for any patch in the input that leaves a path (i.e. a non
deletion) in the result, we check all leading paths against interim
result and then either the index or the working tree.  The interim
results of applying patches are kept track of by fn_table logic for
us already, so use it to fiture out if existing a symbolic link will
cause problems, if a new symbolic link that will cause problems will
appear, etc.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * At least I convinced myself enough to say that I do not seem to
   be breaking things with this patch, after taking patches out of
   dozens of random pairs of commits from the Linux kernel history
   and applying them using this version ;-) No code change since
   last night's snapshot, but the test script is a bit more thorough
   in this version.

 builtin/apply.c                 | 44 +++++++++++++++++++++++++++++
 t/t4122-apply-symlink-inside.sh | 62 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index ef32e4f..dcb44fb 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3483,6 +3483,46 @@ static int check_to_create(const char *new_name, int ok_if_exists)
 	return 0;
 }
 
+static int path_is_beyond_symlink(const char *name_)
+{
+	struct strbuf name = STRBUF_INIT;
+
+	strbuf_addstr(&name, name_);
+	do {
+		struct patch *previous;
+
+		while (--name.len && name.buf[name.len] != '/')
+			; /* scan backwards */
+		if (!name.len)
+			break;
+		name.buf[name.len] = '\0';
+		previous = in_fn_table(name.buf);
+		if (previous) {
+			if (!was_deleted(previous) &&
+			    !to_be_deleted(previous) &&
+			    previous->new_mode &&
+			    S_ISLNK(previous->new_mode))
+				goto symlink_found;
+		} else if (check_index) {
+			int pos = cache_name_pos(name.buf, name.len);
+			if (0 <= pos &&
+			    S_ISLNK(active_cache[pos]->ce_mode))
+				goto symlink_found;
+		} else {
+			struct stat st;
+			if (!lstat(name.buf, &st) && S_ISLNK(st.st_mode))
+				goto symlink_found;
+		}
+	} while (1);
+
+	strbuf_release(&name);
+	return 0;
+symlink_found:
+	strbuf_release(&name);
+	return 1;
+
+}
+
 /*
  * Check and apply the patch in-core; leave the result in patch->result
  * for the caller to write it out to the final destination.
@@ -3570,6 +3610,10 @@ static int check_patch(struct patch *patch)
 		}
 	}
 
+	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
+		return error(_("affected file '%s' is beyond a symbolic link"),
+			     patch->new_name);
+
 	if (apply_data(patch, &st, ce) < 0)
 		return error(_("%s: patch does not apply"), name);
 	patch->rejected = 0;
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 70b3a06..0a8de4a 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -52,4 +52,66 @@ test_expect_success 'check result' '
 
 '
 
+test_expect_success SYMLINKS 'do not follow symbolic link (setup)' '
+
+	git reset --hard &&
+	ln -s ../i386/dir arch/x86_64/dir &&
+	git add arch/x86_64/dir &&
+	git diff HEAD >add_symlink.patch &&
+	git reset --hard &&
+
+	mkdir arch/x86_64/dir &&
+	>arch/x86_64/dir/file &&
+	git add arch/x86_64/dir/file &&
+	git diff HEAD >add_file.patch &&
+	git reset --hard &&
+	rm -fr arch/x86_64/dir &&
+
+	cat add_symlink.patch add_file.patch >patch &&
+
+	mkdir arch/i386/dir
+'
+
+test_expect_success SYMLINKS 'do not follow symbolic link (same input)' '
+
+	# same input creates a confusihng symbolic link
+	test_must_fail git apply patch 2>error-wt &&
+	test_i18ngrep "beyond a symbolic link" error-wt &&
+	test ! -e arch/x86_64/dir &&
+	test ! -e arch/i386/dir/file &&
+
+	test_must_fail git apply --index patch 2>error-ix &&
+	test_i18ngrep "beyond a symbolic link" error-ix &&
+	test ! -e arch/x86_64/dir &&
+	test ! -e arch/i386/dir/file &&
+	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
+	test_must_fail git ls-files --error-unmatch arch/i386/dir &&
+
+	test_must_fail git apply --cached patch 2>error-ct &&
+	test_i18ngrep "beyond a symbolic link" error-ct &&
+	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
+	test_must_fail git ls-files --error-unmatch arch/i386/dir
+'
+
+test_expect_success SYMLINKS 'do not follow symbolic link (existing)' '
+
+	# existing symbolic link
+	git reset --hard &&
+	ln -s ../i386/dir arch/x86_64/dir &&
+	git add arch/x86_64/dir &&
+
+	test_must_fail git apply add_file.patch 2>error-wt-file &&
+	test_i18ngrep "beyond a symbolic link" error-wt-file &&
+	test ! -e arch/i386/dir/file &&
+
+	test_must_fail git apply --index add_file.patch 2>error-ix-file &&
+	test_i18ngrep "beyond a symbolic link" error-ix-file &&
+	test ! -e arch/i386/dir/file &&
+	test_must_fail git ls-files --error-unmatch arch/i386/dir &&
+
+	test_must_fail git apply --cached add_file.patch 2>error-ct-file &&
+	test_i18ngrep "beyond a symbolic link" error-ct-file &&
+	test_must_fail git ls-files --error-unmatch arch/i386/dir
+'
+
 test_done
-- 
2.3.0-rc2-153-g9e53805
