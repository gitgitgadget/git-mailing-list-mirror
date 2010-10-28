From: Mike Herrick <mike.herrick@gmail.com>
Subject: Re: fsck errors on newly cloned, newly imported git repository
Date: Thu, 28 Oct 2010 19:40:15 -0400
Message-ID: <AANLkTimr_11_F7WJK3Uv8N=ORqDYfrLTGyHB7c-npNaU@mail.gmail.com>
References: <AANLkTimxXXNxUOMQyDDoW9+vT9aKL5C5m+VD51jk0zL9@mail.gmail.com>
	<1288004282.819.26.camel@drew-northup.unet.maine.edu>
	<AANLkTi=7mg-1Q1hHPA52MiHa3BXF95SGTTTTLFR9+VZ3@mail.gmail.com>
	<AANLkTinfDh5_-u6nJc=MMs_vPQGuBPhOT-TqgVOvAMPo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Oct 29 01:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBc51-0002B9-Dk
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 01:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759576Ab0J1XkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 19:40:18 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39513 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758456Ab0J1XkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 19:40:16 -0400
Received: by wwe15 with SMTP id 15so2620962wwe.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 16:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=T+yw/OlrIjNafuZaK+liYBTbYtAja5N0iZ4272zDMv4=;
        b=uIUD3THOYUVs9VA5IUXNTsgkB0vPn0OKxCnvaGMe++YH/h/+7V6YVojt9yy1zB9Z1E
         /Gdz0m+baGqDNiE8lQ3/2R5RhDm5HhP285eo3ODFOcJY2ytrKF2ly8IN567nLDzYZX13
         q/TywPLYBHRyeHLHe3aNYe4Mnkv8ULDCEtSQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Fl97+++1L07BafcIk5Tx+9arh+vwOiI+EPJFsoa3nLFzV/QrVidUyLMQlORz40QXOo
         k7H9hRsORD1mvj9C1r2BgM5BDLfuDBiXrh8UsRI0umhpLEv/V3DE1pgziCOEldiaCkbD
         nkSdbX7bYOLIrOyUwVK+toyIQeuTgfp5r6XMI=
Received: by 10.227.129.83 with SMTP id n19mr10189358wbs.33.1288309215173;
 Thu, 28 Oct 2010 16:40:15 -0700 (PDT)
Received: by 10.216.255.143 with HTTP; Thu, 28 Oct 2010 16:40:15 -0700 (PDT)
In-Reply-To: <AANLkTinfDh5_-u6nJc=MMs_vPQGuBPhOT-TqgVOvAMPo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160249>

Following up to my own post, after some serious debugging, it turned
out that the libcrypto library was to blame.

I found that after the clone, a git index-pack on the pack-file would
generate a different index each time (from the same pack-file).  I
narrowed it down to this routine returning an incorrect sha1 on "bad"
machines:

static void write_sha1_file_prepare(const void *buf, unsigned long len,
                                    const char *type, unsigned char *sha1,
                                    char *hdr, int *hdrlen)
{
        git_SHA_CTX c;

        /* Generate the header */
        *hdrlen = sprintf(hdr, "%s %lu", type, len)+1;

        /* Sha1.. */
        git_SHA1_Init(&c);
        git_SHA1_Update(&c, hdr, *hdrlen);
        git_SHA1_Update(&c, buf, len);
        git_SHA1_Final(sha1, &c);
}

Upgrading the libcrypto solved the problem on both machines.

FYI, the offending versions were openssl-0.9.7a-26 and
openssl-0.9.7a-35 (these were Fedora Core 2 vintage).  Hopefully
no-one has any systems this old lying around any longer.

Mike.
