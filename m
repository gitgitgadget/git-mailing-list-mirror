From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv3] tag: add --points-at list option
Date: Wed, 8 Feb 2012 10:43:32 -0800
Message-ID: <20120208184332.GF6264@tgrennan-laptop>
References: <20120208002554.GA6035@sigill.intra.peff.net>
 <1328682076-23380-2-git-send-email-tmgrennan@gmail.com>
 <20120208154442.GB8773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 08 19:44:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvCUw-00060s-MK
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 19:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011Ab2BHSnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 13:43:40 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45598 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab2BHSnj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 13:43:39 -0500
Received: by ggnh1 with SMTP id h1so427626ggn.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 10:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Tx2U5rlRsWPw4c+8K9kiZpd6qeFKEO7s2ZN10cEHZeA=;
        b=MyGQvQXCrq8Uu3RldtGZSdC2KijQEsERAwJa6tvNL5GPDHs+GPGq9rHNoqJDu04mfZ
         IrJY5Lab7BquFe3+kLBdZrl1fOuxwGh7Gvs088B8jWI3CdX3BqDbab0npXzkhu0JHP0W
         xnr8MuXZjdaoazC1uosdcH3YBw366fSE0INtA=
Received: by 10.182.147.4 with SMTP id tg4mr26818243obb.65.1328726618690;
        Wed, 08 Feb 2012 10:43:38 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id g3sm467828obk.6.2012.02.08.10.43.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Feb 2012 10:43:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120208154442.GB8773@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190245>

On Wed, Feb 08, 2012 at 10:44:42AM -0500, Jeff King wrote:
>On Tue, Feb 07, 2012 at 10:21:16PM -0800, Tom Grennan wrote:
>
>> +static const unsigned char *match_points_at(const unsigned char *sha1)
>> +{
>> +	int i;
>> +	const unsigned char *tagged_sha1 = (unsigned char*)"";
>> +	struct object *obj = parse_object(sha1);
>> +
>> +	if (obj && obj->type == OBJ_TAG)
>> +		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;
>
>This is not safe. A sha1 is not NUL-terminated, but is rather _always_
>20 bytes. So when the object is not a tag, you do the hashcmp against
>your single-byte string literal above, and we end up comparing whatever
>garbage is in the data segment after the string literal.

Yikes! That was dumb.

>What you want instead is the all-zeros sha1, like:
>
>  const unsigned char null_sha1[20] = { 0 };
>
>Though we provide a null_sha1 global already. So doing:
>
>  const unsigned char *tagged_sha1 = null_sha1;
>
>would be sufficient.

Or just initialize at test tagged_sha1 with NULL.

static const unsigned char *match_points_at(const unsigned char *sha1)
{
	int i;
	const unsigned char *tagged_sha1 = NULL;
	struct object *obj = parse_object(sha1);

	if (obj && obj->type == OBJ_TAG)
		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;
	for (i = 0; i < points_at.nr; i++)
		if (!hashcmp(points_at.sha1[i], sha1))
			return sha1;
		else if (tagged_sha1 &&
			 !hashcmp(points_at.sha1[i], tagged_sha1))
			return tagged_sha1;
	return NULL;
}

>That being said, I don't know why you want to do both lookups in the
>same loop of the points_at. If it's a lightweight tag and the tag
>matches, you can get away with not parsing the object at all (although
>to be fair, that is the minority case, so it is unlikely to matter).

Yes, I think your saying that the lightweight search could go before the
tag object search like this.

static const unsigned char *match_points_at(const unsigned char *sha1)
{
	const unsigned char *tagged_sha1 = NULL;
	struct object *obj = parse_object(sha1);

	if (sha1_array_lookup(&points_at, sha1) >= 0)
		return sha1;
	if (obj && obj->type == OBJ_TAG)
		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;
	if (tagged_sha1 && sha1_array_lookup(&points_at, tagged_sha1) >= 0)
		return tagged_sha1;
	return NULL;
}

>Also, should we be producing an error if !obj? It would indicate a tag
>that points to a bogus object.

I think the test of (obj) is redundant as this should be caught
by get_sha1() in parse_opt_points_at()

int parse_opt_points_at(const struct option *opt __attribute__ ((unused)),
			const char *arg, int unset)
{
	unsigned char sha1[20];

	if (unset) {
		sha1_array_clear(&points_at);
		return 0;
	}
	if (!arg)
		return error(_("switch 'points-at' requires an object"));
	if (get_sha1(arg, sha1))
		return error(_("malformed object name '%s'"), arg);
	sha1_array_append(&points_at, sha1);
	return 0;
}

>> +	for (i = 0; i < points_at.nr; i++)
>> +		if (!hashcmp(points_at.sha1[i], sha1))
>> +			return sha1;
>> +		else if (!hashcmp(points_at.sha1[i], tagged_sha1))
>> +			return tagged_sha1;
>> +	return NULL;
>
>Why write your own linear search? sha1_array_lookup will do a binary
>search for you.

Well, it's only a linear search of the points_at command arguments.
But by that reasoning, might as well do two sha1_array_lookups like
above and save some code b/c "less code is always better"(TM).

>Other than that, the patch looks OK to me.

Thanks, I'll send what I hope to be the final version later today.

-- 
TomG
