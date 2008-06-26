From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Thu, 26 Jun 2008 16:38:40 -0700
Message-ID: <7vhcbfojgf.fsf@gitster.siamese.dyndns.org>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com>
 <20080626204606.GX11793@spearce.org>
 <7vskuzq5ix.fsf@gitster.siamese.dyndns.org>
 <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org
To: logank@sent.com
X-From: git-owner@vger.kernel.org Fri Jun 27 01:39:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC149-000389-8S
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 01:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbYFZXix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 19:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754654AbYFZXix
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 19:38:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbYFZXiw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 19:38:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C799223DF;
	Thu, 26 Jun 2008 19:38:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5B75D223DB; Thu, 26 Jun 2008 19:38:44 -0400 (EDT)
In-Reply-To: <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com>
 (logank@sent.com's message of "Thu, 26 Jun 2008 16:36:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 080CDD6C-43D9-11DD-B9FF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86504>

logank@sent.com writes:

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
> systems with nfs-utils 0.3.3 and used to frequently get the same error
> while pushing. I made a similar change back in February and haven't
> had a problem since:
>
> diff --git a/index-pack.c b/index-pack.c
> index 5ac91ba..85c8bdb 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -313,7 +313,14 @@ static void *get_data_from_pack(struct
> object_entry *obj)
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

Gaah.  Don't we have NFS experts in house?  Bruce, perhaps?
