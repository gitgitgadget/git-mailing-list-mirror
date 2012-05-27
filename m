From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Sun, 27 May 2012 11:04:07 +0200
Message-ID: <20120527090407.GD86874@tgummerer>
References: <20120523122135.GA58204@tgummerer.unibz.it>
 <CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
 <20120525201547.GB86874@tgummerer>
 <CACsJy8BRWmqz+2_A5_=1S9_sxOQa9GXnPQ7J1Y6id0_vh2-=+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 11:04:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYZPB-0006PN-Be
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 11:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab2E0JEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 05:04:14 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59224 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab2E0JEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 05:04:13 -0400
Received: by weyu7 with SMTP id u7so1380538wey.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9JDz2KyUSH3wKedS2JEkZR+uMV7t9Em1F9548E5ovag=;
        b=vjKXc+g1UVVxN7vmILD3nGc7Keek6fNuGdfZKgnlrDyPPZi+oCe++5buAIBct4rwKm
         A9g42fxq7JBCGA/4KeUFeJpfGzEWWm6jSod18D2LYCs4fyYHDly6yEHn887Lpubsypi5
         3uLZemjI9McK/g3qpeqMTbBBPjhAqY3Dt7UGlDPkiG9w+gih0+bJN4fTcIxa3Nm64RV0
         jH46/2E/4WIw3D69eKZdaCFJ5Hg8zGo8OEqIJ9GP6rlxGF8C5pmYCtXSL38FKD2/+i8Z
         TCcrmTVri+zIsKoxIkHFTIaSSEtQ/zz8lWeL//RJVVps6MCH/+YfpZKX+frIaZKXpEwV
         btXA==
Received: by 10.180.93.38 with SMTP id cr6mr7832600wib.16.1338109451597;
        Sun, 27 May 2012 02:04:11 -0700 (PDT)
Received: from localhost (host152-52-dynamic.14-87-r.retail.telecomitalia.it. [87.14.52.152])
        by mx.google.com with ESMTPS id ez4sm11732241wid.3.2012.05.27.02.04.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 02:04:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8BRWmqz+2_A5_=1S9_sxOQa9GXnPQ7J1Y6id0_vh2-=+Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198583>



On 05/26, Nguyen Thai Ngoc Duy wrote:
> On Sat, May 26, 2012 at 3:15 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > On 05/25, Nguyen Thai Ngoc Duy wrote:
> >> On Wed, May 23, 2012 at 7:21 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >> > == Outlook for the next week ==
> >> >
> >> > - Start working on actual git code
> >> > - Read the header of the new format
> >>
> >> I know it's out of scope, but it would be great if you could make
> >> ls-files read the new index format directly. Having something that
> >> actual works will ensure we don't overlook anything in the new format.
> >> We can then learn from ls-files lesson (especially how to handle both
> >> new/old format) and come up with api/in-core structures for the rest
> >> of git later.
> >
> > Thanks for your suggestion. How did you think this should be done?
> > Writing a extra function in ls-files, just for outputting? I don't
> > think it is necessary to write a extra function, since the result
> > from the read_index_from function in read-cache is used for that
> > anyway. Or did you have something different in mind, that I'm missing
> > here?
> 
> No, read_index_from would go through the normal tree->list conversion.
> What I'd like to see is what it looks like when a command accesses
> index v5 directly in tree form, taking all advantages that tree-form
> provides, and how we should deal with old index versions while still
> supporting index v5 (without losing tree advantages)

Ah ok, thanks for the clarification, I understand what you meant now.
I think however, that it's not very beneficial to do this conversion
now. git ls-files needs the whole index file anyway, so it's probably
not a very good test.
