From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] get_sha1: support relative path "<obj>:<sth>" syntax
Date: Wed, 10 Nov 2010 11:47:36 -0600
Message-ID: <20101110174736.GD11513@burratino>
References: <m3eiatfbg2.fsf@localhost.localdomain>
 <1289407021-30287-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, dirson@bertin.fr,
	kevin@sb.org, gitster@pobox.com, peff@peff.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 18:48:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGEmS-0005Cy-GY
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 18:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab0KJRsA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Nov 2010 12:48:00 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35484 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab0KJRr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 12:47:59 -0500
Received: by ywh2 with SMTP id 2so71229ywh.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MuQE6zngeCgUy7uFFlGsOuWt+koByimkEvHOqqyvLYE=;
        b=D/ZZFAzLkkKytIZZRBFy5oXSFyVBLxPg8sQh9gFOz+LTiwHJq04h8R7rSmKafOoIp/
         ZPWsYXqETlFMiMIOPvlUvPuNgjGJamFQoUiuDrev4on8w+aXRZB9O90+aW9CWUyfbim3
         lAZUPE9yXogQd+KyvrFm3W2xhRw+ao56nzRPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VlcnVS6GcBnoj55cml5YdTVc8LRzqA/xXXPEGvKF40a7bbpBWPLMbcCr0jooKvExvD
         jVLduj422l5cRrTIWdjmqtXzRhhio3QqIUwr0Ve1UZ+RimAwCnFSDaEH3w7bZ5GPA3Wz
         dkX9BxJgZa0DjVnoeN68daH+NOjAC0HesTAZ4=
Received: by 10.204.65.211 with SMTP id k19mr1085520bki.84.1289411278163;
        Wed, 10 Nov 2010 09:47:58 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d17sm452100fav.5.2010.11.10.09.47.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 09:47:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289407021-30287-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161166>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This does not work in commands that startup_info is NULL
> (i.e. non-builtin ones).

That is easily fixable, no?

The non-builtins are:

	fast-import
	imap-send
	shell
	daemon
	show-index
	upload-pack
	http-backend
	http-fetch
	http-push

Of those, only fast-import might have a possible reason need to know
about this new syntax.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Assuming your patch builds on acf4823a (setup: save prefix (original
 cwd relative to toplevel) in startup_info, 2010-10-24).

 Untested.

diff --git a/fast-import.c b/fast-import.c
index 77549eb..3b597e8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2923,8 +2923,11 @@ static void parse_argv(void)
=20
 int main(int argc, const char **argv)
 {
+	static struct startup_info git_startup_info;
 	unsigned int i;
=20
+	startup_info =3D &git_startup_info;
+
 	git_extract_argv0_path(argv[0]);
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
