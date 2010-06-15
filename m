From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Amending a merge commit doesn't update the rerere cache
Date: Tue, 15 Jun 2010 09:08:57 -0400
Message-ID: <AANLkTimlVyDCc72yirAcL0t0YEWErAT_e0Fadq-WbxNM@mail.gmail.com>
References: <AANLkTik50ayTQUnft4oD0Paqf-AuFWxGNdx_zZlHKFPg@mail.gmail.com>
	<4C171C7B.3060904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 15 15:15:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVza-0007zt-Po
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 15:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab0FONPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 09:15:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62206 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab0FONPr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 09:15:47 -0400
Received: by gye5 with SMTP id 5so3121361gye.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9fbCEa/E07gh9lIqSa09pHj+7yleM24xT7py8uRMHQE=;
        b=wWOdfylzyS8F4AdIGJ6BPf1RKSPu1yS4Wo3efadVK4g+EGE6b5gcBEHDsvckMSy8q3
         zVb7/PXLaBa9cZz4Tem/KO6wNieFEw+bGAyhKeih0l1wOWOmiZ+F8e9RI//2Vl3ccFz3
         FZnlOpMRbKlYODnOKtcNXwy4DWcPbIRjjttA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hWTNyBiuJMJvZb1jGWeBvu9oKf7Q3wFf3vX0UQdRv0VWIW3gDd3AM/L72QQWxQgmBg
         Zrld4LyGg27Q1l+wx4w0BoQEZ2CYvU76lDt4zypxENd7mNT5VG6qekHv7CkOMJ9PkgIh
         zpjDT8jQJCaxg7FbiU8pIz9AKLStQcyI5MAPE=
Received: by 10.101.146.34 with SMTP id y34mr6212455ann.151.1276607337937; 
	Tue, 15 Jun 2010 06:08:57 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Tue, 15 Jun 2010 06:08:57 -0700 (PDT)
In-Reply-To: <4C171C7B.3060904@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149183>

On Tue, Jun 15, 2010 at 2:23 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> There is
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git rerere forget that/conflicted/file
>
> It definitely works as long as the conflict is still recorded in the
> index; I'm not sure if it works after you have staged the updated res=
olution.

In fact, I use "rerere forget" as part of a hacked up rerere-train
that I call after I've gotten my merge correct:

---- snip ----
set -- $(git rev-list --parents HEAD -1)
commit=3D$1; shift
parent1=3D$1; shift
other_parents=3D"$@"
if test -z "$other_parents"; then
        echo >&2 "HEAD is not a merge commit"
        exit 1
fi

whence=3D$(git rev-parse --abbrev-ref HEAD)
trap 'git checkout "$whence"' EXIT

git checkout -q "$parent1^0"
if git merge $other_parents; then
        echo "HEAD merges cleanly"
        exit 0
fi

git show -s --pretty=3Dformat:"Learning from %h: %s" "$commit"
git rerere forget 2>/dev/null
git checkout -q $commit -- .
git rerere
---- snip ----

I'm still interesting in making commit do the right thing though. In
general, rerere is an underdocumented feature; I guess I'll start
fixing that part first.

(Aside: and the reason I care about rerere being correct is that I
often need to eventually rebase these merges, which is itself a rather
delicate procedure.)

j.
