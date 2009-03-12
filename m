From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line 
	lengths)
Date: Thu, 12 Mar 2009 08:53:20 +0000
Message-ID: <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>
References: <49B5AF67.6050508@gmail.com>
	 <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org>
	 <49B5F0BA.3070806@gmail.com>
	 <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 09:55:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhggm-00077H-IY
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 09:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbZCLIxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 04:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbZCLIxY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 04:53:24 -0400
Received: from mail-qy0-f122.google.com ([209.85.221.122]:56039 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbZCLIxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 04:53:23 -0400
Received: by qyk28 with SMTP id 28so574246qyk.33
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 01:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/fKPhPkVUuikRYQCbVRzdUbMD3PjzyWuxT0N2g3hH5w=;
        b=u5A+uoI6F7w8k0L4hVHkpYwX8tFqE/aafDNi0xxpRE6cU4bwoxcl9DzJqM7gDZPfy9
         uadOnpw3Ge24cIimJMJRB3tUAx0ygdZR9mthlyLil/cKa9R+dojkFeOQ4AV1R6D9Os5S
         6fL7spvZtARFtqRFYY/2hVLcxwuYutO9+tH7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uo9326GRMgw97/ufxS6Qv6gt42rDiSmnNGYSoKTaNQnSZh/oagS3lSQgtoRj9Mg8jP
         uTluzCXvXTiEx0HdEiGb82r9+5kZhzO4Cm9XVGvfZmUmZ5gq33wKwGsLjCTNslv9Xc22
         PENwZvINwaS+M1zL3qjg8qMppOloSdHlk7uI0=
Received: by 10.224.60.203 with SMTP id q11mr12709352qah.239.1236848000776; 
	Thu, 12 Mar 2009 01:53:20 -0700 (PDT)
In-Reply-To: <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113022>

2009/3/10 Junio C Hamano <gitster@pobox.com>:
> diff --git a/http.c b/http.c
> index f4f0bf6..3d5caa6 100644
> --- a/http.c
> +++ b/http.c
> @@ -25,6 +25,7 @@ static long curl_low_speed_limit =3D -1;
> =C2=A0static long curl_low_speed_time =3D -1;
> =C2=A0static int curl_ftp_no_epsv;
> =C2=A0static const char *curl_http_proxy;
> +static char *user_name, *user_pass;
>
> =C2=A0static struct curl_slist *pragma_header;
>
> @@ -135,6 +136,20 @@ static int http_options(const char *var, const c=
har *value, void *cb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return git_default_config(var, value, cb);
> =C2=A0}
>
> +static void init_curl_http_auth(CURL *result)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!user_name)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(r=
esult, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
> + =C2=A0 =C2=A0 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct strbuf up =3D=
 STRBUF_INIT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!user_pass)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 user_pass =3D xstrdup(getpass("Password: "));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&up, "=
%s:%s", user_name, user_pass);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(r=
esult, CURLOPT_USERPWD,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_detach(&up, NULL));
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +

Elsewhere we seem to protect use of CURL_NETRC_OPTIONAL by checking
for LIBCURL_VERSION_NUM >=3D 0x070907. I have an ancient curl here
(curl-7.9.3-2ssl) which doesn't seem to have this option, so building
next is broken on AIX for me from this morning (c33976cb).

Is there a specific minimum version of curl we want to continue support=
ing?

Mike
