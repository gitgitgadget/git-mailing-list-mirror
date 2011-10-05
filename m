From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH WIP 0/3] git log --exclude
Date: Wed,  5 Oct 2011 18:18:05 +1100
Message-ID: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 09:18:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBLkQ-00053E-2l
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 09:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab1JEHS3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 03:18:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38770 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab1JEHS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 03:18:28 -0400
Received: by ywb5 with SMTP id 5so1294521ywb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=qVttcFmCjsqKw8jrREBDaK/fpt7KYuXF29hAHzYKetU=;
        b=j8k/GKEhCXxtECCSj+QoQTFPWreYaeT8bafmGpTvKNnZmrBYMHSIqZhQFxKrU/DywM
         hDimyVauqvXJVHCo1C0u+i7WEBLmc0aJuTGTZgbq91M1e0L5jYtTsNfzgsZPqbraHPuv
         +OoP6DpfFhdWyJCBpRoANOOsxPmX9p8dEw1S0=
Received: by 10.236.131.42 with SMTP id l30mr11960271yhi.30.1317799107910;
        Wed, 05 Oct 2011 00:18:27 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id p8sm1173731yhe.17.2011.10.05.00.18.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 00:18:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 05 Oct 2011 18:18:13 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182830>

This series adds --exclude that uses .gitignore mechanism remove
commits whose changes that are _entirely_ excluded. The main patch is
2/3 where it teaches diff_tree_* about struct exclude_list.

Because it uses .gitignore mechanism, beware that these patterns do
not behave exactly like pathspecs (patterns without slashes match
every directory, for example)

I tried these commands

  time git log --stat >/dev/null
  time git log --stat --exclude=3DDocumentation >/dev/null

The former took 37 secs, the latter 40 secs. Not bad, but there is
definitely room for improvement. skip_excludes() should be able to
point out whether an entire directory is excluded and skip the whole
directory (as opposed to descending in and checking files one by one
now, in fear of negative patterns). These kinds of optimizations
benefit sparse checkout too.

I think I made a mistake somewhere because the above command seems to
remove more commits than it should... Regardless,
"git log --exclude=3Dpo" on gnome-shell looks sooo clean.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  diff-no-index: rename read_directory to avoid conflict from dir.h
  tree-diff: teach it to understand exclude patterns
  log: add --exclude option

 diff-no-index.c |    6 ++--
 diff.h          |   11 ++++++++++
 revision.c      |    7 ++++-
 revision.h      |    2 +
 tree-diff.c     |   58 +++++++++++++++++++++++++++++++++++++++++++++++=
++++---
 5 files changed, 75 insertions(+), 9 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
