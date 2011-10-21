From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Breakage in master since 6d4bb3833c
Date: Fri, 21 Oct 2011 14:10:53 +0200
Message-ID: <4EA1614D.3090202@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 14:11:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHDwK-00031u-On
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 14:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab1JUMK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 08:10:59 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:48769 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab1JUMK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 08:10:58 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9LCAs4E006152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Oct 2011 14:10:55 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184057>

When testing reference-handling performance using my refperf script [1],
I noticed that there is a problem in master that I bisected down to

6d4bb3833c "fetch: verify we have everything we need before updating our
ref"

When I run the following commands

=======================================================
GIT=$(pwd)/git
ORIG=bug-6d4bb383-repo
REPO=bug-6d4bb383-clone
URL=file://$(pwd)/$ORIG

$GIT init $ORIG
cd $ORIG
$GIT config gc.auto 0
$GIT config gc.packrefs false
touch a.txt
$GIT add a.txt
$GIT commit -am 'Add file'
cd ..

mkdir $REPO
cd $REPO
$GIT init
$GIT remote add origin $URL
$GIT fetch origin
=======================================================

Then the last "git fetch origin" command gives the following output:

=======================================================
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]
  limiting output:
    --max-count=<n>
    --max-age=<epoch>
    --min-age=<epoch>
    --sparse
    --no-merges
    --min-parents=<n>
    --no-min-parents
    --max-parents=<n>
    --no-max-parents
    --remove-empty
    --all
    --branches
    --tags
    --remotes
    --stdin
    --quiet
  ordering output:
    --topo-order
    --date-order
    --reverse
  formatting output:
    --parents
    --children
    --objects | --objects-edge
    --unpacked
    --header | --pretty
    --abbrev=<n> | --no-abbrev
    --abbrev-commit
    --left-right
  special purpose:
    --bisect
    --bisect-vars
    --bisect-all
error: file:///home/mhagger/self/proj/git/git/bug-6d4bb383-repo did not
send all necessary objects

=======================================================

The same error occurs if all of the steps *except* the last one are done
with a release version of git.

Michael

[1] branch "refperf" at git://github.com/mhagger/git.git

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
