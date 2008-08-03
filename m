From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More on git over HTTP POST
Date: Sat, 2 Aug 2008 21:12:58 -0700
Message-ID: <20080803041258.GE27465@spearce.org>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org> <48952B2E.3030209@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 06:14:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPUyn-0003I7-5J
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 06:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbYHCEM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 00:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbYHCEM7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 00:12:59 -0400
Received: from george.spearce.org ([209.20.77.23]:58628 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbYHCEM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 00:12:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id ABE8E38419; Sun,  3 Aug 2008 04:12:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48952B2E.3030209@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91204>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>> Chunked Transfer Encoding
>> -------------------------
>>
>> For performance reasons the HTTP/1.1 chunked transfer encoding is
>> used frequently to transfer variable length objects.  This avoids
>> needing to produce large results in memory to compute the proper
>> content-length.
>
> Note: you cannot rely on HTTP/1.1 being supported by an intermediate  
> proxy; you might have to handle HTTP/1.0, where the data is terminated  
> by connection close.

Well, that proxy is going to be crying when we upload a 120M pack
during a push to it, and it buffers the damn thing to figure out
the proper Content-Length so it can convert an HTTP/1.1 client
request into an HTTP/1.0 request to forward to the server.  That's
just _stupid_.

But from the client side perspective the chunked transfer encoding
is used only to avoid generating in advance and producing the
content-length header.  I fully expect the encoding to disappear
(e.g. in a proxy, or in the HTTP client library) before any sort
of Git code gets its fingers on the data.

Hence to your other remark, I _do not_ rely upon the encoding
boundaries to remain intact.  That is why there is Git pkt-line
encodings inside of the HTTP data stream.  We can rely on the
pkt-line encoding being present, even if the HTTP chunks were
moved around (or removed entirely) by a proxy.

-- 
Shawn.
