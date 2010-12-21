From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: t0050-filesystem.sh unicode tests borked on dash shell
Date: Tue, 21 Dec 2010 19:53:25 +0000
Message-ID: <4D1105B5.5070703@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: prohaska@zib.de
X-From: git-owner@vger.kernel.org Tue Dec 21 20:56:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV8Je-0006T5-PD
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 20:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab0LUTz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 14:55:59 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:59192 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753020Ab0LUTz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Dec 2010 14:55:58 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PV8JR-0005lk-hc; Tue, 21 Dec 2010 19:55:58 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164051>


I noticed recently that the unicode tests, when run by the dash shell,
have not been working as designed. (The tests *pass*, but they are
*not* testing what was intended)

In order to demonstrate, I added an "false &&" line after the touch in
test #8, so that (on Ubuntu):

    $ ./t0050-filesystem -i
    ok 1 - see what we expect
    ok 2 - detection of case insensitive filesystem during repo init
    ok 3 - detection of filesystem w/o symlink support during repo init
    ok 4 - setup case tests
    ok 5 - rename (case change)
    ok 6 - merge (case change)
    not ok 7 - add (with different case) # TODO known breakage
    not ok - 8 setup unicode normalization tests
    #	
    #	
    #	  test_create_repo unicode &&
    #	  cd unicode &&
    #	  touch "$aumlcdiar" &&
    #	false &&
    #	  git add "$aumlcdiar" &&
    #	  git commit -m initial &&
    #	  git tag initial &&
    #	  git checkout -b topic &&
    #	  git mv $aumlcdiar tmp &&
    #	  git mv tmp "$auml" &&
    #	  git commit -m rename &&
    #	  git checkout -f master
    #	
    #	
    $ ls trash\ directory.t0050-filesystem/unicode/
    \x61\xcc\x88

    $ bash t0050-filesystem -i
    ok 1 - see what we expect
    ok 2 - detection of case insensitive filesystem during repo init
    ok 3 - detection of filesystem w/o symlink support during repo init
    ok 4 - setup case tests
    ok 5 - rename (case change)
    ok 6 - merge (case change)
    not ok 7 - add (with different case) # TODO known breakage
    not ok - 8 setup unicode normalization tests
    #	
    #	
    #	  test_create_repo unicode &&
    #	  cd unicode &&
    #	  touch "$aumlcdiar" &&
    #	false &&
    #	  git add "$aumlcdiar" &&
    #	  git commit -m initial &&
    #	  git tag initial &&
    #	  git checkout -b topic &&
    #	  git mv $aumlcdiar tmp &&
    #	  git mv tmp "$auml" &&
    #	  git commit -m rename &&
    #	  git checkout -f master
    #	
    #	
    $ ls trash\ directory.t0050-filesystem/unicode/ | od -x
    0000000 cc61 0a88
    0000004

So bash works fine and I can avoid the problem by running the tests, thus:

    $ SHELL_PATH=/bin/bash make NO_SVN_TESTS=1 test

Since I have an older dash, I compiled dash from source (my dash git repo
claims:

    $ git describe --tags
    v0.5.6-24-gb61ab0b

), but the result was exactly the same.

I afraid I don't have time to investigate this further at the moment ...

ATB,
Ramsay Jones
