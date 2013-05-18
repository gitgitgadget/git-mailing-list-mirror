From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 00/15] New git-related helper
Date: Sat, 18 May 2013 06:46:40 -0500
Message-ID: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udfcm-0006kc-F3
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab3ERLs2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 May 2013 07:48:28 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:61171 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab3ERLs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:48:27 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so5478194obc.7
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=SQRyd1SEunsa2w6wTQbfqVKTOJMOVFKB3VSPjY+OB5s=;
        b=T05G9pMA7PkKFtdtxHAvx6sYbA/OzcoNaDGv0e/mJz++YJQ+iKLtABn/x8p/pVobFo
         xtBNIRjiZVfUGPqsB0sf+m1rdQKgfwEYwYcMHDlklOhPYwBSykBxA6EBVDe9rFRmlV1M
         vCDwd5d3zNf0UtdCjFB6HktQfcskwi5TnJCguSkBBwVHODa0zLwTlXMz+UJYsnCMgbgw
         JMlX0U8NpJatg0h5agQA4+gU7iD3Ds5w+2TncuyedOQcfEMuW8y52uJLFYSs9EQXYfKZ
         l9AVztT2n3KC1+frLEotUCNaVpRbbpeNliBvS2AXB+bSiMLdVBM6RzTRcnYMTdR1hbKQ
         TftA==
X-Received: by 10.60.47.111 with SMTP id c15mr25063629oen.127.1368877706858;
        Sat, 18 May 2013 04:48:26 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p9sm11664157oeq.7.2013.05.18.04.48.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224773>

Hi,

Here goes version 5. I decided to start with a very very minimal workin=
g
version that is only 124 lines of code, then slowly but steadily introd=
uce all
the fancy features. I also tweaked the defaults so they give more meani=
nful
results (IMO).

I also fixed the parsing of diffs so that it tackles corner case Junio
mentioned.

This script allows you to get a list of relevant persons to Cc when sen=
ding a
patch series.

  % git related v1.8.1.6^^1..v1.8.1.6^^2
  Junio C Hamano <gitster@pobox.com> (signer: 92%, author: 7%)
  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> (author=
: 38%)
  Michael Haggerty <mhagger@alum.mit.edu> (author: 15%)

It finds people that might be interesting in a patch, by going back thr=
ough the
history for each single hunk modified, and finding people that reviewed=
,
acknowledged, signed, or authored the code the patch is modifying.

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

  % git related --commits v1.8.1.6^^1..v1.8.1.6^^2
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
  2c5b011 dir.c: Fix two minor grammatical errors in comments
  377d9c4 Makefile: update the default build options for AIX

But wait, there's more: you can also specify a list of patch files, whi=
ch means
this can be used for 'git send-emails' --cc-cmd option.

I don't know about you, but I've found this script incredibly useful.

=46elipe Contreras (15):
  Add new git-related helper to contrib
  contrib: related: add option parsing
  contrib: related: sort by amount of involvement
  contrib: related: print the amount of involvement
  contrib: related: add helper Person classes
  contrib: related: show role count
  contrib: related: add support for more roles
  contrib: related: group persons with same email
  contrib: related: add mailmap support
  contrib: related: allow usage on other directories
  contrib: related: add support for multiple patches
  contrib: related: add option to show commits
  contrib: related: add option to parse from committish
  contrib: related: parse committish like format-patch
  contrib: related: fix parsing of rev-list args

 contrib/related/git-related | 312 ++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 312 insertions(+)
 create mode 100755 contrib/related/git-related

--=20
1.8.3.rc2.542.g24820ba
