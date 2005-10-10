From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strangely broken git repo
Date: Mon, 10 Oct 2005 02:00:06 -0700
Message-ID: <7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
	<4349ED5D.6020703@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <nickh@reactrix.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 11:00:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOtW2-0005Dz-Vy
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 11:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVJJJAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 05:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVJJJAK
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 05:00:10 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:49811 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750766AbVJJJAI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 05:00:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010090000.NIRV19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 05:00:00 -0400
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
cc: git@vger.kernel.org
In-Reply-To: <4349ED5D.6020703@catalyst.net.nz> (Martin Langhoff's message of
	"Mon, 10 Oct 2005 17:26:05 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9878>

"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> writes:

> $ cg-clone http://locke.catalyst.net.nz/git/moodle.git#moodle--topnz
> ...
> Getting index for pack 3e3492f365bb0d4a1ae11dfa7cee9ebbf345e647
> Getting pack 3113eb34ef85482c87c3575721ce978c7232071f
> which contains 007a0323cf0941476dc262f6e3aff6bb9600dcd8
> error: The requested file was not found
> ... (many more like these)

So it failed to grab 007a0323cf0941476dc262f6e3aff6bb9600dcd8,
but that is OK.  That object is in a pack:
pack-3113eb34ef85482c87c3575721ce978c7232071f has it.

> FINISHED --15:56:38--
> Downloaded: 4,723 bytes in 1 files
> New branch: 6759e2800c0cef00017c63b7dbbed80e481dbe2c
> Cloned to moodle.git#moodle--topnz/ (origin
> http://locke.catalyst.net.nz/git/moodle.git#moodle--topnz available as
> branch "origin")
> aporo:~/tmp/moodle.git#moodle--topnz martin$ git-fsck-objects
> bad sha1 file: .git/objects/00/7a0323cf0941476dc262f6e3aff6bb9600dcd8.temp
> ... (many more like these)

This *.temp file is what git-http-fetch creates while retrieving
the object.  After successfully downloading it, it is renamed to
its final name (i.e. sans .temp), but that rename did not
happen.  Well, this object is in a pack, so after failing to
retrieve that, we should have got the list of packs, retrieved
pack index files, and grabbed the pack that contained that
object.  We *should* clean up the *.temp file for this object
whe we do this, but I do not think we do.  But I do not think
this is the _cause_ of your problem.  It is a symptom that
something is going wrong -- namely, the question is why it was
not found in pack-3113eb34ef85482c87c3575721ce978c7232071f.  Did
the client download that pack?

I just tried to clone your repository with 'git clone', and saw
something failing, but I think the object trasfer went fine all
the way down to the initial commit.  I can see this object in my
cloned repository:

        commit 34cc394a7427adf730cfd3fb482dc6d6d5b58775
        Author: Martin Langhoff <martin@catalyst.net.nz>
        Date:   Tue Aug 3 02:50:51 2004 +0000

            initial import

There are funky tag names in your refs/tags directory.  The
really core tools should be able to grok them just fine, but
git-http-fetch failed with this from curl library:

The requested URL returned error: 404
error: Couldn't get http://locke.catalyst.net.nz/git/moodle.git/refs/tags/MOODLE_15_MERGED **INVALID** for tags/MOODLE_15_MERGED **INVALID**

I do not speak curl, but I wonder if we should be quoting
these funky characters like SP and asterisk in the URL when we
make that request, or it is what the library does for us.

Hmph.  Interesting.  I just tried.

$ curl 'http://locke.catalyst.net.nz/git/moodle.git/refs/tags/MOODLE_15_MERGED **INVALID**'

gives an error page "404 Not Found", while

$ wget -O - -o /dev/null 'http://locke.catalyst.net.nz/git/moodle.git/refs/tags/MOODLE_15_MERGED **INVALID**'

works fine and gives 2ddfec0dfd0cffd4892af9aaf48ee29c40c7ada3
back.  So we do need to fix things up somewhat in our scripts as
well.

Anyway, I think I know the problems 'git-clone' would have had
if you tried to clone it with it (not cg-clone which I do not
know much about), and luckily it is only towards the end (after
fetching most of the heads, but hitting the first funky tag).
We should be able to fix this relatively easily.

Oh, Daniel and Nick, while I was reading the http-fetch.c code,
I noticed another thing.

The fetch_alternates() function was supposed to be call-once and
we have a static variable got_alternates that becomes 1 when it
runs for the first time.  However, there are other 'return 0's
introduced that does not set got_alternates to 1.

I am wondering if the semantics has changed that now we chain
the alternates?  Initially, if we are cloning/fetching from
repository A, which borrows from repository B (i.e. alternates
we retrieve from A would name B), and if B in turn borrows from
C, then we assumed that A's alternates would also name C, and
that was the reason why fetch_alternates() was call-once
function.  I do not mind if we change it to chain the alternates
file, but if that is the case we should move the got_alternates
variable into "struct alt_base", and pass the struct, not just
alt->base, to fetch_alternates(), like this (untested, of
course):

diff --git a/http-fetch.c b/http-fetch.c
index 5821c9e..2301f88 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -38,6 +38,7 @@ struct alt_base
 {
 	char *base;
 	int got_indices;
+	int got_alternates;
 	struct packed_git *packs;
 	struct alt_base *next;
 };
@@ -529,8 +530,6 @@ void prefetch(unsigned char *sha1)
 #endif
 }
 
-static int got_alternates = 0;
-
 static int fetch_index(struct alt_base *repo, unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
@@ -611,8 +610,9 @@ static int setup_index(struct alt_base *
 	return 0;
 }
 
-static int fetch_alternates(char *base)
+static int fetch_alternates(struct alt_base *this_alt)
 {
+	char *base = this_alt->base;
 	int ret = 0;
 	struct buffer buffer;
 	char *url;
@@ -622,15 +622,17 @@ static int fetch_alternates(char *base)
 	struct alt_base *tail = alt;
 
 	struct active_request_slot *slot;
-	if (got_alternates)
+	if (this_alt->got_alternates)
 		return 0;
+	this_alt->got_alternates = 1;
 	data = xmalloc(4096);
 	buffer.size = 4095;
 	buffer.posn = 0;
 	buffer.buffer = data;
 
 	if (get_verbosely)
-		fprintf(stderr, "Getting alternates list\n");
+		fprintf(stderr, "Getting alternates list for %s\n",
+			base);
 	
 	url = xmalloc(strlen(base) + 31);
 	sprintf(url, "%s/objects/info/http-alternates", base);
@@ -721,7 +723,6 @@ static int fetch_alternates(char *base)
 		}
 		i = posn + 1;
 	}
-	got_alternates = 1;
 	
 	return ret;
 }
@@ -1092,9 +1093,10 @@ int main(int argc, char **argv)
 	alt = xmalloc(sizeof(*alt));
 	alt->base = url;
 	alt->got_indices = 0;
+	alt->got_alternates = 0;
 	alt->packs = NULL;
 	alt->next = NULL;
-	fetch_alternates(alt->base);
+	fetch_alternates(alt);
 
 	if (pull(commit_id))
 		return 1;
