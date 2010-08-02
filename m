From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 09/16] subtree: rewrite incoming commits
Date: Sun, 1 Aug 2010 22:37:02 -0600
Message-ID: <AANLkTi=pgJGSY2-h2cqf2s7q49Uj0ra8tGCOWd5Do33G@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<1280593105-22015-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 06:37:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofmm1-0002pQ-DT
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 06:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab0HBEhH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 00:37:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57304 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab0HBEhE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 00:37:04 -0400
Received: by wwj40 with SMTP id 40so3450095wwj.1
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 21:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Qxc+xsvhT2PcO8bfkzioExo9u3hH551BKi91TIAug2o=;
        b=wYR0QLf121MBsfu6X5n3CwFaolGt9z/ulCZ9l+cG5inNfEweS0y89vXBkU9HdDP8Hm
         ZQsYIVm4sCB26a1npoMl4QNbZaCggjg9wVZ7fJT8CqeJ6rY/Z89qZoRDzk1oVCFSqQAi
         gNgmWG7hGVdr+dLWQl5UMZTX0s+g7lOu70CyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E7T2AowxVHEMouRrmq4rqDLDJUiDyeF8g2CghX8Dy+E20iSV+lrVUw9bcq3I+rMOuO
         gBJG58LY/iDFgKb5pNdz9xUEdZYQOE9/sb8DA2SRHtEIg9TzWvMwhG8uN49S3y2altH7
         0EVXjGXLxQ+qDfSUmpQTWch4jADSRXJdIHmao=
Received: by 10.227.146.213 with SMTP id i21mr4432254wbv.99.1280723822801; 
	Sun, 01 Aug 2010 21:37:02 -0700 (PDT)
Received: by 10.216.132.8 with HTTP; Sun, 1 Aug 2010 21:37:02 -0700 (PDT)
In-Reply-To: <1280593105-22015-10-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152393>

Hi,

2010/7/31 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> This adds the main function, subtree_import(), which is intended to b=
e
> used by "git clone".
>
> Because subtree packs are not complete. They are barely usable. Git
> client will cry out missing objects here and there... Theortically,
> client code could be adapted to only look for objects within
> subtree. That was painful to try.

It may have been painful, but personally I think it's still the right
way to do it.  Of course, that's a pretty easy thing for me to say,
since you're pretty far ahead of me and I haven't felt your pain yet.
Maybe I'll change my mind after trying it for a while, but I'm not
convinced just yet.

> +/*
> + * Take sha1 of a tree, rewrite it to only return the prefix and ret=
urn
> + * the newsha1.
> + *
> + * If if is zero, write to object store. If fd is greater than zero,
> + * it's a pack file handle.

Should the second word of the second paragraph be 'fd' rather than anot=
her 'if'?


> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (slash && slash[1]) /* trailing slash does not count */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 narrow_tree(entry.sha1, newtree_sha=
1, prefix+subtree_len+1, fd);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(newtree_sha1, entry.sha1, 20=
);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_addf(&buffer, "%o %.*s%c", entry.mode, strlen(entry.path=
), entry.path, '\0');

My compiler complains that you didn't typecast the return value from
strlen to an int.
