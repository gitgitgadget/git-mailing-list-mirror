From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/8] sha1_file: new object source for submodule's alt
 object database
Date: Tue, 30 Apr 2013 02:07:43 -0400
Message-ID: <CAPig+cRamwcEkdNYPr5EZnh83a1GpMKS-4bpLXKkotVMJwftkA@mail.gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
	<1367293372-1958-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 08:07:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX3jB-0002al-Vr
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 08:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab3D3GHq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 02:07:46 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:51975 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3D3GHp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 02:07:45 -0400
Received: by mail-la0-f50.google.com with SMTP id fl20so142157lab.9
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 23:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VJWcEjqvAgeTF4emkFE6eYHxqvDuwbVHHvG7CZSME/c=;
        b=qboRVidCCU6QLgzKyHBvXlNGJ7lj1N+Ky8WotNgBXabKG13f3SfXR7iIB0mF8ELPCe
         jz5kXIEnwRWiqt3tbVf24aX3C6SLddru1k8NQDYboeoKUg1EJ59cjPmv5fdIv3j3Tqa5
         5VEj04snx2y5LY3ALGzPo06499FZDxeGbC0ix3O29qePaiOLwCTsXAhI3JvVwP2PJA4g
         R+YuywdpC8XNgB/T0z9kToY4J89Islcmt5l5d8dwl5OlZ8z/Yu+Vz2XnwOlViwODtx9b
         d7JcI0B7Oawd6VAhr703RT8lChpR3GLfC2Hkdfe3fMJsxPBVECF280kXqwwlKUi5SlrV
         /1sA==
X-Received: by 10.112.157.165 with SMTP id wn5mr27754355lbb.29.1367302063875;
 Mon, 29 Apr 2013 23:07:43 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Mon, 29 Apr 2013 23:07:43 -0700 (PDT)
In-Reply-To: <1367293372-1958-5-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: m7Ww35ymJcs_vPGQgJEUGnaWd0o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222908>

On Mon, Apr 29, 2013 at 11:42 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> This patch separates submodule odb sources from ordinary alternate
> sources. The new sources can be accessed with ODB_EXTALT (e.g. via
> read_sha1_file_extended).
>
> ODB_EXTALT is only added to odb_default in certain cases. Basically:
>
>  - External commands do not access submodule odb by default
>  - unpack-objects, index-pack and rev-list do not
>  - All other builtin commands do
>
> unpack-objects, index-pack and rev-list take new objects from outside
> and have to make sure the repository is still in good state. They
> should not pay attention to submodule's odb, especially rev-list
> because it does connectivity check.
>
> External commands also do not have default access to submodule odb,
> simply because I see no reasons why the should. They don't usually

s/the should/they should/

> play a big role in the user front, where submodule integration happen=
s
> and requires looking into submodule odb.
>
> The die() in add_submodule_odb() may be too strong. There might be a
> use case where somebody wants to add_submodule_odb() and look some up
> with read_sha1_file_extended() even if odb_default does not contain
> ODB_EXTALT. Right now such a use case may need to work around die() b=
y
> temporarily adding ODB_EXTALT to odb_default. Not nice, but as no suc=
h

s/as// perhaps?

> use case exists yet to worry about.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
