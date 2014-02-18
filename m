From: Christian Jaeger <chrjae@gmail.com>
Subject: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Tue, 18 Feb 2014 07:25:10 +0000
Message-ID: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 08:25:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFf3i-00064a-6c
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 08:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbaBRHZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 02:25:33 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:50159 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbaBRHZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 02:25:33 -0500
Received: by mail-wg0-f50.google.com with SMTP id z12so2930677wgg.17
        for <git@vger.kernel.org>; Mon, 17 Feb 2014 23:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=RJEtIMu3rFHe0CKPdiLiiIH3f+srajI7uWk5BBSO4ks=;
        b=pw570B+vGdci5Zujxi6aIhbp0P+VYdsDl+SONCoS6tw5FZ4z1gCCk6MRKMsXFf935D
         49K46qiRVATa0uniMBp02tnApQK2yA1mb5E1d9lZpmfBqFMOdOqzaLtE6Tm/hFU2BxCX
         T/rdPsmEfjzjfowo7RuZ2V1qAW0RMgR6D7JBEAYfrT6+YGsk7w8No6FP1VhDn9c/IhX/
         Dn8WkHvGnO/0HVuJ04qnUTSBLvFY6J1B0y8IlYfghPuJxdVo3ETb3Pfj9dMSeOgqgeb7
         QNx/aRiSfYCwsQGt+J1mQpe6jgjYzzllZYNB4dYeOLj9PlyjWndORKuTlwjBAp6RY50j
         3VXg==
X-Received: by 10.180.107.1 with SMTP id gy1mr16364692wib.47.1392708330781;
 Mon, 17 Feb 2014 23:25:30 -0800 (PST)
Received: by 10.180.101.168 with HTTP; Mon, 17 Feb 2014 23:25:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242277>

Hi

I've got a repository where "git log --raw > _somefile" took a few
seconds in the past, but after an attempt at merging some commits that
were collected in a clone of the same repo that was created about a
year ago, I noticed that this command was now taking 3 minutes 7
seconds. "git gc", "git fsck", "git clone file:///the/repo/.git" also
now each took between ~4-10 minutes, also "git log --raw somefile" got
equally unusably slow. With the help of the people on the IRC, I
tracked it down to my recent use of "git gc --aggressive" in this
repo. Running "git repack -a -d -f" solved it, now it's again taking
4-5 seconds. After running "git gc --aggressive" again for
confirmation, "git log --raw > _somefile" was again slowed down,
although now 'only' to 1 minute 34 seconds; did perhaps my "git remote
add -f other-repo", which I remember was also running rather slowly,
exacerbate the problem (to the > 3 minutes I was seeing)?

The repo has about 6000 commits, about 12'000 files in the current
HEAD, and about 43 MB packed .git contents. The files are (almost) all
plain text, about half of them are about 42 bytes long, the rest up to
about 2 MB although most of them are just around 5-50 KB. Most files
mostly grow at the end. The biggest files (500KB-2MB) are quite
long-lived and don't stop growing, again mostly at the end. Also,
about 2*5K files are each in the same directory, meaning that the tree
objects representing those 2 directories are big but changing only in
a few places.

I've now learned to avoid "git gc --aggressive". Perhaps there are
some other conclusions to be drawn, I don't know.

Christian.
