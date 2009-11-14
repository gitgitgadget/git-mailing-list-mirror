From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Speed up bash completion loading
Date: Sat, 14 Nov 2009 04:35:47 -0600
Message-ID: <20091114103547.GA1829@progeny.tock>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
 <20091111220832.GA31620@progeny.tock>
 <4AFCFF50.5080401@gmail.com>
 <20091113070652.GA3907@progeny.tock>
 <4AFD06CD.7090003@gmail.com>
 <20091113085028.GA4804@progeny.tock>
 <20091113090343.GA5355@progeny.tock>
 <4AFDC4F3.1050607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 11:25:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Fox-0003Go-Pe
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 11:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbZKNKZP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2009 05:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755283AbZKNKZP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 05:25:15 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53597 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898AbZKNKZN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 05:25:13 -0500
Received: by yxe17 with SMTP id 17so3594105yxe.33
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 02:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gGCVeCuiJugb+9NnrTYrRGTESRKDrlg9uCOlfvWVSz8=;
        b=CS+nHYGa6tSATHKkRqZ1CG0iY3/zWZAhJ3ZxNqJxNFAhV+5QFNnRNPIYF+KLnQ3Aaa
         h7GmmuhAug3ZgoOQC4jI+IfgGqbrLOZsPp00y1Q5vi+8nfExhmFSylH/JsRVeDtbpqxK
         b5Fgu6rv0497i8IV4mDTZYHTMqnBzT0c8iEcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cNBSH50O0ohQdjHLFYyUI6bB0K4lCRI0pLy9azO9Mw6hLmr7m0uAZrWbw2hrlCpigo
         VhRWjS7L+L8nyQS0OubO/IsuVZKZBqXAcZ+je+PGapZvVdLSLmuSgGTlysFBVwlKxYuX
         c+keWFoJ+II5yS5lrSjoBFPXuo4BP1d1TCVrk=
Received: by 10.90.16.38 with SMTP id 38mr1968471agp.112.1258194318664;
        Sat, 14 Nov 2009 02:25:18 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 39sm694944yxd.63.2009.11.14.02.25.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Nov 2009 02:25:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4AFDC4F3.1050607@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132866>

Stephen Boyd wrote:

> I was under the impression that setting variables during completion
> meant they were lost at the end of the completion cycle. So to be
> safe I put a 'sleep 5' in __git_list_porcelain_commands() and it
> only stalled me once :-)

Clever. :)

> Plus it seems that __git_all_commands is computed twice if I git
> <TAB><TAB> and then git help <TAB><TAB> after. Can that be avoided?

Sounds like a bug; thanks.  I=E2=80=99ll squash in something like the f=
ollowing
for the next iteration.

-- %< --
Subject: completion: avoid computing command list twice

__git_all_commands is being computed twice on git <TAB><TAB> with
git help <TAB><TAB> after.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6817953..748d4f9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -588,6 +588,7 @@ __git_list_porcelain_commands ()
=20
 __git_compute_porcelain_commands ()
 {
+	__git_compute_all_commands
 	: ${__git_porcelain_commands=3D$(__git_list_porcelain_commands)}
 }
=20
--=20
1.6.5.2
