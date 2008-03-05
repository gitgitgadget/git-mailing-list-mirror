From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] improve 'bad default revision' message for empty repo
Date: Tue, 04 Mar 2008 18:43:25 -0800
Message-ID: <7v7igh51rm.fsf@gitster.siamese.dyndns.org>
References: <3f4fd2640803011140o38ba0830l7775c8528f812779@mail.gmail.com>
 <20080303081021.GA6578@sigill.intra.peff.net>
 <3f4fd2640803041351k6debe788xbf5e818951f70146@mail.gmail.com>
 <20080305010701.GB20007@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Reece Dunn <msclrhd@googlemail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 03:44:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWjc4-00078Q-Jt
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 03:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbYCECnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 21:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbYCECnf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 21:43:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbYCECne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 21:43:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 041D418D2;
	Tue,  4 Mar 2008 21:43:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E648E18D0; Tue,  4 Mar 2008 21:43:27 -0500 (EST)
In-Reply-To: <20080305010701.GB20007@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 4 Mar 2008 20:07:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76166>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 04, 2008 at 09:51:02PM +0000, Reece Dunn wrote:
>
>> >  > Consider the following workflow:
>> >  >
>> >  >     $ mkdir foo
>> >  >     $ cd foo
>> >  >     $ git --bare init
>> >  >
>> >  >     $ git log
>> >  >     fatal: bad default revision 'HEAD'
>> >  >
>> >  > This message is confusing for a newbie. Displaying "no commits" would
>> >  > make more sense here.
>
> What do people think of this patch? It feels a little hack-ish to make
> guesses as to the reasons for a failure, but in my experience an empty
> repo is the cause of this message in 99% of cases.

>
> We could special-case it to HEAD and make a better message, perhaps, but
> that feels even more hack-ish.

How about doing it this way instead, then?

Saying "fatal: You haven't made a commit?" is like saying "How stupid do
you have to be to realize that you are not allowed to run git-log before
making a commit, dummy?", but that is not the message we need to be
sending.  Asking for log is fine.  If you are on an unborn branch and say
"git log", you deserve to get nothing.  Not even an error message.

Not that I haven't thought through the ramifications of this yet; some
callers may need to be adjusted, but they should be prepared for a case
where no rev was given from the command line anyway.

---

 revision.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 63bf2c5..cdd5ad2 100644
--- a/revision.c
+++ b/revision.c
@@ -1323,10 +1323,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		unsigned char sha1[20];
 		struct object *object;
 		unsigned mode;
-		if (get_sha1_with_mode(def, sha1, &mode))
-			die("bad default revision '%s'", def);
-		object = get_reference(revs, def, sha1, 0);
-		add_pending_object_with_mode(revs, object, def, mode);
+		if (!get_sha1_with_mode(def, sha1, &mode)) {
+			object = get_reference(revs, def, sha1, 0);
+			add_pending_object_with_mode(revs, object, def, mode);
+		}
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
