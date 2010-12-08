From: Thomas Rast <trast@student.ethz.ch>
Subject: t9010 broken in pu [Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)]
Date: Wed, 8 Dec 2010 12:23:47 +0100
Message-ID: <201012081223.47642.trast@student.ethz.ch>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 12:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQI7n-0007nE-55
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 12:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab0LHLXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 06:23:50 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:30149 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab0LHLXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 06:23:49 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 8 Dec
 2010 12:23:40 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 8 Dec
 2010 12:23:47 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc4-13-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <7voc90wx36.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163190>

Junio C Hamano wrote:
> * jn/svn-fe (2010-11-19) 17 commits
>  - vcs-svn: Implement Prop-delta handling
>  - vcs-svn: Sharpen parsing of property lines
>  - vcs-svn: Split off function for handling of individual properties
>  - vcs-svn: Make source easier to read on small screens
>  - vcs-svn: More dump format sanity checks
>  - vcs-svn: Reject path nodes without Node-action
>  - vcs-svn: Delay read of per-path properties
>  - vcs-svn: Combine repo_replace and repo_modify functions
>  - vcs-svn: Replace = Delete + Add
>  - vcs-svn: handle_node: Handle deletion case early
>  - vcs-svn: Use mark to indicate nodes with included text
>  - vcs-svn: Unclutter handle_node by introducing have_props var
>  - vcs-svn: Eliminate node_ctx.mark global
>  - vcs-svn: Eliminate node_ctx.srcRev global
>  - vcs-svn: Check for errors from open()
>  - vcs-svn: Allow simple v3 dumps (no deltas yet)
>  - vcs-svn: Error out for v3 dumps
> 
> Some RFC patches, to give them early and wider exposure.

If I'm reading the test report right, the merge conflict in
t/t9010-svn-fe.sh broke tests.  It bisects to 5ea8b68 (Merge branch
'jn/svn-fe' into pu, 2010-12-07), failing with

  expecting success: 
          svnadmin create simple-svn &&
          svnadmin load simple-svn <"$TEST_DIRECTORY/t9135/svn.dump" &&
          svn_cmd export "file://$PWD/simple-svn" simple-svnco &&
          git init simple-git &&
          test-svn-fe "$TEST_DIRECTORY/t9135/svn.dump" >simple.fe &&
          (
                  cd simple-git &&
                  git fast-import <../simple.fe
          ) &&
          (
                  cd simple-svnco &&
                  git init &&
                  git add . &&
                  git fetch ../simple-git master &&
                  git diff --exit-code FETCH_HEAD
          )

  svnadmin: Repository creation failed
  svnadmin: Could not create top-level directory
  svnadmin: 'simple-svn' exists and is non-empty
  not ok - 18 t9135/svn.dump

A quick reading of the merge suggests that you concatenated with an
earlier test that goes

  test_dump () {
        label=$1
        dump=$2
        test_expect_success "$dump" '
                svnadmin create "$label-svn" &&
		# <snip>
        '
  }
  
  test_dump simple t9135/svn.dump

hence creating simple-svn, too.  So a rename or rm -rf should suffice.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
