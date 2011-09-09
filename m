From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 09 Sep 2011 15:50:37 +0200
Message-ID: <4E6A19AD.80100@alum.mit.edu>
References: <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com> <4DF6A8B6.9030301@op5.se> <20110614003029.GA31447@sigill.intra.peff.net> <7vtybtm3dl.fsf@alter.siamese.dyndns.org> <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com> <201106141202.46720.johan@herland.net> <20110614170214.GB26764@sigill.intra.peff.net> <BANLkTin0CjnM_hMaEpMroZdDhhavaoKAv00_4xBqeHj9biToVA@mail.gmail.com> <20110614194749.GA1567@sigill.intra.peff.net> <BANLkTi=GZDLu-ey1=h8LLDbWssoSpsM_jd7R-oFr+b+82Otb8g@mail.gmail.com> <1315511619144-6773496.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 15:50:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R21Tk-0002h4-Qz
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 15:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758699Ab1IINuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 09:50:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58213 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab1IINun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 09:50:43 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p89DobT2006796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 9 Sep 2011 15:50:37 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <1315511619144-6773496.post@n2.nabble.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181066>

On 09/08/2011 09:53 PM, Martin Fick wrote:
> Just thought that I should add some numbers to this thread as it seems that
> the later versions of git are worse off by several orders of magnitude on
> this one.  
> 
> We have a Gerrit repo with just under 100K refs in refs/changes/*.  When I
> fetch them all with git 1.7.6 it does not seem to complete.  Even after 5
> days, it is just under half way through the ref #s! [...]

I recently reported very slow performance when doing a "git
filter-branch" involving only about 1000 tags, with hints of O(N^3)
scaling [1].  That could certainly explain enormous runtimes for 100k refs.

References are cached in git in a single linked list, so it is easy to
imagine O(N^2) all over the place (which is bad enough for 100k
references).  I am working on improving the situation by reorganizing
how the reference cache is stored in memory, but progress is slow.

I'm not sure whether your problem is related.  For example, it is not
obvious to me why the commit that you cite (88a21979) would make the
reference problem so dramatically worse.

I suggest the following experiments to characterize the problem:

1. Fetch the references in batches of a few hundred each, and see if
that dramatically decreases the total time.

2. Same as (1), except run "git pack-refs --all --prune" between the
batches.  In my experiments, packing references made a dramatic
difference in runtimes.

3. Try using the --no-replace-objects option (I assume that it can be
used like "git --no-replace-objects fetch ...").  In my case this option
made a dramatic improvement in the runtimes.

4. Try a test using a repository generated something like the test
script that I posted in [1].  If it also gives pathologically bad
performance, then it can serve as a test case to use while we debug the
problem.

Yours,
Michael

[1] http://comments.gmane.org/gmane.comp.version-control.git/177103

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
