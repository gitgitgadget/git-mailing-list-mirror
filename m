From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 13:11:53 -0500
Message-ID: <20150130181153.GA25513@peff.net>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
 <CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
 <CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
 <xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
 <xmqqa914klg0.fsf@gitster.dls.corp.google.com>
 <xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
 <xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
 <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 19:12:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHG2z-0000cP-KM
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 19:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbbA3SL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 13:11:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:43367 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750923AbbA3SL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 13:11:56 -0500
Received: (qmail 30234 invoked by uid 102); 30 Jan 2015 18:11:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 12:11:56 -0600
Received: (qmail 25910 invoked by uid 107); 30 Jan 2015 18:12:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 13:12:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2015 13:11:53 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263185>

On Thu, Jan 29, 2015 at 12:45:22PM -0800, Junio C Hamano wrote:

> +static int path_is_beyond_symlink(const char *name_)
> +{
> +	struct strbuf name = STRBUF_INIT;
> +
> +	strbuf_addstr(&name, name_);
> +	do {
> +		struct patch *previous;
> +
> +		while (--name.len && name.buf[name.len] != '/')
> +			; /* scan backwards */
> +		if (!name.len)
> +			break;

I imagine it is impossible here for "name_" to be initially empty, but
it would make the backwards-scan loop go quite badly. Worth a comment or
an assert()?

> +		name.buf[name.len] = '\0';
> +		previous = in_fn_table(name.buf);
> +		if (previous) {
> +			if (!was_deleted(previous) &&
> +			    !to_be_deleted(previous) &&
> +			    previous->new_mode &&
> +			    S_ISLNK(previous->new_mode))
> +				goto symlink_found;
> +		} else if (check_index) {
> +			int pos = cache_name_pos(name.buf, name.len);
> +			if (0 <= pos &&
> +			    S_ISLNK(active_cache[pos]->ce_mode))
> +				goto symlink_found;
> +		} else {
> +			struct stat st;
> +			if (!lstat(name.buf, &st) && S_ISLNK(st.st_mode))
> +				goto symlink_found;
> +		}
> +	} while (1);
> +
> +	strbuf_release(&name);
> +	return 0;
> +symlink_found:
> +	strbuf_release(&name);
> +	return 1;

Style nit, but might this be easier to follow the logic without the
gotos, by putting the setup and cleanup in a wrapper function and
returning directly from the main logic?

  static int path_is_beyond_symlink(const char *name)
  {
	struct strbuf buf = STRBUF_INIT;
	int ret;

	strbuf_addstr(&buf, name);
	ret = path_is_beyond_symlink_1(name);
	strbuf_release(&buf);

	return ret;
  }

I can live with it either way, though.

> +	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
> +		return error(_("affected file '%s' is beyond a symbolic link"),
> +			     patch->new_name);

Why does this not kick in when deleting a file? If it is not OK to
add across a symlink, why is it OK to delete? IOW, why should this test
fail:

diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 0a8de4a..f03b604 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -64,6 +64,7 @@ test_expect_success SYMLINKS 'do not follow symbolic link (setup)' '
 	>arch/x86_64/dir/file &&
 	git add arch/x86_64/dir/file &&
 	git diff HEAD >add_file.patch &&
+	git diff -R HEAD >del_file.patch &&
 	git reset --hard &&
 	rm -fr arch/x86_64/dir &&
 
@@ -111,7 +112,11 @@ test_expect_success SYMLINKS 'do not follow symbolic link (existing)' '
 
 	test_must_fail git apply --cached add_file.patch 2>error-ct-file &&
 	test_i18ngrep "beyond a symbolic link" error-ct-file &&
-	test_must_fail git ls-files --error-unmatch arch/i386/dir
+	test_must_fail git ls-files --error-unmatch arch/i386/dir &&
+
+	>arch/i386/dir/file &&
+	test_must_fail git apply del_file.patch &&
+	test_path_is_file arch/i386/dir/file
 '
 
 test_done

> +	test ! -e arch/x86_64/dir &&
> +	test ! -e arch/i386/dir/file &&

Minor nit: use test_path_is_missing here (and elsewhere in the added
tests).

-Peff
