From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Recover broken git repository?
Date: Tue, 14 Jul 2009 16:40:08 +0200
Message-ID: <81b0412b0907140740j4fa1e12csc4c3081719f9090f@mail.gmail.com>
References: <1247577632053-3255106.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Breitwieser <florian.bw@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 16:41:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQjBm-0000yy-4l
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 16:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbZGNOkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 10:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbZGNOkQ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 10:40:16 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:37788 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbZGNOkL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 10:40:11 -0400
Received: by fxm18 with SMTP id 18so2855910fxm.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BGv3szF5qNZ6KqqwhbKeWmsDhNNc0QSCtvvz72ZJxRg=;
        b=Z2JT+DYU9M+F496TIN2/7IxNP6L97wCvzmIvmf7+nA6Hj4kbEs0uPTH2mgbo42rAsl
         zFUiGD4pVckOqjp6UfaM/7+5prv27LHp86+FbF/lFfoZ7Gt5Hx9puz6Wk/TW2F50DBBd
         xO2Xe/iIDtmjxahkpQu7qpti52jQQjmFK2zPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tMQl8kObLt1DOny6M2u1SjKd4QQ4mX/+2glJBBDY1I57ZYrPmLG/WIRt7o2QnXyz2J
         Dm9poaao90U5vqHonaOFRf+fWJZl/LWlwLTCfMLHDyMiSh0o4Uy/dbQrrHifco6qbKmF
         0qomAkW82xQDMUEXe1JQN9fYkxtORVNsAP6R4=
Received: by 10.204.120.16 with SMTP id b16mr6531307bkr.64.1247582408211; Tue, 
	14 Jul 2009 07:40:08 -0700 (PDT)
In-Reply-To: <1247577632053-3255106.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123251>

On Tue, Jul 14, 2009 at 15:20, Florian Breitwieser<florian.bw@gmail.com> wrote:
> I have problems with my git repository, attached below are the steps I tried
> to resolve it. But now I am stuck. Is there any good way to recover?

There are recovery instructions all over the web, and on this mailing list.
Try googling for "git repository corruption recovery".
There is even one in Git's repository:

  Documentation/howto/recover-corrupted-blob-object.txt

> $ git commit -m "Some message"
> error: invalid object 1086b1c606a04bcb78b92d1d411a299d20d18034

Looks like you have hit a genuine repository corruption.

You can try to look for the object in all copies of the project (or just in any
projects you possibly have laying around) and copy it into you repo.
To test if the object is present in a repo:

  git cat-file -t 1086b1c606a04bcb78b92d1d411a299d20d18034

You can just copy (or reference in .git/objects/info/alternates) the whole
repo containing the object in the broken repo. You can cleanup unused
objects afterwards.

> fatal: Error building trees

You can try "git log --pretty=raw --raw --no-abbrev HEAD | less" and
look for the first commit which introduced the invalid object. The history
up to this commit must be intact, BTW. Try to find out what object it was.
If it was a file, than maybe you have the original source somewhere,
or the latest version is present and good enough. Then you can checkout
the good commit, introduce the file from the source, commit, and cherry-pick
all the newer commits on top of it.
If it was a tree, you can try to guess what files did it contain in the
commit which references it and try to rebuild it by using git add and
git write-tree (the latter prints the SHA1 of the generated tree on
stdout, so you can retry indefinitely).
If it happens to be a commit (you'll find the SHA1 in parents of
the good commits, but it does not look like it is the case), you can
try git fsck --lost-found to find all the commits which are not
referenced, try connecting them (by using grafts, for example.
Or checkout and cherry-pick described above).

> $ git-fsck --full
> dangling tree c2549a3cdd83098a523cb707f217f4656cde7eb5
>
> $ git prune

Now that was dangerous. When something was unreferenced
(but useful) now it is lost.
