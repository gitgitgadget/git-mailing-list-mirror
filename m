From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 10/19] pack-bitmap: add support for bitmap indexes
Date: Sat, 26 Oct 2013 17:14:16 +0700
Message-ID: <CACsJy8Cv5WMB=L+fQCj-ZURZC3ZdEqXaqqW_O2ZD-HNcC_V3yg@mail.gmail.com>
References: <20131025055521.GD11810@sigill.intra.peff.net> <20131025060345.GH23098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 26 12:14:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va0tP-0005GB-PY
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 12:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab3JZKOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 06:14:47 -0400
Received: from mail-qe0-f44.google.com ([209.85.128.44]:60288 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab3JZKOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 06:14:46 -0400
Received: by mail-qe0-f44.google.com with SMTP id 6so3003220qeb.17
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WUdvcVbfHShAHF/hI6VbzvJLyNHL0hUsD7zHI9WdDJY=;
        b=aGFCKrlsNl2fHspiFie7Kyqu6LpTi9RxQkUc3FaZKZaFuZPDk01Vl197oH+/v4WZox
         oatIIDEQUur/afrpq/R5dnodw3KRO8A04/q25DiAs5KeQWsg6WLhoXQqcDLSzLI7cXlP
         MTnzik2QOa6eeRJw8+XJARXybXk4s/S42JNx3Yn3tNVULBmrgow317ZC1Kno8Z2740JI
         c5xz2JVgE4kD2wOzi0GpVRINsA3s6FqWFpRx0x/g033XIM01sbB21uODhM4VctqtBrJs
         i1QKFjHLeHayPxklIk3UG4ilsG/lf77693q3ceCWj/oZS5k/dC+/d7n1VHwAimYJtxov
         vnjQ==
X-Received: by 10.49.86.35 with SMTP id m3mr16231565qez.7.1382782486126; Sat,
 26 Oct 2013 03:14:46 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Sat, 26 Oct 2013 03:14:16 -0700 (PDT)
In-Reply-To: <20131025060345.GH23098@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236748>

If it's not mentioned yet, maybe you should note that this code
currently supports only one pack with .bitmap file.

On Fri, Oct 25, 2013 at 1:03 PM, Jeff King <peff@peff.net> wrote:
> diff --git a/khash.h b/khash.h
> new file mode 100644
> index 0000000..0fdf39d
> --- /dev/null
> +++ b/khash.h
> @@ -0,0 +1,342 @@

I notice the line continuations '\' in this file look more aligned if
tab length is set to 4. No idea how many emacs users out there but it
probably does not harm to put

/* -*- mode: c; tab-width: 4; -*- */

at the beginning of this file? Another option is realign the file,
which I doubt is good because this file is imported.

> +static int load_pack_bitmap(void)
> +{
> +       assert(bitmap_git.map && !bitmap_git.loaded);
> +
> +       bitmap_git.bitmaps = kh_init_sha1();
> +       bitmap_git.ext_index.positions = kh_init_sha1_pos();
> +       bitmap_git.reverse_index = revindex_for_pack(bitmap_git.pack);
> +
> +       if (!(bitmap_git.commits = read_bitmap_1(&bitmap_git)) ||
> +               !(bitmap_git.trees = read_bitmap_1(&bitmap_git)) ||
> +               !(bitmap_git.blobs = read_bitmap_1(&bitmap_git)) ||
> +               !(bitmap_git.tags = read_bitmap_1(&bitmap_git)))
> +               goto failed;
> +
> +       if (load_bitmap_entries_v1(&bitmap_git) < 0)
> +               goto failed;

I don't see any mechanism to protect us from corrupt .bitmap files. If
.bitmap is not very large, maybe just check the trailing checksum in
the file when we open it? Else maybe add a crc32 or something after
each commit bitmap in .bitmap v2 and only verify the ones we actually
use?

> +static int open_pack_bitmap(void)
> +{
> +       struct packed_git *p;
> +
> +       assert(!bitmap_git.map && !bitmap_git.loaded);
> +
> +       prepare_packed_git();
> +       for (p = packed_git; p; p = p->next) {
> +               if (open_pack_bitmap_1(p) == 0)
> +                       return 0;

It maybe a good idea to go on anyway, checking for another .bitmap.
Just warn the user about that if found.

> +       }
> +
> +       return -1;
> +}
> +
-- 
Duy
