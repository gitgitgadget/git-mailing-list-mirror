From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 14
Date: Tue, 24 Jul 2012 09:52:52 +0200
Message-ID: <20120724075252.GB40532@tgummerer.surfnet.iacbox>
References: <20120723190847.GA40532@tgummerer.surfnet.iacbox>
 <CACsJy8A8J-FXtJezOZrmqfUPX5unbGG15A6BuZnDW+164n6-kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	mhagger@alum.mit.edu, trast@student.ethz.ch,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 09:53:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StZvX-00052j-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 09:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab2GXHxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 03:53:01 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56118 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084Ab2GXHxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 03:53:00 -0400
Received: by pbbrp8 with SMTP id rp8so12275233pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vbwtjIH/6ygBOmxzD+RApgSOpmAyPyqnGfpjAjBdC9s=;
        b=KLTDm7gV05yKE3qn3A3Dqt47Aa3tjCCDj6LxOmU26t4P6zAZdZ5ZlkH8CoGYb58f+c
         NOVBvPTACV7ngxBEj7G81HFb0ZD6D4kFlowOSbHZKhQ5IY8uo8RbJ8lhDzzqhaCq70A6
         RxgcLbwUP49lZycvFs9OcMDfeE7uBcdu9l39gIIpn9GmzAKFYyY0WN9pd9QLsO1WU3Mp
         SmAL1cYR6zaTy48NDAUQUJHO0lfYIdfhDiiODwtKxshvB+lACPW91p/3KKEALraxLfM1
         C0SAPaf0aNndVGtZ+XVxscQZC+Ux7fc64mftpAgsIXCvX/n8tu1/FOueK3tjOM9ASSwE
         rzQg==
Received: by 10.68.213.225 with SMTP id nv1mr14364865pbc.89.1343116380208;
        Tue, 24 Jul 2012 00:53:00 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id gf3sm3375411pbc.74.2012.07.24.00.52.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 00:52:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8A8J-FXtJezOZrmqfUPX5unbGG15A6BuZnDW+164n6-kw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202019>

On 07/24, Nguyen Thai Ngoc Duy wrote:
> On Tue, Jul 24, 2012 at 2:08 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Is ls-files improvement not drastic because you do not limit subdir
> like grep? I see Thomas Rast put similar partial loading hack to
> ls-files.c so I assume it can partial load too. Is partial loading
> still fast with when a lot of unmerged entries are present?
> -- 
> Duy

Yes, exactly, the ls-files was to show the overall performance of the
index for a full read. The improvement when limiting it to a subdir
is about the same as with git grep. Here are some more timings. I'm
using update-index instead of ls-files in this tests, with a
--force-rewrite option I added which writes the index even if there
are no changes, to test the performance of both the reader and the
writer.

Test                                        this tree      
-----------------------------------------------------------
0002.2: v[23]: update-index                 0.29(0.21+0.06)
0002.3: v[23]: grep nonexistent -- subdir   0.13(0.12+0.01)
0002.5: v4: update-index                    0.26(0.20+0.05)
0002.6: v4: grep nonexistent -- subdir      0.11(0.08+0.02)
0002.7: v4: ls-files -- subdir              0.10(0.07+0.02)
0002.9: v5: update-index                    0.19(0.11+0.07)
0002.10: v5: grep nonexistent -- subdir     0.01(0.00+0.00)
0002.11: v5: ls-files -- subdir             0.01(0.00+0.00)

Partial loading is still fast with unmerged entries, since we only
need to load files that belong to a specific directory there too.
I've created about 15,000 conflicts on the webkit repository, and
got the following times:

Test                                        this tree      
-----------------------------------------------------------
0002.2: v[23]: update-index                 0.30(0.18+0.10)
0002.3: v[23]: grep nonexistent -- subdir   0.13(0.09+0.04)
0002.5: v4: update-index                    0.26(0.22+0.04)
0002.6: v4: grep nonexistent -- subdir      0.11(0.07+0.03)
0002.7: v4: ls-files -- subdir              0.10(0.09+0.01)
0002.9: v5: update-index                    0.21(0.16+0.05)
0002.10: v5: grep nonexistent -- subdir     0.01(0.00+0.00)
0002.11: v5: ls-files -- subdir             0.01(0.00+0.00)

I could create more conflicts (~180,000 files are  in the index),
but I think 15,000 already is a number that's very unlikely to
be reached.
