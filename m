From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [RFC/PATCH] extend meaning of "--root" option to index
 comparisons
Date: Sun, 21 Sep 2008 11:48:10 -0700
Message-ID: <7v63opz66t.fsf@gitster.siamese.dyndns.org>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
 <48CECA42.1050209@drmicha.warpmail.net>
 <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com>
 <20080915223442.GD20677@sigill.intra.peff.net>
 <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com>
 <20080916062105.GA12708@coredump.intra.peff.net>
 <20080918092152.GA18732@coredump.intra.peff.net>
 <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com>
 <20080919142537.GA1287@coredump.intra.peff.net>
 <7vskrvswxp.fsf@gitster.siamese.dyndns.org>
 <20080921135616.GA25238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, sverre@rabbelier.nl,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 21 20:52:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhU2k-0006Jw-PS
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 20:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbYIUSsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 14:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbYIUSsV
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 14:48:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYIUSsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 14:48:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D5D0163D1F;
	Sun, 21 Sep 2008 14:48:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6310163D1B; Sun, 21 Sep 2008 14:48:12 -0400 (EDT)
In-Reply-To: <20080921135616.GA25238@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 21 Sep 2008 09:56:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DAD91C88-880D-11DD-B007-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96420>

Jeff King <peff@peff.net> writes:

> On Fri, Sep 19, 2008 at 01:27:46PM -0700, Junio C Hamano wrote:
> ...
>>  (2) "--root" is about "do we show a creation event as a huge diff from
>>      emptyness?".  Yes, we turn it on for "git log" but it does not have
>>      anything to do with the issue of yet to be born branch, where there
>>      isn't even a big creation event yet.
>
> What about index comparisons? What should an index comparison to a
> branch yet-to-be-born look like? Right now it is an error.

It should be an error, because that is _not_ even an comparison.  At least
at diff-index level.

The diff wrapper UI could do something different, though.  And an obvious
thing to do is to give a fake creation event.

The current output feels perfectly sensible to me.

	$ mkdir d; cd d; tar xf .../t.tar; git init; git add .
	$ git diff --cached
        fatal: No HEAD commit to compare with (yet)

The alternative is no different from "find . -type f | xargs cat" from the
point of view of reviewability.  To make sure you have what you want in
your initial revision, so that you can get things right from the start,
you would want to check things like:

	$ tar df .../t.tar ;# did I change anything?
        $ git ls-files ;# do I have what I want?
        $ git clean -n ;# have I missed anything?

By allowing an auto-fallback to the comparison with an empty tree object, 
you are giving these possibilities:

	$ git diff --cached --stat
	$ git diff --cached --name-only

but the latter is already available from ls-files anyway, and the former
does not feel so interesting.  

In exchange, we lose the reminder to the user that this is a creation
event.  An interactive user (remember, I am not talking about diff-index
here, but diff front-end) may want to treat it specially perhaps by being
extra careful.  If there were no downsides like this in "fall back to
comparing with an empty tree" approach, I wouldn't hesitate to agree it is
a good idea, though.

>> I am reluctant to agree with the opinion that "git log" should be _silent_
>> in a world without any history.
>
> It feels a bit more Unix-y to me. That is, if I am asking for some set
> of commits, and there are _no_ commits in the set, then I expect no
> output.

To this, I am inclined to agree.  We could do something like the attached
patch, but there is a caveat.

There may be commands that

 (1) cannot sanely operate without any positive ref;

 (2) give default "HEAD";

 (3) do not have its own input verification to make sure there is at least
     one positive ref, because they have been relying on revision
     machinery to die() with the existing check.

and this patch is actively breaking them.  If people like this approach
(and I probably will join them), commands that match the above criteria
need to be identified and fixed by setting revs->require_valid_def.

 revision.c |   22 ++++++++++++++++++----
 revision.h |    5 ++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git i/revision.c w/revision.c
index 2f646de..5ce7795 100644
--- i/revision.c
+++ w/revision.c
@@ -1295,12 +1295,26 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		prepare_show_merge(revs);
 	if (revs->def && !revs->pending.nr) {
 		unsigned char sha1[20];
-		struct object *object;
 		unsigned mode;
-		if (get_sha1_with_mode(revs->def, sha1, &mode))
+		int flag;
+		if (!get_sha1_with_mode(revs->def, sha1, &mode)) {
+			struct object *object;
+			object = get_reference(revs, revs->def, sha1, 0);
+			add_pending_object_with_mode(revs, object, revs->def, mode);
+		} else if (!revs->require_valid_def &&
+			   !strcmp(revs->def, "HEAD") &&
+			   resolve_ref(revs->def, sha1, 0, &flag) &&
+			   (flag & REF_ISSYMREF)) {
+			/*
+			 * Most commands can operate on an unborn branch
+			 * without an explicit ref parameter as if no
+			 * positive ref was specified (as opposed to the
+			 * traditional behaviour of barfing on invalid HEAD).
+			 */
+			;
+		} else {
 			die("bad default revision '%s'", revs->def);
-		object = get_reference(revs, revs->def, sha1, 0);
-		add_pending_object_with_mode(revs, object, revs->def, mode);
+		}
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
diff --git i/revision.h w/revision.h
index 2fdb2dd..7890fb7 100644
--- i/revision.h
+++ w/revision.h
@@ -30,7 +30,10 @@ struct rev_info {
 	const char *prefix;
 	const char *def;
 	void *prune_data;
-	unsigned int early_output;
+
+	/* Miscellaneous */
+	unsigned int	early_output:1,
+			require_valid_def:1;
 
 	/* Traversal flags */
 	unsigned int	dense:1,
