From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 17/28] Support pushing from a shallow clone
Date: Tue, 26 Nov 2013 15:38:35 -0500
Message-ID: <CAPig+cSnq8qWusYHYoWRf_n_GaLL_tXTQk5LkLoXuh_WgB00Dg@mail.gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 21:38:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlPPB-00060z-En
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 21:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092Ab3KZUij convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 15:38:39 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33243 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757755Ab3KZUig convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Nov 2013 15:38:36 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so10404535iec.35
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 12:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=0FECB8FytrDGmv2/7gQM64/b7L9ZOz4ALAQ1sx+hU08=;
        b=rs1LnveNXVmWmV9M+0r+N7NY8XM0vWSgZMD+vLBS+shul/rMyb4EKXas64bIlhHAfu
         wPFNO+/4EdHmvu/CqE0kGIxvrer9Ov73GLBw7NSnxSp2LLgB2PusJ0u4oMc/LUEeZCc2
         2phX9fsQqYuU3tVRPFUfE12I+rg4mELM9X88fRBexe2EvlGCBRxjvFQL11eIuMHFPtJc
         pEGhvzo86BDhOkANXYPC086vnNi7NIP7LpaU82UQ8Tydo6AjYxkokuQjLv5Yly3g9X3h
         cnF4EpZnJoWQKepfaZnX5DJAOkZn5CRrNiae4Z48YiXwblu8hJPJQpgGnHBCgsfZm8TX
         g5Qw==
X-Received: by 10.42.147.66 with SMTP id m2mr2800064icv.59.1385498316069; Tue,
 26 Nov 2013 12:38:36 -0800 (PST)
Received: by 10.64.250.198 with HTTP; Tue, 26 Nov 2013 12:38:35 -0800 (PST)
In-Reply-To: <1385351754-9954-18-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: tO6FN-O6M4M6e-SpK9iWqxQe0Xg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238393>

On Sun, Nov 24, 2013 at 10:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> Pushing from a shallow clone using today's send-pack and receive-pack
> may work, if the transferred pack does not end up at any graft
> points. If it does, recent receive-pack that does connectivity check
> will reject the push. If receive-pack is old and does not have the
> connectivity check, the upstream repo becomes corrupt.
>
> The pack protocol is updated and send-pack now sends all shallow
> grafts before it sends the commands, if the repo is shallow. This
> protocol extension will break current receive-pack, which is intended=
,
> mostly to stop corrupting the upstream repo.
>
> Changes on the receiver are similar to what has been done in
> fetch-pack, i.e. filter out refs that require new shallow roots then
> go along as usual.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentatio=
n/technical/pack-protocol.txt
> index eb8edd1..c73b62f 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -43,6 +43,9 @@ static int fix_thin =3D 1;
>  static const char *head_name;
>  static void *head_name_to_free;
>  static int sent_capabilities;
> +static int shallow_push;
> +static const char* alternate_shallow_file;

s/char\* /char */

> +static struct extra_have_objects shallow;
>
>  static enum deny_action parse_deny_action(const char *var, const cha=
r *value)
>  {
