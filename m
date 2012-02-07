From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 7 Feb 2012 10:05:22 -0800
Message-ID: <20120207180522.GA6264@tgrennan-laptop>
References: <1328598076-7773-1-git-send-email-tmgrennan@gmail.com>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
 <7vd39r2g8o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 19:05:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RupQ5-0002h1-33
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 19:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755288Ab2BGSF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 13:05:29 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49970 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab2BGSF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 13:05:28 -0500
Received: by ggnh1 with SMTP id h1so3599960ggn.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 10:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qi+Nx1HxLaVpt0FLpGFpt8cHIFp6fEF9lCNIdwpDBmE=;
        b=H57RHgjdVvwRcFenmtVngisYAtJBZrYB+CB9FUDCUl4s4JxgcQ0BHbNGhbxqqi4RCB
         gXAxtmxSwTg89BZIcLfrvQq2KiAWuS63XGW0Ua0vARX8+UaJ6SSAXvPfOQzuoQqqEjnF
         nWNyeF/J51Vb0wkdsTQawSfRiTpirDlWQTiUc=
Received: by 10.182.11.6 with SMTP id m6mr22024607obb.74.1328637927502;
        Tue, 07 Feb 2012 10:05:27 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id s2sm13934410obx.1.2012.02.07.10.05.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 10:05:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd39r2g8o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190191>

On Tue, Feb 07, 2012 at 12:35:19AM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> +struct points_at {
>> +	struct points_at *next;
>> +	unsigned char *sha1;
>> +};
>
>struct points_at {
>	struct points_at *next;
>        unsigned char sha1[20];
>};
>
>would save you from having to allocate and free always in pairs, no?

Yep

>> +static void free_points_at (struct points_at *points_at)
>
>Please lose the SP before (.

Oops

>> +	if (type != OBJ_TAG
>> +	    || (tag = lookup_tag(sha1), !tag)
>> +	    || parse_tag_buffer(tag, buf, size) < 0) {
>
>Even though I personally prefer to cascade a long expression like this, so
>that you see a parse tree when you tilt your head 90-degrees to the left,
>I think the prevalent style in Git codebase is
>
>	if (A-long-long-expression ||
>            B-long-long-expression ||
>            C-long-long-expression) {
>
>Also we try to avoid assignment in the conditional.

I like to compact multiple conditions to a common exit but also appreciate
the fear and loathing of comma's.

While rearranging this I finally understand how to include lightweight tags.

	struct points_at *pa;
	const unsigned char *tagged_sha1 = (const unsigned char *)"";

	/* First look for lightweight tags - those with matching sha's
	 * but different names */
	for (pa = points_at; pa; pa = pa->next)
		if (!hashcmp(pa->sha1, sha1) && strcmp(pa->refname, refname))
			return pa;
	buf = read_sha1_file(sha1, &type, &size);
	if (buf) {
		if (type == OBJ_TAG) {
			tag = lookup_tag(sha1);
			if (parse_tag_buffer(tag, buf, size) >= 0)
				tagged_sha1 = tag->tagged->sha1;
		}
		free(buf);
	}
	while (points_at && hashcmp(points_at->sha1, tagged_sha1))
		points_at = points_at->next;
	return points_at;

For example,
$ ./git-tag tomg-lw-v1.7.9 v1.7.9
$ ./git-tag -a tomg-lw-v1.7.9 v1.7.9
$ ./git-tag -s tomg-lw-v1.7.9 v1.7.9
$ ./git-tag -s tomg-README HEAD:README
$ ./git-tag -l --points-at v1.7.9 --points-at HEAD:README
tomg-README
tomg-annotate-v1.7.9
tomg-lw-v1.7.9
tomg-signed-v1.7.9
$ ./git-tag -l --points-at v1.7.9 --points-at HEAD:README \*v1.7.9
tomg-annotate-v1.7.9
tomg-lw-v1.7.9
tomg-signed-v1.7.9

>> @@ -432,6 +500,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>  			PARSE_OPT_LASTARG_DEFAULT,
>>  			parse_opt_with_commit, (intptr_t)"HEAD",
>>  		},
>> +		{
>> +			OPTION_CALLBACK, 0, "points-at", &points_at, "object",
>> +			"print only annotated|signed tags of the object",
>> +			PARSE_OPT_LASTARG_DEFAULT,
>> +			parse_opt_points_at, (intptr_t)NULL,
>> +		},
>
>If you are going to reject NULL anyway, do you still need to mark this as
>lastarg-default?
>
>Looking for example in parse-options.h, I found this:
>
>        #define OPT_STRING_LIST(s, l, v, a, h) \
>                    { OPTION_CALLBACK, (s), (l), (v), (a), \
>                      (h), 0, &parse_opt_string_list }
>
>which is used by "git clone" to mark its -c option.
>
>Running "git clone -c" gives me
>
>	error: switch 'c' requires a value
>
>without any extra code in the caller of parse_options().

Cool

>Other than that, looks cleanly done.
>
>Thanks. I'll take another look after I wake up in the morning.

Thanks, I'll send v3 later today.

-- 
TomG
