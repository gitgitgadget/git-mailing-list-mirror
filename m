From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Q: does index-pack work in place on windows?
Date: Thu, 03 Feb 2011 20:14:34 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102031958000.12104@xanadu.home>
References: <7v39o6xk5q.fsf@alter.siamese.dyndns.org>
 <AANLkTi=m+kERSH7TJFjuRaUfA7FR03zwNn2PKFxrqiOp@mail.gmail.com>
 <alpine.LFD.2.00.1102030026430.12104@xanadu.home>
 <7vk4hhwpfb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 02:14:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlAG2-0006qH-7v
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 02:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404Ab1BDBOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 20:14:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48845 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab1BDBOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 20:14:35 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG2009DGJFM4K20@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 Feb 2011 20:14:10 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vk4hhwpfb.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166016>

On Wed, 2 Feb 2011, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >> $ git index-pack
> >> .git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.pack
> >> Unlink of file '.git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.idx'
> >> failed. Should I try again? (y/n)? n
> >> fatal: unable to create
> >> '.git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.idx':
> >> File exists
> >
> > Why would you do such thing in the first place?
> >
> > If the pack exists along with its index on disk, there is no point 
> > recreating it.  Maybe index-pack should just bail out early in that 
> > case.
> 
> I am trying to see if an index-pack with slight modification would be a
> good replacement for verify-pack.

OK, then you don't intend to reuse it as is.  If you really wanted to 
have index-pack work in place then you would have to use 
free_pack_by_name() somewhere before writing the new pack index out, but 
that is still a dubious use case.

index-pack _could_ be a replacement for verify-pack.  It certainly can 
validate a pack since it is its purpose, possibly faster than 
verify-pack.  You'd still have to compare the existing pack index 
against the one index-pack creates without overwriting that original 
index, taking into accound index version differences, etc.

However index-pack won't tell you what is broken in the pack when 
corruptions are to be found.  It will simply tell you at the very end 
that the checksum hash doesn't match, or that some deltas were not 
resolved, that kind of thing, whereas verify-pack has the ability to 
tell you exactly what doesn't match with the info in the index or the 
like as soon as it encounters a problem.


Nicolas
