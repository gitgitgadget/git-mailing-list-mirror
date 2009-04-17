From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] builtin-apply: keep information about files to be
 deleted
Date: Fri, 17 Apr 2009 19:23:24 +0200
Message-ID: <20090417192324.3a888abf@gmail.com>
References: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com>
	<7v4owsfktw.fsf@gitster.siamese.dyndns.org>
	<20090413230351.7cbb01f5@gmail.com>
	<7v1vrwdyxx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 19:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LurvL-0005FR-A4
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 19:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758390AbZDQRau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 13:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757792AbZDQRat
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 13:30:49 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:52863 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbZDQRas convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 13:30:48 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2009 13:30:48 EDT
Received: by bwz7 with SMTP id 7so260926bwz.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=cPSAaqQVzQID3cEOZtLQo/o4hkuH92TlfwpswW4K8W0=;
        b=gq5DlpRcFOM2x4Op/AtQnVd9EqI3CkBkg2kxo1ykN1v55TTHSu62t/4b9YO1fgIlSV
         8+nbjwojarkbrLH6pHbS93ZLx81my3dVzIuaqUapiEIatpm9cv9beZx+YlRcDe6irOnb
         FrHtIzXE2fIIAgrRlmrcz8Aqcl04NoKQNKFQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=M6G4Bh57LGm6CccoGDWbHxyNpbHKNAMcZtt/1qLphh9XEcQwrFUKSa3FuGaJR61G7m
         8F/vrszEdvlH1yXp4igiGRa7/4ktE11KYxZJtbJy5ChDRDdRudIu1th8uL0NRwaG7pTu
         wrG0hRc+p6DHgPUoVpXRRa4lVNS4ecao7MDng=
Received: by 10.204.120.70 with SMTP id c6mr2496695bkr.144.1239989014279;
        Fri, 17 Apr 2009 10:23:34 -0700 (PDT)
Received: from localhost (87-205-51-134.adsl.inetia.pl [87.205.51.134])
        by mx.google.com with ESMTPS id 13sm3679875fks.14.2009.04.17.10.23.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Apr 2009 10:23:34 -0700 (PDT)
In-Reply-To: <7v1vrwdyxx.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116763>


W dniu 13 kwietnia 2009 23:30 u=C5=BCytkownik Junio C Hamano
<gitster@pobox.com> napisa=C5=82:
> =20
> >
> > As far as I understand the code, diffs are applied independently
> > (for every file apply_patch() is called) and for every apply_patch(=
)
> > call fn_table is cleared. So situation you described in only
> > possible in a *single* diff and I don't think it is possible to
> > happen. =20
>
> Yes, one invocation of "git format-patch -1" will not produce such a
> situation.
>
> A single diff file that is concatenation of two "git format-patch -1"
> output (or just a plain-old "diff -ru" output from outside git,
> perhaps managed in quilt) was what introduced fn_table mechanism.
> =C2=A0Apparently people use "git apply" to apply such a patch.
> =20

I have been thinking about that and IMO something is not right in
handling multiple patches. I'm still new to git, so I may be wrong.
Look:

Suppose I have 3 patches:

patch #1: modify A
patch #2: rename A to B
patch #3: modify B

These patches will be applied correctly.

But, if I swap patches #1 and #3, none of them will be applied. This
is because of 2 rules, implemented in add_to_fn_table():

1. If a file was renamed/deleted, applying a patch is not possible.
2. If a file is new/modified, applying a patch is possible.

They seem reasonable. In previous example, file A comes under rule #1
and file B under rule #2. However, there are some cases when these two
rules may cause problems:

patch #1: rename A to B
patch #2: rename C to A
patch #3: modify A

Should patch #3 modify B (which was A) or A (which was C)?

patch #1: rename A to B
patch #2: rename B to A
patch #3: modify A
patch #4: modify B

Which files should be patched by #3 and #4?

In my opinion both #3 and #4 should fail (or both should succeed) --
with my patch only #3 will work and #4 will be rejected, because in #2
B was marked as deleted.
