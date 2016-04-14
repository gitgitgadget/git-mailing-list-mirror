From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Thu, 14 Apr 2016 16:36:15 -0400
Message-ID: <20160414203615.GA31504@sigill.intra.peff.net>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
 <1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
 <xmqqtwj6pnma.fsf@gitster.mtv.corp.google.com>
 <xmqqinzmpmg2.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ5gwW1vwREsK=h0tDuyk18axHU491brKJM_DR53=9zcQ@mail.gmail.com>
 <CAPc5daUZvP03o+eb2ngvRtV=aoXWGnZH9FKj9bRCEj3MrCT8WQ@mail.gmail.com>
 <CAOLa=ZQnM95mApOmYYZa3SeFq2af5FMmiqh0ZFZDn3EO8U9-Dg@mail.gmail.com>
 <20160413220559.GC8712@sigill.intra.peff.net>
 <CAOLa=ZR7rKETM2b34B2Whw7Au-t7iFEkcNAB4ZygeQM=9Lp9zQ@mail.gmail.com>
 <20160414200530.GA26513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:36:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqo00-0008GN-0q
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 22:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbcDNUgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 16:36:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:49668 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750928AbcDNUgT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 16:36:19 -0400
Received: (qmail 22076 invoked by uid 102); 14 Apr 2016 20:36:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 16:36:18 -0400
Received: (qmail 2660 invoked by uid 107); 14 Apr 2016 20:36:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 16:36:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 16:36:15 -0400
Content-Disposition: inline
In-Reply-To: <20160414200530.GA26513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291563>

On Thu, Apr 14, 2016 at 04:05:30PM -0400, Jeff King wrote:

> It looks like that's a little tricky for %(upstream) and %(push), which
> have extra tracking options, but it's pretty trivial for %(symref):
> [...]
> I suspect it could work for the remote_ref_atom_parser, too, if you did
> something like:

So here that is (handling both %(symref) and %(upstream), so replacing
what I sent a few minutes ago). It's only lightly tested by me, so there
may be more corner cases to think about. I kept things where they were
to create a minimal diff, but if it gets squashed in, it might be worth
re-ordering a little to avoid the need for forward declarations.

> I don't know if that would create weird corner cases with RR_SHORTEN
> and RR_TRACK, though, which are currently in the same enum (and thus
> cannot be used at the same time). But it's not like we parse
> "%(upstream:short:track)" anyway, I don't think. For each "%()"
> placeholder you have to choose one or the other: showing the tracking
> info, or showing the refname (possibly with modifiers). So ":track"
> isn't so much a modifier as "upstream:track" is this totally other
> thing.

So actually, we _do_ accept "%(upstream:short,track)" with your patch,
which is somewhat nonsensical. It just ignores "short" and takes
whatever option came last. Which is reasonable, though flagging an error
would also be reasonable (and I think is what existing git does). I
don't think it matters much either way.

---
diff --git a/ref-filter.c b/ref-filter.c
index 3435df1..951c57e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -50,6 +50,11 @@ struct if_then_else {
 		condition_satisfied : 1;
 };
 
