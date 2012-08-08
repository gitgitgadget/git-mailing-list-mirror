From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v3 06/13] Read index-v5
Date: Wed, 8 Aug 2012 21:29:15 +0200
Message-ID: <20120808192915.GB25671@tommy-fedora.surfnet.iacbox>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-7-git-send-email-t.gummerer@gmail.com>
 <CACsJy8DZ-+0XD2HxkTFuXKXJFH66MCLLrfHtcMF-1GqBb2AmVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:29:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzBwb-0007il-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 21:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758828Ab2HHT3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 15:29:19 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32987 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab2HHT3S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 15:29:18 -0400
Received: by wibhr14 with SMTP id hr14so1046791wib.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0LcphVMmViaZTUwjt0TK3ZoxrJ3l8ycbXqNoV1RsSPA=;
        b=CztL2+/D4ztd2gfk50K1q5ZUd5cgVRA1G9g6jUgk2CVec6ED3Gk1npLRIjEGEXAeM1
         aHfe2kbGE9jHCdO3oL46ZJQwNELzpMSu0TTIsjNbFuiT1NVft0qKVqY7z8wwKIyLnoHi
         G+LUbTzFhmPRgnM9bM8UCaW95nUZLldwlQL58nyLwdRotWc4LC1k7jPe969CptmtCQD1
         cRhcV1Ah2Ktm3ulPY23cPTM0Ptl+u1nPTVkaWySa1RknLW3BuFw2vPqSwf5GlkMidSo7
         5/vr7+WehjfI8G2o9GOTPj1AuAXnNNJuXCnAN3N9C5tMLSyVfY0h4YNBSunihS4Z0Gcu
         /tOA==
Received: by 10.180.107.103 with SMTP id hb7mr264856wib.3.1344454157524;
        Wed, 08 Aug 2012 12:29:17 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id t8sm6756474wiy.3.2012.08.08.12.29.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2012 12:29:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8DZ-+0XD2HxkTFuXKXJFH66MCLLrfHtcMF-1GqBb2AmVg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203118>

On 08/08, Nguyen Thai Ngoc Duy wrote:
> uOn Wed, Aug 8, 2012 at 6:17 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > +static struct cache_entry *read_entry(struct directory_entry *de,
> > +                       unsigned long *entry_offset,
> > +                       void **mmap,
> > +                       unsigned long mmap_size,
> > +                       unsigned int *foffsetblock,
> > +                       int fd)
> > +{
> > ....
> > +               if (crc_wrong) {
> > +                       /* wait for 10 milliseconds */
> > +                       usleep(10*1000);
> > +                       munmap(*mmap, mmap_size);
> > +                       *mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> > +               }
> 
> Do we really need to munmap and mmap again? I don't see mmap man page
> mention anything about "refreshing" the mmap'd memory with file
> changes, not sure how it works. msync() seems for writing only.
> 
> If remapping is necessary, how about mremap? What I want to see is
> whether we could avoid passing "fd" down to here.
> 
> > +struct index_ops v5_ops = {
> > +       match_stat_basic,
> > +       verify_hdr,
> > +       read_index_v5,
> > +       NULL
> > +};
> 
> If you do it right, putting write_index_v2 here should work because
> in-core structure is not changed (except that write_index_v2 is static
> function, well..). Maybe putting write_index to this struct is a wrong
> decision. We should be able to read_index_v5+write_index_v2 and
> read_index_v2+write_index_v5.

Hrm I don't think it should be a problem putting write_index_v2 here,
but the way I currently handle it is by replacing the whole index_ops.
I think it's a good thing that the index_ops version always matches
the index version, to avoid any problems there.  The only place where
this can happen in the current code is in update-index.c when we change
the index version.
