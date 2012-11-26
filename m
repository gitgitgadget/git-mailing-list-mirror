From: Stephen Bash <bash@genarts.com>
Subject: Re: git bundle format
Date: Mon, 26 Nov 2012 15:56:24 -0500 (EST)
Message-ID: <1745253724.103630.1353963384110.JavaMail.root@genarts.com>
References: <871B6C10EBEFE342A772D1159D13208537ABF5AB@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jason J CTR Pyeron (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:57:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5jg-0002Ra-1X
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab2KZU4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:56:33 -0500
Received: from hq.genarts.com ([173.9.65.1]:19866 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753576Ab2KZU4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 15:56:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id E0EA5BE21D3;
	Mon, 26 Nov 2012 15:56:29 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dwtve3r3VnKY; Mon, 26 Nov 2012 15:56:24 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 276F4BE1F27;
	Mon, 26 Nov 2012 15:56:24 -0500 (EST)
In-Reply-To: <871B6C10EBEFE342A772D1159D13208537ABF5AB@umechphj.easf.csd.disa.mil>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC23 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210489>

----- Original Message -----
> From: "Jason J CTR Pyeron (US)" <jason.j.pyeron.ctr@mail.mil>
> Sent: Monday, November 26, 2012 2:24:54 PM
> Subject: git bundle format
> 
> I am facing a situation where I would like to use git bundle but at
> the same time inspect the contents to prevent a spillage[1].

As someone who faced a similar situation in a previous life, I'll offer my $0.02, but I'm certainly not the technical expert here.

> Given we have a public repository which was cloned on to a secret
> development repository. Now the developers do some work which should
> not be sensitive in any way and commit and push it to the secret
> repository.
> 
> Now they want to release it out to the public. The current process is
> to review the text files to ensure that there is no "secret" sauce
> in there and then approve its release. This current process ignores
> the change tracking and all non-content is lost.
> 
> In this situation we should assume that the bundle does not have any
> content which is already in the public repository, that is it has
> the minimum data to make it pass a git bundle verify from the public
> repositories point of view. We would then take the bundle and pipe
> it though the "git-bundle2text" program which would result in a
> "human" inspectable format as opposed to the packed format[2]. The
> security reviewer would then see all the information being released
> and with the help of the public repository see how the data changes
> the repository.
> 
> Am I barking up the right tree?

First, a shot out of left field: how about a patch based workflow? (similar to the mailing list, just replace email with sneakernet)  Patches are plain text and simple to review (preferable to an "opaque" binary format?).

Second, thinking about your proposed bundle-based workflow I have two questions I'd have to answer to be comfortable with the solution:

  1) Does the binary bundle contain any sensitive information?
  2) Do the diffs applied to public repo contain any sensitive data?

Question 1 seems tricky to someone who knows *nothing* about the bundle format (e.g. me).  Maybe some form of bundle2text can be vetted enough that everyone involved believes that there is no other information traveling with the bundle (if so, you're golden).  Here I have to trust other experts.  On the flip side, even if the bundle itself is polluted (or considered to be lacking proof to the contrary), if (2) is considered safe, the patching of the public repo could potentially be done on a sacrificial hard drive before pushing.

Question 2 is relatively straight forward and lead me to the patch idea.  I would:
  - Bundle the public repository
  - Init a new repo in the secure space from the public bundle
  - Fetch from the to-be-sanitized bundle into the new repo
  - Examine commits (diffs) introduced by branches in the to-be-sanitized bundle
  - Perhaps get a list of all the objects in the to-be-sanitized bundle and do a git-cat-file on each of them (if the bundle is assembled correctly it shouldn't have any unreachable objects...).  This step may be extraneous after the previous.

HTH,
Stephen
