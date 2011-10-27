From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Thu, 27 Oct 2011 15:32:06 -0700 (PDT)
Message-ID: <m3ehxy5aoe.fsf@localhost.localdomain>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
	<1310084657-16790-3-git-send-email-gitster@pobox.com>
	<CACBZZX6Ss4jLtdrDhLUNKCUjEHjHHKzfv-LMkOyTPDhRUXm4sQ@mail.gmail.com>
	<CACBZZX6ZWOF=j-k8o-4NHmjS2HpyS+PmKjJh_QKevWurBf9pbA@mail.gmail.com>
	<CACBZZX7tghoHhxCygEj9DZSxvKyTvybawVA2HwHBkjBaH73Ujg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 00:32:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJYUh-00029V-4T
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 00:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400Ab1J0WcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 18:32:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43790 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab1J0WcJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 18:32:09 -0400
Received: by faan17 with SMTP id n17so3121769faa.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=f9637zOIG+u4jzjsTJ59mUftNMPxkGPI6PocMgVp00g=;
        b=iJSsYGxlxGGBeBuhCbonQN6VrblCf9xqYzjioxte9UHZGHFOR8/EBkYvvzLGKk7bDS
         Iscir70oRPyz3Zy+f0pXl8WOweqvJ/6u2+V3pbkHhi3m4+41hnTpTTWAZB8jC0XMoSJO
         VYZwa/nBJjXsmJDLH8dUlwjI71lSCnNumkHzU=
Received: by 10.223.64.207 with SMTP id f15mr1293780fai.7.1319754727931;
        Thu, 27 Oct 2011 15:32:07 -0700 (PDT)
Received: from localhost.localdomain (abwc229.neoplus.adsl.tpnet.pl. [83.8.226.229])
        by mx.google.com with ESMTPS id n25sm13586121fah.15.2011.10.27.15.32.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Oct 2011 15:32:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9RMVcDq024463;
	Fri, 28 Oct 2011 00:31:48 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9RMVEKt024458;
	Fri, 28 Oct 2011 00:31:14 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CACBZZX7tghoHhxCygEj9DZSxvKyTvybawVA2HwHBkjBaH73Ujg@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184327>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Oct 27, 2011 at 23:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>=20
> > Actually it just seems slow in general, not just on repositories wi=
th
> > a lot of tags, on linux-2.6.git with this patch:
>=20
> Here's profiling with gprof for everything with >1% of execution time
> with the patch applied:
>=20
>     Each sample counts as 0.01 seconds.
>       %   cumulative   self              self     total
>      time   seconds   seconds    calls   s/call   s/call  name
>      21.07     15.99    15.99  2184059     0.00     0.00  add_descend=
ants_to_write_order
>      20.25     31.35    15.37 1146371554     0.00     0.00  add_to_wr=
ite_order
[...]
>=20
> And without:
>=20
>     Each sample counts as 0.01 seconds.
>       %   cumulative   self              self     total
>      time   seconds   seconds    calls   s/call   s/call  name
>      21.29      9.13     9.13 142180385     0.00     0.00  hashcmp
>      10.59     13.67     4.54 90592818     0.00     0.00  lookup_obje=
ct
[...]

Errr... do or do not gprof results include time spend in libraries?
Though that might not matter for this case.

Can you repeat profiling using "perf events" or something using it
(e.g. via PAPI library like HPCToolkit)?

--=20
Jakub Nar=C4=99bski
