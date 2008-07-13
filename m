From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [RFC PATCH] Fix quadratic performance in rewrite_one.
Date: Sun, 13 Jul 2008 04:37:58 +0400
Organization: TEPKOM
Message-ID: <200807130437.59141.angavrilov@gmail.com>
References: <200807122200.58187.angavrilov@gmail.com> <alpine.LFD.1.10.0807121550320.2959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 02:39:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHpcT-0001YE-IL
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 02:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbYGMAiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 20:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbYGMAiO
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 20:38:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:18454 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbYGMAiN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 20:38:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1816377fgg.17
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 17:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+MfL2kTThImdrdQCago6u8G1k30U8kJ1OoTsGNHXAYs=;
        b=jSRdiWNm+9O2W2uWa5HKAIkcFRKyK2sdQm2y1DqKERk8o1Q/ZClpKzwPaLuBdZo2dJ
         7LkoepOWqRwIOmSvQ9NWel2iVOCzbSfH2pitq5cdrytpayopj8EWlt9cWu6APwaiTOkr
         YiAXUzeP/a9cSs1x0beqIYf1qGQoP/JEQjNpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lEOXOJUmDavoee92cxWg+DntLZPm6KnzykdH17PGdV7X/8Vn8Gc+8rG4YTSOp04Ut4
         pjfzIxB3Be4uRfLKY5g20N9NkFDkDkLAQiB6dW/aTkb1Ed2mLMX4kdOtqqBceewRmvYv
         hLeIx7cCGQOD+ZUkipZ4fmIkqk8fhYLW6rWfE=
Received: by 10.86.59.2 with SMTP id h2mr12170424fga.12.1215909491235;
        Sat, 12 Jul 2008 17:38:11 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 3sm3810767fge.3.2008.07.12.17.38.10
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jul 2008 17:38:10 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.1.10.0807121550320.2959@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88278>

On Sunday 13 July 2008 02:55:27 Linus Torvalds wrote:
> On Sat, 12 Jul 2008, Alexander N. Gavrilov wrote:
> > Parent commits are usually older than their children. Thus,
> > on each iteration of the loop in rewrite_one, add_parents_to_list
> > traverses all commits previously processed by the loop.
> > It performs very poorly in case of very long rewrite chains.
>
> Good call, but you don't seem to invalidate the cache when we remove
> things from the list.

The cache is local to rewrite_one, and is invalidated by exiting from that 
function. Other users of add_parents_to_list just pass NULL as cache_ptr, 
thus causing insert_by_date_cached to degenerate into a simple 
insert_by_date.

> The top of the limit_list() loop does that "get top entry from list, an
> free it", and I'm not seeing you invalidating the cache if that entry that
> just got free'd happened to be the cache entry?

This type of workflow can be expected to keep the list relatively short 
(roughly limited by the number of simultaneously existing branches); and if 
it is already long, new entries will probably be added near the beginning 
anyway, so there doesn't seem to be any need to use caching. 

rewrite_one() is special in that it can sometimes walk through thousands of 
commits at once and put them all into the list -- i.e. it is bound not by the 
width of the history, but by its length.

Alexander
