From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/16] refs: convert for_each_tag_ref to struct
 object_id
Date: Thu, 23 Apr 2015 15:27:23 -0400
Message-ID: <20150423192723.GA29220@peff.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
 <1429745061-295908-3-git-send-email-sandals@crustytoothpaste.net>
 <CAGZ79kas9QgJy1ooCjHPR+ZGGuTdMhTxO9zSMxnGpPk8rG5_xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 21:27:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlMmc-0005px-Ej
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 21:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbbDWT13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 15:27:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:49343 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030493AbbDWT10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 15:27:26 -0400
Received: (qmail 1410 invoked by uid 102); 23 Apr 2015 19:27:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Apr 2015 14:27:26 -0500
Received: (qmail 8265 invoked by uid 107); 23 Apr 2015 19:27:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Apr 2015 15:27:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Apr 2015 15:27:23 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kas9QgJy1ooCjHPR+ZGGuTdMhTxO9zSMxnGpPk8rG5_xQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267703>

On Thu, Apr 23, 2015 at 11:13:32AM -0700, Stefan Beller wrote:

> On Wed, Apr 22, 2015 at 4:24 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > To allow piecemeal conversion of the for_each_*_ref functions, introduce
> > an additional typedef for a callback function that takes struct
> > object_id * instead of unsigned char *.  Provide an extra field in
> > struct ref_entry_cb for this callback and ensure at most one is set at a
> > time.  Temporarily suffix these new entries with _oid to distinguish
> > them.  Convert for_each_tag_ref and its callers to use the new _oid
> > functions, introducing temporary wrapper functions to avoid type
> > mismatches.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> 
> I am currently running this patch series via
> git rebase -i origin/next --exec=make --exec="make test"
> through the compilation and test suite one by one.
> (My current view of origin/next is (c8da2d582, Sync with 2.4.0-rc3)
> and this commit fails in t5312-prune-corruption.sh test 3 5 and 8

It's because of this hunk:

> > @@ -1950,6 +1956,21 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
> >         data.trim = trim;
> >         data.flags = flags;
> >         data.fn = fn;
> > +       data.fn_oid = NULL;
> > +       data.cb_data = cb_data;
> > +
> > +       return do_for_each_entry(refs, base, do_one_ref, &data);
> > +}
> > +
> > +static int do_for_each_ref_oid(struct ref_cache *refs, const char *base,
> > +                          each_ref_fn_oid fn, int trim, int flags, void *cb_data)
> > +{
> > +       struct ref_entry_cb data;
> > +       data.base = base;
> > +       data.trim = trim;
> > +       data.flags = flags;
> > +       data.fn = NULL;
> > +       data.fn_oid = fn;
> >         data.cb_data = cb_data;
> >
> >         if (ref_paranoia < 0)

The ref_paranoia code gets pushed down into do_for_each_ref_oid, but it
needs called in both do_for_each_ref variants. This is probably an
artifact of rebasing the patches (the ref_paranoia stuff was added
recently).

I think it would make sense to pull the setup of the data struct into a
shared function rather than duplicate it. But we want to avoid having to
update do_for_each_ref callsites, so we'll have to provide a wrapper.

Like this:

diff --git a/refs.c b/refs.c
index 95863f2..ad39d74 100644
--- a/refs.c
+++ b/refs.c
@@ -1948,29 +1948,16 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
  * value, stop the iteration and return that value; otherwise, return
  * 0.
  */
-static int do_for_each_ref(struct ref_cache *refs, const char *base,
-			   each_ref_fn fn, int trim, int flags, void *cb_data)
+static int do_for_each_ref_generic(struct ref_cache *refs, const char *base,
+				   each_ref_fn fn, each_ref_fn_oid fn_oid,
+				   int trim, int flags, void *cb_data)
 {
 	struct ref_entry_cb data;
 	data.base = base;
 	data.trim = trim;
 	data.flags = flags;
 	data.fn = fn;
-	data.fn_oid = NULL;
-	data.cb_data = cb_data;
-
-	return do_for_each_entry(refs, base, do_one_ref, &data);
-}
-
-static int do_for_each_ref_oid(struct ref_cache *refs, const char *base,
-			   each_ref_fn_oid fn, int trim, int flags, void *cb_data)
-{
-	struct ref_entry_cb data;
-	data.base = base;
-	data.trim = trim;
-	data.flags = flags;
-	data.fn = NULL;
-	data.fn_oid = fn;
+	data.fn_oid = fn_oid;
 	data.cb_data = cb_data;
 
 	if (ref_paranoia < 0)
@@ -1981,6 +1968,18 @@ static int do_for_each_ref_oid(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
+static int do_for_each_ref(struct ref_cache *refs, const char *base,
+			   each_ref_fn fn, int trim, int flags, void *cb_data)
+{
+	return do_for_each_ref_generic(refs, base, fn, NULL, trim, flags, cb_data);
+}
+
+static int do_for_each_ref_oid(struct ref_cache *refs, const char *base,
+			       each_ref_fn_oid fn, int trim, int flags, void *cb_data)
+{
+	return do_for_each_ref_generic(refs, base, NULL, fn, trim, flags, cb_data);
+}
+
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	unsigned char sha1[20];

You can even dispense with the _oid variant wrapper, and just call into
the generic version directly from the new callsites.

-Peff
