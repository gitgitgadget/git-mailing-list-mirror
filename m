From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 2/4] path: optimize common dir checking
Date: Sat, 15 Aug 2015 20:12:42 +0200
Message-ID: <55CF811A.8060106@alum.mit.edu>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>	<1439416645-19173-2-git-send-email-dturner@twopensource.com>	<55CC5DED.5050304@alum.mit.edu> <xmqqtws1iyxn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 20:13:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQfx5-0004Oh-9F
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 20:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbbHOSNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 14:13:01 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44780 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752683AbbHOSNA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2015 14:13:00 -0400
X-AuditID: 12074413-f79bd6d000007ac2-87-55cf811e9aca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D7.D5.31426.E118FC55; Sat, 15 Aug 2015 14:12:46 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2AF9.dip0.t-ipconnect.de [93.219.42.249])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7FIChTG032300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 15 Aug 2015 14:12:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqqtws1iyxn.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqCvXeD7UoH2imMWm5xOZLeZvOsFo
	0XWlm8miofcKs0X3lLeMDqweO2fdZfe4eEnZY/mDV+weC57fZ/f4vEkugDWK2yYpsaQsODM9
	T98ugTvj8dJetoK/khUbFxo3MB4V6WLk4JAQMJFYeiCsi5ETyBSTuHBvPVsXIxeHkMBlRonu
	Cc+ZIZzzTBLvupYxglTxCmhLNPfMYgexWQRUJa5dbASLswnoSizqaWYCsUUFgiRWLH8BVS8o
	cXLmExYQW0RATWJi2yEwm1mgVOJ76082kCOEBewk5l9whdh1hVFiR98NsPmcAtYSHWtXskLU
	60nsuP4LypaXaN46m3kCo8AsJCtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJd
	c73czBK91JTSTYyQABfewbjrpNwhRgEORiUe3oZl50KFWBPLiitzDzFKcjApifI+iDofKsSX
	lJ9SmZFYnBFfVJqTWnyIUYKDWUmE1yoaKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2a
	WpBaBJOV4eBQkuBVaABqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFaXwxMFJB
	UjxAe3VB2nmLCxJzgaIQracYFaXEeV/WAyUEQBIZpXlwY2Fp6xWjONCXwrxtIO08wJQH1/0K
	aDAT0GC7GWdBBpckIqSkGhgnZnyZb+m/Z27hO/VbunMuT68I+aKc2HHz89zVxw1Enz4WODCj
	1OX06n3m/JJPP+Zcd95jZKBzZPbVube3P1B4vfN5ucSdL8+zzzIuX71H7JBZzuZk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276007>

On 08/14/2015 07:04 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Let's take a step back.
>>
>> We have always had a ton of code that uses `git_path()` and friends to
>> convert abstract things into filesystem paths. Let's take the
>> reference-handling code as an example:
>> ...
>> This seems crazy to me. It is the *reference* code that should know
>> whether a particular reference should be stored under `$GIT_DIR` or
>> `$GIT_COMMON_DIR`, or indeed whether it should be stored in a database.
> 
> It is more like:
> 
>  1. The system as a whole should decide if HEAD and refs/heads/
>     should be per workspace or shared across a repository (and we say
>     the former should be per workspace, the latter should be shared).
> 
>  2. The reference code should decide which ref-backend is used to
>     store refs.
> 
>  3. And any ref-backend should follow the decision made by the
>     system as a whole in 1.

If I understand correctly, you consider the decision of where a
particular reference should be stored to be a kind of "business logic"
decision that should live outside of the refs module. I don't think it
is so important whether this knowledge is inside or outside of the refs
module (I can live with it either way).

> I'd imagine that David's ref-backend code inherited from Ronnie
> would still accept the string "refs/heads/master" from the rest of
> the system (i.e. callers that call into the ref API) to mean "the
> ref that represents the 'master' branch", and uses that as the key
> to decide "ok, that is shared across workspaces" to honor the
> system-wide decision made in 1.  The outside callers wouldn't pass
> the result of calling git_path("refs/heads/master") into the ref
> API, which may expand to "$somewhere_else/refs/heads/master" when
> run in a secondary workspace to point at the common location.

Definitely agreed.

> I'd also imagine that the workspace API would give ways for the
> implementation of the reference API to ask these questions:
> 
>  - which workspace am I operating for?  where is the "common" thing?
>    how would I identify this workspace among the ones that share the
>    same "common" thing?
> 
>  - is this ref (or ref-like thing) supposed to be in common or per
>    workspace?

Yes, I especially like this last idea. For example, suppose the function
is "is_common_reference(refname)". It's nice that this function doesn't
have to know about all possible "things" like your is_common_thing()
function. Therefore it can be simpler. Almost always the caller (and in
this case the caller would usually be within the refs module) will know
that the "thing" it wants to inquire about is a reference name, so it
can spare the extra expense of calling is_common_thing().

If we still need is_common_thing() (e.g., for the implementation of `git
rev-parse --git-path`), its definition would become something like

    return is_common_reference(thing) ||
           is_common_file(thing) ||
           is_common_flurg(thing) || ...;

In this construction I think it is is clear that is_common_reference()
would fit pretty well in the refs module, though elsewhere would be OK too.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
