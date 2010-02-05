From: Jon Nelson <jnelson@jamponi.net>
Subject: Re: git gc / git repack not removing unused objects?
Date: Fri, 5 Feb 2010 15:04:13 -0600
Message-ID: <cccedfc61002051304t6030d3f7if4bb14709ee6c918@mail.gmail.com>
References: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com> 
	<alpine.LFD.2.00.1002051539080.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Feb 05 22:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVM0-0007pM-ER
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab0BEVEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 16:04:35 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:49914 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab0BEVEf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 16:04:35 -0500
Received: by ewy28 with SMTP id 28so473277ewy.28
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 13:04:33 -0800 (PST)
Received: by 10.216.88.143 with SMTP id a15mr342776wef.206.1265403873329; Fri, 
	05 Feb 2010 13:04:33 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002051539080.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139090>

On Fri, Feb 5, 2010 at 2:51 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 5 Feb 2010, Jon Nelson wrote:
>
>> [Using git 1.6.4.2]
>>
>> In one repo I have (136G objects directory, fully packed) I'm having
>> some trouble.
>> I've run git-gc --prune=3Dnow, git repack -Adf, and so on a half-doz=
en
>> times and each time I do so it gets bigger, not smaller.
>
> Please tell us more.

I'll tell you whatever I can -- as soon as I know what it is you want.

>> Setting that aside for the moment, however, I've run into a stranger=
 problem.
>>
>> So I use "git verify-pack -v > gvp.out" and "sort -k3nr < gvp.out |
>> head -n 20" to find the top 20 largest blobs.
>> So I have a blob, b32c3d8e8e24d8d3035cf52f606c2873315fe2b8, and now =
I
>> want to know what tree (or trees) it is in, so I try this:
>>
>>
>> for i in $( git branch -a | sed -e 's/\*//g' | grep -v branch ); do =
if
>> git ls-tree -l -r -t $i | grep
>> b32c3d8e8e24d8d3035cf52f606c2873315fe2b8 > /dev/null; then echo $i;
>> fi; done
>>
>> The results: no branch or tree appears to contain that blob.
>
> What you did above is simply to list trees that are reachable from th=
e
> _heads_ of your branches. =A0If the blob belongs to a commit which is=
n't
> the latest revision of any of your branches then you won't see it lik=
e
> that.
>
>> So I tried a different approach:
>>
>> for i in $( grep tree gvp.out =A0| awk '{ print $1 }' ); do if git
>> ls-tree $i | grep b32c3d8e8e24d8d3035cf52f606c2873315fe2b8 >
>> /dev/null; then echo $i; fi ; done
>>
>> This time, I find (at least) one tree
>> (d813af1537358496ca34958bbff08b87590607bf) with the blob.
>> But which branches might that tree appear in? None.
>>
>> For each branch, I ran "git ls-tree -l -r -t" and saved the output i=
n
>> a file (one per branch).
>> Then I grepped each file for the tree (
>> (d813af1537358496ca34958bbff08b87590607bf) - no luck.
>> I grepped each file for the blob (b32...) - no luck.
>>
>> The results seem to suggest that I have packed trees which reference
>> blobs, but that the trees themselves are not referenced in any branc=
h
>> and therefore I would expect that they would be pruned.
>
> NO. =A0If those trees and blobs are stil there then they do get
> referenced. =A0But not from the latest commit on any of your branches=
=2E
> You need to dig further down in history to find a commit that actuall=
y
> references that blob/tree. =A0One easy method is to do:
>
> =A0 =A0 =A0 =A0git log --raw --all
>
> and within the pager ('less' by default) simply search for "b32c3d8".

OK. I'm piping "git log --raw --all" to a file this very moment. It'll
take a while. However, one thing I did not mention is that there
*should* be a 1:1 correlation between branches and commits. As in,
every time I did a commit, the commit was on a new branch. I'll look
into this, as I've fiddled with the repo a bunch of different ways
lately. I suspect the answer will be found in the logs.

Thanks for the response!

--=20
Jon
