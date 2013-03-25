From: Jeff King <peff@peff.net>
Subject: [PATCH v2 6/9] streaming_write_entry: propagate streaming errors
Date: Mon, 25 Mar 2013 17:49:36 -0400
Message-ID: <20130325214936.GA22419@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202216.GF16019@sigill.intra.peff.net>
 <20130325213934.GE1414@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:50:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFHP-0005Ho-Dg
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933263Ab3CYVtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:49:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39452 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933102Ab3CYVtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:49:40 -0400
Received: (qmail 29032 invoked by uid 107); 25 Mar 2013 21:51:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 17:51:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 17:49:36 -0400
Content-Disposition: inline
In-Reply-To: <20130325213934.GE1414@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219101>

On Mon, Mar 25, 2013 at 02:39:34PM -0700, Jonathan Nieder wrote:

> > --- a/entry.c
> > +++ b/entry.c
> > @@ -126,8 +126,10 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
> >  	fd = open_output_fd(path, ce, to_tempfile);
> >  	if (0 <= fd) {
> >  		result = stream_blob_to_fd(fd, ce->sha1, filter, 1);
> > -		*fstat_done = fstat_output(fd, state, statbuf);
> > -		result = close(fd);
> > +		if (!result) {
> > +			*fstat_done = fstat_output(fd, state, statbuf);
> > +			result = close(fd);
> > +		}
> 
> Should this do something like
> [...]
> to avoid leaking the file descriptor?

Yes, Eric Sunshine noticed this, too. Re-rolled patch is below, which I
think is even a little cleaner.

> > +test_expect_success 'read-tree -u detects bit-errors in blobs' '
> > +	(
> > +		cd bit-error &&
> > +		rm content.t &&
> > +		test_must_fail git read-tree --reset -u FETCH_HEAD
> > +	)
> 
> Makes sense.  Might make sense to use "rm -f" instead of "rm" to avoid
> failures if content.t is removed already.

Yeah, good point. My original test looked like:

  git init bit-error &&
  git fetch .. &&
  corrupt ...
  test_must_fail ...

but I ended up refactoring it to re-use the corrupted directories, and
added the "rm" after the fact. The use of FETCH_HEAD is also bogus
(read-tree is failing, but because we are giving it a bogus ref, not
because of the corruption, so we are not actually testing anything
anymore, even though it still passes).

Both fixed in my re-roll.

-- >8 --
Subject: [PATCH] streaming_write_entry: propagate streaming errors

When we are streaming an index blob to disk, we store the
error from stream_blob_to_fd in the "result" variable, and
then immediately overwrite that with the return value of
"close". That means we catch errors on close (e.g., problems
committing the file to disk), but miss anything which
happened before then.

We can fix this by using bitwise-OR to accumulate errors in
our result variable.

While we're here, we can also simplify the error handling
with an early return, which makes it easier to see under
which circumstances we need to clean up.

Signed-off-by: Jeff King <peff@peff.net>
---
 entry.c                      | 16 +++++++++-------
 t/t1060-object-corruption.sh | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/entry.c b/entry.c
index 17a6bcc..a20bcbc 100644
--- a/entry.c
+++ b/entry.c
@@ -120,16 +120,18 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
 				 const struct checkout *state, int to_tempfile,
 				 int *fstat_done, struct stat *statbuf)
 {
-	int result = -1;
+	int result = 0;
 	int fd;
 
 	fd = open_output_fd(path, ce, to_tempfile);
-	if (0 <= fd) {
-		result = stream_blob_to_fd(fd, ce->sha1, filter, 1);
-		*fstat_done = fstat_output(fd, state, statbuf);
-		result = close(fd);
-	}
-	if (result && 0 <= fd)
+	if (fd < 0)
+		return -1;
+
+	result |= stream_blob_to_fd(fd, ce->sha1, filter, 1);
+	*fstat_done = fstat_output(fd, state, statbuf);
+	result |= close(fd);
+
+	if (result)
 		unlink(path);
 	return result;
 }
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index d36994a..2945395 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -24,6 +24,15 @@ test_expect_success 'setup corrupt repo' '
 	)
 '
 
+test_expect_success 'setup repo with missing object' '
+	git init missing &&
+	(
+		cd missing &&
+		test_commit content &&
+		rm -f "$(obj_to_file HEAD:content.t)"
+	)
+'
+
 test_expect_success 'streaming a corrupt blob fails' '
 	(
 		cd bit-error &&
@@ -31,4 +40,20 @@ test_expect_success 'streaming a corrupt blob fails' '
 	)
 '
 
+test_expect_success 'read-tree -u detects bit-errors in blobs' '
+	(
+		cd bit-error &&
+		rm -f content.t &&
+		test_must_fail git read-tree --reset -u HEAD
+	)
+'
+
+test_expect_success 'read-tree -u detects missing objects' '
+	(
+		cd missing &&
+		rm -f content.t &&
+		test_must_fail git read-tree --reset -u HEAD
+	)
+'
+
 test_done
-- 
1.8.2.13.g0f18d3c
