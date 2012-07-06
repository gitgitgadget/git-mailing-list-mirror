From: Ilya Ruprecht <ilya.ruprecht@googlemail.com>
Subject: git clone fails "with error: RPC failed; result=22, HTTP code = 401
Date: Fri, 6 Jul 2012 14:04:10 +0200
Message-ID: <CAEpEX_7xrGR+Uk5601iKKPr0uQDkT2sQ4ziPVmqCASYy51hBCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 14:04:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn7Gj-0006x2-Ck
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 14:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339Ab2GFMEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 08:04:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59925 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030330Ab2GFMEL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 08:04:11 -0400
Received: by obbuo13 with SMTP id uo13so15011703obb.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LLAuTRhaVcvj7uBPPBE3BJeR1GG4cxcQ/k+1wdkmu4Q=;
        b=Sa3E8HZskC5XY4E53EVDLUPDL0PgAYJ9SsOEfXwX/BnDxdnvEHr8RcgdKMGi8vZV1S
         WryiCM+i7NyFIaf/06a0xa06ou+HlzvzwB2Si1UBDk7OA/tYZsXBh6O/h/0Z87PfmRMj
         5CE0K3+cBvqIVIAvQSk9t7j9YWC6GRyjZS4WC5I2f1wb6TI1Ariekl93brtw5R6+KnmZ
         XrrGeClSq2qz06dyx/zHDPc4INm9NPEImIoVKJN+eByx+Eh2RCWcZKpDRUxIMT2iVqM3
         SAo00UErDPRoQ8Aem226VR8prlRWNcV/tTM1GRAjd5s+iiR5Ous/Q6Z6M3e22mmRpQb+
         iPUg==
Received: by 10.182.16.70 with SMTP id e6mr25672305obd.24.1341576250655; Fri,
 06 Jul 2012 05:04:10 -0700 (PDT)
Received: by 10.76.83.229 with HTTP; Fri, 6 Jul 2012 05:04:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201110>

Hi all,

following enviroment:

stock debian squeeze + apache2 + gitweb.
Apache handles user authentication over ldap.


the apache git-related config is:


---
(taken from the
http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html)

[...]
SetEnv GIT_PROJECT_ROOT /mnt/system/git

AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$
/mnt/system/git/$1
AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$
/mnt/system/git/$1
ScriptAliasMatch \
        "(?x)^/git/(.*/(HEAD | \
                        info/refs | \
                        objects/info/[^/]+ | \
                        git-(upload|receive)-pack))$" \
        /usr/lib/git-core/git-http-backend/$1
ScriptAlias /git/ /usr/lib/cgi-bin/gitweb.cgi/

[...]
        <Location "/git/repo1.git">
                # read access
                <Limit GET>
                        require ldap-group repo.writers
                        require ldap-group repo.readers
                </Limit>

                # write access
                <Limit GET PUT POST DELETE PROPPATCH MKCOL COPY MOVE
LOCK UNLOCK>
                        require ldap-group repo.writers
                </Limit>

        </Location>
----------

The ldap group "repo.writers" has "repo.writer" user in it.
The ldap group "repo.readers" has "repo.reader" user in it.

Using the "repo.writer" User, i can successfully clone the repo / push
into the repo.
The appropriate apache-log entries are:

----------------------------------------------------
10.13.99.59 - - [06/Jul/2012:13:28:57 +0200] "GET
/git/repo1.git/info/refs?service=git-receive-pack HTTP/1.1" 401 2427
"-" "git/1.7.2.5"
10.13.99.59 - repo.writer [06/Jul/2012:13:28:57 +0200] "GET
/git/repo1.git/info/refs?service=git-receive-pack HTTP/1.1" 200 728
"-" "git/1.7.2.5"
10.13.99.59 - repo.writer [06/Jul/2012:13:28:57 +0200] "POST
/git/repo1.git/git-receive-pack HTTP/1.1" 200 754 "-" "git/1.7.2.5"
----------------------------------------------------

But if i try to use the "repo.reader" account to CLONE the repo, then it fails:

output@shell:
----------------------------------------------------
ilya@brick:/tmp $ git clone https://repo.reader@git-host/git/repo1.git
Cloning into repo1...
Password:
error: RPC failed; result=22, HTTP code = 401
fatal: The remote end hung up unexpectedly
ilya@brick:
----------------------------------------------------


output@apache-logs
----------------------------------------------------
10.13.99.59 - - [06/Jul/2012:13:28:13 +0200] "GET
/git/repo1.git/info/refs?service=git-upload-pack HTTP/1.1" 401 2427
"-" "git/1.7.2.5"
10.13.99.59 - repo.reader [06/Jul/2012:13:28:13 +0200] "GET
/git/repo1.git/info/refs?service=git-upload-pack HTTP/1.1" 200 935 "-"
"git/1.7.2.5"
10.13.99.59 - repo.reader [06/Jul/2012:13:28:13 +0200] "POST
/git/repo1.git/git-upload-pack HTTP/1.1" 401 894 "-" "git/1.7.2.5"
----------------------------------------------------

The reason why the cloning fails is pretty clear

1. the repo.reader is trying to "POST /git/repo1.git/git-upload-pack",
2. accordingly the rule "<Limit POST>" for "writers" is matching,
3. apache makes a lookup into LDAP and OF COURSE cannot fint the
"repo.reader"-User in the group "repo.writers"
4. as a result the 401 is replied by apache.

When i put the "repo.reader" user into the "repo.writers"-group, then,
of course, he can clone the repo.
But then he also can push into the repo...


The question is now - why, damn, the git client is trying to post
something on CLONE!??!

And the second question - how do i solve it?


I need the authenticated read / authenticated writes separation.


Thanks in advance!


Ilya
