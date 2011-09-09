From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 09 Sep 2011 17:51:04 +0200
Message-ID: <4E6A35E8.8060502@alum.mit.edu>
References: <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com> <4DF6A8B6.9030301@op5.se> <20110614003029.GA31447@sigill.intra.peff.net> <7vtybtm3dl.fsf@alter.siamese.dyndns.org> <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com> <201106141202.46720.johan@herland.net> <20110614170214.GB26764@sigill.intra.peff.net> <BANLkTin0CjnM_hMaEpMroZdDhhavaoKAv00_4xBqeHj9biToVA@mail.gmail.com> <20110614194749.GA1567@sigill.intra.peff.net> <BANLkTi=GZDLu-ey1=h8LLDbWssoSpsM_jd7R-oFr+b+82Otb8g@mail.gmail.com> <1315511619144-6773496.post@n2.nabble.com> <4E6A19AD.80100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 17:51:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23Mo-0008AO-Go
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 17:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759325Ab1IIPvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 11:51:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58807 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758478Ab1IIPvK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 11:51:10 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p89Fp4ms014914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 9 Sep 2011 17:51:04 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <4E6A19AD.80100@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181081>

I have answered some of my own questions:

On 09/09/2011 03:50 PM, Michael Haggerty wrote:
> 3. Try using the --no-replace-objects option (I assume that it can be
> used like "git --no-replace-objects fetch ...").  In my case this option
> made a dramatic improvement in the runtimes.

This does not seem to help much.

> 4. Try a test using a repository generated something like the test
> script that I posted in [1].  If it also gives pathologically bad
> performance, then it can serve as a test case to use while we debug the
> problem.

Yes, a simple test repo like that created by the script is enough to
reproduce the problem.  The slowdown becomes very obvious after only a
few hundred references.

Curiously, "git clone" is very fast under the same circumstances that
"git fetch" is excruciatingly slow.

According to strace, git seems to be repopulating the ref cache after
each new ref is created (it walks through the whole refs subdirectory
and reads every file).  Apparently the ref cache is being discarded
completely whenever a ref is added (which can and should be fixed) and
then being reloaded for some reason (though single refs can be inspected
much faster without reading the cache).  This situation should be
improved by the hierarchical refcache changes that I'm working on plus
smarter updating (rather than discarding) of the cache when a new
reference is created.

Some earlier speculation in this thread was that that slowdowns might be
caused by "pessimal" ordering of revisions in the walker queue.  But my
test repository shards the references in such a way that the lexical
order of the refnames does not correspond to the topological order of
the commits.  So that can't be the whole story.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
