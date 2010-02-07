From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Using =?utf-8?Q?=E2=80=98git_replace?=
	=?utf-8?B?4oCZ?= to replace blobs
Date: Sat, 6 Feb 2010 19:10:56 -0600
Message-ID: <20100207011056.GA15307@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 02:15:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdvkL-0001b0-D3
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 02:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196Ab0BGBLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 20:11:04 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:52614 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0BGBLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 20:11:03 -0500
Received: by iwn27 with SMTP id 27so860814iwn.5
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 17:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=+JhCNhYUmduZhKFxfx5LVvunjeiF69ZSP68RlCDgX4s=;
        b=xyf2l41DUHBe73977Z1vftDdCh62Ydm0jSgtsfvP4noSBs+bE+3oVlmu6lfJC6e15f
         oAQMvckT1oToF2+Z58Vqp9tst3a4L77cInCyyd0tTwH/wF0eu/RtqGSzirl8bzT2LADB
         SLd/pPa/x8eZGsNk95htEiLkLAsd1/QJRllSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=wmCn/NHj7C+7EDSlrR3W1450rC3ScGAJcLAMiImCprGdFXYR/Mawu3ftV0SIJCW0Ew
         1MeHlRJnAbjCgzgw8s7Vvo/ywJ6yfM9DoXfy4MysXB6XtHFlPALYcQYTrC9y2bhIctNz
         mi/d9to460Kzh/uw6VNWGAtT2zmNocX32oJWM=
Received: by 10.231.146.8 with SMTP id f8mr3246938ibv.58.1265505060119;
        Sat, 06 Feb 2010 17:11:00 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2694614iwn.7.2010.02.06.17.10.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 17:10:59 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139204>

I think it is a known problem that =E2=80=98git replace=E2=80=99 cannot=
 be used safely
to replace blobs used in the currently checked out commit.  The man
page says:

	Comparing blobs or trees that have been replaced with
	those that replace them will not work properly.

Indeed, in practice it produces problems. [1]

I would like to start to fix this.  But the correct semantics are not
obvious to me:

 - When writing a tree from an index that includes replaced blobs,
   should the result use the original blobs or the replaced ones?

 - When reading a tree that includes replaced blobs, should the
   resulting cache entries use the original blobs or the replaced
   ones?

My hunch is to say both should use the replaced blobs.  This way,
replacing a blob in a checked-out index would behave in a more
intuitive way, and git filter-branch would make permanent any
substitutions requested through replaced blob entries.

I have not thought it through completely, though.

Thoughts?
Jonathan

[1] For example,

 git init repo
 cd repo
 echo first > 1.txt
 echo second > 2.txt
 git add 1.txt 2.txt
 git commit -m demonstration
 git show --raw
 git ls-tree HEAD | awk '
	NR =3D=3D 1 { first =3D $3 }
	NR =3D=3D 2 { system("git replace " first " " $3) }
 '
 git status
 rm *
 git checkout -f
 git status

which one would expect to result in a clean tree, produces

 Initialized empty Git repository in /tmp/repo/.git/
 [master (root-commit) 998cc27] demonstration
  2 files changed, 2 insertions(+), 0 deletions(-)
  create mode 100644 1.txt
  create mode 100644 2.txt
 commit 998cc270986f68450f00bda5e5db62f31367ff96
 Author: Jonathan Nieder <jrnieder@gmail.com>
 Date:   Sat Feb 6 18:48:50 2010 -0600

     demonstration

 :000000 100644 0000000... 9c59e24... A  1.txt
 :000000 100644 0000000... e019be0... A  2.txt
 # On branch master
 nothing to commit (working directory clean)
 # On branch master
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working
 #   directory)
 #
 #       modified:   1.txt
 #
 no changes added to commit (use "git add" and/or "git commit -a")
