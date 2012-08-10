From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v3 07/13] Read resolve-undo data
Date: Fri, 10 Aug 2012 11:27:34 +0200
Message-ID: <20120810092733.GE5127@tommy-fedora.scientificnet.net>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-8-git-send-email-t.gummerer@gmail.com>
 <7vk3x7n0fl.fsf@alter.siamese.dyndns.org>
 <20120809232320.GD5127@tommy-fedora.scientificnet.net>
 <7vboijmx5i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 11:27:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzlVQ-00006Q-Ri
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 11:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779Ab2HJJ1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 05:27:40 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36344 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab2HJJ1i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 05:27:38 -0400
Received: by wibhq12 with SMTP id hq12so1031700wib.1
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iwZRL9XL3jWmvVAw+ZjvvP2KqxjtU9SwiQQ37r960pU=;
        b=fwwWac0erwDBJdU3clV2IX9GKGkLhlQne+LBUKGHxVaZnrgUXGlsUH/QbdRAj+d9aZ
         ghN1wMXEYC58fPBdWBDyx0zGfp3+Ddh7F2GLu9nSUKkr96XNm1CLLXv7ABq93fd+p2iZ
         8VWR/qJIlJsbQsmz8/HZdJgoc/F5/Lapav9mT40rRCjXYXSRarU63KYSx9Uiqrpbk7ae
         4n6+1HMWh8WjGyUGHKcWAvA3ApbGy7QhyxO8gZ8BpV1Asta40spcTlRz0D9NuqaNNhrg
         CzSTs1+VH6fftbuvyr8xh7j8YjI5ulJX/C3Ngea3DRa4wK9wuHp6X3wBGOwj3mgD1XHh
         BgJQ==
Received: by 10.216.93.81 with SMTP id k59mr1332458wef.144.1344590856750;
        Fri, 10 Aug 2012 02:27:36 -0700 (PDT)
Received: from localhost ([46.18.27.15])
        by mx.google.com with ESMTPS id q4sm6674470wix.9.2012.08.10.02.27.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Aug 2012 02:27:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vboijmx5i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203213>

On 08/09, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > On 08/09, Junio C Hamano wrote:
> >> Thomas Gummerer <t.gummerer@gmail.com> writes:
> >> 
> >> > Make git read the resolve-undo data from the index.
> >> >
> >> > Since the resolve-undo data is joined with the conflicts in
> >> > the ondisk format of the index file version 5, conflicts and
> >> > resolved data is read at the same time, and the resolve-undo
> >> > data is then converted to the in-memory format.
> >> 
> >> This, and the next one, are both about reading extension data from
> >> the v2 formatted index, no?
> >
> > Yes, exactly.
> >
> >> Again, mild NAK.
> >> 
> >> I think it is a lot more logical for the v5 code to read data stored
> >> in the resolve-undo and cache-tree extensions using the public API
> >> just like other users of these data do, and write out whatever in a
> >> way that is specific to the v5 index format.
> >> 
> >> If the v5 codepath needs some information that is not exposed to
> >> other users of istate->resolve_undo and istate->cache_tree, then the
> >> story is different, but I do not think that is the case.
> >
> > Sorry it's not clear to me what you mean with using the public API here.
> > Do you mean using resolve_undo_write() and resolve_undo_read()?
> 
> The code that reads from istate->resolve_undo is fine to do the v5
> specific conversion, but it does not belong to resolve-undo.c file
> which is about the resolve-undo extension.  Moving it to v5 specific
> file you added for this topic, read-cache-v5.c, and everything looks
> more logical.  When we taught ls-files to show the paths with
> resolve-undo data, we didn't add any function to resolve-undo.c that
> does ls-files's work for it.  Instead, ls-files just uses the public
> API (the data structure you find at the_index.resolve_undo is part
> of the API) to find what it needs to learn, and I think v5 code can
> do the same.
> 
> "then the story is different" comment refers to a possibilty that
> v5 code might need something more than callers outside resolve-undo.c
> can find from its public interface, but I do not think it is the
> case.

Ok, thanks for the clarification, will change it for the re-roll.
