From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] Rewriting git-repack in C
Date: Tue, 13 Aug 2013 21:23:16 +0200
Message-ID: <1376421797-26443-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com,
	apelisse@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 13 21:23:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9KBm-0008P8-I1
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 21:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757984Ab3HMTX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 15:23:26 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:46901 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554Ab3HMTXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 15:23:25 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so4343514eaj.39
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/mARaEunWT+bsNagcn0hisMWPIjVHy0VmX+R6+KoPsA=;
        b=W/GylCm3VvXToGTF9lPxng+M0+pQM95LCFLDhsVOCSvyyPwgxcseAnBv20ZAxaU5ks
         1k52UEeZzUJQ5b1WgvtThBRcJKSR7O73b10gQMPJvZsmwNeB5Aok5hXWQ1tzPda3siox
         tKNkyySIomsuBRINksKubtn+8BU2acTLDalilvxz85ishivltqHMo1bs4h9L/osPU5ei
         JhcnzERswL0SVW5GhOcoPGZknf0blW7JfFLS5q3vKn35nzoaqbTv7yRYDz7pejmZKyAp
         H3uqx7Rb0W/L1kffPl30YAJSegMzEVI5FEya3hWcT3/Ic8h8kTJkaeItDCmnXZIyVgq2
         Q1cg==
X-Received: by 10.14.115.133 with SMTP id e5mr8616183eeh.27.1376421803804;
        Tue, 13 Aug 2013 12:23:23 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id d8sm55512071eeh.8.2013.08.13.12.23.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Aug 2013 12:23:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232246>

Hello,

a few days ago, I asked how I would proceed if I'd want to rewrite git-repack.
The general consensus (Duy, Junio and Matthieu) was to not touch
git-pack-objects, but rather translate the shell version of the git-repack
to C.
I'll send a very rough patch, which still contains 2 todos, so it is not yet
feature complete. I was using the run_command api and the string-list api
a lot.
The following patch is definitle not recommended for a fine review, but
I'd still ask for feedback, whether this seems like the right approach.

Also I'd like to propose a small technical change:
I found no easy way to get a subset of files in a specific directory,
which is very easy in the shell version via * (rm file/in/dir/startswithprefix-*),
So maybe instead of just prefixing the temporary files such as:
$PACKDIR/.tmp-$PID-pack-*
we could put all the temporary files in a temporary directory.
This would come handy as there already exists functions to manipulate 
a directory recursively (such as remove_dir_recursively)

That patch requires the patches of jc/parseopt-command-modes

Stefan

Stefan Beller (1):
  repack: rewrite the shell script in C.

 Makefile                       |   2 +-
 builtin.h                      |   1 +
 builtin/repack.c               | 313 +++++++++++++++++++++++++++++++++++++++++
 contrib/examples/git-repack.sh | 194 +++++++++++++++++++++++++
 git-repack.sh                  | 194 -------------------------
 git.c                          |   1 +
 6 files changed, 510 insertions(+), 195 deletions(-)
 create mode 100644 builtin/repack.c
 create mode 100755 contrib/examples/git-repack.sh
 delete mode 100755 git-repack.sh

-- 
1.8.4.rc2
