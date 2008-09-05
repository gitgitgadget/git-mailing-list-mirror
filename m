From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Fri, 05 Sep 2008 16:43:52 -0700
Message-ID: <7vabemupjb.fsf@gitster.siamese.dyndns.org>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
 <20080902210524.GB7757@leksak.fem-net> <200809022339.20123.johan@herland.net>
 <alpine.LFD.1.10.0809021849390.23787@xanadu.home>
 <32541b130809032150i418014bdo8a838f529e109f50@mail.gmail.com>
 <7vbpz479zs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Stephan Beyer" <s-beyer@gmx.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Pieter de Bie" <pdebie@ai.rug.nl>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 01:45:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbkzp-0000tA-3x
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 01:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbYIEXoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 19:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbYIEXoU
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 19:44:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbYIEXoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 19:44:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ACC1675B76;
	Fri,  5 Sep 2008 19:44:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3199275B70; Fri,  5 Sep 2008 19:44:05 -0400 (EDT)
In-Reply-To: <7vbpz479zs.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 03 Sep 2008 22:31:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D53D5F4-7BA4-11DD-97E4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95049>

Junio C Hamano <gitster@pobox.com> writes:

> "Avery Pennarun" <apenwarr@gmail.com> writes:
> ...
>> 1) Checking out a remote branch "git checkout origin/master" detaches
>> my HEAD, which is kind of bad, since it's such a common thing to want
>> to do.
>
> I do not think it is bad at all.  The feature to detach HEAD was designed
> for that kind of usage.  Start sightseeing, possibly futz with the code,
> and even create some snapshot commits, and then:
>
>  * if it starts to take a usable shape, say "git checkout -b my-topic",
>    from there, to give your exploration a lasting home; or
>    
>  * if it doesn't pan out, just discard it with "git checkout -f master"
>    (or whatever you wanted to switch back to).
>
> One thing that might help for downstream people would be to be able to say
> "I am making 'my-topic' branch out of a detached HEAD, but it really is
> meant to be a fork of origin/master that I detached my HEAD from, so
> please set up tracking for that one".
>
> You could force people to say "git checkout -b my-topic origin/master"
> from the beginning, but that is very unreasonable and unworkable.  When
> you are exploring, you more often than not do not know where your quest
> would lead to until spending some time.  It is quite important to be able
> to delay the decision to create a local branch to keep what you did, and
> (more importantly) to be able to delay deciding what to name that topic.
>
> Perhaps "git checkout -b my-topic" from a detached HEAD should inspect the
> HEAD reflog to see which remote (or local) branch you came from, and give
> that to the --track logic.

So here is a patch for discussion, not heavily tested, but:

	$ git checkout origin/master
        $ git commit; hack hack hack ...
        $ git checkout --track -b mybranch

sequence should result in mybranch tracking the 'master' branch from the
'origin'.

The patch is just a proof of concept; doing this for HEAD reflog that is
several megabytes long might take nontrivial amount of time (at least from
performance standard of git); if we wanted to go this route, we should add
an API to read the reflog entries from more recent to older.

 branch.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git c/branch.c w/branch.c
index b1e59f2..2ec6418 100644
--- c/branch.c
+++ w/branch.c
@@ -48,6 +48,62 @@ static int should_setup_rebase(const struct tracking *tracking)
 }
 
 /*
+ * A branch is created out of "HEAD" and we would want tracking;
+ * go back the reflog to figure out where we really came from.
+ */
+static int refine_head_one(const char *name, size_t namelen,
+			   struct strbuf *found_ref)
+{
+	char *real_ref;
+	unsigned char sha1[20];
+	if (dwim_ref(name, namelen, sha1, &real_ref) != 1)
+		return 0;
+	strbuf_reset(found_ref);
+	strbuf_addstr(found_ref, real_ref);
+	return 0;
+}
+
+static int one_head_ent(unsigned char *osha1, unsigned char *nsha1,
+			const char *ident, unsigned long timestamp, int zone,
+			const char *message, void *cbdata)
+{
+	/*
+	 * Look for signs of HEAD coming from elsewhere.
+	 *
+	 * "checkout: moving from %*s to %s" done by "git checkout"
+	 * "%s: updating HEAD" done by "git reset"
+	 */
+	struct strbuf *found_ref = cbdata;
+	char *cp;
+	size_t len;
+
+	if (!prefixcmp(message, "checkout: moving from ")) {
+		cp = strstr(message, " to ");
+		if (!cp)
+			return 0;
+		cp += 4;
+		len = strlen(cp);
+		if (cp[len-1] == '\n')
+			len--;
+		return refine_head_one(cp, len, found_ref);
+	}
+
+	cp = strstr(message, ": updating HEAD");
+	if (cp && !cp[15])
+		return refine_head_one(message, cp - message, found_ref);
+	return 0;
+}
+
+static const char *refine_head_ref(void)
+{
+	struct strbuf found = STRBUF_INIT;
+
+	strbuf_addstr(&found, "HEAD");
+	for_each_reflog_ent("HEAD", one_head_ent, &found);
+	return strbuf_detach(&found, NULL);
+}
+
+/*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
  * config.
@@ -58,6 +114,9 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	char key[1024];
 	struct tracking tracking;
 
+	if (!strcmp(orig_ref, "HEAD"))
+		orig_ref = refine_head_ref();
+
 	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
 		return error("Tracking not set up: name too long: %s",
 				new_ref);
