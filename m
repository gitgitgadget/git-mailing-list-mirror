From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/67] mailsplit: make PATH_MAX buffers dynamic
Date: Wed, 16 Sep 2015 06:14:18 -0400
Message-ID: <20150916101418.GD13966@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152806.GJ29753@sigill.intra.peff.net>
 <CAPig+cQ+TvT2_ZrbbYFQOdjDNs+b-ADJb+EbKVTP-HaCghjCow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 12:17:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc9mW-0005jX-OM
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 12:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbbIPKOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 06:14:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:59843 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752709AbbIPKO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 06:14:27 -0400
Received: (qmail 15182 invoked by uid 102); 16 Sep 2015 10:14:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 05:14:27 -0500
Received: (qmail 16473 invoked by uid 107); 16 Sep 2015 10:14:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 06:14:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 06:14:18 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQ+TvT2_ZrbbYFQOdjDNs+b-ADJb+EbKVTP-HaCghjCow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278014>

On Tue, Sep 15, 2015 at 08:51:26PM -0400, Eric Sunshine wrote:

> >                 if (strbuf_getwholeline(&buf, f, '\n')) {
> > -                       error("cannot read mail %s (%s)", file, strerror(errno));
> > +                       error("cannot read mail %s (%s)", file.buf, strerror(errno));
> >                         goto out;
> >                 }
> >
> > -               sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
> > +               name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
> >                 split_one(f, name, 1);
> > +               free(name);
> 
> Hmm, why does 'file' become a strbuf which is re-used each time
> through the loop, but 'name' is treated differently and gets
> re-allocated upon each iteration? Why doesn't 'name' deserve the same
> treatment as 'file'?

My thinking was rather the other way around: why doesn't "file" get the
same treatment as "name"?

I generally prefer xstrfmt to strbufs in these patches for two reasons:

  1. The result has fewer lines.

  2. The variable switches from an array to a pointer, so accessing it
     doesn't change. Whereas with a strbuf, you have to s/foo/foo.buf/
     wherever it is accessed.

We can do that easily with "name"; we allocate it, use it, and free it.
But the lifetime of "file" crosses the "goto out" boundaries, and so
it's simplest to clean it up in the "out" section. Doing that correctly
with a bare pointer is tricky (you have to re-NULL it every time you
free the old value), whereas the strbuf's invariants make it trivial.

I guess we could get away with always calling free() right before
assigning (the equivalent of strbuf_reset()), and then rely on exiting
the loop to "out" to do the final free. And then the result (versus the
original code, not my patch) would look like:

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 9de06e3..a82dd0d 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -148,8 +155,7 @@ static int maildir_filename_cmp(const char *a, const char *b)
 static int split_maildir(const char *maildir, const char *dir,
 	int nr_prec, int skip)
 {
-	char file[PATH_MAX];
-	char name[PATH_MAX];
+	char *file = NULL;
 	FILE *f = NULL;
 	int ret = -1;
 	int i;
@@ -161,7 +167,11 @@ static int split_maildir(const char *maildir, const char *dir,
 		goto out;
 
 	for (i = 0; i < list.nr; i++) {
-		snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].string);
+		char *name;
+
+		free(file);
+		file = xstrfmt("%s/%s", maildir, list.items[i].string);
+
 		f = fopen(file, "r");
 		if (!f) {
 			error("cannot open mail %s (%s)", file, strerror(errno));
@@ -173,8 +183,9 @@ static int split_maildir(const char *maildir, const char *dir,
 			goto out;
 		}
 
-		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
 		split_one(f, name, 1);
+		free(name);
 
 		fclose(f);
 		f = NULL;
@@ -184,6 +195,7 @@ static int split_maildir(const char *maildir, const char *dir,
 out:
 	if (f)
 		fclose(f);
+	free(file);
 	string_list_clear(&list, 1);
 	return ret;
 }

which is not so bad.

Of course this is more allocations per loop than using a strbuf. I doubt
it matters in practice (we are about to fopen() and read into a strbuf,
after all!), but we could also follow the opposite direction and use
strbufs for both.

-Peff
