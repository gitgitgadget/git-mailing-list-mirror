From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: git gc gives "error: Could not read..."
Date: Mon, 1 Jun 2015 10:40:53 +0200
Message-ID: <556C1A95.9010704@atlas-elektronik.com>
References: <556C0BAD.80106@atlas-elektronik.com> <20150601081450.GA32634@peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000704080408010700030505"
Cc: Git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 10:41:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzLHX-0008Ee-JL
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 10:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbbFAIlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 04:41:10 -0400
Received: from mail96.atlas.de ([194.156.172.86]:32140 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbbFAIlI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 04:41:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 8E5B010126;
	Mon,  1 Jun 2015 10:41:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7fehKVmrkDqP; Mon,  1 Jun 2015 10:40:54 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Mon,  1 Jun 2015 10:40:54 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id DAD7C27169;
	Mon,  1 Jun 2015 10:40:53 +0200 (CEST)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server id 8.3.327.1; Mon, 1 Jun 2015
 10:40:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150601081450.GA32634@peff.net>
OpenPGP: id=2DF5E01B09C37501BCA99666829B49C5922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270381>

--------------000704080408010700030505
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Am 01.06.2015 um 10:14 schrieb Jeff King:
> On Mon, Jun 01, 2015 at 09:37:17AM +0200, Stefan Näwe wrote:
> 
>> One of my repos started giving an error on 'git gc' recently:
>>
>>  $ git gc
>>  error: Could not read 7713c3b1e9ea2dd9126244697389e4000bb39d85
>>  Counting objects: 3052, done.
>>  Delta compression using up to 4 threads.
>>  Compressing objects: 100% (531/531), done.
>>  Writing objects: 100% (3052/3052), done.
>>  Total 3052 (delta 2504), reused 3052 (delta 2504)
>>  error: Could not read 7713c3b1e9ea2dd9126244697389e4000bb39d85
> 
> The only error string that matches that is the one in parse_commit(),
> when we fail to read the object. It happens twice here because
> `git gc` runs several subcommands; you can see which ones are generating
> the error if you run with GIT_TRACE=1.
> 
> I am surprised that it doesn't cause the commands to abort, though. If
> we are traversing the object graph to repack, for example, we would want
> to abort if we are missing a reachable object (i.e., the repository is
> corrupt).
> 
>> I tried:
>>
>>  $ git cat-file -t 7713c3b1e9ea2dd9126244
>>  fatal: Not a valid object name 7713c3b1e9ea2dd9126244
> 
> Not surprising, if we don't have the object. What is curious is why git
> wants to look it up in the first place. I.e., who is referencing it?
> 
> Either:
> 
>   1. It is an object that we are OK to be missing (e.g., the
>      UNINTERESTING side of a traversal), and the error should be
>      suppressed.
> 
>   2. Your repository really is corrupted, and this is a case where we
>      need to be paying attention to the return value of parse_commit but
>      are not.
> 
> I'd love to see:
> 
>   - the output of "GIT_TRACE=1 git gc" (to see which subcommand is
>     causing the error)
> 
>   - the output of "git fsck" (which should hopefully confirm whether or
>     not there is a real problem)

See attached file.

>   - any mentions of the sha1 in the refs or reflogs. Something like:
> 
>       sha1=7713c3b1e9ea2dd9126244697389e4000bb39d85
>       cd .git
>       grep $sha1 $(find packed-refs refs logs -type f)

That gives nothing.

>   - If that doesn't turn up any hits, then presumably it's an object
>     referencing the sha1. We can dig into the objects (all of them, not
>     just reachable ones), like:
> 
>       {
>         # loose objects
>         (cd .git/objects && find ?? -type f | tr -d /)
>         # packed objects
>         for i in .git/objects/pack/*.idx; do
>           git show-index <$i
>         done | cut -d' ' -f2
>       } |
>       # omit blobs; they are expensive to access and cannot have
>       # reachability pointers
>       git cat-file --batch-check='%(objecttype) %(objectname)' |
>       grep -v ^blob |
>       cut -d' ' -f2 |
>       # now get all of the contents, and look for our object; this is
>       # going to be slow, since it's one process per object; but we
>       # can't use --batch because we need to pretty-print the trees
>       xargs -n1 git cat-file -p |
>       less +/$sha1

Turns out to be a tree:

tree 7713c3b1e9ea2dd9126244697389e4000bb39d85
parent d7acfc22fbc0fba467d82f41c90aab7d61f8d751
author Stefan Naewe <stefan.naewe@atlas-elektronik.com> 1429536806 +0200
committer Stefan Naewe <stefan.naewe@atlas-elektronik.com> 1429536806 +0200


> I would have guessed this was maybe caused by trying to traverse
> unreachable recent objects for reachability. It fits case 1 (it is OK
> for us to be missing these objects, but we might accidentally complain),
> and it would probably happen twice during a gc (once for the repack, and
> once for `git prune`).
> 
> But that code should not be present in older versions of msysgit, as it
> came in v2.2.0 (and I assume "older msysgit is v1.9.5). 

Not exactly. My msysgit is merge-rebase'd (or rebase-merge'd...) onto v2.2.0...
I'll try older versions (pre v2.2.0) on linux.

> And if that is
> the problem, it would follow a copy of the repo, but not a clone (though
> I guess if your clone was on the local filesystem, we blindly hardlink
> the objects, so it might follow there).

I also cloned from local filesystem (widnows drive) to a samba share.

Thanks,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: Useless Invention: How-to cassettes for the deaf.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF

--------------000704080408010700030505
Content-Type: text/plain; charset="windows-1252"; name="git-trace.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="git-trace.log"

JCBHSVRfVFJBQ0U9MSBnaXQgZ2MKMTA6MjE6MjcuMjI4ODQ1IGdpdC5jOjM0OCAgICAgICAg
ICAgICAgIHRyYWNlOiBidWlsdC1pbjogZ2l0ICdnYycKMTA6MjE6MjcuMjI4ODQ1IHJ1bi1j
b21tYW5kLmM6MzQ3ICAgICAgIHRyYWNlOiBydW5fY29tbWFuZDogJ3BhY2stcmVmcycgJy0t
YWxsJyAnLS1wcnVuZScKMTA6MjE6MjcuMjQ0NDQ1IGdpdC5jOjM0OCAgICAgICAgICAgICAg
IHRyYWNlOiBidWlsdC1pbjogZ2l0ICdwYWNrLXJlZnMnICctLWFsbCcgJy0tcHJ1bmUnCjEw
OjIxOjI3LjI2MDA0NSBydW4tY29tbWFuZC5jOjM0NyAgICAgICB0cmFjZTogcnVuX2NvbW1h
bmQ6ICdyZWZsb2cnICdleHBpcmUnICctLWFsbCcKMTA6MjE6MjcuMjc1NjQ2IGdpdC5jOjM0
OCAgICAgICAgICAgICAgIHRyYWNlOiBidWlsdC1pbjogZ2l0ICdyZWZsb2cnICdleHBpcmUn
ICctLWFsbCcKMTA6MjE6MjcuMzM4MDQ3IHJ1bi1jb21tYW5kLmM6MzQ3ICAgICAgIHRyYWNl
OiBydW5fY29tbWFuZDogJ3JlcGFjaycgJy1kJyAnLWwnICctQScgJy0tdW5wYWNrLXVucmVh
Y2hhYmxlPTIud2Vla3MuYWdvJwoxMDoyMToyNy4zNTM2NDcgZ2l0LmM6MzQ4ICAgICAgICAg
ICAgICAgdHJhY2U6IGJ1aWx0LWluOiBnaXQgJ3JlcGFjaycgJy1kJyAnLWwnICctQScgJy0t
dW5wYWNrLXVucmVhY2hhYmxlPTIud2Vla3MuYWdvJwoxMDoyMToyNy4zNTM2NDcgcnVuLWNv
bW1hbmQuYzozNDcgICAgICAgdHJhY2U6IHJ1bl9jb21tYW5kOiAncGFjay1vYmplY3RzJyAn
LS1rZWVwLXRydWUtcGFyZW50cycgJy0taG9ub3ItcGFjay1rZWVwJyAnLS1ub24tZW1wdHkn
ICctLWFsbCcgJy0tcmVmbG9nJyAnLS1pbmRleGVkLW9iamVjdHMnICctLXVucGFjay11bnJl
YWNoYWJsZT0yLndlZWtzLmFnbycgJy0tbG9jYWwnICctLWRlbHRhLWJhc2Utb2Zmc2V0JyAn
LmdpdC9vYmplY3RzL3BhY2svLnRtcC0zODUyLXBhY2snCjEwOjIxOjI3LjM4NDg0OCBnaXQu
YzozNDggICAgICAgICAgICAgICB0cmFjZTogYnVpbHQtaW46IGdpdCAncGFjay1vYmplY3Rz
JyAnLS1rZWVwLXRydWUtcGFyZW50cycgJy0taG9ub3ItcGFjay1rZWVwJyAnLS1ub24tZW1w
dHknICctLWFsbCcgJy0tcmVmbG9nJyAnLS1pbmRleGVkLW9iamVjdHMnICctLXVucGFjay11
bnJlYWNoYWJsZT0yLndlZWtzLmFnbycgJy0tbG9jYWwnICctLWRlbHRhLWJhc2Utb2Zmc2V0
JyAnLmdpdC9vYmplY3RzL3BhY2svLnRtcC0zODUyLXBhY2snCmVycm9yOiBDb3VsZCBub3Qg
cmVhZCA3NzEzYzNiMWU5ZWEyZGQ5MTI2MjQ0Njk3Mzg5ZTQwMDBiYjM5ZDg1CjEwOjIxOjI3
LjkxNTI1OCBydW4tY29tbWFuZC5jOjM0NyAgICAgICB0cmFjZTogcnVuX2NvbW1hbmQ6ICdw
cnVuZScgJy0tZXhwaXJlJyAnMi53ZWVrcy5hZ28nCjEwOjIxOjI3LjkzMDg1OCBnaXQuYzoz
NDggICAgICAgICAgICAgICB0cmFjZTogYnVpbHQtaW46IGdpdCAncHJ1bmUnICctLWV4cGly
ZScgJzIud2Vla3MuYWdvJwplcnJvcjogQ291bGQgbm90IHJlYWQgNzcxM2MzYjFlOWVhMmRk
OTEyNjI0NDY5NzM4OWU0MDAwYmIzOWQ4NQoxMDoyMToyOC4xOTYwNjMgcnVuLWNvbW1hbmQu
YzozNDcgICAgICAgdHJhY2U6IHJ1bl9jb21tYW5kOiAncmVyZXJlJyAnZ2MnCjEwOjIxOjI4
LjIxMTY2NCBnaXQuYzozNDggICAgICAgICAgICAgICB0cmFjZTogYnVpbHQtaW46IGdpdCAn
cmVyZXJlJyAnZ2MnCiQgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KJCBnaXQgZnNjawpkYW5n
bGluZyBjb21taXQgOGEwMDY2Yzc1NmUxM2U1ZjhiMDJmZGFiNDcxNmJmZjc0ZGU3NTU2ZQpk
YW5nbGluZyBjb21taXQgNDUwMTExMTMxYmI1NGMyYTc0MjZjN2M0ZDA3NzI5ZDk2YTNhNGIw
OApkYW5nbGluZyBibG9iIGU2YzFmMGIwNmQ3YzI1NzFmMjc4ODVlZmI3MjI2MjhhNTY0MGY1
YmIKZGFuZ2xpbmcgYmxvYiBhZDAyNmYxN2VmM2NhNzZjOGU2YTE3NmIwZTljMTYxODIwY2I1
NWJkCmRhbmdsaW5nIGNvbW1pdCBiYjgyOGUzYWVhOWNkOGNhNDcyYjdiZjg0MTc1YzJkNzg2
YzZiY2E2CmRhbmdsaW5nIGJsb2IgY2Y4MmExODk3N2IzNDBlOGQ1MmYwZTdkNWEyN2NjOTVk
ZTc5MDgzZQpkYW5nbGluZyBjb21taXQgZTgyMmY1ZmQyMWNiN2MwNTIzZDczNDc0ZDdmZDVm
NzAzOGM1MzMyMwpkYW5nbGluZyBibG9iIDEzMjM1NWRkNzUwYzM0MjVmNTY2ZGI0ZGY5M2Qx
MWRkNTcxM2VlNTcKZGFuZ2xpbmcgYmxvYiAzYmEzNTI4MDg0MzhmYmNiOTM3ZWZiZmUyOTc1
NzJlNTYyOTYyMmJlCmRhbmdsaW5nIGJsb2IgM2Y2MzE1ZTk3ODkzMDliMGI2MDhlMTMwZDg2
M2I5OWJiZjQ3OWVhNApkYW5nbGluZyBjb21taXQgOTAyMzk5ZWIzZDE2NjA2OTQwYzM3MzM0
MGFiMjg3NjkzOTgxMDk0ZApkYW5nbGluZyBibG9iIGQ2YzMwZGIzMzk2ZmQxNTdmOTA1MTA2
OGY4NWU1N2I5YzBlZWM1ZDYKZGFuZ2xpbmcgYmxvYiAzMzQ0ZmEwNjg5NzVhM2I1ZjhiYmIw
MDE2MTM2N2ZkNWNmZTc1YzU2CmRhbmdsaW5nIGJsb2IgNWVhNDYwMTU4ZDIyOTc5ODk4ZThj
NzI2NTBjOTgwNzRkM2Y5ZjlkNwpkYW5nbGluZyBibG9iIGRkMjQ3YmQwZTE4MzkwM2U4MGM2
MzRlM2Q5N2Q3NTc5MDJjMTk4MjkKZGFuZ2xpbmcgY29tbWl0IDc4ODU5MTM1YTQ2YmJkZTBi
ZmQ1NGFkZDQxMzhkNjQ5MmNmMTUwOWEKZGFuZ2xpbmcgYmxvYiA4NGU1YjcyNTRhNTIxMTVh
ZGUzZjExZmNkYzM5YWQzZDk0ODBhZjVhCmRhbmdsaW5nIGJsb2IgYjA4NWJiZjNiNmEzMDIx
ZmQyOGZmNTRmMTAyYWVmOTBiYWU0MWZmYgpkYW5nbGluZyBibG9iIGRhYzUxZTk5OWMzODIw
MTQyYzRiN2VjZmZjN2E4MjQ5ZTFkODNjMzEKZGFuZ2xpbmcgY29tbWl0IDhhZTZmMjRjMmY2
ZjFlMDQ5NGE5NTAyMDEzMWQ3YzMyNmJjNzRhNGQKZGFuZ2xpbmcgYmxvYiA5M2E2MjcwMjM2
ZTM5OTU5YjRlMWExYmI0OTk2YTQ5ODE5YmQ4YmI4CmRhbmdsaW5nIGJsb2IgN2VlN2M0MmU5
OGU2NGEyNTNlNTE4M2I3YTBmYjBkNWZlOGFjNjJkNApkYW5nbGluZyBibG9iIGExZTc3OTUw
NDllNDU5ZGI1OWNiODk3NDIyZDZiNWI5Mjg0ZjAyYzQKZGFuZ2xpbmcgY29tbWl0IDE1MDhm
YTJiYjFiZWJhMzJjZTk3ZDlmZTUyYmE0MWYxNjJjZDJhNTIKZGFuZ2xpbmcgYmxvYiAzNWU4
NWIxOWRhNTczMzFhNmRmZjVkYTNmOThkYmNiYTAwYjFmNWNmCmRhbmdsaW5nIGNvbW1pdCAz
ZDg4NTZjYWY0NDhiZjZmZDhmMjU1NTMxY2QyNDJlOTM3Y2ZlNjBlCmRhbmdsaW5nIGJsb2Ig
ODhlODk4NDAzNjg2NjIyYmVlMmY1YTU2ZTFkY2FiZDNmM2U3NmQ3ZgpkYW5nbGluZyBjb21t
aXQgZmI2ODgxOWQ2NTM1NTU0NTZhMWM4YTY5YWRmZWQ1OWI4NzE0ZmRjYgpkYW5nbGluZyBj
b21taXQgNjYwOTUzNzBlZTdjMDFmOTdlNTViYmFmYjQ2MTczZDQ2MzI0ZDU2NgpkYW5nbGlu
ZyBibG9iIDcxMDlkYmJiNjUzODI5NjFiYWQ3OGU5NmU3NTlkYzEwYzYwODk4OTMKZGFuZ2xp
bmcgYmxvYiA0MzJhNjZlMDdiYzBjNzJiMTE2NjZjYTQyOGU0YzE0NDY2NGI4ZDlkCmRhbmds
aW5nIGNvbW1pdCBhZTRhOTFjMTNiNDQ4YzFlMGRmM2VhNWE0OTBlYWFkZDI5NWI3NzVkCmRh
bmdsaW5nIGJsb2IgMjEyYmNjNTA3M2QzZjE1ZDU1NGM1N2M1ODY2MDdiMTc2OTk5ZmE2ZQpk
YW5nbGluZyBibG9iIDM3NGI5ZmZjZWMxZDNjMDUyNmFjMjgwYjNlMjMwMTk5OTU1NzcyMjkK
ZGFuZ2xpbmcgYmxvYiA3NWFiZGRiYzY2MmQyYWQ0MTE2Y2ZkMWQxYjQ2NTJhMjhjZGY3NTE2
CmRhbmdsaW5nIGNvbW1pdCAxMzZjMjE2MTIwYzdjNmQ1NjJlNjdlZjZhMjZlMTE4ZjNkMzc3
ZDc1CmRhbmdsaW5nIGJsb2IgYjQ4YzEzYmY3YWI5MjBmZTlkNmRhZTNkZDQ5NjA2MTZlMTQ2
ZTJjNApkYW5nbGluZyBibG9iIDEyY2Q0YmYxM2M5MDkxODg0MWFjZGUxNmE4NGMxMjlmNGZl
NGMxY2IKZGFuZ2xpbmcgYmxvYiA0NDhlNmVjYTBiZGQ5MDcwNjI4ZmU5OGEzYjEzYWYzNTQy
ZWViMTkwCmRhbmdsaW5nIGJsb2IgYWY4ZTEwZjY2YTk2OTIwZjljYWY3YWJjN2U3NzhhOGVk
MjViN2U3ZgpkYW5nbGluZyBibG9iIDJmMmZlNzIwMDkzODYzZTQ1NWZkMzUwOTgyZDIyMDEz
MjY4ZGI0YWIKZGFuZ2xpbmcgYmxvYiA3ODZmZDc2ZDZlOTBiZDBmODEyNjg1YmNmMjEzMDhm
NDY5Y2ZmODA2CmRhbmdsaW5nIGNvbW1pdCBiOGNmOGE3YzMzODJhZTI0M2UzNjkxZGU0Mzdj
MTc5ZjZmZTViMTA5CmRhbmdsaW5nIGNvbW1pdCBkZWVmMTllYjhiNjA2ODk5ZDE4YTc3ZTU2
NzE1NjllZTQyMmU1Yzc0CmRhbmdsaW5nIGJsb2IgYzAxMDAyZGExMjEzOGI4NDNlZmMzNzk0
YWUwNTc4MjhkNTc3MTNmZgpkYW5nbGluZyBibG9iIDZlMzFlMzFlMjE0NjI4ZjVjZmIyMDhi
MDlmNGM4Y2I2ZTBhN2VmZDcKZGFuZ2xpbmcgY29tbWl0IGMwMTE2OGViNGYxMDkzNzM0NzAz
NTM4OGU4MmMzNGIzNmI1ZTc1N2EKZGFuZ2xpbmcgY29tbWl0IGM1ZjFlMWYyYTA0YmQ0NmYw
ZjAwMTdiZTZkYmZlMzkxNzBkYWNkMzcKZGFuZ2xpbmcgY29tbWl0IGM2NzE3MDAzMzJkYWM3
MGNiOGYwMmI0OWQ0OTA4NTYzNWRiODI5YjcKZGFuZ2xpbmcgY29tbWl0IGM3YjE2NzA0YTg5
YzVlNmRmZjI2MjUxYzVjM2MzNTk2NjQzYTQ3NjUKZGFuZ2xpbmcgYmxvYiAxM2QyY2RjYTk0
NTY3NTUwZjU3MjBkNzI3MTQwNGQ1Y2YxNDY1Yjc2CmRhbmdsaW5nIGJsb2IgN2E5MjE2YmQz
OWMwMjQ5MjY3ZGEyNGUzNzRiOTNiMGJlZjdiYWIzYQpkYW5nbGluZyBibG9iIGUyNzI5NDNh
ZDY0OTAxMTc0OWQ5OWExMDJmNzVjYmIyY2ZlMDQ4MWMKZGFuZ2xpbmcgYmxvYiBlNDEyYThk
OWY5MWFjNWFiNjIxYzYwN2U5ZTc5ZGQwNzBmMDU3NWVhCmRhbmdsaW5nIGJsb2IgMTVkM2Ux
YzIzZDExOTYzNDk0ZjFmZGRmZmRmYmU4ZDgyMjgxZWJlNwpkYW5nbGluZyBibG9iIGRjYjNl
Y2U2NzNiZDcxYjJhN2NkNzk3ODYzYWIwNWI5ZjU1ZDk4MmEKZGFuZ2xpbmcgYmxvYiBlODkz
ZWRjZTQ0MTk4ZmMzZWQ3ZDJhMGE4MDBhZGRiOWY3ZmNkZDAwCmRhbmdsaW5nIGNvbW1pdCAy
Yzc0ZGJhNGNiODc2MjJiZjI4MWZlYTk1NDk1NTgwZWQ3MTY5ZjdmCmRhbmdsaW5nIGNvbW1p
dCAzODM0OWVlOTVkNzYxYmFkZmI2ZWY4Njg5OTc0NGZmYTdhYTZkYzRkCmRhbmdsaW5nIGNv
bW1pdCAzYjM0OGYzZWFlMGUxNGNkYWY3OTJlYTExMzM0ZjFlYTIwYjhhYzIxCmRhbmdsaW5n
IGNvbW1pdCA1ODc0ZmY1NjkyNjA4MzNiN2RhMTQ1NjVjOWEwNDE3MmY0NWJlYTM0CmRhbmds
aW5nIGJsb2IgODZkNDdkMTZkN2NmNmI0NjBmZjdmMmQ4MjE4NDVhZGQzODViMTY4YQpkYW5n
bGluZyBibG9iIDhlMTRkMDM3NmFlNGM5NjM2NTQwMzhhYjg1NTJjMTRhODhjODJmMTkKZGFu
Z2xpbmcgY29tbWl0IDk2NzRkYWUwNDcwZTE2NTlkMDhkNzI1OGZjODdjY2I2NTQ2OWMzNzcK
ZGFuZ2xpbmcgY29tbWl0IGE4OTQ0MzQ4MDRlNjQ0ZDUyZjE4ZWFjNjU2NGI1NDcwYzM1NWEw
ZmQKZGFuZ2xpbmcgY29tbWl0IGZkZjQ1OGI3ZmZhNmY4MTAzODk4ODgxOGY2YmRiMTQ4ZGRi
ZDI3NDcKZGFuZ2xpbmcgYmxvYiAxYTE1NDQ1NmZkMjAyNjc4ZDA5YzhmZTM0ODhhN2ZmNWVi
MTI4ZjBlCmRhbmdsaW5nIGNvbW1pdCAzMTU1MDBjOTZhNzA1YTE5YmRhNTUxYjU1MmJiNGFm
NzZhNTQyM2I5CmRhbmdsaW5nIGJsb2IgMzVkNTQxYTE2OTgzNzMyZmIzMzIwNTcxMWE0YWUy
NzU2NTlmMzViZgpkYW5nbGluZyBibG9iIGE3MzU0ZDU5Y2Q0NDk1MTVkYWYxZGE1NjNkNGE4
MWIwNTExZTQzZjcKZGFuZ2xpbmcgY29tbWl0IGJmYjU1MzgxNzFjMWEwMGEwOWI5NzkwMDVh
MDMyNDAwYjhiZTZjMTEKZGFuZ2xpbmcgYmxvYiBkYTM1ZjAzNGQxMzBhMGQ1YTc4NjRiMjQz
ZTkxOWMyODg1YWY3ZGNiCmRhbmdsaW5nIGNvbW1pdCAyNTM2NWI4N2U3NDc5MmJkMjc4YWZl
YzUxYWZkZmM3NGVmMzc4MzAxCmRhbmdsaW5nIGJsb2IgOWYzNjI1NGZkYWU2ZWQ4ZTU0M2Q4
YWRhMWRmZWI3MjczMzIyNDIxZgpkYW5nbGluZyBjb21taXQgODIzNzVlNzU1YmViYWI4YjRh
NWMzNGNjMjI3ZmRmYmNhZjU4Nzg3OApkYW5nbGluZyBjb21taXQgMWY3OGY3NmFlYjQyY2Rk
NWU3ZGQ1MjAxZWI0NmYxMWIxNzk0Yjk1OQpkYW5nbGluZyBjb21taXQgNDQxOGQxMWRjNzZh
NGViMDMyN2MyZjE4MmM0MDU4NDc3NGYxZmEyNwpkYW5nbGluZyBjb21taXQgOTI1ODUwYjFl
NThiNjY1YmQ1ZGY1MDhlYjdjYjk5ZWVkYWU4YjQ3MgpkYW5nbGluZyBjb21taXQgYTEzODc2
MGU0YjdjMzI0ZmQ1NGU1Mjk5OGFiMTllZDRjNDEwNjA2NApkYW5nbGluZyBibG9iIGRlNzg4
ZGI5NzRjYTY3NjA2MTAyZjMwMWNiYzk5MjZhNTVlMWQ5YTIKZGFuZ2xpbmcgYmxvYiAwZDc5
NDNmNjk3ZTMxNmI5ZDk3ZmY4OWIwZWZjMzQxNDI1MjA1NDI2CmRhbmdsaW5nIGNvbW1pdCAw
ZTk5OTk4OTk1OGI3YjdhOWU1NzE4NTAwYmMwZDIxMjJlNTE1NWFjCmRhbmdsaW5nIGJsb2Ig
MmQ1OWMwNWY2ODZmODg2ODRjNjUzNTllMmFmNDZiMGEyZTJjMTM4NQpkYW5nbGluZyBibG9i
IDk2NTkxZjdkYzFlOWY2ZDFiNTQwODg0YzIyMDFkYTI1YjQ0MzU2MTEKZGFuZ2xpbmcgYmxv
YiBiMjM5ZmYzYjI4MmM5ZDQ1ZDVlOTAxODM1ZjIxN2RjMjhiOTQ5YjMyCmRhbmdsaW5nIGJs
b2IgZGY3OTY4Y2RjNWQ1NjU4NDY0MWY2MTFmNmY5MDc3MjcwNDhkNzJjZgpkYW5nbGluZyBi
bG9iIDFmNWExMzc3ZThmOTIwZTkzOTI2OTZmMTE4Nzg4NmI4NWE2NWM3OTQKZGFuZ2xpbmcg
YmxvYiA0OWZiZTM0MzcxYzBkZGQzOTFmMzVlYzA1YzVlNmI5MTY2MDE2ZmExCmRhbmdsaW5n
IGJsb2IgNTk5YmRmZTUwNzA3ODhmYzMwMWQzMDAyZWUzOTczMzgzZDBiNmNmOQpkYW5nbGlu
ZyBjb21taXQgNWEzYjI5YzZjZjlhNjIyNTJlNjA3ZDJhMzY3NDAyNTQ5Yjk4MWI2NwpkYW5n
bGluZyBibG9iIDFlZGM1YTNjMmRlNGE4ODNlMGI5NTlhNjYzNzI3YmZmNjkxNzA3YWYKZGFu
Z2xpbmcgYmxvYiA4MWZjMGE3Zjc0MmQ2YzljNjI5ZDIyZmMzYThlY2NmYzYzMWYyMTY1CmRh
bmdsaW5nIGNvbW1pdCAzZTdkZGQyZjdiMjVkNjQyMmE2YmFhZTEyOWNjNGMyYTFiZTA5NzI4
CmRhbmdsaW5nIGJsb2IgOTBkZDRjZjVhZTljNmQ5YjhlZWZmZjA0MDk5ZWM3NjA5MzYyMjcz
OApkYW5nbGluZyBibG9iIDliM2RkYjlhOGU1YWMyYWRiZjBmMmMzYjQwZTljOTNmOTViMzc3
MGQKZGFuZ2xpbmcgY29tbWl0IGU2N2Q1MjdjODRlZWIwOTVhYjhhNjI3Y2MwZDM2OWU0OTcw
OGFmMWIKZGFuZ2xpbmcgYmxvYiAwNjFlMTczZWU2NjdmODJiOTUyZjU3OTk4ZmM3NjY2NDIw
Y2JlY2E1CmRhbmdsaW5nIGNvbW1pdCAzYmJlZjVhNDk4ZDZmYmZlMzRhNWYwNjgyOGRhMWY5
YjFmMjY5OTBkCmRhbmdsaW5nIGNvbW1pdCA2ZTdlNmQ0OTQ5MGM4OGEzYzk3NGY4MGJhYTk0
YTUwNTQ1M2IzYjg3CmRhbmdsaW5nIGJsb2IgODdiZTJiY2YwMjM4ZmM2NDY3MWRmYjRkM2M1
NmI1MTE2ZjhlMDkzOQpkYW5nbGluZyBjb21taXQgOGZkZTliZjhiODU1MTkxOTM2ZjU2NWY4
Y2UxMjA3ZGE0ZmY3ZjcwZgpkYW5nbGluZyBibG9iIDk2N2U4OGJhYmQ5OTNiNzZmOWUwMzkx
NmJlYjI4YzJiZWE3YWNjYmQKZGFuZ2xpbmcgYmxvYiBjNmJlODk4N2QwYWRlYWMzNmE1MzY5
MTA3Njk1MGE2ODQ0MGU2YjFlCmRhbmdsaW5nIGNvbW1pdCBkNTllZDA2NzU2MjdiMzZkN2Fk
ODM2YjgxMGEzZWRlMTNjYmRlZTE3CmRhbmdsaW5nIGJsb2IgNDhkZmY0MDZjMTZmMmFhMTgy
ZTBlMjJmODdjZDdhNGJlZjYwMDA3MgpkYW5nbGluZyBjb21taXQgNGFkZjdmMjNiYmEzMWNi
YjdiMDYyODM2N2M1MWFiYTBlNjgzNTljNQpkYW5nbGluZyBibG9iIDgxZmY1MmNhODkzMmM2
ZjViNjQ3MzdiMjhlMDdhMThhZjAwNTZmMzgK
--------------000704080408010700030505--
