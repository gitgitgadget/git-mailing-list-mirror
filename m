From: Shuang He <shuang.he@intel.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Wed, 26 Jan 2011 15:11:14 +0800
Message-ID: <4D3FC912.4020404@intel.com>
References: <4D3CDDF9.6080405@intel.com> <AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com> <AANLkTinwbm9gcZhGeQCbOEPov0_xV7uJyQvC7J13qO15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 08:11:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhzXK-00030Z-1X
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 08:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab1AZHLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 02:11:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:27936 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697Ab1AZHLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 02:11:19 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 25 Jan 2011 23:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.60,379,1291622400"; 
   d="scan'208";a="700752722"
Received: from she4-mobl3.ccr.corp.intel.com (HELO [10.254.208.80]) ([10.254.208.80])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2011 23:11:15 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <AANLkTinwbm9gcZhGeQCbOEPov0_xV7uJyQvC7J13qO15@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165504>

On 2011/1/25 4:28, Avery Pennarun wrote:
> On Mon, Jan 24, 2011 at 1:53 AM, Christian Couder
> <christian.couder@gmail.com>  wrote:
>> I am not opposed to an option to bisect on the first parents of the
>> bad commit only. And after a very fast look at your patch it seems to
>> be what it does. By the way Avery Pennarun's gitbuilder
>> (https://github.com/apenwarr/gitbuilder) does the same thing. So I
>> know some people are interested in such a feature.
> Just some notes on gitbuilder's algorithm, since I haven't spent the
> time to fully understand Shuang's proposal.
>
> I do understand at least one of his concerns, that is, that people
> like to do a lot of "messy" development on a branch, and when the
> branch is done, merge the whole messy branch into the "mainline".  The
> messy branch would then have a lot of commits that break a lot of
> things before fixing them again later.
>
> In a corporate environment, this method allows people to work all day,
> make frequent commits, pull from other branches at will, and never
> risk their lives by doing poorly-educated rebases.  It works pretty
> well *until* you try to bisect, at which time all these messy commits
> start to bite you.
>
> gitbuilder's bisection is a total hack around this situation, although
> it happens to work perfectly in the workflow it was designed for, thus
> making me feel clever.
>
> Basically, we push/fetch *all* the branches from *everybody* into a
> single repo, and build all of them as frequently as we can.  If you
> think about it, if you have all the branches that someone might have
> pulled/merged from, then you don't have to think of the git history as
> a whole complicated DAG; you can just think of it as a whole bunch of
> separate chunks of linear history.  Moreover, as long as people are
> careful to only pull from a branch when that branch is passing all
> tests - which you can easily see by looking at the gitbuilder console
> - then playing inside each of these chunks of linear history can help
> you figure out where particular bugs were introduced during "messy"
> branches.
>
> It also allows you a nice separation of concerns.  The owner of the
> mainline branch (the "integration manager" person) only really cares
> about which branch they merged that caused a problem, because that
> person doesn't want to fix bugs, he/she simply wants to know who owns
> the failing branch, so that person can fix *their* bug and their
> branch will merge without breaking things.
>
> So this is why gitbuilder uses "git rev-list --first-parent" during
> its "fake bisection" operation: because a different person is
> responsible for each "linear chunk" of history.
>
> Note that you have to use --no-ff when merging if you want this to
> work reliably.  But the build manager person can just remember to do
> that.  Combining --no-ff and --ff-only (which sound mutually exclusive
> but aren't) is a way to be extra specially sure.
>
> Now, if you aren't using gitbuilder, what we want from "bisection" is
> not quite the same, but let's imagine that you at least have a similar
> setup, where people *only* ever merge into the mainline by using
> --no-ff.  In that case, you'd like a bisect operation that *starts* by
> using --first-parent, which will tell you which merge caused the
> problem.  After that, you might want to bisect into the branch.
>
> (I don't actually remember if 'git bisect' understands --first-parent
> correctly.  gitbuilder doesn't exactly bisect either, but that's
> another story and not relevant right now.)
>
> I can actually imagine that there are many more projects that do what
> I'm talking about - "messy" branches that get broken and fixed over
> time, then merge into a "clean" mainline - than projects (like the
> kernel and git.git) that try to keep all branches clean at all times.
> Thus, I could see some argument that a "--first-parents first"
> bisection would actually help out a lot of people, and maybe even
> deserves to be the default.
>
> I don't really care though, I just use gitbuilder :)
>
> Have fun,
>
> Avery

Thanks for helping explaining those stuff, and also glad to learn more 
about gitbuilder :)

Thanks
     --Shuang
