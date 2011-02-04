From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [BUG?] remote-http: interrupted fetch leaves bad index behind
Date: Thu, 3 Feb 2011 19:09:57 -0600
Message-ID: <20110204010957.GB17483@elie>
References: <20101105170640.30975.94952.reportbug@deb0>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?VMO2csO2aw==?= Edwin <edwintorok@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 04 02:10:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlABx-00052V-II
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 02:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab1BDBKG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 20:10:06 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43606 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469Ab1BDBKE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 20:10:04 -0500
Received: by qyk12 with SMTP id 12so1568604qyk.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 17:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=E5NDc1Lt4Yc9NWLZk5JZECvVHMtzNC08TNhatWvqXZA=;
        b=WmGz8EmfaSTQ1p0fUKMkFw9ae3kz/ad3DGnyziVcz2wj4vf2kHfWoDk7OzUyWgAnxp
         HnDjVd3Ul1KqdNi0DVQn32LAfH0Ny3DePK+te+wZtJuySYo5wGCQWo30RnqskV4UQK+m
         TnFe4ZeoCS3G/nnUh1pcRV2KH7ZtZUZty4Iw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jT/JfalDDwj5qKCFlRORyiMbwdspSmAwjDX2o6/F5z89uKz7QI0dyXLa2/rhTihEHl
         9u5CGmvXbGDmG+rhQq9DNLhxb5KUARjVLkAMk/11fbM/QTQDn3+rhb/OXGh357jrBNlR
         xrhRptkcjd6MlgOGcdHhnI88+A20NkfmZHH9o=
Received: by 10.224.37.78 with SMTP id w14mr10273006qad.215.1296781803731;
        Thu, 03 Feb 2011 17:10:03 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id nb15sm109013qcb.26.2011.02.03.17.10.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Feb 2011 17:10:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101105170640.30975.94952.reportbug@deb0>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166015>

Hi gitsters,

T=C3=B6r=C3=B6k Edwin wrote[1]:

> If I run 'git remote update' when the remote is an http URL, and then
> I Ctrl-C in the middle of a pack download, I get the .idx and .pack.t=
emp.
>=20
> Next time when I run 'git remote update' it tells me it can't find so=
me refs:
> error: Unable to find 72128861501dc742d33e88b473482e17f6672d4c under =
http://git.clamav.net/clamav-devel.git
> Cannot obtain needed object 72128861501dc742d33e88b473482e17f6672d4c
> error: Fetch failed.

Steps to reproduce:

 1. Disable smart HTTP[2].
 2.
	git init reproduce
	cd reproduce
	git remote add clam http://git.clamav.net/clamav-devel.git
 3. git fetch clam
    Wait a few seconds (there will be no output).  Hit ^C.

$ ls .git/objects/pack/
pack-98c82c9d2da21d2efddc4544d68332235795df19.idx.temp.temp
$ git fetch clam
error: wrong index v2 file size in .git/objects/pack/pack-98c82c9d2da21=
d2efddc4544d68332235795df19.idx.temp
error: Unable to find fe96c524670f23f73008c0e6b4001c096e4f9532 under ht=
tp://git.clamav.net/clamav-devel.git
Cannot obtain needed object fe96c524670f23f73008c0e6b4001c096e4f9532
error: Fetch failed.

Ideas?
Jonathan

[1] http://bugs.debian.org/602528
[2]
diff --git a/remote-curl.c b/remote-curl.c
index 04d4813..b0ad1aa 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -625,10 +625,12 @@ static int fetch_git(struct discovery *heads,
=20
 static int fetch(int nr_heads, struct ref **to_fetch)
 {
+#if 0
 	struct discovery *d =3D discover_refs("git-upload-pack");
 	if (d->proto_git)
 		return fetch_git(d, nr_heads, to_fetch);
 	else
+#endif
 		return fetch_dumb(nr_heads, to_fetch);
 }
=20
