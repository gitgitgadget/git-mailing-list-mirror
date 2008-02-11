From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Mon, 11 Feb 2008 17:26:26 +0100
Message-ID: <200802111726.28001.jnareb@gmail.com>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org> <200802110224.48790.jnareb@gmail.com> <alpine.LFD.1.00.0802110748370.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:27:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JObVA-0004jJ-5S
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 17:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229AbYBKQ0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 11:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756802AbYBKQ0n
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 11:26:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:27806 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085AbYBKQ0m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 11:26:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so308476ugc.16
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 08:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=ZtlpOh6B/PAdKqMOihxmfdEkGPjGKzCRYrRI6M7yWms=;
        b=YZ4hSWOJDECjGv/C5/X0rwI0UEulKN2HjWz61KMLAEkT6gY/b9xrvLBb6Z/8GqPxWlCYtvl3vAqjJwPyBSITev8ULOrSZqJFHj6IPp6ZWRggJI8+gE4jV+VBQAt8buLtE43dxSZdW34lKoixhj6pdWjpUxa3Ni4FC1PzqDykve0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qBMTDuTQoYdOuUxJx/5t5aZqRHK3p37zi9fXU3OzTA/ikjShE3MJjaZ5nuQvUvqs7LWRftmgehr0BhNneJNDsMX2c8Sf9mdmSzmGW6e8NjFQahYLmhcn/lELXRMfy43UqCPLxayyP0nafN1a4q2Jt2P8aNimN8M47mUzDKIG8rU=
Received: by 10.67.27.3 with SMTP id e3mr9265209ugj.22.1202747200164;
        Mon, 11 Feb 2008 08:26:40 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.23])
        by mx.google.com with ESMTPS id l4sm2116498ugf.75.2008.02.11.08.26.36
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 08:26:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.00.0802110748370.2920@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73551>

On Mon, 11 Feb 2008, Linus Torvalds wrote:
> On Mon, 11 Feb 2008, Jakub Narebski wrote:
>> 
>> Errr... index is per workarea (per checkout), and this information
>> is per repository, so IMHO storing this info in an index (dircache)
>> is a layering violation. Unless you were talking about pack-file-index.
> 
> I did mean the pack-file index, not the "cache" index.

> And yes, just generating the generation number when repacking is fine. It 
> would mean that unpacked objects don't have generation numbers, but of you 
> have tons and tons of unpacked objects, you have more serious problems 
> anyway!

With generation number info in pack index, we could generate them
on repack (adding some time to repack).

With generation number info in separate pack-index like file, we
could add generation info whenever during browsing history we get
to root or to commit with generation number, saving generation
numbers in the by-the-way way, generating them lazily.

>> Weren't the cases of multiple roots that were difficult? Storing roots
>> would help with 'hard' (if seldom happening) cases then.

> The thing that worried me about multiple roots was that they make the 
> generation numbers essentially "meaningless" when compared across totally 
> unrelated commits, and might give incorrect results for generation number 
> comparisons as a result.
> 
> However, I decided that if two commits really *are* totally unrelated and 
> don't share a commit, then:
> 
>  - yes, the generation number comparison is "meaningless"
> 
>  - BUT: we don't actually care if it's correct or not, because it will 
>    never matter: whatever we choose to do, it's correct. Because there are 
>    just two choices:
> 
>     (a) stop early because everything we have left is uninteresting
> 
>     (b) continue to the root because we think we might turn something 
>         interesting into an uninteresting commit.

By the way, with generation number we can always limit walk length
to difference between generation numbers, or distance to root if
it is smaller.

-- 
Jakub Narebski
Poland
