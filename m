From: "Ondrej Certik" <ondrej@certik.cz>
Subject: importing mercurial patch
Date: Tue, 11 Nov 2008 11:58:33 +0100
Message-ID: <85b5c3130811110258h53d389co97a3c33e10667ae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 11 12:00:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzqyi-0007qq-Eu
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 12:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbYKKK6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 05:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755946AbYKKK6g
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 05:58:36 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:51838 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945AbYKKK6f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 05:58:35 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3808591fkq.5
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 02:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=VESxAQjbZkUvCdjD0kyxQKfx53UogxIYfxSZKmw387I=;
        b=lD6n8GA7RhsK2Mb8wUa5SImkCDYg6l1yIBnTqshObByvMOQGYuGZGcPjkNRp6ZB6E6
         2ITMBYlK07xWAlcG99ruuMj77zWbgFbKoeH8dkCfU+KOmPB0LpMyCEezIWZo37OpWFSa
         IAxmNKP9VvqLnvip8PqRcFO1WpvL8nPBtmyYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=oZTZ0gZ32mL0xorqPFp/DIxsvYSLOiJK+6Cvf3AXFVNFI1UN9eVuyN2yigszh0RGxc
         W9JRPuRmeIerRk7YAEHzy3wM+lleFY3LMRTKPNEt4CN2lngTrXtKgrAbhvmCqYB5YtS3
         W+g/04ICFKCqIMEQTaZPbBPkkSnGFbNv8XQQk=
Received: by 10.181.238.16 with SMTP id p16mr2460386bkr.115.1226401113201;
        Tue, 11 Nov 2008 02:58:33 -0800 (PST)
Received: by 10.86.99.20 with HTTP; Tue, 11 Nov 2008 02:58:33 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 01c45326b845b52c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100636>

Hi,

I'd like git to be able to import mercurial-exported patches. This
short Python program does it:


-------------------------------------
#! /usr/bin/python

import os
import sys
import re
import tempfile

def run(cmd):
    print cmd
    os.system(cmd)

patch = sys.argv[1]
p = open(patch).read()
author = re.search("# User (.+)", p).groups()[0]
p = p.split("\n")
while not p[0].startswith("# Parent"):
    del p[0]
i = 1
while not p[i].startswith("diff -r "):
    i += 1
commit_message = "\n".join(p[1:i])
_, filename = tempfile.mkstemp()
f = open(filename, "w")
f.write(commit_message)
f.close()

run("git apply %s" % patch)
run("git ci -a --author='%s' -F %s" % (author, filename) )
---------------------


How should this be implemented in git? Should I try to extend
"git-am.sh" to handle it?

For better imagination, this is how the patch looks like:

http://paste.debian.net/21210/

Thanks for any feedback,
Ondrej
