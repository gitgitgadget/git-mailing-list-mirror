From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 7 Feb 2012 11:02:28 -0800
Message-ID: <20120207190228.GB6264@tgrennan-laptop>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
 <20120207160527.GC14773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 20:02:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuqJK-0004Sn-Lt
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 20:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496Ab2BGTCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 14:02:33 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:39046 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756092Ab2BGTCc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 14:02:32 -0500
Received: by obcva7 with SMTP id va7so8677713obc.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 11:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=K/5csF/f07tUryQnl2DNZGAaK6RVdKVFL5h4zTTMioY=;
        b=wh/Q2uPp39xXZW1rESGxH6ZXpwEvV9n+YbO0HyE6qoJU6zZzgppZUEZ6WM5B29ePsh
         WoOnPAwA8JNt6VTiWB034INONPMhAjrtqZwG2wuSuXKEthv+5BPb9nsmoWPCv7xo1Jm8
         CqTLeeBHINyRMWrNMcoLn5pY5g8LHHcz6j1oE=
Received: by 10.182.75.102 with SMTP id b6mr22383545obw.9.1328641352275;
        Tue, 07 Feb 2012 11:02:32 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id n4sm13998180obv.10.2012.02.07.11.02.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 11:02:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120207160527.GC14773@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190199>

On Tue, Feb 07, 2012 at 11:05:27AM -0500, Jeff King wrote:
>On Mon, Feb 06, 2012 at 11:01:16PM -0800, Tom Grennan wrote:
>
>> +struct points_at {
>> +	struct points_at *next;
>> +	unsigned char *sha1;
>> +};
>
>Would using sha1_array save us from having to create our own data
>structure? As a bonus, it can do O(lg n) lookups, though I seriously
>doubt anyone will provide a large number of "--points-at".

Thanks, but I now realize that I also need to save the pointed at
refname to detect lightweight tags that have matching sha's but
different names.

>> +static void free_points_at (struct points_at *points_at)
>> +{
>> +	while (points_at) {
>> +		struct points_at *next = points_at->next;
>> +		free(points_at->sha1);
>> +		free(points_at);
>> +		points_at = next;
>> +	}
>> +}
>
>Then this could go away in favor of sha1_array_clear.
>
>> +int parse_opt_points_at(const struct option *opt, const char *arg, int unset)
>> +{
>> +	struct points_at *new, **opt_value = (struct points_at **)opt->value;
>> +	unsigned char *sha1;
>> +
>> +	if (!arg)
>> +		return error(_("missing <object>"));
>> +	new = xmalloc(sizeof(struct points_at));
>> +	sha1 = xmalloc(20);
>> +	if (get_sha1(arg, sha1)) {
>> +		free(new);
>> +		free(sha1);
>> +		return error(_("malformed object name '%s'"), arg);
>> +	}
>> +	new->sha1 = sha1;
>> +	new->next = *opt_value;
>> +	*opt_value = new;
>> +	return 0;
>> +}
>
>And this can drop all of the memory management bits, like:
>
>  unsigned char sha1[20];
>
>  if (!arg)
>          return error(_("missing <object>"));
>  if (get_sha1(arg, sha1))
>          return error(_("malformed object name '%s'"), arg);
>  sha1_array_append(opt->value, sha1);
>  return 0;
>
>Also, should you check "unset"? When we have options that build a list,
>usually doing "--no-foo" will clear the list. E.g., this:
>
>  git tag --points-at=foo --points-at=bar --no-points-at --points-at=baz
>
>should look only for "baz".

Ahh, so I just need to:
	if (unset) {
		if (*opt_value)
			free_points_at(*opt_value);
		*opt_value = NULL;
		return 0;
	}
	
>> +static struct points_at *match_points_at(struct points_at *points_at,
>> +					 const unsigned char *sha1)
>> +{
>> +	char *buf;
>> +	struct tag *tag;
>> +	unsigned long size;
>> +	enum object_type type;
>> +
>> +	buf = read_sha1_file(sha1, &type, &size);
>> +	if (!buf)
>> +		return NULL;
>> +	if (type != OBJ_TAG
>> +	    || (tag = lookup_tag(sha1), !tag)
>> +	    || parse_tag_buffer(tag, buf, size) < 0) {
>> +		free(buf);
>> +		return NULL;
>> +	}
>> +	while (points_at && hashcmp(points_at->sha1, tag->tagged->sha1))
>> +		points_at = points_at->next;
>> +	free(buf);
>> +	return points_at;
>> +}
>
>Sorry, I threw a lot of object lookup code at you last time, so I think
>my point may have been lost in the noise. But I think this is slightly
>nicer as:
>
>  static int tag_points_at(struct sha1_array *sa,
>                           const unsigned char *sha1)
>  {
>          struct object *obj = parse_object(sha1);
>          if (!obj)
>                  return 0; /* or probably we should even just die() */
>          if (obj->type != OBJ_TAG)
>                  return 0;
>          if (sha1_array_lookup(sa, ((struct tag *)obj)->tagged->sha1) < 0)
>                  return 0;
>          return 1;
>  }
>
>I.e., using parse_object lets you avoid dealing with memory management
>yourself. And as a bonus, it will reuse the cached information if you
>happen to have already parsed that object (not likely in typical
>repositories, but a huge win in certain pathological cases, like repos
>storing shared objects and refs for a large number of forks).

Aye

>> +		{
>> +			OPTION_CALLBACK, 0, "points-at", &points_at, "object",
>> +			"print only annotated|signed tags of the object",
>> +			PARSE_OPT_LASTARG_DEFAULT,
>> +			parse_opt_points_at, (intptr_t)NULL,
>> +		},
>
>I think you can drop the LASTARG_DEFAULT here, as it is no longer
>optional, no?

You mean flags = 0 instead of PARSE_OPT_LASTARG_DEFAULT, right?

Thanks,
TomG
