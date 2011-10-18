From: Andrea Gelmini <andrea.gelmini@gmail.com>
Subject: Git --reference bug(?)
Date: Wed, 19 Oct 2011 00:04:09 +0200
Message-ID: <CAK-xaQaUxJ5c_kN48g7-J9fosDv6awbAFQSFLpF2fA+hc-i-MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 19 00:04:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGHly-0005yO-Sy
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 00:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab1JRWEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 18:04:30 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:37883 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab1JRWE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 18:04:29 -0400
Received: by pzk36 with SMTP id 36so2673560pzk.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=4aMUmUV5C8u2Y2rmINi1hJSG00nmvEqtNUwrctHBuBQ=;
        b=U4j84m33xlIhNRZZfy429e+T7p0ngtnEMcFQTbNZ0dVz0zqGUJimgh3wXo4wnLJcKf
         V7QnJmiVXO4pKBd7bP4/dF6Wm4uwVjsoXcmnJwmaj66WryYOWy9lxnjmKCamOjEC2hEa
         jC7HHxEPOyQtJGxrgWnfHLZ/49pbubcrggc5Q=
Received: by 10.68.44.168 with SMTP id f8mr2814959pbm.11.1318975469078; Tue,
 18 Oct 2011 15:04:29 -0700 (PDT)
Received: by 10.68.46.230 with HTTP; Tue, 18 Oct 2011 15:04:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183905>

Hi Michael,
   and thanks a lot for your time on Git.
   I have a problem with latest Git tree:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
/tmp/3.1 --reference /home/gelma/dev/kernel/linus/
Cloning into /tmp/3.1...
fatal: Reference has invalid format: 'refs/tags/3.1.1.1^{}'
fatal: The remote end hung up unexpectedly

   It works with Ubuntu Git version 1.7.4.1, of course.

  Well, bisecting I've got this:

dce4bab6567de7c458b334e029e3dedcab5f2648 is the first bad commit
commit dce4bab6567de7c458b334e029e3dedcab5f2648
Author: Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu Sep 15 23:10:43 2011 +0200

    add_ref(): verify that the refname is formatted correctly

    In add_ref(), verify that the refname is formatted correctly before
    adding it to the ref_list.  Here we have to allow refname components
    that start with ".", since (for example) the remote protocol uses
    synthetic reference name ".have".  So add a new REFNAME_DOT_COMPONENT
    flag that can be passed to check_refname_format() to allow leading
    dots.

    Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 096b42c5e993193dd83a02128be4b90ebc59edd1
832a52f7818369bca969d49317718714a5bcabac M	refs.c
:100644 100644 b0da5fc95dff025a8dd5c1f299ee25efc6141e81
d5ac133336dc0da45cd916207d12a5e0e4237ae3 M	refs.h
bisect run success

git bisect log
git bisect start
# bad: [85bb77ed056057b727ba8dc7965fbfcde987d189] Merge branch
'master' of git://git.kernel.org/pub/scm/git/git
git bisect bad 85bb77ed056057b727ba8dc7965fbfcde987d189
# good: [9971d6d52c5afeb8ba60ae6ddcffb34af23eeadd] Git 1.7.4.1
git bisect good 9971d6d52c5afeb8ba60ae6ddcffb34af23eeadd
# good: [456a4c08b8d8ddefda939014c15877ace3e3f499] Merge branch
'jk/diff-not-so-quick'
git bisect good 456a4c08b8d8ddefda939014c15877ace3e3f499
# good: [18dce8d4226c56b10d2b783b476008117d60a23e] Merge branch
'master' of git://git.kernel.org/pub/scm/git/git
git bisect good 18dce8d4226c56b10d2b783b476008117d60a23e
# good: [821b315ebebd5371abd9124478261064b36a6592] Merge branch
'da/make-auto-header-dependencies'
git bisect good 821b315ebebd5371abd9124478261064b36a6592
# bad: [e579a5d398744e8182decff1329c468d59e6974c] Merge branch
'mh/maint-notes-merge-pathbuf-fix'
git bisect bad e579a5d398744e8182decff1329c468d59e6974c
# good: [17e2b114a8f9d66d7c9263755f89cc503c94c38c] Merge branch
'jn/gitweb-highlite-sanitise'
git bisect good 17e2b114a8f9d66d7c9263755f89cc503c94c38c
# good: [5fbdb9c2e8cc7226d9a9e7de5ad09ac5f0a0b906] Merge branch
'jm/mergetool-pathspec'
git bisect good 5fbdb9c2e8cc7226d9a9e7de5ad09ac5f0a0b906
# good: [f989fea0e0b47873de62a355f4766f03a88fb01b] resolve_ref(): also
treat a too-long SHA1 as invalid
git bisect good f989fea0e0b47873de62a355f4766f03a88fb01b
# bad: [9bd500048d467791902b1a5e8c22165325952fde] Merge branch
'mh/check-ref-format-3'
git bisect bad 9bd500048d467791902b1a5e8c22165325952fde
# good: [ce40979cf83c4c92421f9dd56cc4eabb67c85f29] Store the submodule
name in struct cached_refs
git bisect good ce40979cf83c4c92421f9dd56cc4eabb67c85f29
# good: [11fa509957025cc30c063d75014b701dd9ae235d] Merge branch
'mh/iterate-refs'
git bisect good 11fa509957025cc30c063d75014b701dd9ae235d
# bad: [dce4bab6567de7c458b334e029e3dedcab5f2648] add_ref(): verify
that the refname is formatted correctly
git bisect bad dce4bab6567de7c458b334e029e3dedcab5f2648
# good: [7cb368421f62318f2c0f0e19a83ca34c201aebaa] resolve_ref():
expand documentation
git bisect good 7cb368421f62318f2c0f0e19a83ca34c201aebaa

   If I revert it, everything's ok.

Thanks a lot,
Andrea Gelmini
