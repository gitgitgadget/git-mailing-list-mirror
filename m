From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 1/2] config: be strict on core.commentChar
Date: Fri, 16 May 2014 09:42:07 -0500
Message-ID: <537623bf5f850_149cac13044a@nysa.notmuch>
References: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
 <1400248283-303-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 16:53:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJVb-00037W-6a
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144AbaEPOxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 10:53:11 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:64489 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496AbaEPOxK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 10:53:10 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so3070009obc.32
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=U+WEKJADNj/MXTDMEy1ZS9hw+RL0nDgg2xUikmAJCu4=;
        b=PMWNhYjP2no0kiqG5uWJN7KTIaBGxuJJLjUNOlB2OwZWPV4B+UMomQodM04L6q51Rj
         j2ufTt+x0QRNl1mmjAu328519PW9+/n5Klphqu4BUgm/b7LhqdV3p4NlQjmjWykHTLOf
         q3kqVoOSQd0FVKASGCjJBBcivIdGr5aJ9+84LTjmXgIsackvdEwDoeHrXBIPv1PP7UQB
         8wPmwyinp39SGpie81yEHAgJR0MR0cSvxMSCyD5NSPIrx8w4TtuMBt4gNbShO+FlTfSM
         NxK/whMts2Mf+QOgp9V6iUGOsxHpTd/1OJSAp039Ho8sGGQrQMTHfuWUu4dy89zOcUDn
         tV4w==
X-Received: by 10.182.153.33 with SMTP id vd1mr3196869obb.86.1400251989560;
        Fri, 16 May 2014 07:53:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id kt7sm5454726oeb.8.2014.05.16.07.53.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 07:53:09 -0700 (PDT)
In-Reply-To: <1400248283-303-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249323>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> We don't support comment _strings_ (at least not yet). And multi-byte
> character encoding could also be misinterpreted.
>=20
> The test with two commas is deleted because it violates this. It's
> added with the patch that introduces core.commentChar in eff80a9
> (Allow custom "comment char" - 2013-01-16). It's not clear to me _why=
_
> that behavior is wanted.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  config.c          | 8 ++++++--
>  t/t7508-status.sh | 6 ------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/config.c b/config.c
> index a30cb5c..05d909b 100644
> --- a/config.c
> +++ b/config.c
> @@ -826,8 +826,12 @@ static int git_default_core_config(const char *v=
ar, const char *value)
>  	if (!strcmp(var, "core.commentchar")) {
>  		const char *comment;
>  		int ret =3D git_config_string(&comment, var, value);
> -		if (!ret)
> -			comment_line_char =3D comment[0];
> +		if (!ret) {
> +			if (comment[0] && !comment[1])
> +				comment_line_char =3D comment[0];
> +			else
> +				return error("core.commentChar should only be one character");
> +		}

Small nit:

  if (ret)
	  return ret;
  if (comment[0] && !comment[1])
	  comment_line_char =3D comment[0];
  else
	  return error("core.commentChar should only be one character");

--=20
=46elipe Contreras