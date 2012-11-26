From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] fast-export: Allow pruned-references in mark file
Date: Mon, 26 Nov 2012 21:04:13 +0100
Message-ID: <CALWbr2x4aia4DcdnmfEEBsZwCYasTEp2Jc0jwJgvsUqWSDaWTQ@mail.gmail.com>
References: <1353750432-17373-1-git-send-email-apelisse@gmail.com>
	<7vd2z1xb6c.fsf@alter.siamese.dyndns.org>
	<CAMP44s0iSkqcOW0YsD=Jm_=x1tuoRbFQ+EbVvkROa_yY2-WFcA@mail.gmail.com>
	<CALWbr2yZpAT=eSahGcGKw5weoz1MjTzbb16pdQndKDFcn_3VJg@mail.gmail.com>
	<7vhaoctg6i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:04:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td4us-0007tI-C1
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab2KZUEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:04:16 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53332 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab2KZUEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 15:04:14 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so3196169qad.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 12:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tlQ0MnZ1PyrTlOjGbM0vkkZ6CrEqZxUkJFNDBUKwu14=;
        b=X/jDatssaIDiKC1sbUl7T1qqaQ9doqent1emPKjuxDeCNoHNfg0HX1uKVRM4U5NV6o
         mjNO93N/OINKOK5kWhZy8T+XFOq9IRAnJfb33vweB7HzMYhlLsxMWcORGBr/O/oGv/sc
         IJOF1fhyXfiaxwofea+j5MiKS6Tcg2CDMcvcVRN1PXHWXvFdsBj0nGh2QoPjbgBz6gwF
         6HjXCl2ls8X5JRV9mVCIJQkAmbULiXM13cKAuuq+IBNyK/Kxq4VoHDyaQ83g+GDFZf93
         yuUvN+dJtov1sBoPtk4Ecbsw4KU0DkgTzIXsWZMihjcpQnuY1ERib6ggvVIIYG/tpvBI
         vNag==
Received: by 10.49.105.73 with SMTP id gk9mr15310970qeb.40.1353960254009; Mon,
 26 Nov 2012 12:04:14 -0800 (PST)
Received: by 10.49.121.36 with HTTP; Mon, 26 Nov 2012 12:04:13 -0800 (PST)
In-Reply-To: <7vhaoctg6i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210476>

> I am not sure I follow the above, but anyway, I think the patch does
> is safe because (1) future "fast-export" will not refer to these
> pruned objects in its output (we have decided that these pruned
> objects are not used anywhere in the history so nobody will refer to
> them) and (2) we still need to increment the id number so that later
> objects in the marks file get assigned the same id number as they
> were assigned originally (otherwise we will not name these objects
> consistently when we later talk about them).

I fully agree on (1), not so much on (2) though.

I have the following behavior using my patch and running that script
that doesn't look correct.

echo "Working scenario"
git init test &&
(cd test &&
git commit --allow-empty -m "Commit mark :1" &&
git commit --allow-empty -m "Commit mark :2" &&
git fast-export --export-marks=MARKS master > /dev/null &&
cat MARKS &&
git reset HEAD~1 &&
sleep 1 &&
git reflog expire --all --expire=now &&
git prune --expire=now &&
git commit --allow-empty -m "Commit mark :3" &&
git fast-export --import-marks=MARKS \
  --export-marks=MARKS master > /dev/null &&
cat MARKS) &&
rm -rf test

echo "Non-working scenario"
git init test &&
(cd test &&
git commit --allow-empty -m "Commit mark :1" &&
git commit --allow-empty -m "Commit mark :2" &&
git fast-export --export-marks=MARKS master > /dev/null &&
cat MARKS &&
git reset HEAD~1 &&
sleep 1 &&
git reflog expire --all --expire=now &&
git prune --expire=now &&
git fast-export --import-marks=MARKS \
  --export-marks=MARKS master > /dev/null &&
git commit --allow-empty -m "Commit mark :3" &&
git fast-export --import-marks=MARKS \
  --export-marks=MARKS master > /dev/null &&
cat MARKS) &&
rm -rf test

outputs something like this:
Working scenario
Initialized empty Git repository in /home/antoine/test/.git/
[master (root-commit) 6cf350d] Commit mark :1
[master 8f97f85] Commit mark :2
:1 6cf350d7ecb3dc6573b00f839a6a51625ed28966
:2 8f97f85e1e7badf6a3daf411cf8d1133b00d522e
[master 21cadfd] Commit mark :3
warning: Could not read blob 8f97f85e1e7badf6a3daf411cf8d1133b00d522e
:1 6cf350d7ecb3dc6573b00f839a6a51625ed28966
:3 21cadfd87d90c05ce8770c968e5ed3d072ead4ae
Non-working scenario
Initialized empty Git repository in /home/antoine/test/.git/
[master (root-commit) 5b5f7ec] Commit mark :1
[master b224390] Commit mark :2
:2 b224390daee199644495c15503882eb84df07df5
:1 5b5f7ec77768393aab2a0c2c11b4b8f7773f8678
warning: Could not read blob b224390daee199644495c15503882eb84df07df5
[master 181a774] Commit mark :3
:1 5b5f7ec77768393aab2a0c2c11b4b8f7773f8678
:2 181a7744c6d3428edb01a1adc9df247e9620be5f

Both "commit mark :2" and "commit mark :3" end up being marked :2.
Any tool like git-remote-hg that is using a mapping from mark <-> hg changeset
could then fail.
