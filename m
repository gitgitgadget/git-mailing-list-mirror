From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Sun, 29 Jun 2014 10:33:45 +0700
Message-ID: <CACsJy8D8687QULRBZF_hvwASxOy5ekuPJ997xLSDX6HXDXgZnA@mail.gmail.com>
References: <1403914856-3546-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 05:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X15sr-0004LY-AA
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 05:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbaF2DeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 23:34:16 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:64763 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbaF2DeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 23:34:16 -0400
Received: by mail-qc0-f176.google.com with SMTP id w7so5956887qcr.35
        for <git@vger.kernel.org>; Sat, 28 Jun 2014 20:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b2mVrCBoohkyNBThvkB2zWI3g5MnCMqpsTIv1e5zF/o=;
        b=HpPTHV1NSau2H6VyDM5KrYxNTs/sZMyG+ihEYTEhJ0KuNEuVlsgcMMtfOlOpL30lvp
         GrEf7+jXyX7l4fV+T4t++4CD7mIq32o7Mh9AEsqcxaquMiDb5BgdepwGfXbC4m/ZRdXC
         cXMi578uAFkVBxei0IPqBDS6yDr160sGPThU7G6CWJCX+2BfOKmw8+UkYwDxuae1zyi1
         o21qv7FpyienEowDZDHYfMIl1zTDxqLV+gFfO7349ADDXTOcWJTrfkR07Al9Vlp/pCWS
         VoHxfewSjwvwCFho1ckPV4J+67dnR2XrKiRVj9daER1QHfpKGIzIg9HK7WLSTmYPTQS4
         Ijow==
X-Received: by 10.224.137.9 with SMTP id u9mr38503982qat.24.1404012855302;
 Sat, 28 Jun 2014 20:34:15 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 28 Jun 2014 20:33:45 -0700 (PDT)
In-Reply-To: <1403914856-3546-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252627>

On Sat, Jun 28, 2014 at 7:20 AM, David Turner <dturner@twopensource.com> wrote:
> When git checkout checks out a branch, create or update the
> cache-tree so that subsequent operations are faster.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  builtin/checkout.c    |  4 ++++
>  cache-tree.c          | 22 ++++++++++++----------
>  cache-tree.h          |  1 +
>  t/t0090-cache-tree.sh | 15 ++++++++++++++-
>  4 files changed, 31 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 07cf555..df791e8 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -553,6 +553,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
>                 }
>         }
>
> +       if (write_cache_as_tree(NULL, WRITE_TREE_DO_NOT_WRITE, "")) {
> +               warn("Unable to write cache_tree");
> +       }
> +

I wonder if we should do this in !opts->force code path only. In the
opts->force code path we could use prime_cache_tree() (like
read-tree), which is supposedly faster (but may need some tests to be
sure). prime_cache_tree() could be made a bit faster by doing it
during tree traversal in unpack_trees() so we don't have to unpack any
tree objects twice.
-- 
Duy
