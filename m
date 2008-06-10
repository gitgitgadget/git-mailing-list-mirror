From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 11:45:23 -0700
Message-ID: <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 20:47:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K68rr-0008WA-Vy
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 20:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbYFJSpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 14:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYFJSpf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 14:45:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:39196 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbYFJSpf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 14:45:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1878602fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=phoPVtQqwe5CQlEFADGa/2CPgLUFq65xSOgRqXvV6Z0=;
        b=LtAMONedqS/wG9CteIgzKANEln7hNoQgr8dzowuvYXBoMfhtr4+zHxB0Pp4fBXWHpO
         Ds+A/pj46Q9OA9ejSr6xkP5P35FmJX0kPl9NoYWLoDipqarSKNKNM8B6uKjAj3CSFKv9
         N9huxFm230XE1Jjci9KzJB0oAyKXpE5PaaXu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WMOgJSTGrXi6OUhFkUJmqgwanT/m5AqW+utAg0ke47H1qa2LI3pmF3ceaGicslip5o
         eJPRoFVxK6HKWaHLwWA40GhGL5YLzA/y/jqIoiuPOlCZDY8UmdYjGy6L4HhIW7u3pHQa
         KaC0Xn53x/duRLpfx/6x6ovorY/rucwhZhz+4=
Received: by 10.86.70.8 with SMTP id s8mr6123858fga.31.1213123523060;
        Tue, 10 Jun 2008 11:45:23 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Tue, 10 Jun 2008 11:45:23 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84534>

I hadn't thought of exploiting the fact that the SHA1 of an empty file
is fixed. Nice! I believe I can prove there are no races now.
Incidentally, this is how I first found the bug: I was trying to prove
what git did worked.

I still prefer a per-entry flag solution (I suspect it's faster, and
the proof is easier), but that's too much work.

-Ben

On Tue, Jun 10, 2008 at 10:44 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 10 Jun 2008, Ben Lynn wrote:
>>
>> Unfortunately, the solution isn't perfect. Try this:
>
> Heh.
>
> That's just because our "smudge_racily_clean_entry()" uses 0 as the magic
> smudging size.
>
> You can fix this multiple ways. One would be to pick another size that is
> simply less likely (eg ~0 instead), which leaves the theoretical race, and
> just makes it practically impossible to hit (not that I think it's very
> practical to hit already).
>
> The other approach is to know that an empty blob always has a very
> specific SHA1. Here's an trial patch.
>
>                Linus
>
> ---
>  read-cache.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 8e5fbb6..f83de8c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -138,6 +138,16 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
>        return 0;
>  }
>
> +static int is_empty_blob_sha1(const unsigned char *sha1)
> +{
> +       static const unsigned char empty_blob_sha1[20] = {
> +               0xe6,0x9d,0xe2,0x9b,0xb2,0xd1,0xd6,0x43,0x4b,0x8b,
> +               0x29,0xae,0x77,0x5a,0xd8,0xc2,0xe4,0x8c,0x53,0x91
> +       };
> +
> +       return !hashcmp(sha1, empty_blob_sha1);
> +}
> +
>  static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>  {
>        unsigned int changed = 0;
> @@ -193,6 +203,12 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>        if (ce->ce_size != (unsigned int) st->st_size)
>                changed |= DATA_CHANGED;
>
> +       /* Racily smudged entry? */
> +       if (!ce->ce_size) {
> +               if (!is_empty_blob_sha1(ce->sha1))
> +                       changed |= DATA_CHANGED;
> +       }
> +
>        return changed;
>  }
>
>
