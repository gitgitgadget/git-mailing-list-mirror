From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v3 06/13] Read index-v5
Date: Wed, 8 Aug 2012 19:05:33 +0700
Message-ID: <CACsJy8DZ-+0XD2HxkTFuXKXJFH66MCLLrfHtcMF-1GqBb2AmVg@mail.gmail.com>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com> <1344424681-31469-7-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 14:06:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz51g-00047O-GH
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 14:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993Ab2HHMGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 08:06:07 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50832 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab2HHMGF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 08:06:05 -0400
Received: by qcro28 with SMTP id o28so347687qcr.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wtl8zT8VJ4qDwJI2kgfoSeHRmK+fy2ywjurAfSwgFmA=;
        b=pBJuHxun/oEFC0XTIl2eudyN+j31ru6UG3IgtRE0/PHZKjXTLcss+HjUyVAt65Isum
         CDzc2i9un/Paj1cK7pd7ndnKryE4wF9WoD8U4s/8qjStI6t5ytC5cIOUc3squyLYzyPO
         Fwn4y+9J2cHoZCLmdI47DRidw1dN9rDZVdjKNyd2infyHLbgPU0OLsW7Nmo8N1MWf+6C
         NPuU9tX6tGfaPmsqJVo1IJynaw28JqlvQZryH3ldKIL7cQxdzu5Mf5QCZ5CNHLv9onqW
         PUC5wOX+cNDjftmUyQWLxqPfX+a5QrznfBnV87M/vyr5qDX4N7018/lMiv8vVr4BIZbT
         MzYg==
Received: by 10.224.26.210 with SMTP id f18mr29584499qac.80.1344427563847;
 Wed, 08 Aug 2012 05:06:03 -0700 (PDT)
Received: by 10.49.84.73 with HTTP; Wed, 8 Aug 2012 05:05:33 -0700 (PDT)
In-Reply-To: <1344424681-31469-7-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203087>

uOn Wed, Aug 8, 2012 at 6:17 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +static struct cache_entry *read_entry(struct directory_entry *de,
> +                       unsigned long *entry_offset,
> +                       void **mmap,
> +                       unsigned long mmap_size,
> +                       unsigned int *foffsetblock,
> +                       int fd)
> +{
> ....
> +               if (crc_wrong) {
> +                       /* wait for 10 milliseconds */
> +                       usleep(10*1000);
> +                       munmap(*mmap, mmap_size);
> +                       *mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> +               }

Do we really need to munmap and mmap again? I don't see mmap man page
mention anything about "refreshing" the mmap'd memory with file
changes, not sure how it works. msync() seems for writing only.

If remapping is necessary, how about mremap? What I want to see is
whether we could avoid passing "fd" down to here.

> +struct index_ops v5_ops = {
> +       match_stat_basic,
> +       verify_hdr,
> +       read_index_v5,
> +       NULL
> +};

If you do it right, putting write_index_v2 here should work because
in-core structure is not changed (except that write_index_v2 is static
function, well..). Maybe putting write_index to this struct is a wrong
decision. We should be able to read_index_v5+write_index_v2 and
read_index_v2+write_index_v5.
-- 
Duy
