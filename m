From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rebase max-pack-size?
Date: Tue, 22 May 2007 22:29:18 -0700
Message-ID: <7virak5cr5.fsf@assigned-by-dhcp.cox.net>
References: <4648848B.1030304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 07:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqjPZ-0007TV-NR
	for gcvg-git@gmane.org; Wed, 23 May 2007 07:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756271AbXEWF3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 01:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756250AbXEWF3V
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 01:29:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:37659 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbXEWF3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 01:29:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523052921.DPKK12190.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 23 May 2007 01:29:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2VVJ1X00h1kojtg0000000; Wed, 23 May 2007 01:29:19 -0400
In-Reply-To: <4648848B.1030304@gmail.com> (Dana How's message of "Mon, 14 May
	2007 08:47:23 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48141>

Dana How <danahow@gmail.com> writes:

> Let me know if you want them re-sent inline and/or separately.

Recently Linus was very unhappy on the kernel list when somebody
forwarded bunch of patches in a single message, saying we do
reviews one patch per message (and we do not do attachments).

I haven't been very strict about that kind of formality, as I
haven't felt the need too much so far.  Let's see how well we
can do this with this message, which has 5 patches.

----------------------------------------------------------------
>>From 781820f147bcb12dae576734585b27f42faca3ea Mon Sep 17 00:00:00 2001
> From: Dana L. How <danahow@gmail.com>
> Date: Sun, 13 May 2007 11:28:19 -0700
> Subject: [PATCH] Alter sha1close() 3rd argument to request flush only
>
> update=0 suppressed writing the final SHA-1 but was not used.
> Now final=0 suppresses SHA-1 finalization, SHA-1 writing,
> and closing -- in other words,  only flush the buffer.
>
> Signed-off-by: Dana L. How <danahow@gmail.com>

What it does is understandable but it somehow feels funny that
"sha1close(file, hashresult, 0)" does _not_ close it (and does
not hash either for obvious reasons ;-).  I would say we should
let it pass this round, but might want to separate the first
part out into a separate "update hash and flush" function if we
get more callers.

----------------------------------------------------------------
>>From 0c75fd66aa6a758e245d85b9304e85a38e977f94 Mon Sep 17 00:00:00 2001
> From: Dana L. How <danahow@gmail.com>
> Date: Sun, 13 May 2007 11:34:56 -0700
> Subject: [PATCH 1/4] git-repack --max-pack-size: new file statics and code restructuring
>
> Add "pack_size_limit", the limit specified by --max-pack-size,
> "written_list", the list of objects written to the current pack,
> and "nr_written", the number of objects in written_list.
> Put "base_name" at file scope again and add forward declarations.
> Move write_index_file() call from cnd_pack_objects() to
> write_pack_file() since only the latter will know how
> many times to call write_index_file().
>
> Signed-off-by: Dana L. How <danahow@gmail.com>

I would have split this part a bit differently.

This is mostly about restructuring the code so that
write_index_file() is called from write_pack_file(), which by
itself is a very good change (but then we might have been better
off passing basename as a parameter).

You are not using written_list nor limit yet but are introducing
them in this step, which feels not quite right.  I usually compile stuff
with -Werror, and if I ever have to bisect the series, this would bomb out
for these unused variables.  Not nice.

----------------------------------------------------------------
>>From 40ac2f294ec68cae27f8a9262db4cab84f1d2257 Mon Sep 17 00:00:00 2001
> From: Dana L. How <danahow@gmail.com>
> Date: Sun, 13 May 2007 12:06:18 -0700
> Subject: [PATCH 2/4] git-repack --max-pack-size: write_{object,one}() respect pack limit
>
> With --max-pack-size,  generate the appropriate write limit
> for each object and check against it before each group of writes.
> Update delta usability rules to handle base being in a previously-
> written pack.  Inline sha1write_compress() so we know the
> exact size of the written data when it needs to be compressed.
> Detect and return write "failure".
>
> Signed-off-by: Dana L. How <danahow@gmail.com>
> ---
>  builtin-pack-objects.c |  131 ++++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 104 insertions(+), 27 deletions(-)

Again, this is split somewhat wrongly, as you do not have a way
to set max size from the caller, but more importantly, even
though write_one and write_object knows to obey the limit
(perhaps somebody bisecting this series later may set the limit
under the debugger, to work around the lack of option parser),
write_pack_file() does not notice zero return from write_one();
I would have added a check there to do:

	die("sorry, limit reached and we do not have code to split the pack yet.")

which obviously can be updated in the next patch.

----------------------------------------------------------------
>>From 9ec3af1f52f41d0737b6271fded5e94527eb0466 Mon Sep 17 00:00:00 2001
> From: Dana L. How <danahow@gmail.com>
> Date: Sun, 13 May 2007 12:09:16 -0700
> Subject: [PATCH 3/4] git-repack --max-pack-size: split packs as asked by write_{object,one}()
>
> Rewrite write_pack_file() to break to a new packfile
> whenever write_object/write_one request it,  and
> correct the header's object count in the previous packfile.
> Change write_index_file() to write an index
> for just the objects in the most recent packfile.
>
> Signed-off-by: Dana L. How <danahow@gmail.com>
> ---
>  builtin-pack-objects.c |  120 ++++++++++++++++++++++++++++-------------------
>  1 files changed, 71 insertions(+), 49 deletions(-)
>
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 3023aac..ce9eb2d 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> ...
> @@ -652,7 +663,26 @@ static void write_pack_file(void)
>  				die("unable to rename temporary index file: %s",
>  				    strerror(errno));
>  			puts(sha1_to_hex(object_list_sha1));
> +		}
> +
> +		/* mark written objects as written to previous pack */
> +		for (j = 0; j < nr_written; j++) {
> +			written_list[j]->offset = (off_t)-1;
> +		}
> +		nr_remaining -= nr_written;
> +	} while (nr_remaining && i < nr_objects);
> +
> +	free(written_list);
> +	if (do_progress)
> +		stop_progress(&progress_state);
> +	if (written != nr_result)
> +		die("wrote %u objects while expecting %u", written, nr_result);
> +	for (j = 0; i < nr_objects; i++) {
> +		struct object_entry *e = objects + i;
> +		j += !e->offset && !e->preferred_base;
>  	}

