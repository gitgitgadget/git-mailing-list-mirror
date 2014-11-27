From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/1] cat-file: fix a memory leak in cat_one_file
Date: Wed, 26 Nov 2014 16:24:17 -0800
Message-ID: <20141127002417.GT6527@google.com>
References: <CANCZXo7CKz2bOM=6ehed-VLUGtyThuBbwtd_QaBMm2KKhEo=Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 01:24:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtmsi-0001Em-MQ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 01:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbaK0AYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 19:24:21 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34765 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaK0AYU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 19:24:20 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so7758389igb.7
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 16:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=12pNS44d3SXbO/+nJDToCAw4u/bAZIN0vcdXkkiiTBI=;
        b=jsJEtrflEgd8r3GRzfZem/Y4wMNjJTL0oBxPdN1z/1Upm8EWjgL48ouQI9X4wNjmMq
         ypohdTIAtnkBSjuKpF6cUw3S4iQSCjYiHIqCxGuSsNVoVFbHKCkcz9T35wgYFoFNEE8l
         jlYIZhjNvrxThb/4HG2ybG3X7MK1iVIYfN8f9igRRnaBZ+ZHDFg9NP9g/Scf7WVaARlW
         d5kg4YY8vsFXQohmXcd6xq1oTeFDzfcpyZa6A4C0JN7JanukLaFWJjGXtEpl1y9U2bBO
         edCywBqnOss0QEskDv4mo5vqwHe/3EZgqtCCT7Ubhclj50a/HHap1BHOqB3Ty1S+PELg
         NwFw==
X-Received: by 10.50.3.67 with SMTP id a3mr25428141iga.42.1417047859880;
        Wed, 26 Nov 2014 16:24:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccf6:cc10:c864:83c1])
        by mx.google.com with ESMTPSA id j2sm3336731igj.14.2014.11.26.16.24.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 16:24:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANCZXo7CKz2bOM=6ehed-VLUGtyThuBbwtd_QaBMm2KKhEo=Bw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260327>

Hi,

Alexander Kuleshov wrote:

> [Subject: cat-file: fix a memory leak in cat_one_file]

Can you explain further?  How did you run into this?  Is it an
unbounded leak or a small one-time leak?  What is the benefit of
applying this patch?

"By code inspection" is a fine answer to the question of how the
problem was discovered.  I'm just trying to understand the impact of
the change.

Likewise, if the problem was discovered using valgrind, "in order to
have cleaner valgrind output so other problems are easier to find"
might be an okay answer to the question of what the benefit of the
patch is.  (Or it might not --- it depends on the maintainability
impact and how much noise is being suppressed.)

[...]
> +++ b/builtin/cat-file.c
> @@ -18,6 +18,7 @@ static int cat_one_file(int opt, const char
> *exp_type, const char *obj_name)
>      unsigned char sha1[20];
>      enum object_type type;
>      char *buf;
> +    int buf_must_free = 0;

The usual idiom is to initialize a pointer the current function is
responsible for to NULL so it can call free(ptr) unconditionally
before returning.

[...]
> @@ -68,9 +69,14 @@ static int cat_one_file(int opt, const char
> *exp_type, const char *obj_name)
> 
>          if (type == OBJ_BLOB)
>              return stream_blob_to_fd(1, sha1, NULL, 0);
> +
>          buf = read_sha1_file(sha1, &type, &size);

Unrelated change?

> +        buf_must_free = 1;
> +
> -        if (!buf)
> +        if (!buf) {
> +            free(buf);
>              die("Cannot read object %s", obj_name);

Is this free() needed?  The program die()s right afterward, which
would free all memory automatically as part of exiting.  Tools like
valgrind would understand that nothing is wrong since buf is still
reachable through the stack.

[...]
> @@ -110,6 +117,10 @@ static int cat_one_file(int opt, const char
> *exp_type, const char *obj_name)
>          die("git cat-file %s: bad file", obj_name);
> 
>      write_or_die(1, buf, size);
> +
> +    if (buf_must_free)
> +        free(buf);
> +
>      return 0;

Is this free() needed?  The only caller is cmd_cat_file, which exits
right away.

However, cmd_cat_file (and more importantly, cat_one_file) uses
'return' to exit instead of calling exit(), so it does create some
valgrind noise.  Is that what this is about fixing?

On the whole, I'm not too excited --- this patch seems to add
complication for no obvious benefit.

Hope that helps,
Jonathan
