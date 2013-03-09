From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] Trivial (and small) exclude optimizations
Date: Sat,  9 Mar 2013 11:09:47 +0700
Message-ID: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 05:10:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEB7D-0006Vb-O6
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 05:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934000Ab3CIEKB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 23:10:01 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:53953 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933431Ab3CIEJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 23:09:59 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so264857daj.8
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 20:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=tVssQ03uSUK2GdfODVuJTWrvOrfykcCeEzNUOZb/Jxw=;
        b=zRKmiJhPaOPZxwY3Vbt3q/ZD7OEQIvb2N4hQ47HfzYYcnPpM+1AJkI2uOE8VYgtEeV
         /d9iPTooYKPMUPmoX5s3vS1+wFgGq+4yMT5XkEJs1oJfKYgv+VMeP0YslfAdlMP+Z/LB
         jxERwvzDMJS4bO27OPcrWLbdM78E0xrV008VCf2NZmCZ5Unar3yBOluVEx9RoFNtVFrj
         KMgKSBaVZLmhyZ4JzaTtCpRn5O4SiNA6KBUaPxlquWv+EGLHLnm5/NmG9iOVu1GMhORm
         bT1GPyGC2qPf2zdNs+/z/ml01/lvg6b6gRD5tHRigowPSZ2IQ3kiQXk/eArBeFgjIP+F
         vQNg==
X-Received: by 10.68.228.38 with SMTP id sf6mr1323211pbc.89.1362802198349;
        Fri, 08 Mar 2013 20:09:58 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id 1sm8135765pba.32.2013.03.08.20.09.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Mar 2013 20:09:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 09 Mar 2013 11:09:52 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217697>

I've been examining how and where str*cmp are called by
read_directory(). They are presumably where most of the time is spent.
The gain is not big, but still worth it, I think.

These are tested without nd/read-directory-recursive-optim. The saving
is probably smaller as nd/read... cuts down a big number of entries to
be processed by exclude machinery.

There is another optimization window, which a simple hack suggests it
may shave 100ms out of 500ms ls-files time on my machine. Say you have
"/INSTALL" in your root .gitignore. The pattern will be tested for
_all_ pathnames including "path/deep/down/here". By limiting the
pattern to pathnames of the same directory level, the number of
applicable pathnames to the pattern will be usually small and limited
(otherwise as the repository grows with more pathnames, we pay more
for exclude). Haven't figured out how to save directory level yet
though.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  match_pathname: avoid calling strncmp if baselen is 0
  dir.c: inline convenient *_icase helpers
  match_basename: use strncmp instead of strcmp

 attr.c |  2 ++
 dir.c  | 26 ++++++--------------------
 dir.h  | 18 +++++++++++++++---
 3 files changed, 23 insertions(+), 23 deletions(-)

--=20
1.8.1.2.536.gf441e6d
