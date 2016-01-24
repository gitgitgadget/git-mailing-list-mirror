From: Marcus Brinkmann <m.brinkmann@semantics.de>
Subject: Re: [PATCH] contrib/subtree: Split history with empty trees correctly
Date: Sun, 24 Jan 2016 14:07:17 +0100
Message-ID: <56A4CC85.90705@semantics.de>
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
X-From: git-owner@vger.kernel.org Sun Jan 24 14:08:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNKP0-0000lY-UB
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 14:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbcAXNHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2016 08:07:42 -0500
Received: from smtp.semantics.de ([212.117.75.54]:4238 "EHLO
	flusser.semantics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbcAXNHk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2016 08:07:40 -0500
Received: from tarski.semantics.de ([192.168.1.3])
	by flusser.semantics.de with esmtp (Exim 3.36 #1 (Debian))
	id 1aNKQm-0000uz-00; Sun, 24 Jan 2016 14:10:12 +0100
Received: from LOCKE.semantics.de ([192.168.1.6]) by tarski.semantics.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 24 Jan 2016 14:07:18 +0100
Received: from [192.168.142.172] (80.147.161.94) by Locke.semantics.de
 (192.168.1.6) with Microsoft SMTP Server (TLS) id 14.0.722.0; Sun, 24 Jan
 2016 14:07:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <871t9cvqsp.fsf@waller.obbligato.org>
X-OriginalArrivalTime: 24 Jan 2016 13:07:18.0192 (UTC) FILETIME=[27289300:01D156A8]
X-semantics-MailScanner: Found to be clean
X-semantics-MailScanner-From: m.brinkmann@semantics.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284648>

With my patch, "git subtree split -P" produces the same result (for my
data set) as "git filter-branch --subdirectory-filter", which is much
faster, because it selects the revisions to rewrite before rewriting.
As I am not using any of the advanced features of "git subtree", I will
just use "git filter-branch" instead.

Thanks!
Marcus

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
>=20
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
>=20
>                            -David
>=20


--=20
s<e>mantics GmbH
Viktoriaallee 45
52066 Aachen
Web: www.semantics.de
Registergericht  : Amtsgericht Aachen, HRB 8189
Gesch=E4ftsf=FChrer  : Kay Heiligenhaus M.A.
                   Dipl. Ing. Jos=E9 de la Rosa
