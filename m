From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v2 3/4] unpack_trees(): add support for sparse 
	checkout
Date: Tue, 11 Aug 2009 08:47:53 +0700
Message-ID: <fcaeb9bf0908101847w7b3b22d9w84514a29ceae719e@mail.gmail.com>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com> 
	<1249917562-5931-2-git-send-email-pclouds@gmail.com> <1249917562-5931-3-git-send-email-pclouds@gmail.com> 
	<1249917562-5931-4-git-send-email-pclouds@gmail.com> <alpine.DEB.1.00.0908101837510.8324@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 11 03:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MagTO-0004sJ-3k
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 03:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbZHKBsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 21:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbZHKBsN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 21:48:13 -0400
Received: from mail-yw0-f193.google.com ([209.85.211.193]:41575 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbZHKBsM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 21:48:12 -0400
Received: by ywh31 with SMTP id 31so4451541ywh.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 18:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ah2I3Xc3RnhRSS4mlbQSK0qHzopZbRmx/1SMnDDKqUQ=;
        b=aBYLSAjCLBb+7PUkZ8vExBCXPgJRtYuCMcXHknZXZSJkfabqG1J0M4pSswWPXZDqjP
         V8ygIlwZ/lFpx4XW6sL44tPUvhvB1G12UeLKT3YthiuQYeikq8Qj741j4wzu4evwl6Ef
         VG/zXFK/IJZ1WQ0/40EQbtUBTQWCbmY7XV74Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Is3iElFYamlm/AXEDuOLnYg70jWmIF+ePi9pO8nUhAV1JgJMRUbS2+cFKkgrn9r8o0
         CfTgUziDLL9FCgkIUjGErJRIlqfCj/fEtLcqUbB9MXtcF4HEBiJBn3w42LvRp1/2kpj9
         VNJ2WCTySCaAZZ6V9olN9kh55w3DZFxwAt9zA=
Received: by 10.100.143.9 with SMTP id q9mr13682and.110.1249955293226; Mon, 10 
	Aug 2009 18:48:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908101837510.8324@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125510>

2009/8/10 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 10 Aug 2009, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> This patch teaches unpack_trees() to checkout/remove entries on work=
ing
>> directories appropriately when sparse checkout area is changed. Hook
>> "sparse" is needed to help determine which entry will be checked out=
,
>> which will not be.
>>
>> When the hook is run, it is prepared with a pseudo index. The hook t=
hen
>> can use "git update-index --[no-]assume-unchanged" to manipulate the
>> index. It should not do anything else on the index. Assume unchanged
>> information from the index will be used to shape working directory.
>
> If I understand correctly, the purpose of the hook is to allow the us=
er to
> mark something as unwanted preemptively, right?
>
> If that is the sole reason for the hook, would it not be better to ad=
d
> support for a file .git/info/sparse which has the same syntax as
> .git/info/exclude, and which is used to determine if an
> added/modified/deleted file is supposed to be in the "sparse" area or=
 not?
>
> Something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0!/Documentation/
>
> comes to mind.

That was what the original series was about (although I used git
config instead of .git/info/sparse). The hook has two advantages:

 - flexibility: you can set things differently based on branch, for
example, or filter files based on certain file content.
 - less code bloat (and less intrusive too), compare ~1000 lines of
change of the original series with this series.
--=20
Duy
