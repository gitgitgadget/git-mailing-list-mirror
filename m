From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git stash syntax error under AIX 5.3
Date: Wed, 3 Nov 2010 10:07:18 -0500
Message-ID: <20101103150718.GA12733@burratino>
References: <AANLkTimSpPLfqv07+Tmcj-iM0W+p86V2-HRrq71Umdtr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brian Riehman <briehman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 16:07:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDewJ-0000ox-6Z
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 16:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab0KCPHn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 11:07:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46753 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab0KCPHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 11:07:42 -0400
Received: by fxm16 with SMTP id 16so545511fxm.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yhmZnwzjnPM8MD9KWKEbVwib6Uw2ZMKgrVUHoVFP5Bk=;
        b=RkudSFmUPYbpLq/y8WLWwiVDVR9sXUDzWEqFw5hcVtVyjNGkoAfSrV+3Sykm9zbVEd
         t02EVA+kh1hSYIRWz3bQ2blJhErv27ioGPurnNOFqLGTs1WC8RrLxFeBxh4CKEAjGdCK
         ZHKA8ipTz2eKqh/LGasvZGDeKctTP8n8JttOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UWG2KI+m6t+AFdOIzmxlBD6WanXTZpcojur0OOkGoeCDWUQwKrsBSjlN91fb3bB2Og
         3ch6jvcsezUX3ZG2ZF8l4EHCzuFCmg2ERzW28vDL4K5nVi4zp31swFu6Lio83i4x9j2F
         xOck6RBuM/zqxv2dCJXUyP3deF8L+PWi+yGtM=
Received: by 10.223.86.16 with SMTP id q16mr2892144fal.58.1288796860777;
        Wed, 03 Nov 2010 08:07:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id y19sm3727203fau.41.2010.11.03.08.07.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 08:07:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimSpPLfqv07+Tmcj-iM0W+p86V2-HRrq71Umdtr@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160600>

Hi Brian,

Brian Riehman wrote:

> The stash command relies on bash-specific shell scripting techniques

Git actually uses the ${var%glob} syntax pretty widely, and it is
fairly portable (see http://unix.org/2008edition/ and search for "sh -"
for details).  I suspect the problem is rather the seemingly-unbalanced
braces:

> < =C2=A0 =C2=A0 =C2=A0 if test "${REV}" !=3D "${REV%{*\}}"

How about this patch?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/git-stash.sh b/git-stash.sh
index 5fb1245..0a41226 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -311,7 +311,7 @@ parse_flags_and_rev()
 	test "$ref_stash" =3D "$(git rev-parse --symbolic-full-name "${REV%@*=
}")" &&
 	IS_STASH_REF=3Dt
=20
-	if test "${REV}" !=3D "${REV%{*\}}"
+	if test "${REV}" !=3D "${REV%\{*\}}"
 	then
 		# maintainers: it would be better if git rev-parse indicated
 		# this condition with a non-zero status code but as of 1.7.2.1 it
