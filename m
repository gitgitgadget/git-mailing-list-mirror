From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Git performance results on a large repository
Date: Sun, 05 Feb 2012 16:01:22 +0100
Message-ID: <4F2E99C2.7090609@dbservice.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com> <CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 16:35:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru47P-0007UC-F3
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 16:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab2BEPe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 10:34:57 -0500
Received: from static.133.192.47.78.clients.your-server.de ([78.47.192.133]:53643
	"EHLO office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab2BEPe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 10:34:57 -0500
X-Greylist: delayed 2005 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Feb 2012 10:34:56 EST
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.053,BAYES_00: -1.665,TOTAL_SCORE: -1.612,autolearn=ham
X-Spam-Level: 
X-Footer: ZGJzZXJ2aWNlLmNvbQ==
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sun, 5 Feb 2012 16:01:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0) Gecko/20120124 Thunderbird/10.0
In-Reply-To: <CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189945>

On 2/4/12 7:53 AM, Nguyen Thai Ngoc Duy wrote:
> On Fri, Feb 3, 2012 at 9:20 PM, Joshua Redstone<joshua.redstone@fb.com>  wrote:
>> I timed a few common operations with both a warm OS file cache and a cold
>> cache.  i.e., I did a 'echo 3 | tee /proc/sys/vm/drop_caches' and then did
>> the operation in question a few times (first timing is the cold timing,
>> the next few are the warm timings).  The following results are on a server
>> with average hard drive (I.e., not flash)  and>  10GB of ram.
>>
>> 'git status' :   39 minutes cold, and 24 seconds warm.
>>
>> 'git blame':   44 minutes cold, 11 minutes warm.
>>
>> 'git add' (appending a few chars to the end of a file and adding it):   7
>> seconds cold and 5 seconds warm.
>>
>> 'git commit -m "foo bar3" --no-verify --untracked-files=no --quiet
>> --no-status':  41 minutes cold, 20 seconds warm.  I also hacked a version
>> of git to remove the three or four places where 'git commit' stats every
>> file in the repo, and this dropped the times to 30 minutes cold and 8
>> seconds warm.
> Have you tried "git update-index --assume-unchaged"? That should
> reduce mass lstat() and hopefully improve the above numbers. The
> interface is not exactly easy-to-use, but if it has significant gain,
> then we can try to improve UI.
>
> On the index size issue, ideally we should make minimum writes to
> index instead of rewriting 191 MB index. An improvement we could do
> now is to compress it, reduce disk footprint, thus disk I/O. If you
> compress the index with gzip, how big is it?
If you're not afraid to add filesystem-specific code to git, you could 
leverage the btrfs find-new command (or use the ioctl directly) to 
quickly find changed files since a certain point in time. Other CoW 
filesystems may have similar mechanisms. You could for example store the 
last generation id in an index extension, that's what those extensions 
are for, right?

tom
