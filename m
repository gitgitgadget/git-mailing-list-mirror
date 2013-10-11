From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BAD PATCH 0/9] v4-aware tree walker API
Date: Fri, 11 Oct 2013 20:05:28 +0700
Message-ID: <20131011130528.GA10014@lanh>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1310091137310.3023@syhkavp.arg>
 <20131011122259.GA7776@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Oct 11 15:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUcLk-0005Wf-WC
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 15:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824Ab3JKNBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 09:01:45 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:42673 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab3JKNBo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 09:01:44 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so4141781pbc.39
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HPZLZoXVdEFfy/2oFcb47Ec0eIS7GEcpDomMI0TtVEM=;
        b=zTi1d9BbRxFbfhElYtaYg+7VVFzL7wzlN0TDTWo/wRAqe+lP+t2B1lrS+8VYpELbI5
         WNz4Wig0kE+8+aGINKgRcCpaS6D/1FCH7FVUDwD3OqxqR2xh2Pm6PPUAzE/Oli8vNQBW
         nrm04OMh8vi97cnyjzntPtXclie39vDaES5KdGC2ulhdYuVa12JoXzQNmIBv2ULJRd6p
         7v1gXWjLNTYsXTbJRKZYm9uZnqRSBmkVh1nBs9jdRhVdI/IcdVaodCK2mvWySGtUYCPG
         I6xgG6vQX/zrYHts24K66fXA00sg9PVURGKrIaz3v0HrAd9P626pnwIZs4Kqqi756V9U
         21rg==
X-Received: by 10.68.191.193 with SMTP id ha1mr15293031pbc.166.1381496503642;
        Fri, 11 Oct 2013 06:01:43 -0700 (PDT)
Received: from lanh ([115.73.225.239])
        by mx.google.com with ESMTPSA id b3sm59821052pbh.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 06:01:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Oct 2013 20:05:28 +0700
Content-Disposition: inline
In-Reply-To: <20131011122259.GA7776@lanh>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235903>

On Fri, Oct 11, 2013 at 07:22:59PM +0700, Duy Nguyen wrote:
> > > Maybe we could make an exception and allow the tree walker to pass
> > > pv4_tree_cache* directly to decode_entries so it does not need to do
> > > the first lookup every time..
> > > 
> > > Suggestions?

Looking at decode_entries() traces I think the "one decode_entries()
for one tree_entry()" just amplifies the delta chain effect. If you
hide 3 entries behind 5 layers of copy sequences
(i.e. tree1->tree2->..->tree5->real-tree-entry), then every
decode_entries(count=1) will have to go through 5 layers.

It makes me wonder if we should cache shortcuts so that after the
first going through 5 layers, the second can jump directly to the tree
entries.

> > 
> > I'll try to have a look at your patches in more details soon.
> 
> Shameful fixup (though it does not seem to impact the timing)

And here's another one

-- 8< --
diff --git a/list-objects.c b/list-objects.c
index 39ad3e6..85dc14e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -82,8 +82,10 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
+#if 0
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
+#endif
 	obj->flags |= SEEN;
 	show(obj, path, name, cb_data);
 	me.up = path;
