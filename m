From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [RFC/PATCH] tag: add --points-at list option
Date: Sun, 5 Feb 2012 22:32:13 -0800
Message-ID: <20120206063213.GC10489@tgrennan-laptop>
References: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
 <20120206000420.GC28735@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, krh@redhat.com,
	jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 07:32:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuI7i-0001Tl-4U
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 07:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab2BFGcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 01:32:18 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64459 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab2BFGcR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 01:32:17 -0500
Received: by vbjk17 with SMTP id k17so3665668vbj.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 22:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OV6pcLUtXc+PB6kENbutybK4E/qWKhtLe3UEG+d3sIM=;
        b=RLt/v9F1ohsOsM2JmGJNKkwOjG+EjeGQWq92Pt6GHmhy65MOhoy9jga1MO2IqNt8gG
         zma3A+T8lUUtWhbgboitsPSQuq1mjJgQ5XXYU5HF8Z5n0GyBVmrbYPGsRsu9WRD+FVgf
         rw79wBYZmGLZnaiASbj5Mpl0QEreZ6J1AIsD0=
Received: by 10.52.173.52 with SMTP id bh20mr7563949vdc.9.1328509937149;
        Sun, 05 Feb 2012 22:32:17 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id bj13sm9728075vdc.15.2012.02.05.22.32.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 22:32:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120206000420.GC28735@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190030>

On Sun, Feb 05, 2012 at 07:04:21PM -0500, Jeff King wrote:
>On Sun, Feb 05, 2012 at 02:28:07PM -0800, Tom Grennan wrote:
>
>> This filters the list for annotated|signed tags of the given object.
>> Example,
>> 
>>    john$ git tag -s v1.0-john v1.0
>>    john$ git tag -l --points-at v1.0
>>    v1.0-john
>
>I really like this approach. One big question, and a few small comments:
>
>> +--points-at <object>::
>> +	Only list annotated or signed tags of the given object.
>> +
>
>It is unclear to me from this documentation if we will only peel a
>single level, or if we will peel indefinitely. E.g., what will this
>show:
>
>  $ git tag one v1.0
>  $ git tag two one
>  $ git tag --points-at=v1.0
>
>It will clearly show "one", but will it also show "two" (from reading
>the code, I think the answer is "no")? If not, should it?

Actually, neither one nor two would be listed as these are lightweight
tags.  In the modified example,

  $ git tag -a -m One one v1.0
  $ git tag -a -m Two two one
  $ git tag --points-at v1.0
  one
  $ git tag --points-at one
  two

one's object is v1.0 whereas two's object is one

>> +		buf = read_sha1_file(sha1, &type, &size);
>> +		if (!buf || !size)
>> +			return 0;
>
>Before your patch, a tag whose sha1 could not be read would get its name
>printed, and then we would later return without printing anything more.
>Now it won't get even the first bit printed.
>
>However, I'm not sure the old behavior wasn't buggy; it would print part
>of the line, but never actually print the newline.

If you prefer, I can restore the old behavior just moving the
condition/return back below the refname print; then add "buf" qualifier
to the following fragment and at each intermediate free.

>> +		if (filter->points_at) {
>> +			unsigned char tagged_sha1[20];
>> +			if (memcmp("object ", buf, 7) \
>> +			    || buf[47] != '\n' \
>> +			    || get_sha1_hex(buf + 7, tagged_sha1) \
>> +			    || memcmp(filter->points_at, tagged_sha1, 20)) {
>> +				free(buf);
>> +				return 0;
>> +			}
>> +		}
>
>Hmm, I would have expected to use parse_tag_buffer instead of doing it
>by hand. This is probably a tiny bit more efficient, but I wonder if the
>code complexity is worth it.

I didn't see how to get the object sha out of parse_tag_buffer() to
compare with "point_at". The inline conditions seem simple enough.

>
>>  static int list_tags(const char **patterns, int lines,
>> -			struct commit_list *with_commit)
>> +			struct commit_list *with_commit,
>> +			unsigned char *points_at)
>
>Like Junio, I was surprised this did not allow a list.

I agree and will change it.

Thanks,
TomG
