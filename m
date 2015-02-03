From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] apply: do not touch a file beyond a symbolic link
Date: Mon, 2 Feb 2015 20:11:40 -0500
Message-ID: <20150203011139.GC31946@peff.net>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1422919650-13346-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 02:12:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIS2i-0007NT-7a
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 02:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbbBCBLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 20:11:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:44341 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752726AbbBCBLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 20:11:42 -0500
Received: (qmail 29608 invoked by uid 102); 3 Feb 2015 01:11:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 19:11:42 -0600
Received: (qmail 4763 invoked by uid 107); 3 Feb 2015 01:11:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 20:11:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 20:11:40 -0500
Content-Disposition: inline
In-Reply-To: <1422919650-13346-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263299>

On Mon, Feb 02, 2015 at 03:27:30PM -0800, Junio C Hamano wrote:

> +static struct string_list symlink_changes;

I notice we don't duplicate strings for this list. Are the paths we
register here always stable? I think they should be, as they are part of
the "struct patch".

> +#define SYMLINK_GOES_AWAY 01
> +#define SYMLINK_IN_RESULT 02
> +
> +static uintptr_t register_symlink_changes(const char *path, uintptr_t what)
> +{
> +	struct string_list_item *ent;
> +
> +	ent = string_list_lookup(&symlink_changes, path);
> +	if (!ent) {
> +		ent = string_list_insert(&symlink_changes, path);
> +		ent->util = (void *)0;
> +	}
> +	ent->util = (void *)(what | ((uintptr_t)ent->util));
> +	return (uintptr_t)ent->util;
> +}

I was surprised to see this as a bit-field and not a "current state" as
we walk through the set of patches to apply. I think this means we'll be
overly cautious with a patch that does:

  1. add foo as a symlink

  2. remove foo

  3. add foo/bar

which is perfectly OK, but we'll reject. I suspect this is making things
much simpler for you, because now we don't have to worry about order of
application that we were discussing the other day. If that is the
reason, then I think patches like the above are an acceptable casualty.
It seems rather far-fetched in the first place for a real patch (as
opposed to a mischievous one).

> +	/*
> +	 * An attempt to read from or delete a path that is beyond
> +	 * a symbolic link will be prevented by load_patch_target()
> +	 * that is called at the beginning of apply_data().  We need
> +	 * to make sure that the patch result is not deposited to
> +	 * a path that is beyond a symbolic link ourselves.
> +	 */
> +	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
> +		return error(_("affected file '%s' is beyond a symbolic link"),
> +			     patch->new_name);

Do we need to check the patch->is_delete case here (with patch->old_name)?

I had a suspicion that the new patch 3/4 to check the reading-side might
help with that, but the comment here sounds like we do need to check
here, too (and I am not clear on how 3/4 handles deleting from a patch
on the far side of a symlink we have just created).

It does seem to work, though. I'm just not sure how. :)

Here's the test addition I came up with, because it didn't look like we
were covering this case. 

diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 942c5cb..fbba8dd 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -89,6 +89,7 @@ test_expect_success SYMLINKS 'do not follow symbolic link (setup)' '
 	rm -fr arch/x86_64/dir &&
 
 	cat add_symlink.patch add_file.patch >patch &&
+	cat add_symlink.patch del_file.patch >tricky_del &&
 
 	mkdir arch/i386/dir
 '
@@ -112,6 +113,20 @@ test_expect_success SYMLINKS 'do not follow symbolic link (same input)' '
 	test_i18ngrep "beyond a symbolic link" error-ct &&
 	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
 	test_must_fail git ls-files --error-unmatch arch/i386/dir
+
+	>arch/i386/dir/file &&
+	git add arch/i386/dir/file &&
+	test_must_fail git apply tricky_del &&
+	test_path_is_file arch/i386/dir/file &&
+
+	test_must_fail git apply --index tricky_del &&
+	test_path_is_file arch/i386/dir/file &&
+	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
+	git ls-files --error-unmatch arch/i386/dir &&
+
+	test_must_fail git apply --cached tricky_del &&
+	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
+	git ls-files --error-unmatch arch/i386/dir
 '
 
 test_expect_success SYMLINKS 'do not follow symbolic link (existing)' '
@@ -125,6 +140,7 @@ test_expect_success SYMLINKS 'do not follow symbolic link (existing)' '
 	test_i18ngrep "beyond a symbolic link" error-wt-add &&
 	test_path_is_missing arch/i386/dir/file &&
 
+	mkdir arch/i386/dir &&
 	>arch/i386/dir/file &&
 	test_must_fail git apply del_file.patch 2>error-wt-del &&
 	test_i18ngrep "beyond a symbolic link" error-wt-del &&