+struct refname_atom {
+	enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
+	unsigned int strip;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -67,7 +72,8 @@ static struct used_atom {
 		char color[COLOR_MAXLEN];
 		struct align align;
 		struct {
-			enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT } option;
+			enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
+			struct refname_atom refname;
 			unsigned int nobracket: 1;
 		} remote_ref;
 		struct {
@@ -82,16 +88,14 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
-		enum { S_FULL, S_SHORT } symref;
-		struct {
-			enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
-			unsigned int strip;
-		} refname;
+		struct refname_atom refname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 static int need_color_reset_at_eol;
 
+static const char *show_ref(struct refname_atom *atom, const char *refname);
+
 static void color_atom_parser(struct used_atom *atom, const char *color_value)
 {
 	if (!color_value)
@@ -100,13 +104,34 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 		die(_("unrecognized color: %%(color:%s)"), color_value);
 }
 
+static void refname_atom_parser_internal(struct refname_atom *atom,
+					 const char *arg, const char *name)
+{
+	if (!arg)
+		atom->option = R_NORMAL;
+	else if (!strcmp(arg, "short"))
+		atom->option = R_SHORT;
+	else if (skip_prefix(arg, "strip=", &arg)) {
+		atom->option = R_STRIP;
+		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
+			die(_("positive value expected refname:strip=%s"), arg);
+	} else if (!strcmp(arg, "dir"))
+		atom->option = R_DIR;
+	else if (!strcmp(arg, "base"))
+		atom->option = R_BASE;
+	else
+		die(_("unrecognized %%(%s) argument: %s"), name, arg);
+}
+
 static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
 
 	if (!arg) {
-		atom->u.remote_ref.option = RR_NORMAL;
+		atom->u.remote_ref.option = RR_REF;
+		refname_atom_parser_internal(&atom->u.remote_ref.refname,
+					     arg, atom->name);
 		return;
 	}
 
@@ -116,16 +141,17 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 	for (i = 0; i < params.nr; i++) {
 		const char *s = params.items[i].string;
 
-		if (!strcmp(s, "short"))
-			atom->u.remote_ref.option = RR_SHORTEN;
-		else if (!strcmp(s, "track"))
+		if (!strcmp(s, "track"))
 			atom->u.remote_ref.option = RR_TRACK;
 		else if (!strcmp(s, "trackshort"))
 			atom->u.remote_ref.option = RR_TRACKSHORT;
 		else if (!strcmp(s, "nobracket"))
 			atom->u.remote_ref.nobracket = 1;
-		else
-			die(_("unrecognized format: %%(%s)"), atom->name);
+		else {
+			atom->u.remote_ref.option = RR_REF;
+			refname_atom_parser_internal(&atom->u.remote_ref.refname,
+						     s, atom->name);
+		}
 	}
 
 	string_list_clear(&params, 0);
@@ -244,31 +270,12 @@ static void if_atom_parser(struct used_atom *atom, const char *arg)
 
 static void symref_atom_parser(struct used_atom *atom, const char *arg)
 {
-	if (!arg)
-		atom->u.symref = S_FULL;
-	else if (!strcmp(arg, "short"))
-		atom->u.symref = S_SHORT;
-	else
-		die(_("unrecognized %%(symref) argument: %s"), arg);
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
 }
 
 static void refname_atom_parser(struct used_atom *atom, const char *arg)
 {
-	if (!arg)
-		atom->u.refname.option = R_NORMAL;
-	else if (!strcmp(arg, "short"))
-		atom->u.refname.option = R_SHORT;
-	else if (skip_prefix(arg, "strip=", &arg)) {
-		atom->u.contents.option = R_STRIP;
-		if (strtoul_ui(arg, 10, &atom->u.refname.strip) ||
-			atom->u.refname.strip <= 0)
-			die(_("positive value expected refname:strip=%s"), arg);
-	} else if (!strcmp(arg, "dir"))
-		atom->u.contents.option = R_DIR;
-	else if (!strcmp(arg, "base"))
-		atom->u.contents.option = R_BASE;
-	else
-		die(_("unrecognized %%(refname) argument: %s"), arg);
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
 }
 
 static struct {
@@ -1112,8 +1119,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				    struct branch *branch, const char **s)
 {
 	int num_ours, num_theirs;
-	if (atom->u.remote_ref.option == RR_SHORTEN)
-		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	if (atom->u.remote_ref.option == RR_REF)
+		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
 				       &num_theirs, NULL)) {
@@ -1145,8 +1152,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = ">";
 		else
 			*s = "<>";
-	} else /* RR_NORMAL */
-		*s = refname;
+	} else
+		die("BUG: unhandled RR_* enum");
 }
 
 char *get_head_description(void)
@@ -1184,41 +1191,43 @@ static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref
 {
 	if (!ref->symref)
 		return "";
-	else if (atom->u.symref == S_SHORT)
-		return shorten_unambiguous_ref(ref->symref,
-					       warn_ambiguous_refs);
 	else
-		return ref->symref;
+		return show_ref(&atom->u.refname, ref->symref);
 }
 
 static const char *get_refname(struct used_atom *atom, struct ref_array_item *ref)
 {
 	if (ref->kind & FILTER_REFS_DETACHED_HEAD)
 		return get_head_description();
-	if (atom->u.refname.option == R_SHORT)
-		return shorten_unambiguous_ref(ref->refname, warn_ambiguous_refs);
-	else if (atom->u.refname.option == R_STRIP)
-		return strip_ref_components(ref->refname, atom->u.refname.strip);
-	else if (atom->u.refname.option == R_BASE) {
+	return show_ref(&atom->u.refname, ref->refname);
+}
+
+static const char *show_ref(struct refname_atom *atom, const char *refname)
+{
+	if (atom->option == R_SHORT)
+		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	else if (atom->option == R_STRIP)
+		return strip_ref_components(refname, atom->strip);
+	else if (atom->option == R_BASE) {
 		const char *sp, *ep;
 
-		if (skip_prefix(ref->refname, "refs/", &sp)) {
+		if (skip_prefix(refname, "refs/", &sp)) {
 			ep = strchr(sp, '/');
 			if (!ep)
 				return "";
 			return xstrndup(sp, ep - sp);
 		}
 		return "";
-	} else if (atom->u.refname.option == R_DIR) {
+	} else if (atom->option == R_DIR) {
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
