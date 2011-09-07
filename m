From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] fetch: bigger forced-update warnings
Date: Wed, 7 Sep 2011 17:20:42 -0400
Message-ID: <20110907212042.GG13364@sigill.intra.peff.net>
References: <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net>
 <20110902152947.GB19213@sigill.intra.peff.net>
 <7v4o0uncq0.fsf@alter.siamese.dyndns.org>
 <20110902162524.GC19690@sigill.intra.peff.net>
 <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
 <20110905204729.GB4221@sigill.intra.peff.net>
 <CAJo=hJtvU+ujYBMvrgVJpBdaTUq+NOsQwVFkL-A4pHv-CRPdDg@mail.gmail.com>
 <20110905205735.GA5578@sigill.intra.peff.net>
 <CAJo=hJvFSegSzTOMj824PoG=soj75JMChfRnjyz4rNgUcVM=Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1PYL-00065B-RH
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095Ab1IGVUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:20:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54497
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757089Ab1IGVUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:20:44 -0400
Received: (qmail 6136 invoked by uid 107); 7 Sep 2011 21:21:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 17:21:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 17:20:42 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvFSegSzTOMj824PoG=soj75JMChfRnjyz4rNgUcVM=Jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180913>

On Mon, Sep 05, 2011 at 02:14:57PM -0700, Shawn O. Pearce wrote:

> > Right. What I mean is, what should the bigger warning look like?
> 
> Its a bikeshed. I refuse to paint bikesheds. :-)

Hmph. Somebody has to write the patch. :P

> > Also, you suggested caching to avoid looking through the whole reflog
> > each time. I think you could probably just sample the last 10 or so
> > reflog entries to get an idea.
> 
> Good point. 10 or so last records might be representative of the
> branch's recent behavior, which is all that matters to the user who
> wants this warning.

Actually, because recent ones are near the end, it's much easier to say
"look at the last 4096 bytes of reflogs" rather than "look at exactly
10". For our purposes, it's about the same (actually 4096 is probably
more like 18-20, depending on the exact size of each entry. But it's a
page, so it's probably reasonable).

-- >8 --
Subject: fetch: bigger forced-update warnings

The default fetch refspec allows forced-updates. We already
print "forced update" in the status table, but it's easy to
miss. Let's make the warning a little more prominent.

Some branches are expected to rewind, so the prominent
warning would be annoying. However, git doesn't know what
the expectation is for a particular branch. We can have it
guess by peeking at the lost couple of reflog entries. If we
see all fast forwards, then a new forced-update is probably
noteworthy. If we see something that force-updates all the
time, it's probably boring and not worth displaying the big
warning (we keep the status table "forced update" note, of
course).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 93c9938..93bfefa 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -208,6 +208,34 @@ static struct ref *get_ref_map(struct transport *transport,
 	return ref_map;
 }
 
+struct update_counts {
+	unsigned fastforward;
+	unsigned forced;
+};
+
+static int count_updates(unsigned char *osha1, unsigned char *nsha1,
+			 const char *email, unsigned long timestamp, int tz,
+			 const char *message, void *data)
+{
+	struct update_counts *uc = data;
+	/* We could check the ancestry of osha1 and nsha1, but this is way
+	 * cheaper */
+	if (!prefixcmp(message, "fetch: fast-forward"))
+		uc->fastforward++;
+	else if (!prefixcmp(message, "fetch: forced-update\n"))
+		uc->forced++;
+	return 0;
+}
+
+static int forced_update_is_uncommon(const char *ref)
+{
+	struct update_counts uc;
+	memset(&uc, 0, sizeof(&uc));
+	if (for_each_recent_reflog_ent(ref, count_updates, 4096, &uc) < 0)
+		for_each_reflog_ent(ref, count_updates, &uc);
+	return uc.fastforward && uc.forced <= 1; /* 1 for the one we just did */
+}
+
 #define STORE_REF_ERROR_OTHER 1
 #define STORE_REF_ERROR_DF_CONFLICT 2
 
@@ -239,7 +267,8 @@ static int s_update_ref(const char *action,
 
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
-			    char *display)
+			    char *display,
+			    int *uncommon_forced_update)
 {
 	struct commit *current = NULL, *updated;
 	enum object_type type;
@@ -336,6 +365,8 @@ static int update_local_ref(struct ref *ref,
 			TRANSPORT_SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
 			pretty_ref,
 			r ? _("unable to update local ref") : _("forced update"));
+		if (!r && forced_update_is_uncommon(ref->name))
+			*uncommon_forced_update = 1;
 		return r;
 	} else {
 		sprintf(display, "! %-*s %-*s -> %s  %s",
@@ -355,6 +386,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
+	int uncommon_forced_update = 0;
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -428,7 +460,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		fputc('\n', fp);
 
 		if (ref) {
-			rc |= update_local_ref(ref, what, note);
+			rc |= update_local_ref(ref, what, note,
+					       &uncommon_forced_update);
 			free(ref);
 		} else
 			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
@@ -450,6 +483,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		error(_("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "
 		      "branches"), remote_name);
+	if (uncommon_forced_update)
+		warning("HEY STUPID FIX YOUR TOPICS");
 	return rc;
 }
 
-- 
1.7.6.10.g62f04
