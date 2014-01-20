From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] list-objects: only look at cmdline trees with edge_hint
Date: Tue, 21 Jan 2014 06:57:08 +0700
Message-ID: <CACsJy8CBuW0dXgbSLgFHye9-aCDQCaK47MFpqeCh3m3JWHJOEw@mail.gmail.com>
References: <20140120212845.GA11451@sigill.intra.peff.net> <20140120213250.GB16095@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 21 00:57:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Oiu-00085v-OL
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 00:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbaATX5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 18:57:42 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:56972 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaATX5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 18:57:40 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so6486944qcq.18
        for <git@vger.kernel.org>; Mon, 20 Jan 2014 15:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YEMKqxYCrF0ElselllkShBLsd01aMLJBB8py7iABebo=;
        b=p1t+qDSWgx6nzefVxl6KAAjST/BRi3JaHJTa415gOHViBa4OotgbkfHtobYxuwCqIl
         UdGRCMcvZJi3AQecE9r+Z5DJZD6QcwXBBBkIMoRuhF3HQwj7vFfkQPuwkWLkYLmWXncy
         sA2PThUlNbQieNmo6BxHxJYJF8U9EVlHcPtbwT0It8ltrhQFDxRw9gVbnvMaW4h0jqAh
         Tu+Vt6CW5Ae/SiCqh8z06249N/dkQcpavyE8FF9jJdmUVmHIdgVPE5KbPAy8GXA2pgP8
         O64zgKtQoPF6fzcvf8QhCIydy9R9qiYdheWGYFRUCbXcOqUwkjDXUFmgXStjpJgKlXBx
         OF0w==
X-Received: by 10.224.98.147 with SMTP id q19mr9611765qan.8.1390262259906;
 Mon, 20 Jan 2014 15:57:39 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Mon, 20 Jan 2014 15:57:08 -0800 (PST)
In-Reply-To: <20140120213250.GB16095@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240737>

On Tue, Jan 21, 2014 at 4:32 AM, Jeff King <peff@peff.net> wrote:
> This patch therefore ties the extra tree examination to the
> revs->edge_hint flag; it is the presence of that flag that
> makes the tradeoff worthwhile.
>
> Here is output from the p0001-rev-list showing the
> improvement in performance:
>
> Test                                             HEAD^             HEAD
> -----------------------------------------------------------------------------------------
> 0001.1: rev-list --all                           0.69(0.65+0.02)   0.69(0.66+0.02) +0.0%
> 0001.2: rev-list --all --objects                 3.22(3.19+0.03)   3.23(3.20+0.03) +0.3%
> 0001.4: rev-list $commit --not --all             0.04(0.04+0.00)   0.04(0.04+0.00) +0.0%
> 0001.5: rev-list --objects $commit --not --all   0.27(0.26+0.01)   0.04(0.04+0.00) -85.2%

You must have so much fun (or headache, depending on your view) with
the variety of repos on github :)

> diff --git a/list-objects.c b/list-objects.c
> index 6cbedf0..43ce1d9 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -162,15 +162,17 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
>                 }
>                 mark_edge_parents_uninteresting(commit, revs, show_edge);
>         }
> -       for (i = 0; i < revs->cmdline.nr; i++) {
> -               struct object *obj = revs->cmdline.rev[i].item;
> -               struct commit *commit = (struct commit *)obj;
> -               if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
> -                       continue;
> -               mark_tree_uninteresting(commit->tree);
> -               if (revs->edge_hint && !(obj->flags & SHOWN)) {
> -                       obj->flags |= SHOWN;
> -                       show_edge(commit);
> +       if (revs->edge_hint) {
> +               for (i = 0; i < revs->cmdline.nr; i++) {
> +                       struct object *obj = revs->cmdline.rev[i].item;
> +                       struct commit *commit = (struct commit *)obj;
> +                       if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
> +                               continue;
> +                       mark_tree_uninteresting(commit->tree);
> +                       if (revs->edge_hint && !(obj->flags & SHOWN)) {

Not really important, but perhaps remove revs->edge_hint here because
it's already checked?

> +                               obj->flags |= SHOWN;
> +                               show_edge(commit);
> +                       }
>                 }
>         }
>  }
-- 
Duy
