From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Submodules or similar for exercise/exam management
Date: Thu, 18 Nov 2010 11:36:27 -0500
Message-ID: <201011181636.oAIGaRxm021543@no.baka.org>
References: <201011181109.08345.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:21:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8Ae-0001Wo-3r
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759934Ab0KRRVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 12:21:11 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:58413 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241Ab0KRRVK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:21:10 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id oAIHL4s0017989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Nov 2010 12:21:04 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id oAIGaRxm021543;
	Thu, 18 Nov 2010 11:36:27 -0500
In-reply-to: <201011181109.08345.trast@student.ethz.ch>
Comments: In reply to a message from "Thomas Rast <trast@student.ethz.ch>" dated "Thu, 18 Nov 2010 11:09:08 +0100."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161688>


In message <201011181109.08345.trast@student.ethz.ch>, Thomas Rast writes:

    The requirements we came up with are roughly:

    1) commit across all sub-repos at the same time (atomicity nice but
       optional)
      1b) tag across all sub-repos
    2) do recursive clone/update of one super-repo easily
    3) never need to be aware of repo boundaries or manipulate sub-repo
    4) sanely cope with branches etc. in case the user wants them

This is exactly the sort of situation I wrote gitslave for.
http://gitslave.sf.net  I have a superproject of many subprojects where
I want to perform the same git operation on all of them at the same
time as if it was one giant repository (without the drawbacks of a
giant repository while losing as few as the benefits as possible).

It does not perform atomic commits across sub-repos, but otherwise
handles 1 and 1b.  2 and 4 are handled as well.  3 is mostly handled,
and by mostly, I mean if you get, for instance, a merge conflict in
the superproject or the subproject, you would need to resolve that
using the normal git commands and then typically retry the gitslave
command.  gitslave does not prevent you from using any git command in
any way you might desire, it simply allows you to use "gits" instead
of "git" when you want your command to run over all repos.

    A sample workflow might be:

      foo clone git@example.com/some/super/repo
      # time passes
      cd repo
      foo update
      # work
      foo status
      foo diff
      foo commit -m 'one message fits all'
      # possibly, but this could also be commit --no-push instead
      foo push

In the gitslave world, this would be done:

git clone git@example.com/some/super/repo
cd repo
gits checkout master
# time passes
gits pull
# work
gits status
gits diff
gits commit -a -m 'one message fits none'
# I am not familiar with the "git commit --no-push" option
gits push

    Merges are expected to be rare but would happen every so often.

gits checkout featurebranch
# work
gits commit -a -m 'features are misunderstood'
gits checkout master
gits merge featurebranch
gits tag v1.0 -a -m "feature available"
gits push
gits push --tags

    Has this been done before?  Or do we need to hack up a new wrapper
    around submodules?

Hopefully gitslave will work for you (or could be modified to work for
you).  It is not perfect but has been working well enough for a team
of developers for over two years.

					-Seth Robertson
