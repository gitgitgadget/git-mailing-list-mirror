From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Thu, 26 Jun 2008 22:54:13 -0400
Message-ID: <20080627025413.GA19568@fieldses.org>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com> <20080626204606.GX11793@spearce.org> <7vskuzq5ix.fsf@gitster.siamese.dyndns.org> <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org
To: logank@sent.com
X-From: git-owner@vger.kernel.org Fri Jun 27 04:55:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC47L-0004eI-83
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 04:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbYF0CyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 22:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbYF0CyW
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 22:54:22 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43399 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbYF0CyW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 22:54:22 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KC46H-00059l-IH; Thu, 26 Jun 2008 22:54:13 -0400
Content-Disposition: inline
In-Reply-To: <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86515>

On Thu, Jun 26, 2008 at 04:36:27PM -0700, logank@sent.com wrote:
> On Jun 26, 2008, at 1:56 PM, Junio C Hamano wrote:
>
>>> "The file shouldn't be short unless someone truncated it, or there
>>> is a bug in index-pack.  Neither is very likely, but I don't think
>>> we would want to retry pread'ing the same block forever.
>>
>> I don't think we would want to retry even once.  Return value of 0  
>> from
>> pread is defined to be an EOF, isn't it?
>
> No, it seems to be a simple error-out in this case. We have 2.4.20  
> systems

That version's for the client or the server?

--b.

> with nfs-utils 0.3.3 and used to frequently get the same error  
> while pushing. I made a similar change back in February and haven't had a 
> problem since:
>
> diff --git a/index-pack.c b/index-pack.c
> index 5ac91ba..85c8bdb 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -313,7 +313,14 @@ static void *get_data_from_pack(struct object_entry 
> *obj)
> 	src = xmalloc(len);
> 	data = src;
> 	do {
> +		// It appears that if multiple threads read across NFS, the
> +		// second read will fail. I know this is awful, but we wait for
> +		// a little bit and try again.
> 		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
> +		if (n <= 0) {
> +			sleep(1);
> +			n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
> +		}
> 		if (n <= 0)
> 			die("cannot pread pack file: %s", strerror(errno));
> 		rdy += n;
>
> I use a sleep request since it seems less likely that the other thread  
> will have an outstanding request after a second of waiting.
>
> -- 
>                                                         Logan Kennelly
>       ,,,
>      (. .)
> --ooO-(_)-Ooo--
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
