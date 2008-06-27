From: Christian Holtje <docwhat@gmail.com>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Fri, 27 Jun 2008 09:54:10 -0400
Message-ID: <590C8EE3-B909-4EE5-8EFA-F5B9031A8C05@gmail.com>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com> <20080626204606.GX11793@spearce.org> <7vskuzq5ix.fsf@gitster.siamese.dyndns.org> <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: logank@sent.com
X-From: git-owner@vger.kernel.org Fri Jun 27 15:55:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCEPu-0000CT-Ax
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbYF0NyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbYF0NyO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:54:14 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:57527 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbYF0NyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:54:13 -0400
Received: by yx-out-2324.google.com with SMTP id 31so150068yxl.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=wrFQT+bkqJQ6eHcAIH047MAZoNqMhtp71jnOy9EoXb8=;
        b=fQD25jp/RxmNwnFUmDmH7gpOBl/RCVHNCKXYR115QlFgJluLi0ePGyrkj/aoqw2HUx
         keQQ28C5RGMxvrQZjBtLH3EcyfovZtw0/RllSZh/DXn07QGhK2W9+A5twvuNHC1YhaMt
         D/jM8F3E6WomGsxCuZCFtuf8GGGChe9uc4MTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=w+ZrShZQ/vzTyqOE0CLMyOq30u+DKpC3JPu7GQ9+CGFWW7146Fxwd0yvMeRVAouFkq
         qEZcO+7RbZPh2Y0h1ULz0XmWSIA/B0VS7O5MDbb0NyXmGOTUqcadOuLkCAjKs90jb5EU
         YNAkTbUeGvcPEg8mgyY8XH7nSU8xrdBNK6RkM=
Received: by 10.151.48.20 with SMTP id a20mr2279822ybk.111.1214574852028;
        Fri, 27 Jun 2008 06:54:12 -0700 (PDT)
Received: from ?192.168.0.161? ( [206.210.75.84])
        by mx.google.com with ESMTPS id x56sm4226901pyg.10.2008.06.27.06.54.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 06:54:11 -0700 (PDT)
In-Reply-To: <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86564>

On Jun 26, 2008, at 7:36 PM, logank@sent.com wrote:
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

This does work.  But the "unpacking objects" phase becomes very slow.   
I had 86 objects and I could see every time it did a sleep because the  
counter would wait a second (or more) before the next object was  
unpacked.

Ciao!
