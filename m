From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 20/21] refs: add LMDB refs backend
Date: Thu, 14 Jan 2016 15:52:59 -0500
Message-ID: <20160114205259.GA10440@sigill.intra.peff.net>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
 <1452561740-8668-21-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:53:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJotI-0004fc-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 21:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbcANUxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 15:53:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:53927 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750999AbcANUxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 15:53:01 -0500
Received: (qmail 9315 invoked by uid 102); 14 Jan 2016 20:53:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 15:53:01 -0500
Received: (qmail 11472 invoked by uid 107); 14 Jan 2016 20:53:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 15:53:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 15:52:59 -0500
Content-Disposition: inline
In-Reply-To: <1452561740-8668-21-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284091>

On Mon, Jan 11, 2016 at 08:22:19PM -0500, David Turner wrote:

> +static int rename_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
> +			     const char *email, unsigned long timestamp, int tz,
> +			     const char *message, void *cb_data)
> +{
> +
> +	const char *newrefname = cb_data;
> +	MDB_val key, new_key, val;
> +
> +	assert(transaction.cursor);
> +
> +	if (mdb_cursor_get_or_die(transaction.cursor, &key, &val, MDB_GET_CURRENT))
> +		die("renaming ref: mdb_cursor_get failed to get current");
> +
> +	new_key.mv_size = strlen(newrefname) + 5 + 1 + 8;
> +	new_key.mv_data = xmalloc(new_key.mv_size);
> +	strcpy(new_key.mv_data, "logs/");
> +	strcpy((char *)new_key.mv_data + 5, newrefname);
> +	memcpy((char *)new_key.mv_data + new_key.mv_size - 8,
> +	       (const char *)key.mv_data + key.mv_size - 8, 8);
> +	mdb_put_or_die(&transaction, &new_key, &val, 0);
> +	mdb_cursor_del_or_die(transaction.cursor, 0);
> +	free(new_key.mv_data);
> +	return 0;

When you re-roll, do you mind avoiding strcpy here? I know that your
malloc is big enough, but:

  1. Avoiding strcpy makes auditing easier.

  2. We can probably come up with a solution that avoids the magic
     numbers, making it more pleasant to read.

  3. Manual computation plus a strcpy can be vulnerable to integer
     overflows in the size (I didn't check the types on MDB_val to see
     if that is feasible or not, but again, it's nice to avoid for audit
     purposes).

Since we free the memory immediately-ish, I think using a strbuf would
be a good fit. Something like:

  struct strbuf path = STRBUF_INIT;
  ...
  strbuf_addf(&path, "logs/%s", newrefname);
  strbuf_add(&path, (const char *)key.mv_data + key.mv_size - 8, 8);
  new_key.mv_size = path.len;
  new_key.mv_data = path.buf;
  ... mdb_put, etc ...
  strbuf_release(&path);

(I hope I'm reading the 8-byte thing right; should we also be asserting
that key.mv_size >= 8?).

> +static int lmdb_for_each_reflog_ent_order(const char *refname,
> +					  each_reflog_ent_fn fn,
> +					  void *cb_data, int reverse)
> +{
> +	MDB_val key, val;
> +	char *search_key;
> +	char *log_path;
> +	int len;
> +	MDB_cursor *cursor;
> +	int ret = 0;
> +	struct strbuf sb = STRBUF_INIT;
> +	enum MDB_cursor_op direction = reverse ? MDB_PREV : MDB_NEXT;
> +	uint64_t zero = 0ULL;
> +
> +	len = strlen(refname) + 6;
> +	log_path = xmalloc(len);
> +	search_key = xmalloc(len + 1);
> +	sprintf(log_path, "logs/%s", refname);
> +	strcpy(search_key, log_path);

Ditto here (and for sprintf, too). You can do these with xstrfmt:

  log_path = xstrfmt("logs/%s", refname);
  len = strlen(log_path); /* or use a strbuf to avoid the extra strlen */

The search_key one looks like an extra off-by-one, but the extra byte
gets used below. So maybe:

  /* \0 may be rewritten as \1 for reverse search below */
  search_key = xstrfmt("%s\0", log_path);

though I think:

  if (reverse) {
	/* explanation ... */
	search_key = xstrfmt("%s\1", log_path);
  } else {
	search_key = xstrdup(log_path);
  }

might be clearer to a reader. There are a few other sprintfs and
strcpys, but I think they can all use similar techniques.

-Peff
