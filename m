Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66041FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 19:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758952AbcLUTsQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 14:48:16 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34290 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758880AbcLUTsP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 14:48:15 -0500
Received: by mail-pg0-f44.google.com with SMTP id y62so36477683pgy.1
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 11:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netskope.com; s=google;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=v1SPtcnfe+Ic8eLts+VtYGnt4VZQulLXplUuUvv8YK8=;
        b=GpbBqSFMibXiEFr+Q5yXPH4COLQ5zlrM1HB2A14F8S2lHBqgy6zTkiJWObKNCMCiKw
         myaqWHcOIqwPmkw/gvJ9uhw5rkTojFNgCSW+v7XNWLWDCqhm3BiYj/iQDP0VlrC/ia9x
         Ig4WhdFl1uQPGLtan6HcvkfTp9UsVaOfK+EYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=v1SPtcnfe+Ic8eLts+VtYGnt4VZQulLXplUuUvv8YK8=;
        b=eFe6cGwHRt9GqOLO0h1h5TpnxyhequwKcWfkBxETI/uxuZBuWGr1Um7P4McefP2l7h
         w00wIbBF/pPu/Vlph8zjFHGV6ZgE0toKCong32tYJuBcdwlrorR+/5G0bBJfFgE/rUUG
         K9nFqGUaF+4ZGKqSTrI0rJLIM/8fSMYf4PpQwxfAUPD5Dmd9iRZvqnOrnIzIANJXTj4U
         gUCsH9beACW6CoXcyLsMo7bn2eufiG20Oj9ydTdTw2rXuk9p/gciPEkXhZFBDSJZu4e2
         WdRIbKtExTtA+/ti5rXqW9WN38tx2ZrsUSyp6LV4NJxOyg2nFUPV2KcJGr8LMmkJRLfq
         OgVw==
X-Gm-Message-State: AIkVDXJQUXq0FKzjXSYd66xvEw1a78S6B2PplnUpTjwteXymQjhKfI2D9fRkCHSJaFXGQkGq
X-Received: by 10.84.198.129 with SMTP id p1mr12025660pld.14.1482349678478;
        Wed, 21 Dec 2016 11:47:58 -0800 (PST)
Received: from [192.168.65.161] (162.253.183.182.static.etheric.net. [162.253.183.182])
        by smtp.gmail.com with ESMTPSA id y20sm48864049pfj.26.2016.12.21.11.47.57
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Dec 2016 11:47:58 -0800 (PST)
From:   Kai Zhang <kai@netskope.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Bug report: Git pull hang occasionally
Message-Id: <9B7DCFB3-73A4-40DE-8FC6-867C5016EF95@netskope.com>
Date:   Wed, 21 Dec 2016 11:47:56 -0800
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Issue: Git pull hang occasionally, and when git pull start hanging, need =
manually "kill -9" to stop hanging

Environment:
Server side:
Git version: 2.11.0
OS: ubuntu 12.04
Nginx: 1.9.7.4
fcgiwrap: 1.1.0
Git repo: None bare, small size (less than 5 MB including .git folder), =
small file number (less than 100 files)

Nginx config for git:

    location ~* /git(\/.*) {
        root /var/git;
        fastcgi_buffers 256 8k;
        fastcgi_param SCRIPT_FILENAME   =
/usr/lib/git-core/git-http-backend;
        fastcgi_param GIT_HTTP_EXPORT_ALL       true;
        fastcgi_param GIT_PROJECT_ROOT          /var/git;
        fastcgi_param PATH_INFO                 $1;
        fastcgi_pass unix:/var/run/fcgiwrap.socket;
        include         /opt/openresty/nginx/conf/fastcgi_params;
    }

Client side:
Git version: 2.11.0
OS: ubuntu 12.04
All git operations go through http only

End to end work flow:
Keep committing small files to non-bare git repo on server side (twice =
per second), message will be sent to client side for every update, once =
client receives message, do git pull

Hanging frequency:
Around 4 times a day

Hanging command stack:
root     32640 23228  0 20:51 ?        00:00:00 git pull -v remote_name =
master --allow-unrelated-histories
root     32641 32640  0 20:51 ?        00:00:00 git fetch =
--update-head-ok -v remote_name master
root     32642 32641  0 20:51 ?        00:00:00 git-remote-http =
remote_name http://server:80/git/repo_name/.git
root     32651 32642  0 20:51 ?        00:00:00 git fetch-pack =
--stateless-rpc --stdin --lock-pack --thin --no-progress =
http://server:80/git/repo_name/.git/

Access log for hanging git pull:
10.1.0.10 - - [20/Dec/2016:20:38:10 +0000] "GET =
/git/repo_name/.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 200 =
363 "-" "git/2.11.0" "-"
10.1.0.10 - - [20/Dec/2016:20:38:10 +0000] "POST =
/git/repo_name/.git/git-upload-pack HTTP/1.1" 200 5 "-" "git/2.11.0" "-"

Error log for hanging git pull:
2016/12/20 20:38:10 [error] 9957#0: *687703 FastCGI sent in stderr: =
"fatal: 'HEAD' is a symref but it is not?" while reading response header =
from upstream, client: 10.1.0.11, server: server, request: "POST =
/git/repo_name/.git/git-upload-pack HTTP/1.1", upstream: =
"fastcgi://unix:/var/run/fcgiwrap.socket:", host: "server"


Some observation:
1. When hanging happen, same repository could be cloned or pulled by =
another process on the same client.
2. After killing hanging git pull, during retry,  same repository can be =
sync up successfully.
3. Git pull has been executed twice per second. But hanging only happens =
around 4 times a day.
4. When "fatal: 'HEAD' is a symref but it is not?" happen for POST on =
server side, client side always start to hang. And when hanging happen =
on client side, this log for POST always appears. But, if  "fatal: =
'HEAD' is a symref but it is not?" happen for GET request on server =
side, client side never hang. For example:=20

2016/12/20 20:36:53 [error] 9954#0: *685174 FastCGI sent in stderr: =
"fatal: 'HEAD' is a symref but it is not?" while reading response header =
from upstream, client: 10.1.0.11, server: server, request: "GET =
/git/repo_name/.git/info/refs?service=3Dgit-upload-pack HTTP/1.1", =
upstream: "fastcgi://unix:/var/run/fcgiwrap.socket:", host: "server"

will not trigger hanging on client side. And this log "fatal: 'HEAD' is =
a symref but it is not?" is happening very rare (less than 10 times a =
day).


It seems a error handling issue on client side. Any help or pointer on =
where to look will be appreciated.

Regards
Kai

PS. I am not subscribed to the mailing list, please keep me in Cc


