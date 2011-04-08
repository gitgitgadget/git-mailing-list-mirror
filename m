From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Proposed design of fast-export helper
Date: Fri, 8 Apr 2011 01:47:41 -0500
Message-ID: <20110408064741.GA22462@elie>
References: <20110401061434.GA4469@kytes>
 <20110407230249.GA20226@elie>
 <20110408053326.GA27332@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 08:47:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q85U3-0000G6-6P
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 08:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab1DHGrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 02:47:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51408 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab1DHGrt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 02:47:49 -0400
Received: by iyb14 with SMTP id 14so3188466iyb.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 23:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DxVOOJYNAP8qpRef+pZ3zDPj79kpBLOsdKj5/ghFWPM=;
        b=rDYuh1kChvCPCYjzau72/KaYNF79GQAX9h3lL+mFfl46epApPjKO0Y1Bo89PvKdc42
         yvg1u0CY9Ccu7fHgm9lYJX5hBflvqBzS7gUZtSFQaBlj57CnRkwmXL3BY2mIxbSTgO1r
         6rfBIVSSW778zxQnjyghUnuoPfYtfxoP44bgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bB4tD28udIZk4ER6VOJJDYGYZFJhJlS+vbinzeN+o6aUGbWlXqPwgoX9crIQdHdj7D
         2CiQqFV5tgk5pAdAchRWnX/OTepa/HBVFYguCyreUigSl8/aVRYN4mfHVEjbPk65rSh5
         aqbKkQqTHxq6mSl42uVWoKo+ZSqnX2Wyspbhw=
Received: by 10.231.16.134 with SMTP id o6mr1841562iba.108.1302245268593;
        Thu, 07 Apr 2011 23:47:48 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.ameritech.net [69.209.53.77])
        by mx.google.com with ESMTPS id 19sm1668303ibx.35.2011.04.07.23.47.46
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 23:47:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110408053326.GA27332@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171107>

Hi again,

Ramkumar Ramachandra wrote:

> Next step: We should find out all the things <dataref> can currently
> be, by looking at existing frontend implementation.

There are only a few places a <dataref> can come from.

 * marks (":5"-style datarefs and from the marks file)
 * output from the "ls" or "cat" command
 * out-of-band knowledge by the frontend about this specific backend
   (e.g., "I know git fast-import supports git-style blob names, so I
   will use them").

> Then, we should
> come tighten the spec so that it doesn't clobber any of those things.
> Also, we should find a way to let the backend know "how" to index/
> retrieve a blob -- this is only straightforward in the case of marks.

If this key/value store is specifically for use with fast-import
backends, I'd prefer it just deal with marks.  Caching responses to
lookup of blobs using a backend-specific <dataref> format is a
different problem.

>> I assume the delimited format works as in fast-import's "data" command
>> (and only supports blobs ending with LF)?
>
> Yes.  This is actually quite an ugly to support -- We should probably
> drop support for this.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 2c2ea12..1fb71f7 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -826,8 +826,8 @@ of the next line, even if `<raw>` did not end with an `LF`.
>  Delimited format::
>  	A delimiter string is used to mark the end of the data.
>  	fast-import will compute the length by searching for the delimiter.
> -	This format is primarily useful for testing and is not
> -	recommended for real data.
> +	This format is should only be used for testing; other
> +	backends are not required to support this.

That would mean git's fast-import test suite couldn't be used with
arbitrary fast-import backends.  The delimited format is also very
convenient for testing "by hand".  I'm not convinced it's that hard to
support.

> Performance and portability considerations.  Calling semantics will
> probably be highly inelegant too, since full-blown bi-directional
> communication is necessary.

Takes command on stdin, writes response to stdout.  Seems kind of
typical for helper programs, but you are right to mention that shell
scripts do not deal so well with that when the helper process needs
to handle multiple requests.

e.g., see /usr/share/debconf/confmodule.

> Jonathan Nieder writes:

>> 	FILE *f = kvstore_fopen(key, O_WRONLY);
>> 	fwrite(value, sz, 1, f);
>> 	kvstore_fclose(f);
>> 
>> 	FILE *f = kvstore_fopen(key, O_RDONLY);
>> 	strbuf_fread(&value, SIZE_MAX, f);
>> 	kvstore_fclose(f);
>
> I don't like this.  The caller should not have to know about whether
> blobs are persisted in-memory or on-disk.  When there are a few small
> frequently-used blobs, the key-value might decide to persist them in
> memory, and we should allow for this kind of optimization.

A FILE * can have a pipe underlying it, or a memory area (with
fmemopen).  But I agree that using FILE * here would be a bad API
after all, for other reasons (the FILE * operations are just not quite
right).

>> Is there prior art that this could mimic or reuse (so we can learn
>> from others' mistakes and make sure the API feels familiar)?
>
> Kyoto Cabinet

Yikes, its API is complicated. :)  Does Kyoto Cabinet support values
longer than a size_t can describe?  Maybe that's not worth supporting
after all (I guess it would be nice to have an example of a 4 GiB file
in version control to motivate it first).

> Obviously, this will be less efficient than a store which keys
> everything using a fixed 20-byte SHA1

Sure, sticking to fixed-length, 20-byte keys could be reasonable if
that's what the application requires.  Is this for caching or for
avoiding an internal marks table?
