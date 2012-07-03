From: Jeff King <peff@peff.net>
Subject: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Tue, 3 Jul 2012 14:04:39 -0400
Message-ID: <20120703180439.GC3294@sigill.intra.peff.net>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
 <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
 <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:04:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm7Sx-00044q-R3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 20:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab2GCSEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 14:04:42 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52435
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab2GCSEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 14:04:42 -0400
Received: (qmail 23912 invoked by uid 107); 3 Jul 2012 18:04:49 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 14:04:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 14:04:39 -0400
Content-Disposition: inline
In-Reply-To: <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200925>

When we try to push a ref and the right-hand side of the
refspec does not find a match, we try to create it. If it is
not fully qualified, we try to guess where it would go in
the refs hierarchy based on the left-hand source side. If
the source side is not a ref, then we give up and give a
long explanatory message.

For deletions, however, this doesn't make any sense. We
would never want to create on the remote side, and if an
unqualified ref can't be matched, it is simply an error. The
current code handles this already because the left-hand side
is empty, and therefore does not give us a hint as to where
the right-hand side should go, and we properly error out.
Unfortunately, the error message is the long "we tried to
qualify this, but the source side didn't let us guess"
message, which is quite confusing.

Instead, we can just be more succinct and say "we can't
delete this because we couldn't find it". So before:

  $ git push origin :bogus
  error: unable to push to unqualified destination: bogus
  The destination refspec neither matches an existing ref on the remote nor
  begins with refs/, and we are unable to guess a prefix based on the source ref.
  error: failed to push some refs to '$URL'

and now:

  $ git push origin :bogus
  error: unable to delete 'bogus': remote ref does not exist
  error: failed to push some refs to '$URL'

It is tempting to also catch a fully-qualified ref like
"refs/heads/bogus" and generate the same error message.
However, that currently does not error out at all, and
instead gets sent to the remote side, which typically
generates a warning:

  $ git push origin:refs/heads/bogus
  remote: warning: Deleting a non-existent ref.
  To $URL
   - [deleted]         bogus

While it would be nice to catch this error early, a
client-side error would mean aborting the push entirely and
changing push's exit code. For example, right now you can
do:

  $ git push origin refs/heads/foo refs/heads/bar

and end up in a state where "foo" and "bar" are deleted,
whether both of them currently exist or not (and see an
error only if we actually failed to contact the server).
Generating an error would cause a regression for this use
case.

Signed-off-by: Jeff King <peff@peff.net>
---
On Tue, Jul 03, 2012 at 07:42:07AM -0400, jonsmirl@gmail.com wrote:

> I have the branch name wrong. It is fl.stgit not fl.stg.
> But the error message sent me off in the wrong direction looking for an answer.

I think this would help. I used "remote ref does not exist"
because that is the simplest explanation for the user.
However, given that we will try to push a fully qualified
ref that does not exist, a more accurate message might
"destination refspec did not match" or something similar.  I
prefer the former, though, as it less arcane.

 remote.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/remote.c b/remote.c
index 6833538..04fd9ea 100644
--- a/remote.c
+++ b/remote.c
@@ -1100,6 +1100,9 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 0:
 		if (!memcmp(dst_value, "refs/", 5))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
+		else if (is_null_sha1(matched_src->new_sha1))
+			error("unable to delete '%s': remote ref does not exist",
+			      dst_value);
 		else if ((dst_guess = guess_ref(dst_value, matched_src)))
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 		else
-- 
1.7.11.rc1.21.g3c8d91e
