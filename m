From: Morten Welinder <mwelinder@gmail.com>
Subject: [PATCH] write_sha1_buffer
Date: Fri, 15 Apr 2005 20:50:06 -0400
Message-ID: <118833cc05041517502fa52a89@mail.gmail.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Apr 16 02:47:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMbSZ-00067x-D2
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 02:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVDPAuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 20:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVDPAuM
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 20:50:12 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:58970 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262495AbVDPAuH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 20:50:07 -0400
Received: by rproxy.gmail.com with SMTP id a41so737039rng
        for <git@vger.kernel.org>; Fri, 15 Apr 2005 17:50:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=a8WrT1OwkqFJCpJPlpu7j58141cWRYNwzpq/vZRYaz8GrEn7kN9aDJl+MpFdCN5Tzkm6rf0in8nupNupaWOOl/rx3IitIc4Ei3WOmFIwCNDuXmuY3eUUnTCx5la8K5vXWPBWEvZA9J6GoIQucjfAWhoTWhHx8aAtC9T22Q4bhwI=
Received: by 10.38.86.53 with SMTP id j53mr3663546rnb;
        Fri, 15 Apr 2005 17:50:06 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Fri, 15 Apr 2005 17:50:06 -0700 (PDT)
To: git@vger.kernel.org, torvalds@osdl.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This write will failing sooner or later when someone's disk fills up. 
That'll leave someone with
a truncated file.

Signed-off-by: Morten Welinder <mwelinder@gmail.com>


--- read-cache.c
+++ read-cache.c        2005-04-15 20:32:52.111187168 -0400
@@ -276,9 +276,13 @@
                                        " This is bad, bad, BAD!\a\n");
                return 0;
        }
-       write(fd, buf, size);
-       close(fd);
-       return 0;
+
+       if (write(fd, buf, size) != size) {
+               close(fd);
+               return error("Failed to write file %s\n", filename);
+       }
+
+       return close(fd);
 }
