Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B712A207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 23:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951344AbdDYXjT (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 19:39:19 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33352 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1950866AbdDYXjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 19:39:17 -0400
Received: by mail-vk0-f53.google.com with SMTP id j127so63310484vkh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saltstack-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=uqkEinAwKaHKj8R90rviZiJwExkcymuQYwtwnxUP850=;
        b=ITdm5toq+Fnr1res0MmyY2AHejZv5jmULZF+irwn1ouV3cIll8vdqXkwNy3w9zojJg
         9Vz/c4Yb+nt/sLwzoj519pdyhF4WEyFlNc78A3ar2+QJLwDc74hd3k1v9pI1K0fHVjq+
         uWqbEzpWQ4xucWl9DsUaL8wqi01J7ACqQvCzYnUMtKQtIzjkswgfMivgleVUg1ux+4Th
         O3J2jHEzEx8CoqlTrXnmpkKoKufroKHlrZmq7wE4GAYzZKFjI6HW1+ubeL4qxYOJCl5q
         gDuq+jRzKSGDJNYL3vpDJUP6yc352ks7o3Ht/0czioicrQZCUsoo0QH5gMiC5UW4oWw4
         DqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uqkEinAwKaHKj8R90rviZiJwExkcymuQYwtwnxUP850=;
        b=gt9n26ZtluuP55LSi87z91WTnOJwM5bJcla/KIk7zzhgX+eRgO6tpfuF8J12UF4a9e
         UUZeSlQ3j3k15rfvrLJI0VvFWYyFlWrS52+OP9cIhjfN8Sh6alEcerDIg161wDkP7ojr
         Pvt/oZ25ghOBjcn4aes7RlW2cudVycNhL9l+6q9+aJ5YpybN/lOT074WA7uEpCQUSjBH
         fDaXm2fNBKlI9Al4Fa/gQxett4FSojVxdtUNvVkimzhxY9A4N0LIFccbXxSDBLwayYiK
         +WnhSXkcPZ6NTIOCGNwMr52Bx49IfN6WJdFclrBp8j3+XffAxoWQkm5hF6UBVBDcVGAM
         eexA==
X-Gm-Message-State: AN3rC/4xFUROfi2hcjWknTTlYFMoFL03YeyfiG2cnKb/klTI7HvupGei
        BNuMq4E3XUP85SMbM0NUw8NDrpi1m/6rUg8=
X-Received: by 10.31.136.145 with SMTP id k139mr1597264vkd.51.1493163556657;
 Tue, 25 Apr 2017 16:39:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.72.151 with HTTP; Tue, 25 Apr 2017 16:39:16 -0700 (PDT)
From:   Daniel Wallace <dwallace@saltstack.com>
Date:   Tue, 25 Apr 2017 17:39:16 -0600
Message-ID: <CAA2+9hC4d0+igaSV6ziC55=KZGYrZN2A+8-Enhm0F4hExH3m_Q@mail.gmail.com>
Subject: Possible regression in git-http-backend
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am not sure if this is a regression or not, but I wanted to get feedback.

It looks like this commit changed some behavior in git-http-backend

https://git.kernel.org/pub/scm/git/git.git/commit/?id=6bc0cb5176a5e42ca4a74e3558e8f0790ed09bb1

The change that it has made is that it no git-upload-pack hangs when
uwsgi doesn't close stdin.

http://lists.unbit.it/pipermail/uwsgi/2016-April/008440.html

This was the only place I could find this discussed online for uwsgi
(but I did find several blog posts comments mentioning the issue).  It
looks like it was worked around in uwsgi >= 2.0.13 by adding the
setting `cgi-close-stdin-on-eof = true`.  But there was some
discussion last year that this shouldn't be needed based on the RFC
for cgi?

http://lists.unbit.it/pipermail/uwsgi/2016-May/008462.html
http://web.archive.org/web/20100212094332/http://hoohoo.ncsa.illinois.edu/cgi/in.html

"""
The server will send CONTENT_LENGTH bytes on this file descriptor.
Remember that it will give the CONTENT_TYPE of the data as well. The
server is in no way obligated to send end-of-file after the script reads
CONTENT_LENGTH bytes.
"""

Here is a gist for providing a config setup, I used the latest nginx
from the nginx repo for centos 7 and uwsgi 2.0.14 from epel.  The
setup requires starting nginx.service and uwsgi.service and creating a
bare repo in /srv/git/ and running

https://gist.github.com/gtmanfred/8b2e26b07db3c75094d0607048b2c828

Thanks,
Daniel
