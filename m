From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Fri, 13 Jun 2014 06:03:45 +0200
Message-ID: <539A7821.906@web.de>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>	 <xmqqa99h6hbh.fsf@gitster.dls.corp.google.com> <1402615835.5629.34.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 06:04:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvIig-000175-4S
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 06:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbaFMED6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 00:03:58 -0400
Received: from mout.web.de ([212.227.15.4]:60316 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbaFMED5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 00:03:57 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MZlMw-1XBBAz059C-00LVeO; Fri, 13 Jun 2014 06:03:47
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1402615835.5629.34.camel@stross>
X-Provags-ID: V03:K0:BVSWenYczHsyWFy+XpiIqKV9fpXweCf2r5yjUq+D3NoY3hCLgVX
 0A4mJlr+nusEOARUrG/ayPne8gftG2gpZd8uqGr4mBvbJDn35kxg4dPGMGvM5PSWqGc1edj
 iVnes+9EoYCqtQvHxUTTfWc2cJHgHd7lj2ll90VgrYQUIiKd78lJnN/TQRPRIdjMlG+NOJq
 u+/rsxSBR2kualNUZAI+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251513>

On 2014-06-13 01.30, David Turner wrote:
> On Thu, 2014-06-12 at 12:47 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>>
>>> This issue bit us again recently.
>>>
>>> In talking with some colleagues, I realized that the previous version
>>> of this patch, in addition to being potentially slow, was incomplete.
>>> Specifically, it didn't handle the case of refs/heads/case/one vs
>>> refs/heads/CASE/two; these are case clones even though they strcasecmp
>>> different.
>>
>> Good catch to realize that two refs that share leading paths that
>> are the same except for cases are also problematic, but that makes
>> this feature even less about "case clones", doesn't it?
> 
> I agree: word "clone" is less good now.  Maybe "case conflicts"?
> 
>> Also it somehow feels that the patch attempts to solve the issue at
>> a wrong level.  On a platform that cannot represent two refs like
>> these (e.g. trying to create "FOO" when "foo" already exists, or
>> trying to create "a/c" when "A/b" already exists---ending up with
>> "A/c" instead, which is not what the user wanted to create), would
>> it be more sensible to fail the ref creation without touching the
>> users of ref API such as receive-pack?  That way, you would also
>> catch other uses of refs that are not supported on your system,
>> e.g. "git branch a/c" when there already is a branch called "A/b",
>> no?
> 
> So we would change is_refname_available?  And to do this, we would
> change the ref_dir functions to take case into account?
> 
> This might be somewhat complicated because we could be starting from a
> repo which already has case conflicts.  What should we do about that?  I
> think this is even possible on a case-insensitive filesystem with
> packed-refs, although I have not checked. 
It is:

user@mac:~/test> git init
Initialized empty Git repository in /Users/tb/test/.git/
user@mac:~/test> git checkout -b Branch
Switched to a new branch 'Branch'

user@mac:~/test> echo a>a && git add a && git commit -m "Add a"
[Branch (root-commit) e27e99c] Add a
 1 file changed, 1 insertion(+)
 create mode 100644 a

user@mac:~/test> ls .git/refs/heads/
Branch

user@mac:~/test> git pack-refs --all

user@mac:~/test> ls .git/refs/heads/ 

user@mac:~/test> git checkout -b BRANCH

Switched to a new branch 'BRANCH'

user@mac:~/test> ls .git/refs/heads/
BRANCH
user@mac:~/test> git branch
* BRANCH
  Branch
user@mac:~/test> 


> The simplest idea is probably
> to pretend that the first conflicting refname component we find is the
> one true one, and reject new refs containing versions which are case
> conflicting with this one until the user cleans up their repo.  In other
> words, if the user has A/b and a/c already, and we find A/b first, then
> we reject a/d but allow A/d.   This is arbitrary, but workable.  We
> could warn about this situation when we load up the refs, too.  
> 
> Does this match what you are suggesting? 
> 
> If so, I think it is possible, and if I don't hear anything back from
> the other ref folks, I'll see if I have time to implement it.



I can see 2 ways "forward": Either to try to avoid case insensitve refs at all.
If you do that carefully in a project, it may work with the patches you suggest.

Or try to have a functionality to always use packed refs, and have a configuration
for it:

The advantage can be that branch names like "Branch" and "BRANCH" can live together
in a project, regardless if you have a case sensitive or insensitve file system.
This assumes that e.g. "core.packedrefs" is default true whenever core.ignorecase
is true, which we can easily do in init_db.c


Another advantage with the "always packed refs" is that you can have branches
bugfix and bugfix/next-bug side by side.
Today when you create a branch bugfix theh you have a file bugfix,
and can not create a directory called bugfix/ to store the file bugfix/next-bug.

I don't know if this is scaling well for many refs, some reports say it does not.
But I can imagine to mmap .git/packed-refs into memory, throw every line
into a hash table and do a lazy check if a ref is "good" whenever it is needed.
Or do it in git fsck ?

The disadvantege with packed refs is that you need to carefully lock one central
file, and that may be a bottleneck on a server.

I don't have that many refs in my projects, so I only can test on dummy repos,
more or less close to reality.