I am a bit confused by this loop.  Don't you have to start with i=0
for this check to be meaningful?

> +	if (j)
> +		die("wrote %u objects as expected but %u unwritten", written, j);
>  }


----------------------------------------------------------------
>>From 279d1f9e0e7265c6ccf8759bbe8c5539bf3089fa Mon Sep 17 00:00:00 2001
> From: Dana L. How <danahow@gmail.com>
> Date: Sun, 13 May 2007 12:47:09 -0700
> Subject: [PATCH 4/4] git-repack --max-pack-size: add option parsing to enable feature
>
> Add --max-pack-size parsing and usage messages.
> Upgrade git-repack.sh to handle multiple packfile names,
> and build packfiles in GIT_OBJECT_DIRECTORY not GIT_DIR.
> Update documentation.
>
> Signed-off-by: Dana L. How <danahow@gmail.com>
> ---
>  Documentation/git-pack-objects.txt |    5 +++++
>  Documentation/git-repack.txt       |    5 +++++
>  builtin-pack-objects.c             |    9 ++++++++-
>  git-repack.sh                      |   14 ++++++++------
>  4 files changed, 26 insertions(+), 7 deletions(-)
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index ce9eb2d..930b57a 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> ...
> @@ -1713,6 +1713,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  			pack_compression_level = level;
>  			continue;
>  		}
> +		if (!prefixcmp(arg, "--max-pack-size=")) {
> +			char *end;
> +			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
> +			if (!arg[16] || *end)
> +				usage(pack_usage);
> +			continue;
> +		}
>  		if (!prefixcmp(arg, "--window=")) {
>  			char *end;
>  			window = strtoul(arg+9, &end, 0);

Hmmm.  I was almost going to suggest to have this spelled in
bytes, with suffixes like k/m/g.  However, because wanting to
limit a pack under 1.4MB does not make much sense these days,
and because having to spell "up to 2GB" as 2047 is not too much
trouble, I think this is Ok.

Shouldn't we have a safety to error out when --stdout and
--max-pack-size are both given?  Currently it silently ignores
the limit, doesn't it?

> diff --git a/git-repack.sh b/git-repack.sh
> index 8bf66a4..4ea6e5b 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> ...
> @@ -35,7 +36,7 @@ true)
>  esac
>  
>  PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
> -PACKTMP="$GIT_DIR/.tmp-$$-pack"
> +PACKTMP="$GIT_OBJECT_DIRECTORY/.tmp-$$-pack"
>  rm -f "$PACKTMP"-*
>  trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
>  

Although this is a good change, this hunk does not belong to
this.

----------------------------------------------------------------

Overall everything looks good, except some minor details noted
above.  Separation of the commits into logical steps does not
need to be fixed up (they are already in 'next'), but follow-up
patches might be needed.

And I have to agree with Linus; responding this way was more
cumbersome than it should have been.
