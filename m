From: Ondrej Certik <ondrej@certik.cz>
Subject: git am can't import patches with the UTF8 BOM
Date: Thu, 15 Oct 2009 10:51:48 -0700
Message-ID: <85b5c3130910151051h799770b9yd0e56472125426cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 19:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyUaE-0002op-K1
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 19:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933160AbZJORw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 13:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933062AbZJORw0
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 13:52:26 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:55513 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbZJORwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 13:52:25 -0400
Received: by ywh6 with SMTP id 6so1071375ywh.4
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=D9rHRwq7l9SapOS6lkkKvULGoUELlzDXjZnQ9X91xfk=;
        b=pqMtNyEpqsLuQDrycKhqI9QTN7vj8/MQUBAdvZAS4xO+HDjHbDuX7IJsXUkrPMk7mU
         M1Lkouxb1fOSt+NwZmjETK36s9MV/exxH4EwJWDvBhiUydP+FKOP1VOY5hOFfnUL/pOb
         exQfyksC1adJnNyl16gRhNLHUYtbO0vfwGx7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=UClvekIZ/H88br8uZW4SHp+lDg5+EO0sSCqPskVtGyvff6tfcnhlNUBmiqDICT6QKO
         4/Bw5PlSh2YX+RFyXSh29iZFsbj2sQ3sp7B/N7srPjLKxbt0tIkWkx/NXYJN2I5Gcb6X
         KuYjYXwmuceLqnHUbJQ/AN5Jsf0OuosDDevG0=
Received: by 10.91.55.14 with SMTP id h14mr408767agk.67.1255629108379; Thu, 15 
	Oct 2009 10:51:48 -0700 (PDT)
X-Google-Sender-Auth: bb9f182984b0595f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130408>

Hi,

this happens to me very often when someone sends a patch using windows
(and I use linux):

$ git am ~/Desktop/0001-1664-nonsymbolic-systems-may-need-basis-recalculatio.patch
Patch format detection failed.

and the problem is that the patch contains the byte-order mark (BOM)
at the beginning:

$ hexdump -C ~/Desktop/0001-1664-nonsymbolic-systems-may-need-basis-recalculatio.patch
| less
00000000  ef bb bf 46 72 6f 6d 20  39 31 37 63 30 39 36 32  |...From 917c0962|
00000010  32 38 35 30 37 37 31 66  38 33 33 62 35 66 39 34  |2850771f833b5f94|
00000020  30 36 65 30 64 65 37 33  30 35 61 34 30 38 66 65  |06e0de7305a408fe|
00000030  20 4d 6f 6e 20 53 65 70  20 31 37 20 30 30 3a 30  | Mon Sep 17 00:0|
00000040  30 3a 30 30 20 32 30 30  31 0a 46 72 6f 6d 3a 20  |0:00 2001.From: |

e.g. it's the "ef bb bf" as can be checked on the wikipedia:

http://en.wikipedia.org/wiki/Byte-order_mark#Representations_of_byte_order_marks_by_encoding

for utf-8.

So either the windows version of git should not send the BOM in the
first place, or the linux version of git should be able to handle it.
Which of those should be fixed?

Thanks,
Ondrej

P.S. I currently use this simple python script to strip it:

------------------------
#!/usr/bin/python
"""
Fixes a bogus git patch.

Sometimes a patch that people submit to sympy contains the UTF-8 byte-order
mark (BOM), which are 3 character at the beginning, that cause "git am" to fail
when applying it. The solution is to remove them, which is the purpose of this
script. See this link for more info:

http://en.wikipedia.org/wiki/Byte-order_mark

Usage:

  git-fix-patch some.patch > some_fixed.patch

you can also rewrite the original file with the fix (inplace) by:

  git-fix-patch -s some.patch

"""

from textwrap import fill
import os
import re
from optparse import OptionParser

def main():
    parser = OptionParser(usage="[options] args")
    parser.add_option("-s", "--save", dest="save", action="store_true",
            default=False,
            help="Rewrite the original file with the fixed patch")
    options, args = parser.parse_args()
    if len(args) != 1:
        parser.print_help()
        return

    filename = args[0]
    s = open(filename).read()
    start = s.find("From")
    if start > 10:
        raise Exception("Uknown format of the git patch")

    # strip the bogus characters at the beginning of the file
    s = s[start:]

    # either save to a file or dump to stdout:
    if options.save:
        outfile = filename
        open(outfile, "w").write(s)
    else:
        print s

if __name__ == '__main__':
    main()
-----------------------
