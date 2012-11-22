From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: [PATCH] Completion must sort before using uniq
Date: Wed, 21 Nov 2012 23:16:09 -0500
Message-ID: <CAFj1UpF2wh0imcqW7Ez_J14R_07a_A1-YWESaGrHRNa7Nsv-xg@mail.gmail.com>
References: <1353557598-4820-1-git-send-email-marc.khouzam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 20:47:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbckS-0007a4-A9
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931Ab2KVTrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:47:24 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62390 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab2KVTrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:47:21 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2443963iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fegw3iZFk1noFsx/Uq6leM+ofht67KNA1kM2CNG8VCA=;
        b=a4uUwFfS1siaR5Rm1RIFJaPMSW2svBQ+vyMsKIViL9ScrzrGVWfke+ivMhN18L0Nnc
         v44pqCtEJ2y1u25YbvzR5PhoJuOZq6oBTcKUDFQB7x/2EQHtmK0DxcbVAZCUo7mNdSoc
         JfK4H2AHa4bi9K/iZ/DcxWK1Jaxzb7H3a8ZKrP4vxddkIjw8q66YPjnvwYBUNvrfdC33
         FiaAqzPpRKJSoWfU2M0qQJZsHX/JoPVfHHrpndcGJvgRJB61JPewjhYroukOMFl81Sbv
         zAylL4sMAjvPgysTkq0Qmr0TDQ70N9QphZ5IkLXb4dZsd0/0z2KmWHhbsuj2m0bOr8pl
         wZwg==
Received: by 10.50.33.232 with SMTP id u8mr1819174igi.39.1353557769694; Wed,
 21 Nov 2012 20:16:09 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Wed, 21 Nov 2012 20:16:09 -0800 (PST)
In-Reply-To: <1353557598-4820-1-git-send-email-marc.khouzam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210202>

The uniq program only works with sorted input.  The man page states
"uniq prints the unique lines in a sorted file".

When __git_refs use the guess heuristic employed by checkout for
tracking branches it wants to consider remote branches but only if
the branch name is unique.  To do that, it calls 'uniq -u'.  However
the input given to 'uniq -u' is not sorted.

For example if all available branches are:
  master
  remotes/GitHub/maint
  remotes/GitHub/master
  remotes/origin/maint
  remotes/origin/master

When performing completion on 'git checkout ma' the choices given are
  maint
  master
but when performing completion on 'git checkout mai', no choices
appear, which is obviously contradictory.

The reason is that, when dealing with 'git checkout ma',
"__git_refs '' 1" will find the following list:
  master
  maint
  master
  maint
  master
which, when passed to 'uniq -u' will remain the same.
But when dealing with 'git checkout mai', the list will be:
  maint
  maint
which happens to be sorted and will be emptied by 'uniq -u'.

The solution is to first call 'sort' and then 'uniq -u'.

Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
---

I ran into this by fluke when testing the tcsh completion.

Thanks for considering the fix.

Marc

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index bc0657a..85ae419 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -321,7 +321,7 @@ __git_refs ()
                                if [[ "$ref" == "$cur"* ]]; then
                                        echo "$ref"
                                fi
-                       done | uniq -u
+                       done | sort | uniq -u
                fi
                return
        fi
--
1.8.0.1.g9fe2839
