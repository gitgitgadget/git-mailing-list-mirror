From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] index-pack: never prune base_cache.
Date: Wed, 23 Jul 2008 15:41:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231537420.8986@racer>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness> <20080723111931.GF15243@artemis.madism.org> <alpine.DEB.1.00.0807231235150.8986@racer> <20080723120045.GA21274@atjola.homenet>
 <20080723121118.GA20614@artemis.madism.org> <20080723125226.GA11679@atjola.homenet> <alpine.DEB.1.00.0807231407040.8986@racer> <20080723134448.GB11679@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1073628401-1216824077=:8986"
Cc: Pierre Habouzit <madcoder@debian.org>, spearce@spearce.org,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfXk-0003Cq-6K
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYGWOlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYGWOlQ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:41:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:42113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751797AbYGWOlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:41:16 -0400
Received: (qmail invoked by alias); 23 Jul 2008 14:41:14 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp051) with SMTP; 23 Jul 2008 16:41:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/D+wc88eXD/ynik4mjpbH8Qd3Jjey597SKYi2PBP
	atX0KfIg4GXFn9
X-X-Sender: gene099@racer
In-Reply-To: <20080723134448.GB11679@atjola.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89664>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1073628401-1216824077=:8986
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 23 Jul 2008, Björn Steinbrink wrote:

> diff --git a/index-pack.c b/index-pack.c
> index ac20a46..33ba8ef 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -699,6 +699,9 @@ static struct object_entry *append_obj_to_pack(
>  	write_or_die(output_fd, header, n);
>  	obj[0].idx.crc32 = crc32(0, Z_NULL, 0);
>  	obj[0].idx.crc32 = crc32(obj[0].idx.crc32, header, n);
> +	obj[0].hdr_size = n;
> +	obj[0].type = type;
> +	obj[0].size = size;
>  	obj[1].idx.offset = obj[0].idx.offset + n;
>  	obj[1].idx.offset += write_compressed(output_fd, buf, size, &obj[0].idx.crc32);
>  	hashcpy(obj->idx.sha1, sha1);

I confirm that the issues I saw went away with this patch, and it looks 
obviously like the correct approach.

The only things valgrind is still complaining about (apart from libz, 
which I will not bother commenting about) are uninitialized parts of the 
data being written to disk, and a crc over them.

Judging from the addresses, those are probably the bytes that are padded 
for 4- or 8-byte alignment, so they are probably fine.

Thanks,
Dscho

--8323329-1073628401-1216824077=:8986--
