From: Illia Bobyr <Illia.Bobyr@ronin-capital.com>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Mon, 11 Jul 2011 19:14:16 -0500
Message-ID: <4E1B91D8.5040500@ronin-capital.com>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 02:14:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgQcX-0000jz-KK
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 02:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab1GLAOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 20:14:20 -0400
Received: from spam01.roncap.com ([64.95.232.121]:44584 "EHLO
	spam01.roncap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab1GLAOU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2011 20:14:20 -0400
X-ASG-Debug-ID: 1310429658-47422f040001-QuoKaX
Received: from psys-sltc-exhc1.ronin.roncap.com ([10.106.240.21]) by spam01.roncap.com with ESMTP id l9txJtqmmY9iKU5F (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Mon, 11 Jul 2011 19:14:18 -0500 (CDT)
X-Barracuda-Envelope-From: Illia.Bobyr@ronin-capital.com
Received: from psys-cltc-excl1.ronin.roncap.com ([fe80::6131:9de3:c24c:5b2d])
 by psys-sltc-exhc1.ronin.roncap.com ([::1]) with mapi; Mon, 11 Jul 2011
 19:14:18 -0500
X-ASG-Orig-Subj: Re: [PATCH 2/5] add object-cache infrastructure
Thread-Topic: [PATCH 2/5] add object-cache infrastructure
Thread-Index: AcxAKKL6cgZvVHiIQSeDD6whXiia+Q==
In-Reply-To: <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20110624
 Thunderbird/5.0
acceptlanguage: en-US
X-Barracuda-Connect: UNKNOWN[10.106.240.21]
X-Barracuda-Start-Time: 1310429658
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://spam01.roncap.com:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at roncap.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176911>

On 7/11/2011 6:21 PM, Junio C Hamano wrote:
> Jeff King<peff@peff.net>  writes:
>
>> ... But with a commit no top, you get:
>>
>>    <<<<<<<  HEAD
>>    two
>>    =======
>>    one
>>    >>>>>>>  one
>>
>> which looks like you are reverting, because of course you are building
>> on top of the finished series.
> Exactly.
>
>>    $ git rebase master topic
>>    Applying: one
>>    Using index info to reconstruct a base tree...
>>    Falling back to patching base and 3-way merge...
>>    Auto-merging file
>>    CONFLICT (content): Merge conflict in file
>>    Failed to merge in the changes.
>>    Patch failed at 0001 one
>>
>>    hint: this commit may already be in upstream as 1234abcd;
>>    hint: the differences between that commit and this one are:
>>
>>    diff --git a/file b/file
>>    --- a/file
>>    +++ b/file
>>    @@ -1 +1 @@
>>    -modified one
>>    +one
>>
>>    When you have resolved this problem run "git rebase --continue".
>>    If you would prefer to skip this patch, instead run "git rebase --skip".
>>    To restore the original branch and stop rebasing run "git rebase --abort".
> Actually I do not think identifying the ones that can safely skipped is
> such a big issue. The case I am most concerned about is when you see that
> "two reverted back to one" (which you obviously want to avoid, to keep the
> effect of the commit the upstream has to have "two" on that line), but at
> the same time when you do not agree with the change that the upstream took
> for the _current commit_ you are replaying (i.e. you want the final result
> to have "one", not "modified one" which the upstream has applied).
>
> The conflict resolution to come up with such an incremental change is very
> painful. You have to avoid the "s/two/one/" revert, and you have to keep
> the "s/modified one/one" revert, and you need to know which hunks are
> conflicting due to what (i.e. the former is because a patch similar to the
> one you haven't replayed in this rebase session is already in upstream,
> the latter is the upstream tweaked the current patch you are looking at in
> a way you do not agree with).
>
> I do not have a good idea to solve this in mind yet.

I am not 100% sure that my solution is exactly about this problem, but 
it seems to be quite relevant.

I think that if you rebase "step-by-step" by doing, for this particular 
example, something like

$ git rebase master^ topic
$ git rebase master topic

You will first see the /modified one/one/ conflict that you will resolve 
your "two" against and then your second rebase will apply with no conflicts.

I have a set of scripts that help me do this kind of rebases by 
essentially rebasing the topic branch against every single commit on the 
upstream.

This way I can clearly see every conflict as at appears and can fix it 
even in cases when a rebase against the final state would give an 
absolutely unbearable diff.

It definitely is much slower but in my case I find this to be the only 
possible solution.  rerere helps enormously here.
At the same time the less changes are in topic...master the faster it 
would be and the more changes are there the more you benefit from a 
gradual rebase.


Here is the actual use case in case I was not very clear above or in 
case someone is interested.

I have a very longed lived branch that I have to rebase against an 
actively developed master.
Besides been longed live the branch contains a lot of absolutely 
unrelated changes.

The branch is a "next version branch" and contains a result of a two 
year work done by two people who though that their version of the 
application will become master "tomorrow", so they where not too shy to 
change things.

The upstream is developed by another 6 - 8 people over 3 years and they 
have no knowledge of the changes done in the "next version branch".

Here is were I step in and am told to get the changes from the next 
version branch onto the master.  And I am not part of either of these 
two groups of people.

In addition to that one of the guys who developed the next version has 
left the company before I joined and the other one is also gone by now.

While it seems pretty crazy to me, thanks to git rebase, git rerere and 
the "step-by-step" rebase I am at my 9th rebase of this topic branch 
through last year and had only minor problems so far.

Essentially now we have 6 people developing the application "in the 
middle" of its history with one person trying to hold the rest of the 
history on top.
I imagine this as a kind of an acrobatic trick worth showing in a circus :)

Ilya Bobyr