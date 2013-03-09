From: Bernhard Posselt <mail@bernhard-posselt.com>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Sat, 09 Mar 2013 01:08:32 +0100
Message-ID: <513A7D80.5000501@bernhard-posselt.com>
References: <5139D76D.80703@bernhard-posselt.com> <20130308212831.GA9217@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 09 01:09:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE7Lr-0005pM-6v
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 01:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab3CIAJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 19:09:00 -0500
Received: from suou.newyork.w1r3.net ([204.62.14.108]:59321 "EHLO
	suou.newyork.w1r3.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab3CIAI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 19:08:59 -0500
Received: from [192.168.1.139] (194-208-147-142.tele.net [194.208.147.142])
	by suou.newyork.w1r3.net (Postfix) with ESMTPSA id 0007441A04;
	Sat,  9 Mar 2013 01:08:56 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130308212831.GA9217@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217694>

On 03/08/2013 10:28 PM, Jeff King wrote:
> On Fri, Mar 08, 2013 at 01:19:57PM +0100, Bernhard Posselt wrote:
>
>> Using valgrind gives me:
>>
>> $ valgrind /usr/bin/git pull --rebasehttps://github.com/PatrickHeller/core.git  master
>> ==5995== Memcheck, a memory error detector
>> ==5995== Copyright (C) 2002-2012, and GNU GPL'd, by Julian Seward et al.
>> ==5995== Using Valgrind-3.8.1 and LibVEX; rerun with -h for copyright info
>> ==5995== Command: /usr/bin/git pull --rebasehttps://github.com/PatrickHeller/core.git  master
>> ==5995==
>> remote: Counting objects: 5, done.
>> remote: Compressing objects: 100% (1/1), done.
>> remote: Total 3 (delta 2), reused 3 (delta 2)
>> Unpacking objects: 100% (3/3), done.
>>   Fromhttps://github.com/PatrickHeller/core
>>    * branch            master     -> FETCH_HEAD
>> First, rewinding head to replay your work on top of it...
>> Applying: distinguish between touch and write
>> Applying: remove debug output
>> *** Error in `git': malloc(): memory corruption: 0x00000000027f14e0 ***
> The problem is likely happening in a sub-command of git-pull, so
> valgrind isn't reporting it. Can you try re-running with
> "valgrind --trace-children=yes", or alternatively narrow down the
> problematic command by setting GIT_TRACE=1 in the environment?
>
> -Peff
Thanks for the reply!

Heres the output with GIT_TRACE=1, the valgrind log has 4000 lines. If 
you should still require the valgrind log, please tell me.

$ git pull --rebase https://github.com/PatrickHeller/core.git master
trace: exec: 'git-pull' '--rebase' 
'https://github.com/PatrickHeller/core.git' 'master'
trace: run_command: 'git-pull' '--rebase' 
'https://github.com/PatrickHeller/core.git' 'master'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--is-bare-repository'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'ls-files' '-u'
trace: built-in: git 'symbolic-ref' '-q' 'HEAD'
trace: built-in: git 'config' '--bool' 'branch.master.rebase'
trace: built-in: git 'config' '--bool' 'pull.rebase'
trace: built-in: git 'rev-parse' '-q' '--verify' 'HEAD'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'update-index' '-q' '--ignore-submodules' '--refresh'
trace: built-in: git 'diff-files' '--quiet' '--ignore-submodules'
trace: built-in: git 'diff-index' '--cached' '--quiet' 
'--ignore-submodules' 'HEAD' '--'
trace: built-in: git 'rev-parse' '-q' '--git-dir'
trace: built-in: git 'rev-parse' '-q' '--verify' 
'refs/remotes/https://github.com/PatrickHeller/core.git/master'
trace: built-in: git 'rev-parse' '-q' '--verify' 'HEAD'
trace: built-in: git 'fetch' '--update-head-ok' 
'https://github.com/PatrickHeller/core.git' 'master'
trace: run_command: 'git-remote-https' 
'https://github.com/PatrickHeller/core.git' 
'https://github.com/PatrickHeller/core.git'
trace: run_command: 'rev-list' '--objects' '--stdin' '--not' '--all' 
'--quiet'
trace: run_command: 'fetch-pack' '--stateless-rpc' '--stdin' 
'--lock-pack' '--thin' 'https://github.com/PatrickHeller/core.git/'
trace: exec: 'git' 'fetch-pack' '--stateless-rpc' '--stdin' 
'--lock-pack' '--thin' 'https://github.com/PatrickHeller/core.git/'
trace: built-in: git 'fetch-pack' '--stateless-rpc' '--stdin' 
'--lock-pack' '--thin' 'https://github.com/PatrickHeller/core.git/'
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (1/1), done.
remote: Total 3 (delta 2), reused 3 (delta 2)
trace: run_command: 'unpack-objects' '--pack_header=2,3'
trace: exec: 'git' 'unpack-objects' '--pack_header=2,3'
trace: built-in: git 'unpack-objects' '--pack_header=2,3'
Unpacking objects: 100% (3/3), done.
trace: run_command: 'rev-list' '--objects' '--stdin' '--not' '--all'
trace: exec: 'git' 'rev-list' '--objects' '--stdin' '--not' '--all'
trace: built-in: git 'rev-list' '--objects' '--stdin' '--not' '--all'
 From https://github.com/PatrickHeller/core
  * branch            master     -> FETCH_HEAD
trace: built-in: git 'rev-parse' '-q' '--verify' 'HEAD'
trace: built-in: git 'show-branch' '--merge-base' 'refs/heads/master' 
'd686039828089d53fb42e42046d7a9a3992a0507'
trace: built-in: git 'fmt-merge-msg'
trace: built-in: git 'rev-parse' '--parseopt' '--' '--onto' 
'd686039828089d53fb42e42046d7a9a3992a0507' 
'd686039828089d53fb42e42046d7a9a3992a0507'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--is-bare-repository'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'config' '--bool' 'rebase.stat'
trace: built-in: git 'config' '--bool' 'rebase.autosquash'
trace: built-in: git 'rev-parse' '--verify' 
'd686039828089d53fb42e42046d7a9a3992a0507^0'
trace: built-in: git 'rev-parse' '--verify' 
'd686039828089d53fb42e42046d7a9a3992a0507^0'
trace: built-in: git 'symbolic-ref' '-q' 'HEAD'
trace: built-in: git 'rev-parse' '--verify' 'master^0'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'update-index' '-q' '--ignore-submodules' '--refresh'
trace: built-in: git 'diff-files' '--quiet' '--ignore-submodules'
trace: built-in: git 'diff-index' '--cached' '--quiet' 
'--ignore-submodules' 'HEAD' '--'
trace: built-in: git 'merge-base' 
'd686039828089d53fb42e42046d7a9a3992a0507' 
'0525bbd73c9015499ba92d1ac654b980aaca35b2'
First, rewinding head to replay your work on top of it...
trace: built-in: git 'checkout' '-q' 
'd686039828089d53fb42e42046d7a9a3992a0507^0'
trace: built-in: git 'update-ref' 'ORIG_HEAD' 
'0525bbd73c9015499ba92d1ac654b980aaca35b2'
trace: exec: 'git-am' '--rebasing' '--resolvemsg=
When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase 
--abort".
'
trace: run_command: 'git-am' '--rebasing' '--resolvemsg=
When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase 
--abort".
'
trace: built-in: git 'format-patch' '-k' '--stdout' '--full-index' 
'--ignore-if-in-upstream' '--src-prefix=a/' '--dst-prefix=b/' 
'--no-renames' 
'd686039828089d53fb42e42046d7a9a3992a0507..0525bbd73c9015499ba92d1ac654b980aaca35b2'
trace: built-in: git 'rev-parse' '--parseopt' '--' '--rebasing' 
'--resolvemsg=
When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase 
--abort".
'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-prefix'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'var' 'GIT_COMMITTER_IDENT'
trace: built-in: git 'rev-parse' '--verify' '-q' 'HEAD'
trace: built-in: git 'config' '--bool' '--get' 'am.keepcr'
trace: built-in: git 'mailsplit' '-d4' 
'-o/srv/http/owncloud/.git/rebase-apply' '-b' '--'
trace: built-in: git 'update-index' '-q' '--refresh'
trace: built-in: git 'diff-index' '--cached' '--name-only' 'HEAD' '--'
trace: built-in: git 'cat-file' '-t' 
'48bb53030c657e1133da47765c7c778a069af665'
trace: built-in: git 'cat-file' 'commit' 
'48bb53030c657e1133da47765c7c778a069af665'
trace: built-in: git 'config' 'i18n.commitencoding'
trace: built-in: git 'show' '-s' '--pretty=raw' '--encoding=UTF-8' 
'48bb53030c657e1133da47765c7c778a069af665' '--'
trace: built-in: git 'diff-tree' '--root' '--binary' '--full-index' 
'48bb53030c657e1133da47765c7c778a069af665'
Applying: distinguish between touch and write
trace: built-in: git 'write-tree'
trace: built-in: git 'rev-parse' '--verify' '-q' 'HEAD'
trace: built-in: git 'commit-tree' 
'd785d568d8b4649dfdcc01e03d6c8e87b036ea5a' '-p' 
'd686039828089d53fb42e42046d7a9a3992a0507'
trace: built-in: git 'update-ref' '-m' 'pull --rebase 
https://github.com/PatrickHeller/core.git master: distinguish between 
touch and write' 'HEAD' '2726978d8cbd9b0a3367fd3d62b64b4c78438e79'
trace: built-in: git 'cat-file' '-t' 
'45869afa5ac718e11c3d2e3bccdb501a022cfc24'
trace: built-in: git 'cat-file' 'commit' 
'45869afa5ac718e11c3d2e3bccdb501a022cfc24'
trace: built-in: git 'config' 'i18n.commitencoding'
trace: built-in: git 'show' '-s' '--pretty=raw' '--encoding=UTF-8' 
'45869afa5ac718e11c3d2e3bccdb501a022cfc24' '--'
trace: built-in: git 'diff-tree' '--root' '--binary' '--full-index' 
'45869afa5ac718e11c3d2e3bccdb501a022cfc24'
Applying: remove debug output
*** Error in `git': malloc(): memory corruption: 0x000000000139f4e0 ***
