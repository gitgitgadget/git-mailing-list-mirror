From: Wincent Colaiuta <win@wincent.com>
Subject: (Ab)using filter-branch from a post-receive hook
Date: Sat, 14 Jul 2012 21:01:52 -0700
Message-ID: <8D1AF968-AF34-4590-AB8F-E644C534A928@wincent.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 15 07:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqGzC-0002Mf-Jr
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 07:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805Ab2GOFDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 01:03:01 -0400
Received: from outmail148101.authsmtp.com ([62.13.148.101]:53262 "EHLO
	outmail148101.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708Ab2GOFDA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 01:03:00 -0400
X-Greylist: delayed 3664 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jul 2012 01:02:59 EDT
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt12.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id q6F41r9I059222
	for <git@vger.kernel.org>; Sun, 15 Jul 2012 05:01:53 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id q6F41mCr075265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 15 Jul 2012 05:01:49 +0100 (BST)
Received: from [192.168.1.131] (c-69-181-20-120.hsd1.ca.comcast.net [69.181.20.120])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id q6F41kfh008251
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sun, 15 Jul 2012 00:01:47 -0400
X-Mailer: Apple Mail (2.1278)
X-Server-Quench: cd922a22-ce31-11e1-80b9-0022640b883e
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha Dh4fBRVVLUBPVglL NEteaF1JP0tFGBZ7 RjoUWVRVUk1xXGl1 agBVZEtcak5QWAZ0 UktNXFBTFBpqBAMA SF8YJB1zKnYEeHl1 Z0BnEHRdW0I0JhJ0 QEwFF28bNjJjaX0e URVZagtUIgpXfh9H aFZ7VCEFaWZSKGIR FU4uJDE3Mn1RKSBJ TxtIJ0gbR00LVjAm QBVKFH03GlYZAj8+ JBEnNFNUHEEWMS0A 
X-Authentic-SMTP: 61633436303433.1015:706
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 184.73.234.210/25
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201466>

Hi,

At $day_job we want to start publishing a subtree of our codebase as open source. As we audit and prep more sections of the code base, we'll be broadening the subtree(s) that we export, until eventually we want as close as possible to the whole thing to be open source.

The resulting public repo would only contain commits from the master branch that touch the "open" parts of the tree, so while the result wouldn't be complete or coherent, it would produce a "read-only" open source artifact and allow us to start sharing code today rather than a year or two years from now when the entire code base is audited.

I'm thinking of (ab)using filter-branch from a post-receive hook as a means to do this. Does this sound sane, or are there better options?

Specifically, I was thinking of doing the following:

- on pushing into our authoritative repo, we replicate to a second "scratch" repo where all the dirty work gets done

- the scratch repo has a master branch, and an initial "open" branch created using `git filter-branch`

- a post-receive hook in the scratch repo, given a series of commits A..B on the master branch, cherry-picks them onto the "open" branch, producing commits A'..B'

- the hook runs `git filter-branch` on the "open" branch over commits A'..B', filtering the not-yet-open parts of the tree and dropping empty commits

- the hook pushes the resulting HEAD to a public repo

Thoughts? Closest to this idea that I've been able to find online so far is [1].

Cheers,
Wincent

[1] http://stackoverflow.com/questions/2296047/repeatedly-using-git-filter-branch-to-rewrite-new-commits
