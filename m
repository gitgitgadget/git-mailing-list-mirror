From: Ilya Basin <basinilya@gmail.com>
Subject: Re[3]: What can cause empty GIT_AUTHOR_NAME for 'git filter-branch --tree-filter' on Solaris?
Date: Wed, 17 Oct 2012 14:36:23 +0400
Message-ID: <1665262317.20121017143623@gmail.com>
References: <1109432467.20121017104729@gmail.com> <507E5CE0.10002@viscovery.net> <1013956402.20121017125847@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 12:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOQzR-0005kj-W1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 12:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab2JQKga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 06:36:30 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:64090 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201Ab2JQKg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 06:36:29 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so4887236lag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:cc:subject
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=m+adzBHHOglFWqEEPT+l4iS6zjiygxJ3NJhgdJQnZ2c=;
        b=hAUM/qTq7vupZ4jLKCyFQeEwkz+jPNvTWYoo7kTwbl+028wq3xvaVZwK7sPWqUe3kY
         zfgC95aSXLJInmtuRgfF6EeJvYcPpT7Dyacr3HbpJovDBLIaV1I/1M7ipbyxXNo3d+IU
         E6uJqbqf3Jj9tnm08S4H11FefU03/7m3MroJHD2qF51CXtI0xX5zLIac9PEDJYJZkxbH
         RVuwb/WzCABUQQuJ1O+BoEtg4IBJ+V+64WTiRtvzUpdtCPiyMetwDQK3mYQdhn8KoM7+
         fWIoZSBRDdtlq5TrOJvDzUuSb0sAXxdKnridvBoWXOsPh4lO8JhmsywMqol3AzndQPRz
         uVEA==
Received: by 10.152.47.97 with SMTP id c1mr15139683lan.37.1350470188400;
        Wed, 17 Oct 2012 03:36:28 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:6c:7728:c125:e694])
        by mx.google.com with ESMTPS id pz9sm6371516lab.11.2012.10.17.03.36.22
        (version=SSLv3 cipher=OTHER);
        Wed, 17 Oct 2012 03:36:23 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <1013956402.20121017125847@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207908>

JS>> Most likely, your sed has problems with a sed script in function
JS>> get_author_ident_from_commit. I tested it like this:

JS>> $ sh -c '. $(git --exec-path)/git-sh-setup;
JS>>                 get_author_ident_from_commit HEAD'
JS>> GIT_AUTHOR_NAME='Johannes Sixt'
JS>> GIT_AUTHOR_EMAIL='j6t@kdbg.org'
JS>> GIT_AUTHOR_DATE='@1350025129 +0200'

JS>> -- Hannes

IB> Both systems have GNU sed 4.2.1 installed. I wrote a wrapper script wor sed.
IB> It's output attached.
IB> The difference is letter case in sed input data:
IB> Solaris:
IB>   /^AUTHOR /
IB> Windows:
IB>   /^author /

The culprit is bad $PATH :
When git-filter-branch runs, for some reason two new entries precede
/usr/bin in it:
     /tmp/777/.ilya-sparc/bin
     /home/tester/.ilya/opt/SNiFF-3.2.1/bin
     /export/home/testora/app/testora/product/11.2.0/client_32/bin
    +/usr/xpg6/bin
    +/usr/xpg4/bin
     /usr/bin
     /home/tester/apache-ant-1.7.1/bin
     /usr/jdk/instances/jdk1.5.0//bin

And /usr/xpg6/bin/tr fails to make "AUTHOR" lowercase.
