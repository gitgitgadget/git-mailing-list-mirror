From: Charlie Dyson <charlie@charliedyson.net>
Subject: git-submodule.sh respects submodule.$name.update in .git/config but
 not .gitmodules
Date: Fri, 6 Dec 2013 15:48:46 +0000
Message-ID: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 06 16:48:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voxe9-0002ia-TO
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 16:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767Ab3LFPsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 10:48:50 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:61804 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab3LFPss (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 10:48:48 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so1279128pbc.35
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=WhY+Ba1evq07eEs3SEGtwMBD7WqhldMbXWKhZ73aSWk=;
        b=ziMf73ayBi5ASunAFYn7LtLtKokMLSYj65FKQhdPmjveadD+z814TcOZt/fpYX3wAj
         5Mb769zReoKd4CTh18VRqbVeKEZNSSQvqUo6TCV3CB1Y2OO5V4n4AQycFktVA8hrTfMy
         NEWTy4it0nPY2DnaAbUoQ9iqvC5B1P7MlKcqwnzDyytxVw/IHra/+5eP5prURoGmDyO2
         R6sDuVYj0+S4uy+cUX6wVfIpljKPGafwu0UBRpoc/sqDzlw6jLEaxqMylSPFjVe0VNNJ
         1umG3EmY/zejYQlxW61yVUniKw1H4GSbJh8rFAE6ikaSY65KwN/19wW0OebU1iQgFw1C
         GTtQ==
X-Received: by 10.66.182.199 with SMTP id eg7mr4960367pac.135.1386344926904;
 Fri, 06 Dec 2013 07:48:46 -0800 (PST)
Received: by 10.68.247.161 with HTTP; Fri, 6 Dec 2013 07:48:46 -0800 (PST)
X-Google-Sender-Auth: QlYlJNeaqmbucgMj_Uwb_QkhrBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238932>

gitmodules(5) states that submodule.$name.update should be defined in
.gitmodules. However in cmd_update() in git-submodule.sh, git config
is used with "-f .gitmodules". Consequently this flag is only
respected in .git/config

Tested against: 1.8.2.1 [sorry! I've checked the relevant bit of
source and it's the same]

Steps to reproduce:
$ git init
$ git submodule add -b master someproject
$ git config -f .gitmodules --add submodule.someproject.update merge
$ # Go to someproject and commit something
$ git submodule update --remote

The latter does not perform a merge, and behaviour is visibly
different to adding --merge.

I would submit a patch but I'm not completely sure what the behaviour
would be - simply adding "-f .gitmodules" would hurt users that have
adopted the practice of specifying their update preference in
.git/config.

Perhaps the right thing to do is read from .git/config and fall back
to .gitmodules using get_submodule_config().

Cheers,

Charlie
