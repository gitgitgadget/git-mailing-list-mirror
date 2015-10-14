From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 02/26] mailinfo: fix for off-by-one error in boundary stack
Date: Wed, 14 Oct 2015 13:12:58 -0700
Message-ID: <CAGZ79kYGB8QOio7dqKNPjsQg6xeCSEkvC_8_a3=h9sHxbn-6uw@mail.gmail.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
	<1444778207-859-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:13:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSQ7-00024q-H2
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbbJNUNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:13:00 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33143 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbbJNUM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:12:59 -0400
Received: by ykoo7 with SMTP id o7so58584381yko.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/AOwI1jvb6fPxcGzqaLDEWUKUtgkNWvSZNycfqCp9sk=;
        b=kT4GKEof0PXviKM3IzdvpeeFQyiZIn9mWztoBGwU3F2fS3lrsn1cWFTwy016cPkTe7
         JzX8Z1X8s7A43KEf15+ucKIKUY33BtT3zmL/CosT88o9QfC5oSzMiFELOcM7VmRjjNHM
         czWbgaWrdJmvGZIDBhZXfV9ikpWlEOzvt+RXUB+6+Y7MvS498IXLnf+DODHCrwyv4oP/
         svUGSo0TdvocCUMFNmVaPSdOmqYkJCX6OU8Ds6GFe82urD4GQ22V7THmq9NXqj89E+3d
         gZm3C7LM2V/xFRCmNp79rIa46NS7PkOXu+EVHgV6R11hG2loKx0eEXWHTbDpOacQNeFG
         Zx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/AOwI1jvb6fPxcGzqaLDEWUKUtgkNWvSZNycfqCp9sk=;
        b=gfslXjWc1jBEI39c6FpUITw4Jz8eeAEKle4p9PvrRxuz2XF/S8LccoAdgYTNkpDs7p
         Kc+74MMXR1JDkK9iW8ijzRWambvthNbBCLtAzDXclNIyPwuzP6lwFL5RbfosewwLa4ss
         8Saq8A2aWh1WUKxE2npSNoyaxktVay3tOeLaqPQGN5UNP54xsCXxH2tZr4Efiyt6lsMh
         VS2S5dASGg3+N0zWSy6+8e4B7zpS2wq26Z/BcaliWQVp0/GVz6Z5YBAC4CBvlKkz8nk0
         x3D8lHZY0qrUSuNgGOzTzPZ+QdnljwD6eC1U6Jx5kU8xewmZM+ZhAbircNXcYNF9XzU6
         UwiA==
X-Gm-Message-State: ALoCoQlmb34h28VBzmP3vbIZFEjnuOMk/HTKzb7/TXhVVVD1zPAJyqpHuDhT/K9PSKiSdKu8YY/m
X-Received: by 10.129.80.214 with SMTP id e205mr3702877ywb.199.1444853578738;
 Wed, 14 Oct 2015 13:12:58 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 14 Oct 2015 13:12:58 -0700 (PDT)
In-Reply-To: <1444778207-859-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279589>

On Tue, Oct 13, 2015 at 4:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> We pre-increment the pointer that we will use to store something at,
> so the pointer is already beyond the end of the array if it points
> at content[MAX_BOUNDARIES].
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  As always, I am very bad at checking and fixing off-by-one errors.
>  A few extra sets of eyeballs are very much appreciated.

some relevant lines from the file:
    #define MAX_BOUNDARIES 5
    static struct strbuf *content[MAX_BOUNDARIES];
    static struct strbuf **content_top = content;

content has slots 0..4, so checking content[5] is out of range,
but was allowed in the original code.

So this patch looks good to me, though looking at
289796dd29dd656734cfd59b657deb943a71cf6a,
makes me wonder if we forget the other spot where it's
decremented in that patch.

Also looking at the patch, makes we wonder if we rather want to change
-    static struct strbuf *content[MAX_BOUNDARIES];
+    static struct strbuf *content[MAX_BOUNDARIES + 1];

instead? That would actually increase the allocated memory,
and allow to write one more content line, but reading the code is
easier as we don't need to reason about > or >=.

Another way would be to rewrite this part to use an index instead
of content_top being a pointer. And the index could be compared
to strictly less than MAX_BOUNDARIES.

> ---
>  builtin/mailinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 330bef4..2742d0d 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -185,7 +185,7 @@ static void handle_content_type(struct strbuf *line)
>
>         if (slurp_attr(line->buf, "boundary=", boundary)) {
>                 strbuf_insert(boundary, 0, "--", 2);
> -               if (++content_top > &content[MAX_BOUNDARIES]) {
> +               if (++content_top >= &content[MAX_BOUNDARIES]) {
>                         fprintf(stderr, "Too many boundaries to handle\n");
>                         exit(1);
>                 }
> --
> 2.6.1-320-g86a1181
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
