From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Mon, 11 Feb 2008 02:24:48 +0100
Message-ID: <200802110224.48790.jnareb@gmail.com>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org> <200802102353.40230.jnareb@gmail.com> <alpine.LFD.1.00.0802101507100.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 02:25:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JONQI-0000Xe-4S
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 02:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbYBKBY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 20:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbYBKBY4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 20:24:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:5143 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbYBKBYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 20:24:55 -0500
Received: by ug-out-1314.google.com with SMTP id z38so208482ugc.16
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 17:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=XVZiIwBoJYeLfqf9zgcN54R0XfoNfNE8B2EDq7JJZVI=;
        b=lL9K3fB2L1m4ujEjy16d/3hRuKsOGmmg23snr95JRvx0Oe6Yx58iXvMGpYHO/Je1GPVWdYJxCvsYu/TlxaqmE7C0ujAT2eUTv+j143rGwhby2O2kQyvWd8W4eU0+CtquouvwRvP91v5TDLrP/msR5Kx8yMebtC7t2XimFqdEANk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nuqsPaPdMspmLhpYbp5lnc3IDhEbUKqZnU6DThvsO4ckZNB7NREyG0NiXMQgiVBsFZpPBVnqrLzzXTaGTM/etWnAgWhAJl0/T2tLf2c/s5XR9/eVYpggqilKi++T36dIvPoZBP9N9AiOxND7ZBuucI2P4/5a7De+5LNu76607vg=
Received: by 10.67.15.15 with SMTP id s15mr8458406ugi.27.1202693093804;
        Sun, 10 Feb 2008 17:24:53 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.19])
        by mx.google.com with ESMTPS id y37sm17937737iky.7.2008.02.10.17.24.51
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 17:24:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.00.0802101507100.2896@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73448>

Linus Torvalds wrote:
> On Sun, 10 Feb 2008, Jakub Narebski wrote:
> > 
> > Well, we could always add it as a local (per repository) "cache".
> > With only generation numbers we could use pack-index-like format
> > to store a mapping "commit sha-1 => generation number", just like
> > now pack index stores mapping "object sha-1 => offset in pack".
> 
> Yes, and even embedding this in the pack-file (or perhaps, the index, as a 
> new index extension) is probably a good idea.

Errr... index is per workarea (per checkout), and this information
is per repository, so IMHO storing this info in an index (dircache)
is a layering violation. Unless you were talking about pack-file-index.

I think that separate file is better idea, this way we can update
generation info lazily: when we went to the root or project whose
all parents have generatrion number, then we save gen numbers to
such "cache" file. If we had to calculate it (even accidentally),
save it.

> > If we want to store also roots, we could either map 
> > "commit sha-1 => generation number, roots set offset / id" (constant
> > length value)[*1*], or have gen-*.gen file with generation numbers
> > and roots, and gen-*.idx as index to that file.
> 
> The thing is, the roots are almost never actually interesting. Very seldom 
> do you have any issue with different commits having different roots. So I 
> really don't think it's worth it, considering that it's also much more 
> complicated than just adding a sequence number to each commit.

Weren't the cases of multiple roots that were difficult? Storing roots
would help with 'hard' (if seldom happening) cases then.

-- 
Jakub Narebski
Poland
