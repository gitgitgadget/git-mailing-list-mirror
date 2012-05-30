From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: calling git rebase with invalid onto-ref exits with wrong error message
Date: Wed, 30 May 2012 11:27:02 +0200
Message-ID: <CABPQNSZntbPQ7taPhr_QUNnwzOcexjteUsnpmrkCiRUYRA3nvA@mail.gmail.com>
References: <op.we351rjtt21y7h@id-c1003.oslo.osa>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: manuelah@opera.com
X-From: git-owner@vger.kernel.org Wed May 30 11:27:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZfBz-0001pA-57
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 11:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422Ab2E3J1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 05:27:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63277 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab2E3J1m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 05:27:42 -0400
Received: by dady13 with SMTP id y13so6676349dad.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=313wrBm1haSukihAbyL8fxByxxXimWBywDIq7H7uWIw=;
        b=HCijp2qvmWl+2W8gubWFRBFlk6rQvVpyRGhoDThuZlQXrwY0NDlK27HfUqR8nUKL/k
         VKPug81rBI6LH5Y6auv/o1OBgzP4C12BfcXi1uQLV/9pWlUz9Wm4b3o9NOArSnveMx3t
         JRGxPHjKHThewEoyQ0tFi6iRW6AeHBJ3PVjjpT5VsiqVZEdS8KobeDU9GdWlN+6/R3Pc
         NJ4MNFA64I/Pxtvl5nXYCxWYgvp4ZGaVaX/UDoHbt0B/fx4e93LvgkEJLiOBEQ47o5Xj
         XkVB1AtI1BE9kMbjFQl2EfSrwHAc0Kc/XvYM9UQvxxgiAR9Aj1BBfAUHnk9UfygsKgJT
         6TaQ==
Received: by 10.68.203.7 with SMTP id km7mr47711082pbc.7.1338370062397; Wed,
 30 May 2012 02:27:42 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Wed, 30 May 2012 02:27:02 -0700 (PDT)
In-Reply-To: <op.we351rjtt21y7h@id-c1003.oslo.osa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198788>

On Wed, May 30, 2012 at 11:02 AM, Manuela Hutter <manuelah@opera.com> w=
rote:
> Just noticed a small bug (in git version 1.7.10.msysgit.1):
>
> calling
> =A0 git rebase --onto <onto-ref> <base-ref> <branch-ref>
>
> with an unknown <onto-ref> reports:
> =A0 fatal: Needed a single revision
> =A0 Does not point to a valid commit: <branch-ref>
>
> Expected:
> =A0 fatal: Needed a single revision
> =A0 Does not point to a valid commit: <onto-ref>
>

Indeed. This looks like the result of a bad merge-resolution, but I
could be mistaken. This looks like the correct solution to me:

diff --git a/git-rebase.sh b/git-rebase.sh
index 24a2840..3267c92 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -423,7 +423,7 @@ case "$onto_name" in
 	;;
 *)
 	onto=3D$(git rev-parse --verify "${onto_name}^0") ||
-	die "Does not point to a valid commit: $1"
+	die "Does not point to a valid commit: $onto_name"
 	;;
 esac
