From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 10/23] untracked cache: save to an index extension
Date: Wed, 10 Dec 2014 07:21:07 +0700
Message-ID: <CACsJy8BGfRPAMK9rFBiHs7w8L_3JwbRsZViDwPPVw6AVjUXg8g@mail.gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com> <1418047507-22892-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 01:21:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyV2E-0006QH-PR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 01:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbaLJAVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 19:21:39 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:46207 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaLJAVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 19:21:38 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so1982382igb.17
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8/gAcI7qlanqrTkaYlQQIMJyjpKeMSzblNs+qjp4/RQ=;
        b=Clv1h7uoP6E0L/5hzeMkh9lhg51+2hx3CoXTwJPPgA9Z3qL3P88sD/htEIgCuCsuLq
         +4OHCHM0Sg7c25sfHXdKCKPckinbk5ZAjAcpAfTDyVrpP8J9YffWauCXUYbmJ+pK/wI7
         5iOyGqBROojOl3lheRjIyoH9K8718PuqCmvrcEmrGPu7CjRFp9nmrZwhjZByEN6VQigO
         NOpTl2mPAooH6HjCObN5Mu/MT28oNtk3xgplAjeklH+wSrvKkYeKDU/gNvnFIclYfl3l
         aNB3Bu7hnKQGhuFl3+IvzMX1efdZ1lPybY+YNgE0m8ONXMqJ0VMZVtMmIAW+k6wo509X
         QBKA==
X-Received: by 10.43.119.131 with SMTP id fu3mr4418224icc.56.1418170897840;
 Tue, 09 Dec 2014 16:21:37 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Tue, 9 Dec 2014 16:21:07 -0800 (PST)
In-Reply-To: <1418047507-22892-12-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261182>

On Mon, Dec 8, 2014 at 9:04 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> +void write_untracked_extension(struct strbuf *out, struct untracked_=
cache *untracked)
> +{
> +       struct ondisk_untracked_cache *ouc;
> +       struct write_data wd;
> +       unsigned char varbuf[16];
> +       int len =3D 0, varint_len;
> +       if (untracked->exclude_per_dir)
> +               len =3D strlen(untracked->exclude_per_dir);
> +       ouc =3D xmalloc(sizeof(*ouc) + len);
> +       stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_inf=
o_exclude.stat);
> +       stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_ex=
cludes_file.stat);
> +       hashcpy(ouc->info_exclude_sha1, untracked->ss_info_exclude.sh=
a1);
> +       hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.=
sha1);
> +       ouc->dir_flags =3D htonl(untracked->dir_flags);
> +       memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len =
+ 1);
> +       strbuf_add(out, ouc, sizeof(*ouc) + len);

just fyi, this sizeof(*ouc) here is wrong because we write down an
unknown number of padding by the compiler after the last field "char
exclude_per_dir[1]". I will use offsetof(struct..., exclude_per_dir)
next time. Spotted by valgrind.
--=20
Duy
