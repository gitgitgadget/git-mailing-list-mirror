From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Thu, 26 Jun 2008 13:56:38 -0700
Message-ID: <7vskuzq5ix.fsf@gitster.siamese.dyndns.org>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com>
 <20080626204606.GX11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 22:57:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KByXH-0005jb-35
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 22:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759778AbYFZU4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 16:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbYFZU4s
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 16:56:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759757AbYFZU4r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 16:56:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 30B6F21928;
	Thu, 26 Jun 2008 16:56:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5355921927; Thu, 26 Jun 2008 16:56:41 -0400 (EDT)
In-Reply-To: <20080626204606.GX11793@spearce.org> (Shawn O. Pearce's message
 of "Thu, 26 Jun 2008 16:46:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 636E4158-43C2-11DD-B87E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86486>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Christian Holtje <docwhat@gmail.com> wrote:
>> I have read all the threads on git having trouble with pread() and I  
>> didn't see anything to help.
> ...
>>   Receiving objects: 100% (253/253), 5.27 MiB | 9136 KiB/s, done.
>>   fatal: cannot pread pack file: No such file or directory
>>   fatal: index-pack failed
>> 
>> The end of the strace looks like so:
>> pread(3, "", 205, 1373)                 = 0
>> write(2, "fatal: cannot pread pack file: N"..., 57) = 57
>
> Hmmph.  So pread for a length of 205 can return 0 on NFS?  Is this
> a transient error?  If so, perhaps a patch like this might help:
>
> diff --git a/index-pack.c b/index-pack.c
> index 5ac91ba..737f757 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -309,14 +309,19 @@ static void *get_data_from_pack(struct object_entry *obj)
>  	unsigned char *src, *data;
>  	z_stream stream;
>  	int st;
> +	int attempts = 0;
>  
>  	src = xmalloc(len);
>  	data = src;
>  	do {
>  		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
> -		if (n <= 0)
> +		if (n <= 0) {
> +			if (n == 0 && ++attempts < 10)
> +				continue;
>  			die("cannot pread pack file: %s", strerror(errno));
> +		}
>  		rdy += n;
> +		attempts = 0;
>  	} while (rdy < len);
>  	data = xmalloc(obj->size);
>  	memset(&stream, 0, sizeof(stream));
>
>
> The file shouldn't be short unless someone truncated it, or there
> is a bug in index-pack.  Neither is very likely, but I don't think
> we would want to retry pread'ing the same block forever.

I don't think we would want to retry even once.  Return value of 0 from
pread is defined to be an EOF, isn't it?
