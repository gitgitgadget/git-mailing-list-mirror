From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 00/11] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 14:30:20 -0500
Message-ID: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:32:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH2O-0004rb-Ab
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab3DSTbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Apr 2013 15:31:46 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:42899 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab3DSTbp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:31:45 -0400
Received: by mail-qc0-f181.google.com with SMTP id a22so2223648qcs.40
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=SDC80s4GJkerdjxNSBLn1FSQF138gvvhK/kKZ7IBVHI=;
        b=GlI+MUAElYSdxjnyOAZNb+zBfk+MhLnTr40usqe/mwNx+0P/b4hEN039piH1VwSqID
         8WbBreclfeXXMw10Hf24v1aWY88TEypY9+KpDRqiNy4y5d45AnLUE4fFbteDLspy+FTk
         wXbNQpCAr5sj1NGHL1G/HQCw0I0RewlLkxicLMg3vDK6ATPnjDU+WR9L2Ug/07KPURVp
         8f9Q5rTlQv1X68Yo08RtgntBU1XZMJrYjV0qZO59/LCQyVlfb9M3gobVmoNFcMdZcPru
         Bua8ztPHOh0papiXyyStx+De87uTQWqAq8r6HiFgmEUPiDFj8yjIMZvvWHUfBwgHXtVH
         K4kg==
X-Received: by 10.49.107.193 with SMTP id he1mr17324870qeb.2.1366399904596;
        Fri, 19 Apr 2013 12:31:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id en8sm18658895qeb.0.2013.04.19.12.31.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:31:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221797>

Hi,

Here goes another try, I made some changes based on comments, and shoul=
d be
simpler now. Plus a few improvements. The interdiff will be on the patc=
hes, but
only the first one changed substantially.

This script allows you to get a list of relevant persons to Cc when sen=
ding a
patch series.

  % git cc-cmd v1.8.1.6^^1..v1.8.1.6^^2
  "Henrik Grubbstr=C3=B6m" <grubba@grubba.org> (author: 7%)
  junio (signer: 84%, author: 15%)
  "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com> (auth=
or: 30%, signer: 7%)
  "Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> (author: 7%)
  Jean-Noel Avila <jn.avila@free.fr> (signer: 7%)
  Duy Nguyen <pclouds@gmail.com> (author: 7%)
  Michael Haggerty <mhagger@alum.mit.edu> (author: 15%)
  Clemens Buchacher <drizzd@aon.at> (author: 7%)
  Joshua Jensen <jjensen@workspacewhiz.com> (author: 7%)
  Johannes Sixt <j6t@kdbg.org> (signer: 7%)

It find people that might be interesting in a patch, by going back thro=
ugh the
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
this can be used for git send-emails --cc-cmd option.

=46elipe Contreras (11):
  Add new git-cc-cmd helper to contrib
  contrib: cc-cmd: add option parsing
  contrib: cc-cmd: add support for multiple patches
  contrib: cc-cmd: add option to show commits
  contrib: cc-cmd: add option to parse from committish
  contrib: cc-cmd: parse committish like format-patch
  contrib: cc-cmd: fix parsing of rev-list args
  contrib: cc-cmd: add option to fetch aliases
  contrib: cc-cmd: support multiple roles
  contrib: cc-cmd: sort by participation
  contrib: cc-cmd: ignore chunks with no original lines

 contrib/cc-cmd/git-cc-cmd | 258 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 258 insertions(+)
 create mode 100755 contrib/cc-cmd/git-cc-cmd

--=20
1.8.2.1.790.g4588561
