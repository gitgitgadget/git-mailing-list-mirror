From: Jeff King <peff@peff.net>
Subject: Re: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 20:34:33 -0500
Message-ID: <20140125013433.GA22336@sigill.intra.peff.net>
References: <20140124090104.GA396@x4>
 <0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
 <20140124170739.GC396@x4>
 <20140124170909.GD396@x4>
 <20140124182341.GB8202@sigill.intra.peff.net>
 <20140124183222.GE396@x4>
 <20140124185538.GA9836@sigill.intra.peff.net>
 <xmqq4n4trvzj.fsf@gitster.dls.corp.google.com>
 <20140124204825.GA17167@sigill.intra.peff.net>
 <xmqqeh3xqe91.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>,
	Jim Garrison <jim.garrison@nwea.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 25 02:35:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6s9G-0004Yu-BS
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 02:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbaAYBeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 20:34:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:38505 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751432AbaAYBef (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 20:34:35 -0500
Received: (qmail 22496 invoked by uid 102); 25 Jan 2014 01:34:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Jan 2014 19:34:35 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:34:33 -0500
Content-Disposition: inline
In-Reply-To: <xmqqeh3xqe91.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241057>

On Fri, Jan 24, 2014 at 01:08:42PM -0800, Junio C Hamano wrote:

> Not really.  You do not have to view it as "'not refs/heads/foo' is
> affecting the previous '+refs/heads/*:refs/remotes/origin/*'".
> 
> You can think of two refspecs "refs/heads/foo refs/heads/bar" are
> both affecting the "end result"; so far we only had a single way for
> multiple refspecs to affect the end result and that was a "union".
> Introducing "subtract" as another mode of combining is not too bad,
> I would think, at the conceptual level.

OK, I buy that line of reasoning. I assume that ordering should not
matter (that is, we would apply all positive refspecs, and then subtract
all negative refspecs).

I took a quick look at the refspec code, and how bad it would be to
implement this feature. It's rather a bit of a mess. It looks like there
are three separate code paths to apply refspecs:

  - fetch uses get_ref_map, which calls get_fetch_map for each refspec;
    each refspec than expands into 0, 1, or multiple refs (if it's a
    pattern). You can mention a ref multiple times on the LHS of a
    refspec, and it may be fetched multiple times. After we have the
    whole list, we detect duplicate destinations, and either drop the
    duplicates (if all sources are the same) or complain (if there are
    different sources).

  - push uses match_push_refs, which calls get_ref_match for each ref
    (not refspec). So the loop is inside-out from fetch, and it looks
    like we do weird things with multiple matches. We seem to handle
    multiple explicit matches like:

      $ git push --dry-run tmp master:foo master:bar
      To tmp
       * [new branch]      master -> foo
       * [new branch]      master -> bar

    but we don't seem to do the same for pattern matches:

      $ git push --dry-run tmp refs/heads/*:refs/foo/* \
                               refs/heads/*:refs/bar/*
      To tmp
       * [new branch]      master -> refs/foo/master

    we just take the first match, even though the two did not conflict.
    I doubt this comes up that much, but I do not see any reason this
    should not be doing the same as fetch: apply all refspecs to come up
    with a complete list, then cull duplicates.

  - @{upstream} uses apply_refspecs to convert a single name. This is
    also used by transport-helper's fetch_with_import and
    push_with_import. Which makes me think they do not handle
    overlapping refspecs at all, unlike the builtin counterparts.

    There is also query_refspecs, which underlies apply_refspecs. I'm
    not even sure I understand all of the uses there.

The patch below implements negative refspecs for fetch, but does nothing
for push and apply_refspecs (in fact, it probably makes them worse,
because they've learned to parse negative refspecs, but not handle them
properly).

The helpers in the patch could probably be used to build support for the
other code paths, but it really seems like there could stand to be some
refactoring. I'm not sure if I have the time/stomach for it at the
moment. But I'll post this here anyway in case somebody else is
interested.

> I tend to agree that "refs/heads/foo:" is being too cute and may be
> confusing, at least if it will be the only way to express this in
> the end-user-facing UI.  Even some people were confused enough on a
> very sensible "push nothing to ref means deletion" to make us add
> another explicit way, "push --delete", to ask for the same thing.

Agreed. I went with "^refs/heads/master" in the patch below, but I am
open to other suggestions.

---
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 025bc3e..47f25e9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -363,6 +363,8 @@ static struct ref *get_ref_map(struct transport *transport,
 		tail = &rm->next;
 	}
 
+	ref_map = apply_negative_refspecs(ref_map, refspecs, refspec_count);
+
 	return ref_remove_duplicates(ref_map);
 }
 
diff --git a/remote.c b/remote.c
index a89efab..b7b20de 100644
--- a/remote.c
+++ b/remote.c
@@ -16,6 +16,7 @@ static struct refspec s_tag_refspec = {
 	1,
 	0,
 	0,
+	0,
 	"refs/tags/*",
 	"refs/tags/*"
 };
@@ -533,8 +534,14 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			rs[i].force = 1;
 			lhs++;
 		}
+		else if (*lhs == '^') {
+			rs[i].negative = 1;
+			lhs++;
+		}
 
 		rhs = strrchr(lhs, ':');
+		if (rs[i].negative && rhs)
+			goto invalid;
 
 		/*
 		 * Before going on, special case ":" (or "+:") as a refspec
@@ -1663,6 +1670,9 @@ int get_fetch_map(const struct ref *remote_refs,
 {
 	struct ref *ref_map, **rmp;
 
+	if (refspec->negative)
+		return 0;
+
 	if (refspec->pattern) {
 		ref_map = get_expanded_map(remote_refs, refspec);
 	} else {
@@ -1705,6 +1715,48 @@ int get_fetch_map(const struct ref *remote_refs,
 	return 0;
 }
 
+static int refspec_match(const struct refspec *refspec,
+			 const char *name)
+{
+	if (refspec->pattern)
+		return match_name_with_pattern(refspec->src, name, NULL, NULL);
+
+	return !strcmp(refspec->src, name);
+}
+
+static int omit_name_by_refspec(const char *name,
+				const struct refspec *refspecs,
+				int nr_refspec)
+{
+	int i;
+
+	for (i = 0; i < nr_refspec; i++) {
+		if (refspecs[i].negative && refspec_match(&refspecs[i], name))
+			return 1;
+	}
+	return 0;
+}
+
+struct ref *apply_negative_refspecs(struct ref *ref_map,
+				    const struct refspec *refspecs,
+				    int nr_refspec)
+{
+	struct ref **tail;
+
+	for (tail = &ref_map; *tail; ) {
+		struct ref *ref = *tail;
+
+		if (omit_name_by_refspec(ref->name, refspecs, nr_refspec)) {
+			*tail = ref->next;
+			free(ref->peer_ref);
+			free(ref);
+		} else
+			tail = &ref->next;
+	}
+
+	return ref_map;
+}
+
 int resolve_remote_symref(struct ref *ref, struct ref *list)
 {
 	if (!ref->symref)
diff --git a/remote.h b/remote.h
index fb7647f..534d365 100644
--- a/remote.h
+++ b/remote.h
@@ -67,6 +67,7 @@ struct refspec {
 	unsigned pattern : 1;
 	unsigned matching : 1;
 	unsigned exact_sha1 : 1;
+	unsigned negative : 1;
 
 	char *src;
 	char *dst;
@@ -157,6 +158,10 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
+struct ref *apply_negative_refspecs(struct ref *ref_map,
+				    const struct refspec *refspecs,
+				    int nr_refspecs);
+
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 
