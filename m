From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: touching a file causes it to be listed using git diff-files
Date: Thu, 14 Jan 2010 00:01:46 -0500
Message-ID: <p06240810c774498d4a2e@[63.138.152.134]>
References: <p0624080ec7740ddc4caf@[63.138.152.134]> <20100114030204.GB1878@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 06:02:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVHrE-000718-0D
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819Ab0ANFCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777Ab0ANFCs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:02:48 -0500
Received: from deanbrook.org ([72.52.70.192]:60265 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750695Ab0ANFCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:02:47 -0500
Received: from ::ffff:71.123.114.34 ([71.123.114.34]) by deanbrook.org for <git@vger.kernel.org>; Wed, 13 Jan 2010 21:02:44 -0800
In-Reply-To: <20100114030204.GB1878@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136926>

At 10:02 PM -0500 1/13/10, Jeff King wrote:
>On Wed, Jan 13, 2010 at 06:57:28PM -0500, Stephen Bannasch wrote:
>
>> If I touch a file in the working directory (only changing it's last-modified) attribute it shows up when running git diff-files.
>>
>> If I then run git status followed by git diff-files again it doesn't show up either time.
>>
>> Is this an error?
>
>No. For performance reasons[1], plumbing commands like diff-files do not
>update the index. You must run "git update-index --refresh" manually.
>
>User-facing porcelain commands like "git diff" and "git status" will
>refresh the index automatically. So "git status" will, as a side effect,
>refresh the index and impact further calls to diff-files.
>
>-Peff
>
>[1] Refreshing the index needs to stat all of the files. If you are
>writing a script using plumbing commands, you probably want to do the
>possibly-expensive refresh once at the start of your script, and then
>issue many diff commands. This makes a lot of sense for "diff-index",
>which otherwise does not need to touch the working tree at all. I'm not
>sure how much it helps with diff-files, though, which clearly ends up
>stat'ing the working tree file anyway.

Jeff,

Thanks for that explanation.

Do you know if there is a plumbing command that will stat all of the files without listing the files that actually do need updating?

In the case where file1 has been only touched but file2 has been changed (and both are tracked) I'd like to stat both filesand then run diff-files as plumbing to see that only file2 has been changed in the working directory.

'git diff' also stats the files but strangely 'git diff --quiet' doesn't ???

In this example .snarfit.yml has real changes.

  $ touch nowebdb.cs

  $ git diff-files
  :100644 100644 22dab3b1c864d808da4d2be40196250ba879f68f 0000000000000000000000000000000000000000 M      .snarfit.yml
  :100644 100644 57982f13c69a91e3341d5b06021d31944633b5a3 0000000000000000000000000000000000000000 M      nowebdb.css

  $ git diff --quiet

  $ git diff-files
  :100644 100644 22dab3b1c864d808da4d2be40196250ba879f68f 0000000000000000000000000000000000000000 M      .snarfit.yml
  :100644 100644 57982f13c69a91e3341d5b06021d31944633b5a3 0000000000000000000000000000000000000000 M      nowebdb.css

  $ git diff --shortstat
   1 files changed, 2 insertions(+), 2 deletions(-)

  $ git diff-files
  :100644 100644 22dab3b1c864d808da4d2be40196250ba879f68f 0000000000000000000000000000000000000000 M      .snarfit.yml

I thought adding '-q' to update-index would cause it to run quietly but that is not the case:

  $ git diff-files
  :100644 100644 22dab3b1c864d808da4d2be40196250ba879f68f 0000000000000000000000000000000000000000 M      .snarfit.yml
  :100644 100644 57982f13c69a91e3341d5b06021d31944633b5a3 0000000000000000000000000000000000000000 M      nowebdb.css

  $ git update-index --refresh -q
  .snarfit.yml: needs update

  $ git diff-files
  :100644 100644 22dab3b1c864d808da4d2be40196250ba879f68f 0000000000000000000000000000000000000000 M      .snarfit.yml
