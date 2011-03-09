From: Jason Miller <jason@milr.com>
Subject: Re: git-svn with big subversion repository
Date: Tue, 8 Mar 2011 21:53:42 -0800
Message-ID: <20110308215342.35b8aac1@naru.jasonmmiller.org>
References: <C992EE5B.CBFB%jkristian@linkedin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Kristian <jkristian@linkedin.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 07:11:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxCcP-0002UN-QN
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 07:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab1CIGL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 01:11:26 -0500
Received: from eastrmfepi101.cox.net ([68.230.241.197]:43142 "EHLO
	eastrmfepi101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab1CIGLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 01:11:25 -0500
X-Greylist: delayed 1061 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Mar 2011 01:11:25 EST
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmfepo203.cox.net
          (InterMail vM.8.01.04.00 201-2260-137-20101110) with ESMTP
          id <20110309055344.WKHZ32702.eastrmfepo203.cox.net@eastrmimpo02.cox.net>;
          Wed, 9 Mar 2011 00:53:44 -0500
Received: from naru.jasonmmiller.org ([98.182.25.247])
	by eastrmimpo02.cox.net with bizsmtp
	id Gttg1g0085KsrWi02ttga2; Wed, 09 Mar 2011 00:53:44 -0500
X-VR-Score: -200.00
X-Authority-Analysis: v=1.1 cv=7pnWggiXOXQ2QAfmW6m14qCrZ7JR9LVvc7C/OcPmZyA=
 c=1 sm=1 a=6OgPwM6wysAA:10 a=kj9zAlcOel0A:10 a=RvIMCnx3Jxw3m1/9SlLfAA==:17
 a=jU4qhlNgAAAA:8 a=dwulyOQLNzwPssGTIHYA:9 a=hb-8PK8OOvt1wG5eWPYaTXeN3uAA:4
 a=CjuIK1q_8ugA:10 a=8b0Wbe0r5TcA:10 a=RvIMCnx3Jxw3m1/9SlLfAA==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
In-Reply-To: <C992EE5B.CBFB%jkristian@linkedin.com>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.22.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168718>

On Wed, 2 Mar 2011 02:43:23 +0000
John Kristian <jkristian@linkedin.com> wrote:

> How do you recommend using git to work with branches of a large, busy
> subversion repository? In general, how can small teams use git for
> their tasks, and use subversion to coordinate with a larger
> organization?

I don't know if this is the same problem that you are having, but...

I had to clone a repository with 200k revisions and 12000
branches+tags.  It was going to take weeks and weeks with a local
svnsync mirror on a high-end workstation with fast disks.

I've never touched perl-code previous to this, but a friend pointed me
at a good perl profiler, and I found pretty quickly the offending line
of code in git-svn:

3515         return unless ::verify_ref($self->refname.'^0');

This was basically doing a
  system("git rev-parse --verify some-reference^0")

several times per revision fetched per branch.  When you have 12000
branches, that really, really adds up.  I made a change that seems to
speed it up by a factor of about 10-20x on my repository, but I'm still
digging around in git to see if I'm doing it correctly.

My basic logic is that if the above one-liner returns true then either
one of the following files will exist:
    $ENV{GIT_DIR}/refs/remotes/$refname
    $ENV{GIT_DIR}/refs/$refname
    $ENV{GIT_DIR}/refs/heads/$refname
or there will be an entry for the reference in
    $ENV{GIT_DIR}/packed-refs

Furthermore since packed-refs changes infrequently, you can cache its
contents.

I'm still digging around in the plumbing to see if this is
assumption is true or not.  If I find it is true, I'll likely submit a
patch.  Now that it "works on my machine" I've backburnered it a bit
since git is more a tool I use than a project I hack on.

-Jason
