From: Paul Campbell <pcampbell@kemitix.net>
Subject: [RFD] subtree status - comparing subtree with a remote
Date: Sat, 23 Feb 2013 00:19:08 +0000
Message-ID: <CALeLG_mF2Fucf=A2Dzn_KFgim8Z3vFpdWR84FYpu5gqKv=S64g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 01:19:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U92q1-0003u5-7t
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 01:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329Ab3BWATM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 19:19:12 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:45137 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117Ab3BWATJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 19:19:09 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc18so1115391obb.36
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 16:19:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=2MCprYQAqUY+9VrW2UPImAAZ4J9UWnBdEPWF5loAg6Q=;
        b=ISQ7OYUEaMtYl1zkKYFwvsu4F6UAEwetFwZ5pFtuzfaSEfrSANzt5+olFpgpFprNql
         wQzijKFd+LXRV/032+3gyV8g2CXyq06Xw130mEB2HYU6WhUt8ytheq1ZLRCS/L1J7gdS
         Et4wMdJ+SQ9m7FRETztqu0UyPqccb4N+H6dPw6JqHnGHRA9P4+xzrNn7X89YhKimOGQR
         rn13ZyeJ5SCr78Snahin2qBzB1/8LjHuatZRfLGM9FzuB6J0VUvOaOKwwZ437Fkbt00w
         eKUpAqGHRmele8pFrQ8BB45K+Zm1h/0/0B2UE124q+wTqehFD1JApXtuZyg+ZZYRgDkB
         ZFDg==
X-Received: by 10.60.172.18 with SMTP id ay18mr1528955oec.126.1361578748378;
 Fri, 22 Feb 2013 16:19:08 -0800 (PST)
Received: by 10.76.13.196 with HTTP; Fri, 22 Feb 2013 16:19:08 -0800 (PST)
X-Originating-IP: [2.102.85.14]
X-Gm-Message-State: ALoCoQmjcbdBjbTlXapQtqRMxLLFRnkXx7RvdbOdoeCOLcu/Th8Yoi2h54AXLztJHH/pxQSZBPBK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216884>

Hi,

I'm looking at adding a "git subtree status" command that will tell if
a subtree is up-to-date, ahead of, behind, divergant with or unrelated
to a remote repo.

I just wanted to check that I'm working this out correctly before
writing the code.

1) perform a synthetic subtree split

  mine=$(git subtree split --prefix=subtree/path)

This outputs the SHA1 for this subtree in isolation to the superproject.

2) fetch latest branch HEAD from remote repository we're comparing with

  git fetch $repo $branch
  theirs=$(git rev-parse FETCH_HEAD)

3) Find common ancestor

  base=$(git merge-base $mine $theirs)

Where:

* $base == $mine && $base == $theirs : up-to-date

* $base == $mine && $base != $theirs : behind remote - can pull

* $base != $mine && $base == $theirs : ahead of remote - can push

* $base != $mine && $base != $theirs : divergent

* $base == null : no common ancestor - wrong repo?

Comments?

-- 
Paul [W] Campbell
