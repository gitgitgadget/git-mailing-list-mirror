From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 2/4] path: optimize common dir checking
Date: Mon, 31 Aug 2015 14:56:39 -0400
Organization: Twitter
Message-ID: <1441047399.25570.20.camel@twopensource.com>
References: <1440618365-20628-1-git-send-email-dturner@twopensource.com>
	 <1440618365-20628-3-git-send-email-dturner@twopensource.com>
	 <55E2A1BF.5080204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	sunshine@sunshineco.com
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:56:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUG8-0007Yw-67
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbbHaS4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 14:56:44 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33039 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbbHaS4n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:56:43 -0400
Received: by qgp105 with SMTP id 105so19663155qgp.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Td+6FHI9ksuiuqq0ddzMEMCvZRuAXL+0xgW+/wY4EJw=;
        b=WcSf1QxdJnwNRQ+N3/ZSbBdccqDsfKnWR6AFxvFXZ8390Ahe/eOXMwd81G/n7+U9vC
         aC6OuBtUaaZhF99Bmn/7BNYGxyXxaNLcTMg18JRhoPng8+a6THVwGdd1RDBODYZWnp0n
         FlkTduo4OmXUeGmUcnqkFzCy2mTFxpVkemR8towYE/yNjrV2e/Om98S2Aw8k0FV3O9nb
         88+Hirl1zTMd46kWOLYdgHKLBSwlwlrHPIbxwQuBjdeKkRt58GRJVSLsalAmpEmoy4tU
         eTKiOaK6Rr4dhgYg9QDvev1wPd2fQdgmBm/nSCh31B+/TN56VM3oItJmbUQ2EG8RaCi/
         7Ycw==
X-Gm-Message-State: ALoCoQn6Qf+U2Z3HPCIif29ypzP+IU7BQJSbAqbtzrM33OdF9mtf8NmL7fVU0FO2w8fJAZ8tNb+e
X-Received: by 10.140.195.141 with SMTP id q135mr42178118qha.75.1441047402880;
        Mon, 31 Aug 2015 11:56:42 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id k110sm9336106qge.8.2015.08.31.11.56.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2015 11:56:42 -0700 (PDT)
In-Reply-To: <55E2A1BF.5080204@web.de>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276912>

On Sun, 2015-08-30 at 08:25 +0200, Torsten B=C3=B6gershausen wrote:
> On 26.08.15 21:46, David Turner wrote:
> > Instead of a linear search over common_list to check whether
> > a path is common, use a trie.  The trie search operates on
> > path prefixes, and handles excludes.
> >=20
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  path.c                | 226 ++++++++++++++++++++++++++++++++++++++=
++++++++----
> >  t/t0060-path-utils.sh |   1 +
> >  2 files changed, 213 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/path.c b/path.c
>=20
>=20
> > +		child->len =3D root->len - i - 1;
> > +		if (child->len) {
> > +			child->contents =3D strndup(root->contents + i + 1,
> > +						   child->len);
> >  		}
> Could we use xtrndup() instead of strndup() ?
> (Otherwise it won't compile under Mac OS here)

Thanks.  Junio, can we squash in the following?  (Or let me know and I
can resend the series with both this and your patch squashed)

---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 777af35..21306ab 100644
--- a/path.c
+++ b/path.c
@@ -191,7 +191,7 @@ static void *add_to_trie(struct trie *root, const
char *key, void *value)
=20
 		child->len =3D root->len - i - 1;
 		if (child->len) {
-			child->contents =3D strndup(root->contents + i + 1,
+			child->contents =3D xstrndup(root->contents + i + 1,
 						   child->len);
 		}
 		child->value =3D root->value;
