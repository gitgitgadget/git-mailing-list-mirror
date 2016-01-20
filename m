From: Marcus Brinkmann <m.brinkmann@semantics.de>
Subject: Re: [PATCH] contrib/subtree: Split history with empty trees correctly
Date: Wed, 20 Jan 2016 12:22:24 +0100
Message-ID: <569F6DF0.60900@semantics.de>
References: <56991CFC.7060705@ruhr-uni-bochum.de>
 <xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
 <87twmbaizo.fsf@waller.obbligato.org> <569EE046.9040506@semantics.de>
 <871t9cvqsp.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Ware <davidw@realtimegenomics.com>, <git@vger.kernel.org>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 12:23:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLqqu-0000M3-Kg
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 12:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbcATLXB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 06:23:01 -0500
Received: from smtp.semantics.de ([212.117.75.54]:1542 "EHLO
	flusser.semantics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964818AbcATLW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 06:22:59 -0500
Received: from tarski.semantics.de ([192.168.1.3])
	by flusser.semantics.de with esmtp (Exim 3.36 #1 (Debian))
	id 1aLqtE-0008VB-00; Wed, 20 Jan 2016 12:25:28 +0100
Received: from LOCKE.semantics.de ([192.168.1.6]) by tarski.semantics.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Jan 2016 12:22:25 +0100
Received: from [192.168.142.172] (80.147.161.94) by Locke.semantics.de
 (192.168.1.6) with Microsoft SMTP Server (TLS) id 14.0.722.0; Wed, 20 Jan
 2016 12:22:25 +0100
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <871t9cvqsp.fsf@waller.obbligato.org>
X-OriginalArrivalTime: 20 Jan 2016 11:22:25.0650 (UTC) FILETIME=[D6DBDD20:01D15374]
X-semantics-MailScanner: Found to be clean
X-semantics-MailScanner-From: m.brinkmann@semantics.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284455>

On 01/20/2016 05:05 AM, David A. Greene wrote:
> Marcus Brinkmann <m.brinkmann@semantics.de> writes:
>=20
>> 'git subtree split' will fail if the history of the subtree has empt=
y
>> tree commits (or trees that are considered empty, such as submodules=
).
>> This fix keeps track of this condition and correctly follows the his=
tory
>> over such commits.
>=20
> Thanks for working on this!  Please add a test to t7900-subtree.sh.

I couldn't get the tests to run and I couldn't find documentation on ho=
w
to run it.  If you enlighten me I can add a test :)

>> @@ -625,12 +629,16 @@ cmd_split()
>>  	=09
>>  		# ugly.  is there no better way to tell if this is a subtree
>>  		# vs. a mainline commit?  Does it matter?
>> -		if [ -z $tree ]; then
>> -			set_notree $rev
>> -			if [ -n "$newparents" ]; then
>> -				cache_set $rev $rev
>> +		if [ -z $found_first_commit ]; then
>> +			if [ -z $tree ]; then
>> +				set_notree $rev
>> +				if [ -n "$newparents" ]; then
>> +					cache_set $rev $rev
>> +				fi
>> +				continue
>> +			else
>> +				found_first_commit=3Dyes
>>  			fi
>> -			continue
>>  		fi
>>
>>  		newrev=3D$(copy_or_skip "$rev" "$tree" "$newparents") || exit $?
>=20
> Can you explain the logic here?  The old code appears to be using the
> lack of a tree to filter out "mainline" commits from the subtree hist=
ory
> when splitting.  If that test is only done before seeing a proper
> subtree commit and never after, then any commit mainline commit
> following the first subtree commit in the rev list will miss being
> marked with set_notree and the cache will not have the identity entry
> added.
>=20
> Test #36 in t7900-subtree.sh has a mainline commit listed after the
> first subtree commit in the rev list, I believe.
>=20
> I'm not positive your change is wrong, I'd just like to understand it
> better.  I'd also like a comment explaining why it works so future
> developers don't get confused.  Overall, I am trying to better commen=
t
> the code as I make my own changes.

It's possible the patch does not work for some cases.  For example, I
don't know how the rejoin variant of splits work.

Some observations:

1) The notree list is never actually used except to identify which
commits have been visited in check_parents.

2) I have no idea what use case is covered by the "if [ -n "$newparents=
"
]; then cache_set $rev $rev; fi".  I left it in purely for traditional
reasons.  So, clarifying that would go a long way in understanding the
code, and if there is a test for that, I will figure it out.

3a) The bug happens because on the first commit that deletes the subdir=
,
newparents will not be empty, and the "cache_set $rev $rev" will kick i=
n
and subsequently (when the subdir is added again) the history will
divert into the $rev commit which is not rewritten, but part of the
unsplit tree.  This seems very wrong to me!  See 2).

3b) To be very clear: It seems logically inconsistent to me to ever cal=
l
set_notree and cache_set on the same rev.  It also seems logically
inconsistent to me to call cache_set rev1 rev2 where rev2 is not
rewritten.  Both seem to be invariant errors that could be caught by
assertions.  They probably should.  In fact, I think my patch makes the
questionable if-case to be dead code, because newparents is never
non-empty before found_first_commit is true.  As such, I think it could
be eliminated.  But I am not 100% sure, as I don't know the intention o=
f
the original code.

4) My patch only preserves the special handling of empty trees up to th=
e
first commit that introduces subdir, because we don't want an empty
commit at the beginning.  After that, empty subdirs are not special at
all - the empty tree is replaced by EMPTY_TREE and handled as if it's a
normal subdir commit.  copy_and_skip will do the right thing.

5) I didn't test any case with multiple parents (merge commits).  There
are several of those cases (merge commits into empty subdirs, branches
with different non-empty subdirs from empty ones), and they don't apply
to my use case (git-svn conversion).  I read the copy_and_skip code and
see that it optimizes some of those cases, and although I didn't see an
obvious problem, I didn't think too deeply about it.

Thanks,
Marcus



--=20
s<e>mantics GmbH
Viktoriaallee 45
52066 Aachen
Web: www.semantics.de
Registergericht  : Amtsgericht Aachen, HRB 8189
Gesch=E4ftsf=FChrer  : Kay Heiligenhaus M.A.
                   Dipl. Ing. Jos=E9 de la Rosa
