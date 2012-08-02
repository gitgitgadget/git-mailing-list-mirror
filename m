From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 09/16] Read index-v5
Date: Thu, 2 Aug 2012 16:04:53 +0200
Message-ID: <20120802140453.GC1000@tgummerer.unibz.it>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <1343905326-23790-10-git-send-email-t.gummerer@gmail.com>
 <CACsJy8Co8warnQg+fKmXnO_wt=dTPBjRRe+Apic6-GBrTr_3rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 16:05:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sww1P-0003ck-Ix
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 16:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab2HBOE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 10:04:58 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53981 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab2HBOE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 10:04:57 -0400
Received: by wgbdr13 with SMTP id dr13so8002802wgb.1
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GFih15z092Klar2tYlHJXx8NSHr+Lqo88zAmK1a1s5I=;
        b=SZXDUFX/ICxzfteLmoEcSX3a+em6MD9frLZ3uKhPQLL0Pyvu/u9db7l2QH0dFgOY2D
         1ttDEcdpnWI+kIzgB441GsmXKCkxdzGZu/hFwA1mo5H9sDOkTMssCPZ6gj0QvNK9du24
         xcgntJl2BU7ZAGtA7Y3FpU8mFgWoTAJmjkXM1rptnKwE1dcFdGRrHYxtjxjNNXNr28LF
         L0fvVfhq6W/UYUPkwBgoGig8yOXok/2dpPwYQZwljgu773QBzAJUeT7FZnBu3u1L+Ys8
         BVV4kseYmnh/yDPqPGQSJHGIPGvKOGtfzozdDyIq3l4ETwNjbWbda0omND0cuXsJbUao
         LFEA==
Received: by 10.217.1.7 with SMTP id m7mr10801149wes.158.1343916295843;
        Thu, 02 Aug 2012 07:04:55 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id cl8sm33824836wib.10.2012.08.02.07.04.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 07:04:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8Co8warnQg+fKmXnO_wt=dTPBjRRe+Apic6-GBrTr_3rg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202778>

On 08/02, Nguyen Thai Ngoc Duy wrote:
> General note. I wonder if we should create a separate source file for
> v5 (at least the low level handling part). Partial reading/writing
> will come (hopefully soon) and read-cache.c on master is already close
> to 2000 lines.

To me it would make sense, but we'd probably have to split it to
at least 3 files, one for index-v2, one for index-v5 and one for
the general functions/api.

> On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > +static struct cache_entry *cache_entry_from_ondisk_v5(struct ondisk_cache_entry_v5 *ondisk,
> > +                                                  struct directory_entry *de,
> > +                                                  char *name,
> > +                                                  size_t len,
> > +                                                  size_t prefix_len)
> > +{
> > +       struct cache_entry *ce = xmalloc(cache_entry_size(len + de->de_pathlen));
> > +       int flags;
> > +
> > +       flags = ntoh_s(ondisk->flags);
> 
> huh? ntoh_s (and ntoh_l below)? search/replace problem?

No, they are correct, Junio introduced this functions with index-v4 for
systems which need aligned access. They are defined as written below.

> #ifndef NEEDS_ALIGNED_ACCESS
> #define ntoh_s(var) ntohs(var)
> #define ntoh_l(var) ntohl(var)
> #else
> static inline uint16_t ntoh_s_force_align(void *p)
> {
> 	uint16_t x;
> 	memcpy(&x, p, sizeof(x));
> 	return ntohs(x);
> }
> static inline uint32_t ntoh_l_force_align(void *p)
> {
> 	uint32_t x;
> 	memcpy(&x, p, sizeof(x));
> 	return ntohl(x);
> }
> #define ntoh_s(var)
> ntoh_s_force_align(&(var))
> #define ntoh_l(var)
> ntoh_l_force_align(&(var))
> #endif

> > +       ce->ce_ctime.sec  = 0;
> > +       ce->ce_mtime.sec  = ntoh_l(ondisk->mtime.sec);
> -- 
> Duy
