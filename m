From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 16/38] resolve_gitlink_ref(): implement using resolve_ref_recursively()
Date: Tue, 14 Jun 2016 01:03:52 -0400
Message-ID: <CAPig+cQTDrUw63qWknZQxmuDBXkoYr6gLyp5Bu=JopeT394puw@mail.gmail.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu> <a9787723bcd990413661b8cb2e5542d618ab6321.1464983301.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 14 07:03:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCgW6-0004ri-CS
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 07:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbcFNFDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 01:03:54 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33358 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcFNFDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 01:03:53 -0400
Received: by mail-io0-f195.google.com with SMTP id 5so19321010ioy.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 22:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0tdayoUJgxaNZVH4wLfu2uJSp1/TGSpP+2ZmE2wJB3Q=;
        b=msRZg0QyyAdtFKlYsq/YOgBtfqD/ihj6HgVGBKiy3Frwsv9xxygjmn4DQKN/d0h8zV
         3v0yu0cqrUJBuPQDLPzMJMr/WfH0jCytS07b7LfAHtLpCD1TYg2zvT89Bh3WVYN5FjsA
         MqX1+UEwtktzGS8LXRCJirxr+/Deo52qzmla6tjWpNqB4e5RgQ/vDF+IZnxIdzGJ40w+
         10TXODM0QPYRcnq7PyHxVg8qLVCv6VQohTIcJ3AVP12zVQ8M/ZqWwuOrhAzF1Gz14gLw
         vdXRGr/00mRyZBkgBf2y4c9bm+2rbKCqD+COq9/Rd8j0V+pPnkIbcepr0MnA/OntDgcC
         R8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0tdayoUJgxaNZVH4wLfu2uJSp1/TGSpP+2ZmE2wJB3Q=;
        b=R+S6O0oX3/QuYQ16TNU9Vs6I1XFEvhbTJ33kMyMGWvB2d75B02zVR886Snv4NatGgk
         lNRHBU6xxZ8KhzqUm8NrzJXON/VdeZYUI6XnO2OlvuV6GTGqrd7uZYfM4y/VRcsLhvFr
         +IDK3dxpg7WHuNwzS0WEHsTSW0bRPRlFl+QL2b4GrSxY0hsUpniG9isEvkFzttEPfDhb
         M3WUCBoiLF4GcG/eAYX2cLQBisjWFb7tcOVCSf/7qj2UlXjTX38inWgaylVqZRNAe/1c
         32zH+8ZMRPearpwtsptxx3uN9yaPiSVkwP0qQ+DIuTVxKKV3hHraGg2gvFVLWpMCwII4
         YIIQ==
X-Gm-Message-State: ALyK8tJflI6yeFOkOb4BC8MyF81B2idgLT7xLjZQZSWbTtRSc5JaxGBZ3YDUVgNeUkPg2L17e0GugXmw6boceA==
X-Received: by 10.107.197.70 with SMTP id v67mr6673564iof.34.1465880632593;
 Mon, 13 Jun 2016 22:03:52 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Mon, 13 Jun 2016 22:03:52 -0700 (PDT)
In-Reply-To: <a9787723bcd990413661b8cb2e5542d618ab6321.1464983301.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: cIekv98GD8VVGtTKZg2VYKhmxhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297262>

On Fri, Jun 3, 2016 at 5:03 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> resolve_ref_recursively() can handle references in arbitrary files
> reference stores, so use it to resolve "gitlink" (i.e., submodule)
> references. Aside from removing redundant code, this allows submodule
> lookups to benefit from the much more robust code that we use for
> reading non-submodule references. And, since the code is now agnostic
> about reference backends, it will work for any future references
> backend (so move its definition to refs.c).
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> diff --git a/refs.c b/refs.c
> @@ -1299,6 +1299,30 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
> +int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
> +{
> +       int len = strlen(path);
> +       struct strbuf submodule = STRBUF_INIT;
> +       struct ref_store *refs;
> +       int flags;
> +
> +       while (len && path[len-1] == '/')
> +               len--;
> +       if (!len)
> +               return -1;
> +
> +       strbuf_add(&submodule, path, len);

It took me a moment to figure out that you're using the strbuf only
for its side-effect of giving you a NUL-terminated string needed by
get_ref_store(), and not because you need any fancy functionality of
strbuf. I wonder if xstrndup() would have made this clearer.

Not worth a re-roll.

> +       refs = get_ref_store(submodule.buf);
> +       strbuf_release(&submodule);
> +       if (!refs)
> +               return -1;
> +
> +       if (!resolve_ref_recursively(refs, refname, 0, sha1, &flags) ||
> +           is_null_sha1(sha1))
> +               return -1;
> +       return 0;
> +}
