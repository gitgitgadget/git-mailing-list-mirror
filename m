From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Add '--create-index' to git-unpack-objects
Date: Wed, 12 Oct 2005 17:34:26 +0400
Message-ID: <20051012173426.56fd5c1c.vsu@altlinux.ru>
References: <Pine.LNX.4.63.0510121301340.30679@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__12_Oct_2005_17_34_26_+0400_LKlTuAno6_8oC/HA"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 12 15:36:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPgku-0003Gt-KW
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 15:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVJLNeg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 09:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVJLNeg
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 09:34:36 -0400
Received: from mivlgu.ru ([81.18.140.87]:9184 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S964775AbVJLNeg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 09:34:36 -0400
Received: from master.mivlgu.local (master.mivlgu.local [192.168.1.230])
	by mail.mivlgu.ru (Postfix) with SMTP
	id BFF9E801B; Wed, 12 Oct 2005 17:42:25 +0400 (MSD)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510121301340.30679@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10023>

--Signature=_Wed__12_Oct_2005_17_34_26_+0400_LKlTuAno6_8oC/HA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 12 Oct 2005 13:02:36 +0200 (CEST) Johannes Schindelin wrote:

> Add the option '--create-index' to git-unpack-objects, which makes it 
> create an index file instead of expanding its contents. While at it, 
> document the dry-run option '-n', and optionally take a pack file instead 
> of stdin.


> @@ -104,7 +119,15 @@ static void added_object(unsigned char *
>  static void write_object(void *buf, unsigned long size, const char *type)
>  {
>  	unsigned char sha1[20];
> -	if (write_sha1_file(buf, size, type, sha1) < 0)
> +	if (create_index) {
> +		char header[100];
> +		SHA_CTX c;
> +
> +		SHA1_Init(&c);
> +		SHA1_Update(&c, header, 1+sprintf(header, "%s %lu", type, size));
> +		SHA1_Update(&c, buf, size);
> +		SHA1_Final(current_sha1, &c);
> +	} else if (write_sha1_file(buf, size, type, sha1) < 0)
>  		die("failed to write object");

Sorry, but this cannot work.  git-unpack-objects does a streaming
unpack, and it needs to be able to read back the objects it has written
out previously (in case a delta later in the stream references some
older object).  Saving unpacked objects in memory would obviously be
unacceptable.

However, if you need to create a pack index, you obviously have a pack
file with random access ability, and in this case it is possible to
build the index efficiently (in two passes over the pack file) without
storing unpacked objects in the filesystem.  I made a separate utility
to do this; will send a patch in some minutes.

--Signature=_Wed__12_Oct_2005_17_34_26_+0400_LKlTuAno6_8oC/HA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDTRDkW82GfkQfsqIRAmSvAJ9RhXxAQg+Oh9ohun6MGejZnDsmXwCcDSSe
owaiTGqYp/s5RpL/9NIeqOQ=
=8WSq
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Oct_2005_17_34_26_+0400_LKlTuAno6_8oC/HA--
