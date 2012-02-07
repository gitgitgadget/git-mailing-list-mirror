From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 7 Feb 2012 11:05:27 -0500
Message-ID: <20120207160527.GC14773@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 17:05:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RunXy-0007Ok-DS
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 17:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab2BGQFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 11:05:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59293
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302Ab2BGQF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 11:05:29 -0500
Received: (qmail 7565 invoked by uid 107); 7 Feb 2012 16:12:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 11:12:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 11:05:27 -0500
Content-Disposition: inline
In-Reply-To: <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190180>

On Mon, Feb 06, 2012 at 11:01:16PM -0800, Tom Grennan wrote:

> +struct points_at {
> +	struct points_at *next;
> +	unsigned char *sha1;
> +};

Would using sha1_array save us from having to create our own data
structure? As a bonus, it can do O(lg n) lookups, though I seriously
doubt anyone will provide a large number of "--points-at".

> +static void free_points_at (struct points_at *points_at)
> +{
> +	while (points_at) {
> +		struct points_at *next = points_at->next;
> +		free(points_at->sha1);
> +		free(points_at);
> +		points_at = next;
> +	}
> +}

Then this could go away in favor of sha1_array_clear.

> +int parse_opt_points_at(const struct option *opt, const char *arg, int unset)
> +{
> +	struct points_at *new, **opt_value = (struct points_at **)opt->value;
> +	unsigned char *sha1;
> +
> +	if (!arg)
> +		return error(_("missing <object>"));
> +	new = xmalloc(sizeof(struct points_at));
> +	sha1 = xmalloc(20);
> +	if (get_sha1(arg, sha1)) {
> +		free(new);
> +		free(sha1);
> +		return error(_("malformed object name '%s'"), arg);
> +	}
> +	new->sha1 = sha1;
> +	new->next = *opt_value;
> +	*opt_value = new;
> +	return 0;
> +}

And this can drop all of the memory management bits, like:

  unsigned char sha1[20];

  if (!arg)
          return error(_("missing <object>"));
  if (get_sha1(arg, sha1))
          return error(_("malformed object name '%s'"), arg);
  sha1_array_append(opt->value, sha1);
  return 0;

Also, should you check "unset"? When we have options that build a list,
usually doing "--no-foo" will clear the list. E.g., this:

  git tag --points-at=foo --points-at=bar --no-points-at --points-at=baz

should look only for "baz".

> +static struct points_at *match_points_at(struct points_at *points_at,
> +					 const unsigned char *sha1)
> +{
> +	char *buf;
> +	struct tag *tag;
> +	unsigned long size;
> +	enum object_type type;
> +
> +	buf = read_sha1_file(sha1, &type, &size);
> +	if (!buf)
> +		return NULL;
> +	if (type != OBJ_TAG
> +	    || (tag = lookup_tag(sha1), !tag)
> +	    || parse_tag_buffer(tag, buf, size) < 0) {
> +		free(buf);
> +		return NULL;
> +	}
> +	while (points_at && hashcmp(points_at->sha1, tag->tagged->sha1))
> +		points_at = points_at->next;
> +	free(buf);
> +	return points_at;
> +}

Sorry, I threw a lot of object lookup code at you last time, so I think
my point may have been lost in the noise. But I think this is slightly
nicer as:

  static int tag_points_at(struct sha1_array *sa,
                           const unsigned char *sha1)
  {
          struct object *obj = parse_object(sha1);
          if (!obj)
                  return 0; /* or probably we should even just die() */
          if (obj->type != OBJ_TAG)
                  return 0;
          if (sha1_array_lookup(sa, ((struct tag *)obj)->tagged->sha1) < 0)
                  return 0;
          return 1;
  }

I.e., using parse_object lets you avoid dealing with memory management
yourself. And as a bonus, it will reuse the cached information if you
happen to have already parsed that object (not likely in typical
repositories, but a huge win in certain pathological cases, like repos
storing shared objects and refs for a large number of forks).

> +		{
> +			OPTION_CALLBACK, 0, "points-at", &points_at, "object",
> +			"print only annotated|signed tags of the object",
> +			PARSE_OPT_LASTARG_DEFAULT,
> +			parse_opt_points_at, (intptr_t)NULL,
> +		},

I think you can drop the LASTARG_DEFAULT here, as it is no longer
optional, no?

-Peff
