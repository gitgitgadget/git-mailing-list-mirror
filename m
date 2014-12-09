From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 0/4] some attr optimizations
Date: Tue,  9 Dec 2014 20:53:21 +0700
Message-ID: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 14:53:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyLEN-0001Q5-PJ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 14:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957AbaLINxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 08:53:31 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33239 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896AbaLINxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 08:53:31 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so604092pdj.7
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 05:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=IwLe8Nji5tig6cT2YjqO03to+qyCy6hxBSCWthlH5bk=;
        b=eC9YOv3gNAOwT3kk/xwfQ2qTccQws4wUODRJJChnrVXtnnwtH6T0GqSDj38eA9LrEe
         KnubOvIQKSVvHEH/MLxwGvkNTbalHP37YgOvPHdw85wwud4uedVw0B6HeemMGdDLOkrN
         LYoiVXIqp06t8h7IiBW3+nENDccOxylBp8Z0PKaYY15wadyTW9BdEsEPlsH72/DKpeDr
         8WaYdk0EyCZyElmpUN6KIQwpfc4dY8bBEEYmMP20WbwUusYBSpQ0W6Vu0Tpqg1uBxPKI
         n6dsAo2EC2VF+2Tb21itjme95raWlnO0eqS+2egHrOHee18r3X2A3Byy7/KN5m5gVrdy
         WXhw==
X-Received: by 10.70.137.68 with SMTP id qg4mr31261291pdb.150.1418133210704;
        Tue, 09 Dec 2014 05:53:30 -0800 (PST)
Received: from lanh ([115.73.216.238])
        by mx.google.com with ESMTPSA id a13sm1607722pdm.44.2014.12.09.05.53.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Dec 2014 05:53:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 09 Dec 2014 20:53:26 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261121>

I wondered if I could mark some untracked files but 'precious' using
git attributes. Then I worried that the majority of people who don't
care about this precious thing will have to pay for git_check_attr()
just because some people want it.

Which led me to try to optimize the attr machinery so that, if there's
no sign of "precious" (or any attribute of interest) being defined, we
can keep the overhead down to minimum. The test suite passes, but
these optimizations could break down in subtle ways...

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  attr.c: rename global var attr_nr to git_attr_nr
  attr.c: split path processing code out of collect_all_attrs()
  attr: do not attempt to expand when we know it's not a macro
  attr: avoid heavy work when we know the specified attr is not defined

 attr.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----=
--------
 1 file changed, 74 insertions(+), 18 deletions(-)

--=20
2.2.0.84.ge9c7a8a
