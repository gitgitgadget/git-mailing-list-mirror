From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 15:16:20 -0500
Message-ID: <20150130201620.GA4133@peff.net>
References: <CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
 <CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
 <xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
 <xmqqa914klg0.fsf@gitster.dls.corp.google.com>
 <xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
 <xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
 <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
 <20150130181153.GA25513@peff.net>
 <xmqq61bocao1.fsf@gitster.dls.corp.google.com>
 <xmqq1tmcc9l9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 21:16:34 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHHzV-00054D-Al
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 21:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759611AbbA3UQY (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 15:16:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:43458 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752519AbbA3UQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 15:16:23 -0500
Received: (qmail 3063 invoked by uid 102); 30 Jan 2015 20:16:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 14:16:23 -0600
Received: (qmail 26871 invoked by uid 107); 30 Jan 2015 20:16:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 15:16:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2015 15:16:20 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1tmcc9l9.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263194>

On Fri, Jan 30, 2015 at 12:11:30PM -0800, Junio C Hamano wrote:

> I am not sure how to fix this, without completely ripping out the
> misguided "We should be able to concatenate outputs from multiple
> invocations of 'git diff' into a single file and apply the result
> with a single invocation of 'git apply'" change I grudgingly
> accepted long time ago (7a07841c (git-apply: handle a patch that
> touches the same path more than once better, 2008-06-27).
> 
> "git diff" output is designed each patch to apply independently to
> the preimage to produce the postimage, and that allows patches to
> two files can be swapped via -Oorderfile mechanism, and also "X was
> created by copying from Y and Y is modified in place" will result in
> X with the contents of Y in the preimage (i.e. before the in-place
> modification of Y in the same patch) regardless of the order of X
> and Y in the "git diff" output.  The above input used by t4114.11
> expects to remove 'foo/baz' (leaving an empty directory foo as an
> result but we do not track directories so it can be nuked to make
> room if other patch in the same input wants to put something else,
> either a regular file or a symbolic link, there) and create a blob
> at 'foo', and such an input should apply regardless of the order of
> patches in it.
> 
> The in_fn_table[] stuff broke that design completely.

I had the impression that we did not apply in any arbitrary order that
could work, but rather that we did deletions first followed by
additions. But I am fairly ignorant of the apply code.

If that assumption is correct, then I think we could just follow the
same phases that the actual application does. Here's a hacky version
below. Probably the check of phase versus is_delete needs to be better
(and ideally the logic would be factored out of write_one_result so they
always match).

diff --git a/builtin/apply.c b/builtin/apply.c
index f5491cd..85364b8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3593,7 +3593,7 @@ symlink_found:
  * Check and apply the patch in-core; leave the result in patch->result
  * for the caller to write it out to the final destination.
  */
-static int check_patch(struct patch *patch)
+static int check_patch(struct patch *patch, int phase)
 {
 	struct stat st;
 	const char *old_name = patch->old_name;
@@ -3604,6 +3604,9 @@ static int check_patch(struct patch *patch)
 	int ok_if_exists;
 	int status;
 
+	if (!phase != patch->is_delete)
+		return 0;
+
 	patch->rejected = 1; /* we will drop this after we succeed */
 
 	status = check_preimage(patch, &ce, &st);
@@ -3679,6 +3682,9 @@ static int check_patch(struct patch *patch)
 	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
 		return error(_("affected file '%s' is beyond a symbolic link"),
 			     patch->new_name);
+	if (patch->is_delete && path_is_beyond_symlink(patch->old_name))
+		return error(_("affected file '%s' is beyond a symbolic link"),
+			     patch->old_name);
 
 	if (apply_data(patch, &st, ce) < 0)
 		return error(_("%s: patch does not apply"), name);
@@ -3686,7 +3692,7 @@ static int check_patch(struct patch *patch)
 	return 0;
 }
 
-static int check_patch_list(struct patch *patch)
+static int check_patch_list_1(struct patch *patch, int phase)
 {
 	int err = 0;
 
@@ -3695,12 +3701,22 @@ static int check_patch_list(struct patch *patch)
 		if (apply_verbosely)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
-		err |= check_patch(patch);
+		err |= check_patch(patch, phase);
 		patch = patch->next;
 	}
 	return err;
 }
 
+static int check_patch_list(struct patch *patch)
+{
+	int err = 0;
+	int phase;
+
+	for (phase = 0; phase < 2; phase++)
+		err |= check_patch_list_1(patch, phase);
+	return err;
+}
+
 /* This function tries to read the sha1 from the current index */
 static int get_current_sha1(const char *path, unsigned char *sha1)
 {
