From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC 0/6] fetch with refspec
Date: Fri, 15 Apr 2016 15:19:03 -0400
Message-ID: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:19:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9HI-0006Qq-2n
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbcDOTTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:19:37 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33472 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbcDOTTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:19:32 -0400
Received: by mail-qk0-f172.google.com with SMTP id n63so29972470qkf.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=F9HEboCJ5TlJk1UxfI3fWussSnKJpIfyA+RW6ipfB6U=;
        b=dWJl3T1dO33A6YY39CMcTljN3riMEg2Ut+Zf0dK7WU+2Og7t+1gXa7cTZ2xxVXUCas
         Nh2LQqdySXJWAYgiZoTLvfk6+BZwtD5Hb15n0BQ1KRr4VP1d75/OVDs65GMYsS1rIDg+
         sUon5jZ5wrOB6WE3vN9wa5EP5FPFm4p6/cg8oV0bZR3lsIoDoLMnUYhoVLSf489IyRsn
         4Fdz0v/BeyaAD0uu6woXWHhCvU/lx6cDVVWQaKbQG82NuXdap4hpO3cpIJ56mw18L5nq
         KqYF4zm4w9Ldj7MAmGMVdPwASSvHhXNaOezuw0WoA6Bcs2HAiXnMLr3SkIyyJYbQVhZt
         ejkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F9HEboCJ5TlJk1UxfI3fWussSnKJpIfyA+RW6ipfB6U=;
        b=K2d/YJfgoiQvlnG6k3AR5Th++WKTSEOgdOILnq1M7uQNKPysjcxWnqQyDuaDdpNLF1
         M55ZD+jfwvyQypCBoZ2KzkicXl5FRrBmJ1r/33iPXmrBofgR4CxXZzkyfLB4iPyqn+jg
         KdJywnRT6vwgvhBg0em/oKZ3kAKfnl7VhSfirSdJ4p7Bl8vdFktHv51QOmwUgAlnAaHk
         EZ/EH1jZTNZMiu1BqZnLhUrNNtTfxRWSmHbybRE7eC9He42oSNrNIWE30AyINcT/Fcg8
         QOBZqwEUabOnsq8M/Q+fLRvORaT6T2K8Cxm36/iZsbnZGgvcRHyr8n2es7mwLkqRDmKF
         S7xA==
X-Gm-Message-State: AOPr4FXVhpXkjw7nxcvdu/+azOuOeXklE28Hn85HbT2hpjzv8E8rM2ODHLCFbfA4xjuHcA==
X-Received: by 10.55.172.72 with SMTP id v69mr27760466qke.45.1460747971451;
        Fri, 15 Apr 2016 12:19:31 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c2sm21077097qkb.41.2016.04.15.12.19.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2016 12:19:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291640>

We've got a lot of refs, but pretty frequently we only want to fetch
one.  It's silly for the server to send a bunch of refs that the client
is just going to ignore.  Here are some patches that fix that.

Let me know if this seems reasonable.

(and I'll start in on another round of index-helper as soon as this is sent!)

David Turner (6):
  http-backend: use argv_array functions
  remote-curl.c: fix variable shadowing
  http-backend: handle refspec argument
  transport: add refspec list parameters to functions
  fetch: pass refspec to http server
  clone: send refspec for single-branch clones

 Documentation/technical/protocol-capabilities.txt | 23 +++++++
 builtin/clone.c                                   | 16 ++++-
 builtin/fetch.c                                   | 24 ++++++-
 builtin/ls-remote.c                               |  2 +-
 builtin/remote.c                                  |  2 +-
 http-backend.c                                    | 23 +++++--
 remote-curl.c                                     | 25 ++++---
 t/t5552-http-fetch-branch.sh                      | 47 +++++++++++++
 transport-helper.c                                | 44 ++++++++----
 transport.c                                       | 14 ++--
 transport.h                                       |  4 +-
 upload-pack.c                                     | 81 ++++++++++++++++++++++-
 12 files changed, 261 insertions(+), 44 deletions(-)
 create mode 100755 t/t5552-http-fetch-branch.sh

-- 
2.4.2.767.g62658d5-twtrsrc
