From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Thu, 14 Apr 2016 16:05:30 -0400
Message-ID: <20160414200530.GA26513@sigill.intra.peff.net>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
 <1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
 <xmqqtwj6pnma.fsf@gitster.mtv.corp.google.com>
 <xmqqinzmpmg2.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ5gwW1vwREsK=h0tDuyk18axHU491brKJM_DR53=9zcQ@mail.gmail.com>
 <CAPc5daUZvP03o+eb2ngvRtV=aoXWGnZH9FKj9bRCEj3MrCT8WQ@mail.gmail.com>
 <CAOLa=ZQnM95mApOmYYZa3SeFq2af5FMmiqh0ZFZDn3EO8U9-Dg@mail.gmail.com>
 <20160413220559.GC8712@sigill.intra.peff.net>
 <CAOLa=ZR7rKETM2b34B2Whw7Au-t7iFEkcNAB4ZygeQM=9Lp9zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:05:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqnWE-0001CY-HN
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 22:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbcDNUFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 16:05:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:49654 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751044AbcDNUFd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 16:05:33 -0400
Received: (qmail 20501 invoked by uid 102); 14 Apr 2016 20:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 16:05:33 -0400
Received: (qmail 2492 invoked by uid 107); 14 Apr 2016 20:05:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 16:05:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 16:05:30 -0400
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR7rKETM2b34B2Whw7Au-t7iFEkcNAB4ZygeQM=9Lp9zQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291561>

On Fri, Apr 15, 2016 at 12:47:15AM +0530, Karthik Nayak wrote:

> That does make sense, I guess then I'll stick to shortening all symref's
> by default and allowing the user to change this if needed via the '--format'
> option.

Thanks.

> About %(symref) not getting enough formatting options, I don't see anything
> else in %(upstream) which would be required in %(symref), maybe the 'strip=X'
> option could be added. But for now I see 'short' to be the only needed option.
> If anyone feels that something else would be useful, I'd be glad to
> add it along.

"strip" was the one I was most interested in. I thought "%(upstream)"
and "%(push)" would also take "dir" and "base", which "%(refname)" does.
I'm not sure when those are useful in the first place, but it seems like
they should apply equally well to any instance where we show a ref:
%(refname), %(upstream), %(push), or %(symref).

IOW, I'd expect the logic for handling atom->u.refname to be in a common
function that just gets fed ref->refname, or ref->symref, or whatever.

It looks like that's a little tricky for %(upstream) and %(push), which
have extra tracking options, but it's pretty trivial for %(symref):

diff --git a/ref-filter.c b/ref-filter.c
index 3435df1..816f8c0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -82,7 +82,6 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
-		enum { S_FULL, S_SHORT } symref;
 		struct {
 			enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
 			unsigned int strip;
@@ -242,16 +241,6 @@ static void if_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(if) argument: %s"), arg);
 }
 
-static void symref_atom_parser(struct used_atom *atom, const char *arg)
-{
-	if (!arg)
-		atom->u.symref = S_FULL;
-	else if (!strcmp(arg, "short"))
-		atom->u.symref = S_SHORT;
-	else
-		die(_("unrecognized %%(symref) argument: %s"), arg);
-}
-
 static void refname_atom_parser(struct used_atom *atom, const char *arg)
 {
 	if (!arg)
@@ -305,7 +294,7 @@ static struct {
 	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
-	{ "symref", FIELD_STR, symref_atom_parser },
+	{ "symref", FIELD_STR, refname_atom_parser },
 	{ "flag" },
 	{ "HEAD" },
 	{ "color", FIELD_STR, color_atom_parser },
@@ -1180,29 +1169,33 @@ char *get_head_description(void)
 	return strbuf_detach(&desc, NULL);
 }
 
+static const char *show_ref(struct used_atom *atom, const char *refname);
+
 static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref)
 {
 	if (!ref->symref)
 		return "";
-	else if (atom->u.symref == S_SHORT)
-		return shorten_unambiguous_ref(ref->symref,
-					       warn_ambiguous_refs);
 	else
-		return ref->symref;
+		return show_ref(atom, ref->symref);
 }
 
 static const char *get_refname(struct used_atom *atom, struct ref_array_item *ref)
 {
 	if (ref->kind & FILTER_REFS_DETACHED_HEAD)
 		return get_head_description();
+	return show_ref(atom, ref->refname);
+}
+
+static const char *show_ref(struct used_atom *atom, const char *refname)
+{
 	if (atom->u.refname.option == R_SHORT)
-		return shorten_unambiguous_ref(ref->refname, warn_ambiguous_refs);
+		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->u.refname.option == R_STRIP)
-		return strip_ref_components(ref->refname, atom->u.refname.strip);
+		return strip_ref_components(refname, atom->u.refname.strip);
 	else if (atom->u.refname.option == R_BASE) {
 		const char *sp, *ep;
 
-		if (skip_prefix(ref->refname, "refs/", &sp)) {
+		if (skip_prefix(refname, "refs/", &sp)) {
 			ep = strchr(sp, '/');
 			if (!ep)
 				return "";
@@ -1212,13 +1205,13 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 	} else if (atom->u.refname.option == R_DIR) {
 		const char *sp, *ep;
 
-		sp = ref->refname;
+		sp = refname;
 		ep = strrchr(sp, '/');
 		if (!ep)
 			return "";
 		return xstrndup(sp, ep - sp);
 	} else
-		return ref->refname;
+		return refname;
 }
 
 /*


I suspect it could work for the remote_ref_atom_parser, too, if you did
something like:

  struct refname_parser_atom {
    enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
    unsigned int strip;
  };

  struct used_atom {
    ...
    union {
      struct refname_parser_atom refname;
      struct {
        struct refname_parser_atom refname;
	enum { RR_TRACK, ... } option;
      } remote_ref;
      ...
  };

and then just passed the refname_parser_atom to show_ref() above. I
don't know if that would create weird corner cases with RR_SHORTEN and
RR_TRACK, though, which are currently in the same enum (and thus cannot
be used at the same time). But it's not like we parse
"%(upstream:short:track)" anyway, I don't think. For each "%()"
placeholder you have to choose one or the other: showing the tracking
info, or showing the refname (possibly with modifiers). So ":track"
isn't so much a modifier as "upstream:track" is this totally other
thing.

-Peff
