From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 4/4] t1006: add tests for git cat-file --literally
Date: Fri, 17 Apr 2015 20:00:10 -0400
Message-ID: <CAPig+cRoY5OEvoZ4oysdiDTpMh+mYgL3dYAOYOhnRgH_=a1fzQ@mail.gmail.com>
References: <552E9816.6040502@gmail.com>
	<1429117232-5102-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 02:00:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjGBJ-00060n-3B
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 02:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbbDRAAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 20:00:12 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34699 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbbDRAAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 20:00:11 -0400
Received: by iedfl3 with SMTP id fl3so94386396ied.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 17:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/MFZZoo4B3HwSLhwXrp6pmEkZWpitZLwyGqUApPzi3M=;
        b=JpqzFIWhx6Ct9MFIOtVfoZY5KvSGJ06QGxK5KChbX3n0wbGlrRVzzkLCxC9XA7bnCH
         3N7mNtP0NPkDM8c1WoRyqpLClyXVqV5mPoqvm4JOUkXsyGHmFX0452GrJevc670a1uTJ
         m0S/SL7K9EG7MncF4vUIZ1+4YdjtXvBbzSYU/Zb7EswxaXP2mIvJd4zOz3lSpERxl7yz
         gVZm1WZLyJl1jo77TP1kGTwwik2Cr4cloPigBLLr540QTwM1i2MsXFodbTlnkxtUou+c
         ljjE6VbXXYusaKsg0rnfFBpAcx+pWijLwaTahmeWfTLdhL9vIaEsk5KU/S7GJlbcUng+
         9o/w==
X-Received: by 10.107.3.199 with SMTP id e68mr6846450ioi.92.1429315210068;
 Fri, 17 Apr 2015 17:00:10 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 17 Apr 2015 17:00:10 -0700 (PDT)
In-Reply-To: <1429117232-5102-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: eeFCPDSfhdDn3NdxDK1SxEvn-BM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267403>

On Wed, Apr 15, 2015 at 1:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index ab36b1e..61fab78 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -296,4 +308,21 @@ test_expect_success '%(deltabase) reports packed delta bases' '
>         }
>  '
>
> +bogus_type="bogus"
> +bogus_content="bogus"
> +bogus_size=$(strlen $bogus_content)

If someone ever changes the value of 'bogus_content' so it contains
whitespace, then the result of strlen() will be incorrect as you've
invoked it. You should quote its argument (as other callers in this
script do) to safeguard against such an issue.

    bogus_size=$(strlen "$bogus_content")

> +bogus_sha1=$(printf $bogus_content | git hash-object -t $bogus_type --literally -w --stdin)

Ditto regarding quoting of 'bogus_content'.

Also, if someone ever modifies 'bogus_content' so that it contains a
literal '%' (such as "%s"), then your printf() invocation will
misbehave. Either call it like this:

    $(printf '%s' "$bogus_content" | ...)

or, better yet, call echo_without_newline() as other similar code
elsewhere in this script does, and as suggested earlier[1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/266972/

> +test_expect_success "Type of broken object is correct" '
> +       echo $bogus_type >expect &&
> +       git cat-file -t --literally $bogus_sha1 >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success "Size of broken object is correct" '
> +    echo $bogus_size >expect &&

Bad indentation. Use tab rather than spaces.

> +       git cat-file -s --literally $bogus_sha1 >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.0.rc1.249.gb598846
