From: Csaba Henk <csaba@lowlife.hu>
Subject: Re: git symbolic-ref vs. reflog (vs. rebase)
Date: Fri, 29 Apr 2011 22:51:31 +0530
Message-ID: <BANLkTi=yDECQs=mVkEfrkrFfy0dgFf4U3Q@mail.gmail.com>
References: <ipek0o$l0v$1@dough.gmane.org> <7vk4edyqqn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:21:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFrOA-0007Ex-B6
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 19:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894Ab1D2RVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 13:21:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44390 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab1D2RVw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 13:21:52 -0400
Received: by wya21 with SMTP id 21so2992114wya.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gFasWOQ2/10mRjY+5o0zF6yT6UCwO18HgFd7WbpBEhA=;
        b=hKlc9kIBO3ympxmHKx+zgXSlMWoxgTy18mmW2QzIInkf+mljshYiId8lJv0o6VThvP
         kj0ccv3BSy8OQFbTkzCX9TD2fZn0o4wrqxhwDUFHmTbBwDODFadunoF/qPuqsJePxQbG
         kC8ZtBctSlOiAOzCSwWHbKRNlNsMBG3AOwr3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=GApss4kiCVqhx4a2xMUuyF+Unv/EaO/8AT4iMtuO+hof0O5ldO8XPIphRx9QWFnfck
         zP0KwzV/Jl3jdhKZt2mWDssebJRwFUfi639rQsdRPz2kCXqYKUlfr8uofnqrssMS+x97
         DWIsE+UCF4Wggz2Ka5pE3CYYdGK/Nb3pATMC0=
Received: by 10.216.255.73 with SMTP id i51mr895652wes.88.1304097711125; Fri,
 29 Apr 2011 10:21:51 -0700 (PDT)
Received: by 10.216.186.143 with HTTP; Fri, 29 Apr 2011 10:21:31 -0700 (PDT)
In-Reply-To: <7vk4edyqqn.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: smYX2wZSCMO9-Ll2WhPRSvIsYtg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172476>

On Fri, Apr 29, 2011 at 9:49 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Csaba Henk <csaba@lowlife.hu> writes:
>
>> "git symbolic-ref" is a dangerous command in the sense that it can
>> change your HEAD position without updating the reflog. Is it
>> intended behaviour?
>
> Yes, it is. =A0But you can choose to do:
>
> =A0 =A0 =A0 =A0$ git branch side
> =A0 =A0 =A0 =A0$ git symoblic-ref -m "move to side" HEAD refs/heads/s=
ide
> =A0 =A0 =A0 =A0$ git log --oneline -g HEAD@{0}
> =A0 =A0 =A0 =A005ddb9b HEAD@{0}: move to side
> =A0 =A0 =A0 =A0e69de29 HEAD@{1}: commit (initial): first commit
>
> if you wanted to.

So do you think the following patch would be the correct fix for the
rebase issue:

diff --git a/git-rebase.sh b/git-rebase.sh
index cbb0ea9..10c1727 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -284,7 +284,7 @@ do
                head_name=3D"$(cat "$dotest"/head-name)" &&
                case "$head_name" in
                refs/*)
-                       git symbolic-ref HEAD $head_name ||
+                       git symbolic-ref -m "rebase: aborting" HEAD
$head_name ||
                        die "Could not move back to $head_name"
                        ;;
                esac


?

Csaba
