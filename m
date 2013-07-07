From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 17/22] read-cache: read cache-tree in index-v5
Date: Sun, 7 Jul 2013 16:41:44 -0400
Message-ID: <CAPig+cTREFye20By1XDCgsXp1-RjonOOzfksoNY=LUUq4i1arQ@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
	<1373184720-29767-18-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 22:42:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvvmU-0008CR-Om
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 22:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab3GGUlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 16:41:47 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:39418 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab3GGUlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 16:41:46 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so3221377lab.38
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=6eVNgI0HCl7e14G5DfdGg6Y1NkMapLps7fWWVrbiqm8=;
        b=OqaA7vqeXmOW5n2RqQoCq6/NoAmOscCWOBr85hs47gWQbtHeLAYCePbYjU49leHKu2
         ZnzYBYdskpnHA50KqSg/hHzt0QFbavj/KpFztYf/vzwIRXK8OX+UKUXYkfIw5YQgwgjb
         5cLkgExHjsiDTt2cndgLhJg7QDNnOGQolEIWKT/WcoQqVWXHDJ8m41aNoSbA3h4EWyOM
         PPvCmq7BP59X555Knb/yNewZ0WI6h/WgVCRJDrMkRJ809Z9rbxL3Mg6Fy7Kw9Y1ujtun
         6kRcqSjxu+IspCWIT/4gEOrDQM6CKQJqLDGhFjk3AGyhhlgKHO9rC1zkPAZZUfvbKsa8
         RO+w==
X-Received: by 10.152.4.65 with SMTP id i1mr9104266lai.21.1373229704368; Sun,
 07 Jul 2013 13:41:44 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Sun, 7 Jul 2013 13:41:44 -0700 (PDT)
In-Reply-To: <1373184720-29767-18-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: uXNPWw7MRvwrWud6bLj8ZOkLv_g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229804>

On Sun, Jul 7, 2013 at 4:11 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Since the cache-tree data is saved as part of the directory data,
> we already read it at the beginning of the index. The cache-tree
> is only converted from this directory data.
>
> The cache-tree data is arranged in a tree, with the children sorted by
> pathlen at each node, while the ondisk format is sorted lexically.
> So we have to rebuild this format from the on-disk directory list.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/read-cache-v5.c b/read-cache-v5.c
> index 193970a..f1ad132 100644
> --- a/read-cache-v5.c
> +++ b/read-cache-v5.c
> @@ -448,6 +448,103 @@ static int read_conflicts(struct conflict_entry **head,
>         return 0;
>  }
>
> +/*
> + * This function modifys the directory argument that is given to it.

s/modifys/modifies/

> + * Don't use it if the directory entries are still needed after.
> + */
> +static struct cache_tree *cache_tree_convert_v5(struct directory_entry *de)
> +{
> +       struct directory_queue *queue;
> +
> +       if (!de->de_nentries)
> +               return NULL;
> +       queue = xcalloc(1, sizeof(struct directory_queue));
> +       queue[0].de = de;
> +       queue[0].down = xcalloc(de->de_nsubtrees, sizeof(struct directory_queue));
> +
> +       sort_directories(de, queue[0].down);
> +       return convert_one(queue, 0);
> +}
> +
>  static void resolve_undo_convert_v5(struct index_state *istate,
>                                     struct conflict_entry *conflict)
>  {
