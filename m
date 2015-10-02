From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH/RFC 1/2] sha1_file: close all pack files after running
Date: Fri, 2 Oct 2015 22:06:46 +0300
Message-ID: <20151002190646.GC26154@wheezy.local>
References: <1443670163-31193-1-git-send-email-max@max630.net>
 <1443670163-31193-2-git-send-email-max@max630.net>
 <33b74e875c7298f67640f5850e88c152@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 02 21:06:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi5fU-0002Bq-FU
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 21:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbbJBTGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 15:06:52 -0400
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:42806
	"EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818AbbJBTGv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2015 15:06:51 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-02.prod.phx3.secureserver.net with 
	id QK6n1r00A5B68XE01K6qNy; Fri, 02 Oct 2015 12:06:51 -0700
Content-Disposition: inline
In-Reply-To: <33b74e875c7298f67640f5850e88c152@dscho.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278942>

On Fri, Oct 02, 2015 at 12:05:55PM +0200, Johannes Schindelin wrote:
> Hi Max,
> 
> On 2015-10-01 05:29, Max Kirillov wrote:
>> When a builtin has done its job, but waits for pager or not waited
>> by its caller and still hanging it keeps pack files opened.
>> This can cause a number of issues, for example on Windows git gc
>> cannot remove the packs.
> 
> I did not experience that issue. In any case, closing the
> packs after the builtin function has returned might not
> change anything anyway because we are about to `exit()`
> and that's that.

Steps to reproduce:
1. install the latest git-for-windows, 2.6.0.windows.1
2. run the script in the end of message
3. remember the directory name, press the enter as it asks
4. in the less scrool down

Then inspect the processes git.exe and less.exe with Process
Explorer of something you find convenient. Both processes
should have opened the pack file, and git.exe should have it
mapped (I found it in the "View"->"Lower Pane views"->"Dlls").

Then, if you run another bash window, cd to the repository
and run "git repack -a -d", it should print:

----
$ git repack -a -d
Counting objects: 3001, done.
Compressing objects: 100% (1003/1003), done.
Writing objects: 100% (3001/3001), done.
Total 3001 (delta 997), reused 3001 (delta 997)
Unlink of file '.git/objects/pack/pack-e1b0e3ac01ff8d79a77648de3370f49b93c58a8b.pack' failed. Should I try again? (y/n)
----

I would like the git gc to succeed, because I run it as a
scheduled task nightly and feel a bit annoyed by the opened
windows which wait for me to say yes (after exiting pager).

So, the fix is needed approximately in that place, after
running any builtin command.

For your case, I think, the same close_all_packs() should be
invoked before the repacking.

> The convention in Git seems to call things _gently rather
> than _nodie:

Thanks, will change it if the idea is welcomed.

>> -void close_pack_windows(struct packed_git *p)
>> +static int close_pack_windows_nodie(struct packed_git *p)
>>  {
>>  	while (p->windows) {
>>  		struct pack_window *w = p->windows;
>>  
>>  		if (w->inuse_cnt)
>> -			die("pack '%s' still has open windows to it",
>> -			    p->pack_name);
>> +			return 1;
>> +
>>  		munmap(w->base, w->len);
>>  		pack_mapped -= w->len;
>>  		pack_open_windows--;
>>  		p->windows = w->next;
>>  		free(w);
>>  	}
>> +
>> +	return 0;
>> +}
> 
> And while we're at it, why not teach that function a new
> parameter `int close_pack_fd`?

I think "close windows" should close windows, if it also
closes pack fd probably should be another name. But current
code seems quite logical. Close the packs, and run closing
windows from it.

> There is another problem: when we cannot close the pack
> window, we cannot really continue, can we?

Yes we can, unlocking of the window is not needed for the
current process to do what it intended to do, it would just
interfere with concurrent git gc.

For the clone case probably die would be appropriate. If you
feel like it worth complicating the code we might search for
some solution.

-- 
Max

The script:
--------- ./t-windows-pack-close.sh ---------
#!/bin/sh

set -e

TEST_DIR=`mktemp -d`

t_git() {
    git --work-tree="$TEST_DIR" --git-dir="$TEST_DIR/.git" "$@"
}

t_git init

for i in $(seq 1000)
do
    echo "commit$i" >"$TEST_DIR/commit.$i"
    t_git add "commit.$i"
    t_git commit -m "commit$i" -q
done

t_git repack

pack_path=$(find "$TEST_DIR/.git/objects/pack" -name "pack-.pack")

echo "dir: $TEST_DIR"
echo press enter to start git log
read

t_git -c core.packedGitWindowSize=100 log
-----------------------------
