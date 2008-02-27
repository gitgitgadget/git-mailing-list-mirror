From: Junio C Hamano <gitster@pobox.com>
Subject: Re: warning: no common commits - slow pull
Date: Tue, 26 Feb 2008 21:12:45 -0800
Message-ID: <7vir0byoc2.fsf@gitster.siamese.dyndns.org>
References: <200802102007.38838.lenb@kernel.org>
 <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org>
 <200802261438.17014.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nicolas Pitre <nico@cam.org>, Theodore Tso <tytso@mit.edu>,
	git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 06:13:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUEby-0006QL-QL
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 06:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbYB0FNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 00:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbYB0FNI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 00:13:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbYB0FNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 00:13:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5E1F31C2D;
	Wed, 27 Feb 2008 00:13:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E65F21C2C; Wed, 27 Feb 2008 00:12:52 -0500 (EST)
In-Reply-To: <200802261438.17014.lenb@kernel.org> (Len Brown's message of
 "Tue, 26 Feb 2008 14:38:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75201>

Len Brown <lenb@kernel.org> writes:

>> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>>  * [new tag]         v2.6.25-rc2 -> v2.6.25-rc2
>> Updating 4ee29f6..101142c
>> Fast forward
>>  Makefile                               |    4 +-
> ...
>> [lenb@d975xbx2 linus (master)]$            
>> [lenb@d975xbx2 linus (master)]$ git --version
>> git version 1.5.4.1.122.gaa8d
>
> It still happens with latest git. (linus has declared -rc3 this time)

That's because nobody has touched anything in this area since your
last report.

But I now have a theory.

Next time this happens, could you run ls-remote for all four git
servers and compare them?

    $ LINUS=kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
    $ for i in 1 2 3 4; do git ls-remote git://git$i.$LINUS >git$i.txt; done

If my theory is correct, a workaround would be not to fetch from
git://git.kernel.org/ but from git://git$i.kernel.org/ for some value
of $i.

Now to the theory part.

Suppose the ancestry is like this:

         o (rc2)             o (rc3)
        /                   /
    ---A---o---o---o---o---B---o---o---o---C

And the event sequence is:

 (0) You are in sync with rc2 (have commits up to "A" and tag
     rc2);

 (1) Linus builds up to "B", tags rc3, pushes out to the master;

 (2) git1 and git2 mirror that history;

 (3) Linus builds up to "C", pushes out to the master;

 (4) git1 gets "C" but git2 mirror lags behind;

 (5) You fetch, which happens to first go to git1; you get "C"
     and learn that rc3 points at "B" that is locally reachable,
     but you do not have rc3 tag itself yet.  So git-fetch
     auto-follows (i.e. asks for "rc3" tag);

 (6) However, that goes over a separate connection, and you
     happen to hit git2, which does have "B" and rc3, but it
     does not have "C" yet.

 (7) You tell the other end "Hey, I have C", which git2 does not
     understand, because it hasn't seen the commit through the
     mirroring system yet.

Now, even if we are in the above situation, things _ought_ to work
(and I strongly suspect that the scripted git-fetch did work
correctly).  git2 would say "You have "C"?  I dunno that one, but keep
talking", and you will keep sending "I have this, this, this,...",
walking the ancestry chain down from C.  When you say "I also have B",
it would say "Aha, Ok, I heard enough to tell that rc3 tag is the only
thing I need to send to you".

However, if the current version of git-fetch has a bug in the
negotiation code when it auto-follows tags, that could throw this
conversation to compute what's common way off, and that is what I
suspect is happening.

For example, I notice that the list of old refs is reused (kept in the
transport structure) when it reconnects to a different instance of
git-upload-pack to auto-follow the tags, and never refreshed from the
actual remote end you are talking with.

This stale list of refs is passed all the way down to fetch_pack(),
representing _your_ idea of what they said they have, which does not
match the reality if you are connecting to a different host (via DNS
round robin).  Even if there is no DNS round robin issue, if an update
happened on the host between the time you fetched the refs from there
and you started a different instance of git-upload-pack for auto
follow the tags, the issue is the same (if you re-read the list of
refs from the new instance of upload-pack, you should be Ok, as the
upload-pack on the other end should be internally consistent).

Another possibile problem area I did not check is if the current
git-fetch takes care of clearing various mark bits used and left by
find_common() and get_rev() in builtin-fetch-pack.c during the main
transfer, before it initiates another round to auto follow the tags.
When we wrote fetch-pack the first time, we did not design it (most
importantly, find_common()) to be callable more than once, as cleaning
them was unnecessary overhead for the call-once-and-exit program.

The attached stops the stale set of refs from being used for common
ancestry computation.  It may or may not fix your issue, but at least
it should be more correct than what we currently have, I think.

diff --git a/builtin-fetch.c b/builtin-fetch.c
index ac335f2..c7cdd42 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -544,9 +544,16 @@ static int do_fetch(struct transport *transport,
 
 	fetch_map = ref_map;
 
-	/* if neither --no-tags nor --tags was specified, do automated tag
-	 * following ... */
+	/*
+	 * If neither --no-tags nor --tags was specified, do automated tag
+	 * following.
+	 */
 	if (tags == TAGS_DEFAULT && autotags) {
+		if (transport->remote_refs) {
+			struct ref *stale = (struct ref *)transport->remote_refs;
+			free_refs(stale);
+			transport->remote_refs = NULL;
+		}
 		ref_map = find_non_local_tags(transport, fetch_map);
 		if (ref_map) {
 			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
