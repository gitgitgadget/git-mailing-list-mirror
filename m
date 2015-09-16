From: Jeff King <peff@peff.net>
Subject: Re: git-svn: cat-file memory usage
Date: Wed, 16 Sep 2015 07:56:42 -0400
Message-ID: <20150916115642.GA5104@sigill.intra.peff.net>
References: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9CB@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 13:56:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcBKZ-0006Ge-Pl
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 13:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbbIPL4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 07:56:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:59897 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750989AbbIPL4u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 07:56:50 -0400
Received: (qmail 24016 invoked by uid 102); 16 Sep 2015 11:56:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 06:56:50 -0500
Received: (qmail 17192 invoked by uid 107); 16 Sep 2015 11:56:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 07:56:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 07:56:42 -0400
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9CB@mail.accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278023>

On Wed, Sep 16, 2015 at 04:00:48AM -0700, Victor Leschuk wrote:

>  * git svn clone of trac  takes about 1 hour 
>  * git svn clone of FreeBSD has already taken more than 3 days and
>  still running (currently has cloned about 40% of revisions)

I haven't worked with git-svn in a long time, but I doubt that it is the
fastest way to do a large repository import. You might want to look into
a tool like svn2git or reposurgeon to do the initial import.

> I have valgrind'ed the git-cat-file (which is running is --batch mode
> during the whole clone) and found no serious leaks (about 100 bytes
> definitely leaked), so all memory is carefully freed, but the heap
> usage grows maybe due to fragmentation or smth else. When I looked
> through the code I found out that most of heap allocations are called
> from batch_object_write() function (strbuf_expand -> realloc).

Certainly we will call strbuf_expand once per object. I would have
expected we would call read_sha1_file(), too. It looks like we always
try to stream blobs, but I think we have to fall back to reading the
whole object if there are deltas.

You can try this patch, which will reuse the same strbuf over and over:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 07baad1..73f338c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -256,7 +256,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 static void batch_object_write(const char *obj_name, struct batch_options *opt,
 			       struct expand_data *data)
 {
-	struct strbuf buf = STRBUF_INIT;
+	static struct strbuf buf = STRBUF_INIT;
 
 	if (sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
 		printf("%s missing\n", obj_name ? obj_name : sha1_to_hex(data->sha1));
@@ -264,10 +264,10 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 		return;
 	}
 
+	strbuf_reset(&buf);
 	strbuf_expand(&buf, opt->format, expand_format, data);
 	strbuf_addch(&buf, '\n');
 	batch_write(opt, buf.buf, buf.len);
-	strbuf_release(&buf);
 
 	if (opt->print_contents) {
 		print_object_or_die(opt, data);

That will reduce your reallocs due to strbuf_expand, though I'm doubtful
that it will solve the problem (and if it does, I think the right
solution is probably to look into using a better allocator than what
your system malloc() is providing).

>  * In perl code do not run git cat-file in batch mode (in
>  Git::SVN::apply_textdelta) but rather run it as separate commands
>  each time
> 
>    my $size = $self->command_oneline('cat-file', '-s', $sha1);
>    # .....
>    my ($in, $c) = $self->command_output_pipe('cat-file', 'blob', $sha1);
> 
> The second approach doesn't slow down the whole process at all (~72
> minutes to clone repo both with --batch mode and without).

I'm surprised the startup cost of the process doesn't make an impact,
but maybe it gets lost in the noise of the rest of the work (AFAICT, the
point of this cat-file is to retrieve a blob, apply a delta to it, and
then write out the resulting object; that write is probably a lot more
expensive).

-Peff
