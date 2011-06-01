From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/10] revert: Introduce HEAD, TODO files to persist
 state, plan
Date: Wed, 1 Jun 2011 14:31:26 -0500
Message-ID: <20110601193126.GC9730@elie>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-9-git-send-email-artagnon@gmail.com>
 <20110526161102.GC24931@elie>
 <BANLkTino5gmfXjeOVih7+LHcMu1usPWAoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRr8n-0003Ki-Bn
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 21:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759482Ab1FATbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 15:31:35 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52733 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757970Ab1FATbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 15:31:34 -0400
Received: by ywe9 with SMTP id 9so63302ywe.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6LYV8Rc08iRhI7y21+n9SXLHM5DCSNEB77Ps9Yw56MA=;
        b=C5cz8gYq4tNBzOCxAD34Ro/qMToVeb7+Xvs3sP+r5hnPx+4IGoVGEWDw1hz1ma0u/e
         N16AyoCnTKBwCHO9nyAVxPYUMhcMA0WpEBhU8WI8DFI/HCtMgff+YvGr8VpNq9GBmR79
         0nRgmUYO/xP1ai2Fenj59ptR18jTZf3rZ8YD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a/JJupaTcmWVmxkCUQdPUQ3HC7J+f42D81IfjQqQe4TAiWZObA+uv0UhCD8t3nx9De
         L9zULk3CiN45idisvHltAu1+A9hYQ5LURWnCdoIqefR3yDOnNgaXQgXa4c/yt9lslPQt
         U2i4F+CBAwJaJOdzofBdezRETOe1+KYgE3Fyc=
Received: by 10.236.187.5 with SMTP id x5mr9669107yhm.255.1306956693694;
        Wed, 01 Jun 2011 12:31:33 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id i62sm1447448yhm.24.2011.06.01.12.31.32
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 12:31:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTino5gmfXjeOVih7+LHcMu1usPWAoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174896>

Ramkumar Ramachandra wrote:

> is there some
> API I can use to avoid iterating over all the commits twice? Once to
> populate the commit_list to persist the TODO, and the second time to
> actually pick them?

Good catch.  (If I understand correctly this was a potential problem
with the previous iterations, too.)

So, before thinking about what APIs git provides, what is the desired
behavior?  It is possible to walk a revision list incrementally (like
"git log" does); should cherry-pick take advantage of that?

. If yes, the "todo list" would have to be in some form that can be
  updated incrementally (something like the original revision range
  with the commits already cherry-picked negated).  This sounds
  complicated to me.

. If no, the "todo list" needs to be fully resolved to start out, and
  then the cherry-pick loop can just walk through it.  In git API
  terms, that means first populating the commit_list (for example
  using a loop that gets revisions and inserts them at the end of a
  commit_list, or by preparing the revision walk with "limited" flag
  set), then walking through it with commit_list APIs.
