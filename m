From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] index-pack: optionally reject packs with duplicate objects
Date: Thu, 22 Aug 2013 20:45:19 +0700
Message-ID: <CACsJy8DkUeS3s+X=gKX4ZAi82g_D_9t=bBVs8NNY2EeqM9W-rQ@mail.gmail.com>
References: <20130821204955.GA28025@sigill.intra.peff.net> <20130821205220.GB28165@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 22 15:45:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCVD0-0001gL-BQ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 15:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295Ab3HVNpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 09:45:50 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36708 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3HVNpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 09:45:49 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so3549962obb.5
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e6scW4QP96ORbePhTm932P7vkkhotYEjPIYlDro/siU=;
        b=VFI9d3M2DYFxs5cVTBvIZQRog3pLsTsDqrMFrvjwzec5v6yCfeOEIjFZTW5CkgNfXx
         zw0hfwkQaPFAJbJqYOP2Td0XOO6iInmH5OtrgPSEDWElN8lHxoE6NVmD1rY4RC7ooG3I
         GXNxB79iM9Bpz/MFN2//zjTbM+Q/F4H4PlSs7w7MFH3jlCq5cPYcA5jbAxZHsWU0qzyA
         0l/1YU+GsD0WBafuu5HqMvG2aXpC7LNbm1mVtUkX+/AN4SNS2c9yXovaCib9lAcslu9n
         ZikiFaAHeHTDzz3Lh+qUjLfGe0azZa2h8IIvMnEmf5mHUDNeTrzXeKyAzEYZ0E0+v9in
         pntw==
X-Received: by 10.182.214.98 with SMTP id nz2mr14399492obc.37.1377179149317;
 Thu, 22 Aug 2013 06:45:49 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Thu, 22 Aug 2013 06:45:19 -0700 (PDT)
In-Reply-To: <20130821205220.GB28165@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232766>

On Thu, Aug 22, 2013 at 3:52 AM, Jeff King <peff@peff.net> wrote:
> @@ -68,6 +81,16 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
>         else
>                 sorted_by_sha = list = last = NULL;
>
> +       if (opts->duplicates == WRITE_IDX_DUPLICATES_REJECT) {
> +               struct pack_idx_entry **dup;
> +
> +               dup = find_duplicate(sorted_by_sha, nr_objects,
> +                                    sizeof(*sorted_by_sha), sha1_compare);
> +               if (dup)
> +                       die("pack has duplicate entries for %s",
> +                           sha1_to_hex((*dup)->sha1));
> +       }
> +
>         if (opts->flags & WRITE_IDX_VERIFY) {
>                 assert(index_name);
>                 f = sha1fd_check(index_name);

write_idx_file() is called after index-pack processes all delta
objects. Could resolve_deltas() go cyclic with certain duplicate
object setup?
-- 
Duy
