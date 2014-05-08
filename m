From: dturner@twopensource.com
Subject: [PATCH 0/2] Re: ignorecase: Fix git mv on insensitive filesystems
Date: Thu,  8 May 2014 10:23:32 -0700
Message-ID: <1399569814-20644-1-git-send-email-dturner@twopensource.com>
References: <536B4680.1010806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 19:24:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiS3I-0002Zs-Pk
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 19:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbaEHRYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2014 13:24:04 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:50412 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbaEHRYB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 13:24:01 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so3228838qgf.31
        for <git@vger.kernel.org>; Thu, 08 May 2014 10:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=3Of38wd4v47STI4kcdrR+7WpXmPwg6F6Qgk+Cdt3SMo=;
        b=LHMZ7Ugf6/bFAfitHhSINkhzEg3uEVqC5z4SbXLHbcQW+5lRWgDgk7v3DUKbRJWRjg
         1tmhFeWpm1j/WM7AR/uW9n5798kEpY7rcn6N33M0nlFSrFLQ7aGe5Nyu2o3QICICj2w4
         qkzauXBUld01O6GQNXzSQdKUvWXuFoMQGK9xbIwCWIpo6wSFMGIPOD4sZdFfgNjyfEeF
         RtF/ZF3ckFSnSCeCpaE8f2UuC7/OLFFgzWhA936AkqyyCbZwlusrT8X0d9q8HxYx2O07
         P0m1vNKNbWBxzNqjTgPw4/C0nSWTyCRh9tYK1kz1Y2i5EHXc3lJiAL+hTBk/LU7Qs5XO
         pTaA==
X-Gm-Message-State: ALoCoQl/3aeC9n0JV2J4kFAP+DKEZowtgJq81SiZJkqyTY8pVCxt9j3m8A7Qt88eTrlx46NhlsJW
X-Received: by 10.224.169.6 with SMTP id w6mr7014941qay.102.1399569840434;
        Thu, 08 May 2014 10:24:00 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id w8sm2339093qag.30.2014.05.08.10.23.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 May 2014 10:23:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.33.g27630aa
In-Reply-To: <536B4680.1010806@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248424>

Torsten B=C3=B6gershausen wrote:
> On 05/08/2014 08:37 AM, Johannes Sixt wrote:
> > What if both inums are zero? Can this happen on any sane POSIX syst=
em? I
> > don't know, but my gut feeling is that inode zero is too special to=
 be
> > allocated for files or directories.
> >
> > In that case, it is safe to assume that the st_ino field is just a
> > placeholder when it is zero, and we have to compare the file name. =
Then we
> > can either assume that this happens only for our emulation layer on=
 MinGW
> > (and the comparison can be case-insensitive) or choose the comparis=
on mode
> > based on core.ignorecase. This patch does the former, but I think w=
e
> > should do the latter.
> Whatever we do, we should "protect" the strcasecmp() with ignore_case=
:
>=20
> !ignore_case || strcasecmp(src, dst)
>=20
> (And once that is done, you don't need to look at st_ino at all)

If both st_inos are zero on POSIX systems, there are two
possibilities: the two files are case-clones, or the two files are
hard-links of one another.  Checking st_ino was just an optimization
to avoid the slow string comparison.  I hadn't considered the
hard-link case important, but I guess it's better to be correct.  So
here's a patch without (as well as a cleaned-up version of the first
patch, to keep the series together).
