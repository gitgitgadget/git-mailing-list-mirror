From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 00/11] Add new git-related helper to contrib
Date: Thu, 25 Apr 2013 14:59:32 -0500
Message-ID: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSLv-0003ei-BL
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757716Ab3DYUBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 16:01:06 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35664 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab3DYUBF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:05 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so2903415obb.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=5m+haTwaggMZDkw8mi1y/nVS8IyZcx9p+DPR22gzwQg=;
        b=qjvv8asEyeeIVhKaAyZJB6Z7w2La6C8kK6Otc31RwWzav2y04KbOZj5EIGGwiEt15q
         kXRilEtcFThD+Hx62Mwxzpuewd4fJU32CBlf/0YB6ibcEl3WDQ53jhNvoQTKdYfNtRla
         2vH54YJ8nt8Hyn2ZP1QGaoW3Q2UeHvrCZ/68Df4kuT2Hi8sAaiTAG3maQJA/LcdWlCBK
         fcMP5v6JFkPjZ2IKCzt2XsKzSaNsQQIJyWEBAeROr5wD6rV0tJK3sYu8S2yZtflArkG4
         QZw9AntuPCBz63MfMAJhnOgPM/BYfIvco5llwhHhU45XTqyJDEmIY2BECcL4n0BRKEWd
         lXpw==
X-Received: by 10.60.27.136 with SMTP id t8mr6917593oeg.92.1366920064136;
        Thu, 25 Apr 2013 13:01:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm4723057obx.9.2013.04.25.13.01.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222428>

Hi,

Previously known as git-cc-cmd, I've renamed it git-related (tentativel=
y). I
removed support for aliases, as I don't think it's very useful, and I'v=
e added
support for mailmap, which I think covers similar use-cases.

This script allows you to get a list of relevant persons to Cc when sen=
ding a
patch series.

  % git cc-cmd v1.8.1.6^^1..v1.8.1.6^^2
  Junio C Hamano <gitster@pobox.com> (signer: 84%, author: 15%)
  "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com> (auth=
or: 38%, signer: 7%)
  Michael Haggerty <mhagger@alum.mit.edu> (author: 15%)
  Jean-Noel Avila <jn.avila@free.fr> (signer: 7%)
  "Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> (author: 7%)
  "Henrik Grubbstr=C3=B6m" <grubba@grubba.org> (author: 7%)
  Clemens Buchacher <drizzd@aon.at> (author: 7%)
  Joshua Jensen <jjensen@workspacewhiz.com> (author: 7%)
  Johannes Sixt <j6t@kdbg.org> (signer: 7%)

It finds people that might be interesting in a patch, by going back thr=
ough the
history for each single hunk modified, and finding people that reviewed=
,
acknowledge, signed, or authored the code the patch is modifying.

It does this by running 'git blame' incrementally on each hunk, and the=
n
parsing the commit message. After gathering all the relevant people, it=
 groups
them to show what exactly was their role when the participated in the
development of the relevant commit, and on how many relevant commits th=
ey
participated. They are only displayed if they pass a minimum threshold =
of
participation.

The code finds the changes in each commit in the list, runs 'git blame'
to see which other commits are relevant to those lines, and then adds
the author and signer to the list.

=46inally, it calculates what percentage of the total relevant commits
each person was involved in, and if it passes the threshold, it goes in=
=2E

You can also choose to show the commits themselves:

  % git cc-cmd --commits v1.8.1.6^^1..v1.8.1.6^^2
  9db9eec attr: avoid calling find_basename() twice per path
  94bc671 Add directory pattern matching to attributes
  82dce99 attr: more matching optimizations from .gitignore
  593cb88 exclude: split basename matching code into a separate functio=
n
  b559263 exclude: split pathname matching code into a separate functio=
n
  4742d13 attr: avoid searching for basename on every match
  f950eb9 rename pathspec_prefix() to common_prefix() and move to dir.[=
ch]
  4a085b1 consolidate pathspec_prefix and common_prefix
  d932f4e Rename git_checkattr() to git_check_attr()
  2d72174 Extract a function collect_all_attrs()
  8cf2a84 Add string comparison functions that respect the ignore_case =
variable.
  407a963 Merge branch 'rr/remote-helper-doc'
  ec775c4 attr: Expand macros immediately when encountered.

But wait, there's more: you can also specify a list of patch files, whi=
ch means
this can be used for 'git send-emails' --cc-cmd option.


=46elipe Contreras (11):
  Add new git-related  helper to contrib
  contrib: related: add option parsing
  contrib: related: add support for multiple patches
  contrib: related: add option to show commits
  contrib: related: add option to parse from committish
  contrib: related: parse committish like format-patch
  contrib: related: fix parsing of rev-list args
  contrib: related: support multiple roles
  contrib: related: sort by participation
  contrib: related: group persons with same email
  contrib: related: add support for mailmap

 contrib/related/git-related | 272 ++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 272 insertions(+)
 create mode 100755 contrib/related/git-related

--=20
1.8.2.1
