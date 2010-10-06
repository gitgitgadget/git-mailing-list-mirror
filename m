From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules too
Date: Wed, 6 Oct 2010 15:52:07 -0700
Message-ID: <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <jens.lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:52:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3cqS-0001EM-B2
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823Ab0JFWwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:52:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60793 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989Ab0JFWwM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 18:52:12 -0400
Received: by pzk34 with SMTP id 34so13593pzk.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:52:11 -0700 (PDT)
Received: by 10.142.141.3 with SMTP id o3mr12162006wfd.238.1286405530878;
        Wed, 06 Oct 2010 15:52:10 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id d10sm1458834wfe.22.2010.10.06.15.52.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:52:09 -0700 (PDT)
In-Reply-To: <4CAB8DDF.8080004@web.de>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158340>

On Oct 5, 2010, at 1:43 PM, Jens Lehmann wrote:

>   Kevin reported the fetch time went up from 1.5s to 20s for him
>   because of the recursion. Kevin, could you please test the branch
>   "parallel-submodule-fetch" from my github repository:
> 
>      http://github.com/jlehmann/git-submod-enhancements.git
> 
>   It has these three patches based on next plus a preliminary
>   commit fetching submodules in parallel (but note that a limit
>   of 128 submodules is hardcoded and the output might be mixed
>   between the fetch threads, I'll fix that when you confirm the
>   performance benefit I expect).

The first `git fetch` still took 20 seconds, but that's because there was data to fetch from one of the deeply-nested submodules (data which, incidentally, I have zero reason to want to fetch). Subsequent fetches took 6.3 seconds. This is contrasted with 1.9s to run `git -c fetch.recursive=false fetch`.

On Oct 5, 2010, at 2:06 PM, Junio C Hamano wrote:

>>   a) "git fetch --all"
>> 
>>      The user wanted to fetch new commits from all remotes. I think
>>      git should also fetch all submodules then, no matter if new
>>      commits from them are fetched in the superproject, as the user
>>      explicitly said he wants everything. Objections?
> 
> Why?  I do not see a "--submodules" option on that command line.  The only
> thing I asked is to grab all branches for the project I ran "git fetch"
> in.

I agree with Junio.

>>   b) "git fetch [<repository>]"
>> 
>>      The user wants to fetch from the default [or a single repo]. I
>>      think all submodules should be fetched too, Kevin thinks this
>>      should happen only when it is necessary (at least for his 'H'
>>      repository). While I think fetching all submodules too is
>>      consistent with the fact that you get all branches in the
>>      superproject too, whether you need them or not, we can't seem
>>      to agree on this one (also see my proposal below).
> 
> The case with <repository> is a lot more questionable than the case of
> fetching implicitly from whereever you usually fetch from.  Imagine that
> you fork git.git, and create a separate project that has some nifty
> additions to support submodules better.  The additional part is naturally
> done as a submodule.  This jens.git repository becomes very popular and
> people clone from it.  Your users usually interact with your repository by
> saying "git fetch" or "git pull" without any explicit <repository>.  They,
> however, would want to fetch/pull from me from time to time to get updates
> that you haven't incorporated in jens.git repository. "git fetch junio" is
> run.  Why should such a "fetch" go to your repository and slurp the
> objects for the submodules?
> 
> Perhaps you would want some knobs like these?
> 
>        [remote "origin"]
>                fetch-submodules = all
>                fetch-submodules = changed
> 
>        [remote "junio"]
>                fetch-submodules = none
> 
> I dunno.  I've never been a fan of automatically recursing into submodules
> (iow, treating the nested structure as if there is no nesting), so...

I agree with this as well.

After thinking on it a bit, I think the best solution is to add a switch --submodules to fetch which will also fetch all submodules, but otherwise fetch will fetch no submodules. This will avoid the problem of detecting changed submodules, while still allowing users to explicitly request all submodules in case they're about to get on a plane flight. And of course we can use a config switch to turn --submodules on or off by default. We should also give some thought to automatically updating submodules when `git pull` is performed. I could imagine `git pull --submodules` effectively doing `git pull && git submodule update --init --recursive`, though this implies submodule updating behavior as part of merge, and it seems harder to justify that.

-Kevin Ballard
