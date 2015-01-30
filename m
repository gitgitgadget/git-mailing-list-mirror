From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 15:07:32 -0500
Message-ID: <20150130200731.GC30738@peff.net>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
 <CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
 <CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
 <xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
 <xmqqa914klg0.fsf@gitster.dls.corp.google.com>
 <xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
 <xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
 <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
 <20150130181153.GA25513@peff.net>
 <xmqq61bocao1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 21:07:41 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHHqu-0002p0-SW
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 21:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762925AbbA3UHg (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 15:07:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:43441 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751769AbbA3UHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 15:07:34 -0500
Received: (qmail 2701 invoked by uid 102); 30 Jan 2015 20:07:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 14:07:34 -0600
Received: (qmail 26746 invoked by uid 107); 30 Jan 2015 20:08:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 15:08:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2015 15:07:32 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61bocao1.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263192>

On Fri, Jan 30, 2015 at 11:48:14AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> +	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
> >> +		return error(_("affected file '%s' is beyond a symbolic link"),
> >> +			     patch->new_name);
> >
> > Why does this not kick in when deleting a file? If it is not OK to
> > add across a symlink, why is it OK to delete?
> 
> Hmph, adding
> 
> 	if (patch->is_delete &&	path_is_beyond_symlink(patch->old_name))
> 		return error(_("deleted file '%s' is beyond a symlink"),
> 				patch->old_name);
> 
> seems to break t4114.11, which wants to apply this patch to a tree
> that does not have a symbolic link but a directory at 'foo/'.
> 
> diff --git a/foo b/foo
> new file mode 120000
> index 0000000..ba0e162
> --- /dev/null
> +++ b/foo
> @@ -0,0 +1 @@
> +bar
> \ No newline at end of file
> diff --git a/foo/baz b/foo/baz
> deleted file mode 100644
> index 682c76b..0000000
> --- a/foo/baz
> +++ /dev/null
> @@ -1 +0,0 @@
> -if only I knew

Hrm. That only works in the current code because we apply the deletion
in the directory (and then clean up the now-empty directory) first. So I
think you would need to check the paths progressively as you apply them,
since those other parts of the diff "haven't happened yet".

If we take deletion as one phase and addition as another, I think you
could get away with:

diff --git a/builtin/apply.c b/builtin/apply.c
index f5491cd..12c9d8e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3549,7 +3549,7 @@ static int check_to_create(const char *new_name, int ok_if_exists)
 	return 0;
 }
 
-static int path_is_beyond_symlink(const char *name_)
+static int path_is_beyond_symlink(const char *name_, int check_table)
 {
 	struct strbuf name = STRBUF_INIT;
 
@@ -3562,7 +3562,8 @@ static int path_is_beyond_symlink(const char *name_)
 		if (!name.len)
 			break;
 		name.buf[name.len] = '\0';
-		previous = in_fn_table(name.buf);
+
+		previous = check_table ? in_fn_table(name.buf) : NULL;
 		if (previous) {
 			if (!was_deleted(previous) &&
 			    !to_be_deleted(previous) &&
@@ -3676,9 +3677,12 @@ static int check_patch(struct patch *patch)
 		}
 	}
 
-	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
+	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name, 1))
 		return error(_("affected file '%s' is beyond a symbolic link"),
 			     patch->new_name);
+	if (patch->is_delete && path_is_beyond_symlink(patch->old_name, 0))
+		return error(_("affected file '%s' is beyond a symbolic link"),
+			     patch->old_name);
 
 	if (apply_data(patch, &st, ce) < 0)
 		return error(_("%s: patch does not apply"), name);


but I suspect we could construct a case that depends more closely on the
order of application. E.g., a patch that does:

  1. add foo as a symlink
  2. add file foo/bar

is definitely wrong. But is:

  1. add file foo/bar
  2. add foo as a symlink

does not technically fall afoul of the symlink rules. It is a _bogus_
patch, of course, because the second part will get a D/F conflict. I am
not sure if there are any legitimate patches that could run into this
ordering problem, but even without it, it smells a bit funny to complain
for the wrong reason.

Looking at the code, though, it seems like we should be doing these
checks progressively as we add entries to the fn_table. So that is doing
the right thing. It is only the deletion re-ordering that trips us up.
Can we reorder all deletions before all additions before calling
check_patch on each?

-Peff
