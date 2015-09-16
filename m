From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: git-svn: cat-file memory usage
Date: Wed, 16 Sep 2015 06:40:23 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9CD@mail.accesssoftek.com>
References: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9CB@mail.accesssoftek.com>,<20150916115642.GA5104@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 15:45:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcD17-0003j2-UD
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 15:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbbIPNox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 09:44:53 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:10530 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbbIPNow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2015 09:44:52 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Wed, 16 Sep 2015 06:44:49 -0700
Thread-Topic: git-svn: cat-file memory usage
Thread-Index: AdDwd7WOQE5vqCUYR5OLO4z1rAJbXQADYdaF
In-Reply-To: <20150916115642.GA5104@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278027>

Hello Jeff, thanks for the advice.

Unfortunately using patch didn't change the situation. I will run some tests with alternate allocators (looking at jemalloc and tcmalloc). As for alternate tools: as far as I understood svn2git calls 'git svn' itself. So I assume it can't fix the memory usage or speed up clone process... Correct me if I'm wrong.

Reposurgeon looks interesting... Will give it a try. 

Btw, what do you think of getting rid of batch mode for clone/fetch in perl code. It really hardly has any impact on performance but reduces memory usage a lot.

--
Best Regards,
Victor
________________________________________
From: Jeff King [peff@peff.net]
Sent: Wednesday, September 16, 2015 4:56 AM
To: Victor Leschuk
Cc: git@vger.kernel.org
Subject: Re: git-svn: cat-file memory usage

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
-       struct strbuf buf = STRBUF_INIT;
+       static struct strbuf buf = STRBUF_INIT;

        if (sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
                printf("%s missing\n", obj_name ? obj_name : sha1_to_hex(data->sha1));
@@ -264,10 +264,10 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
                return;
        }

+       strbuf_reset(&buf);
        strbuf_expand(&buf, opt->format, expand_format, data);
        strbuf_addch(&buf, '\n');
        batch_write(opt, buf.buf, buf.len);
-       strbuf_release(&buf);

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
