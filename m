From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [BUG] git-check-ignore: Segmentation fault
Date: Tue, 19 Feb 2013 16:24:24 +1100
Message-ID: <CAKJhZwR7AT6VfCZYwaTvWYyjtYWg+RxBSmB5NaJY0LrqMUnD6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Adam Spiers <git@adamspiers.org>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 06:25:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7fhL-00048S-Rc
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 06:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab3BSFY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 00:24:26 -0500
Received: from mail-ia0-f172.google.com ([209.85.210.172]:43118 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab3BSFYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 00:24:25 -0500
Received: by mail-ia0-f172.google.com with SMTP id l29so3685072iag.17
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 21:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=7frEPyD4P6F2X03KN7GoR05dBCc+ZPhZc4q4yJ+vb6I=;
        b=llI5FrvctIqTM+jJKEG9aI3m0Pal+Snm/HnhDb3uss+BxJUuhe0SehuKV3+9xnRcwg
         mqR2LxhatUBYw6bUe/tznckVSjVHpX/0aJ+gVUVLiWMX3KRwAP2mbkWuiKiP0eiTJR0Q
         ra9fTLR9zaOit79YqBEWNQC7wJAMktXCUtbhvbRnRdkABaCLtdrkwCgjMdjDhUHdQosh
         Tk/LRPRI7HgtjZt/7OAID8FfFs0fwpuIcXth2PpzLTtopZ0OFHLvlQLNwl6hxs2KPHUJ
         t0/ItgXTpMY73BS4tEefeVsd5leMFVth1tsHpHrxMVUdd+vDUm9SyG+E+rUDvrkg4O1I
         782w==
X-Received: by 10.50.53.146 with SMTP id b18mr8160339igp.82.1361251464547;
 Mon, 18 Feb 2013 21:24:24 -0800 (PST)
Received: by 10.50.13.104 with HTTP; Mon, 18 Feb 2013 21:24:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216562>

Hi there,

The new git-check-ignore command seg faults when
    (1) it is called with single dot path name at $GIT_DIR level  _AND_
    (2) and .gitignore has at least one directory pattern.

Git version: 1.8.2.rc0.16.g20a599e

Reproduce the bug:
    $ git --version
    git version 1.8.2.rc0.16.g20a599e
    $ mkdir test
    $ cd test
    $ git init
    $ git check-ignore .  # All good, no errors here
    $ echo "dirpattern/" > .gitignore
    $ git check-ignore .
    Segmentation fault (core dumped)

The segmentation fault is actually caused by hash_name(const char
*name, int namelen) function in name-hash.c when the 'name' argument
is an empty stringi and namelen is 0.

The empty string comes from a call to the prefix_path(prefix, len,
path) function in setup.c. In this instance arguments 'prefix' is
NULL, 'len' is 0 and 'path' is "." .

Cheers,
Zoltan
