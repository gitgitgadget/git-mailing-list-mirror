From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon, 14 Jul 2014 18:33:10 +0100
Message-ID: <53C41456.2000006@ramsay1.demon.co.uk>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>	<1405140276-32162-4-git-send-email-dturner@twitter.com>	<CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com> <xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:33:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6k7r-0001ST-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 19:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbaGNRdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 13:33:16 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:35766 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751334AbaGNRdP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 13:33:15 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id C8F154008DE;
	Mon, 14 Jul 2014 18:33:08 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 76293400837;
	Mon, 14 Jul 2014 18:33:08 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Mon, 14 Jul 2014 18:33:07 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253499>

On 14/07/14 16:54, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>> On Sat, Jul 12, 2014 at 11:44 AM, David Turner <dturner@twopensource.com> wrote:
>>> @@ -342,6 +342,15 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>>>
>>>                 discard_cache();
>>>                 read_cache_from(index_lock.filename);
>>> +               if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
>>> +                       fd = open(index_lock.filename, O_WRONLY);
>>> +                       if (fd >= 0)
>>> +                               if (write_cache(fd, active_cache, active_nr) == 0) {
>>> +                                       close_lock_file(&index_lock);
>>
>> If write_cache() returns a negative value, index.lock is probably
>> corrupted. Should we die() instead of moving on and returning
>> index_lock.filename to the caller? The caller may move index.lock to
>> index later on and officially ruin "index".
> 
> Perhaps true, but worse yet, this will not play nicely together with
> your split index series, no?  After taking the lock and writing and
> closing, we spawn the interactive while still holding the lock, and
> the "open" we see here is because we want to further update the same
> under the same lock.  Perhaps write_locked_index() API in the split
> index series can notice that the underlying fd in index_lock has
> been closed earlier, realize that the call is to re-update the
> index under the same lock and open the file again for writing?

Hmm, I was just about to suggest that there was some negative interplay
between the 'dt/cache-tree-repair' and 'nd/split-index' branches as well.

The pu branch fails the testsuite for me. In particular, t0090-cache-tree.sh
fails like so:

    $ ./t0090-cache-tree.sh -i -v
    ...
    ok 9 - second commit has cache-tree

    expecting success: 
    	cat <<-\EOT >foo.c &&
    	int foo()
    	{
    		return 42;
    	}
    	int bar()
    	{
    		return 42;
    	}
    	EOT
    	git add foo.c &&
    	test_invalid_cache_tree &&
    	git commit -m "add a file" &&
    	test_cache_tree &&
    	cat <<-\EOT >foo.c &&
    	int foo()
    	{
    		return 43;
    	}
    	int bar()
    	{
    		return 44;
    	}
    	EOT
    	(echo p; echo 1; echo; echo s; echo n; echo y; echo q) |
    	git commit --interactive -m foo &&
    	test_cache_tree
    
    [master d1075a6] add a file
     Author: A U Thor <author@example.com>
     1 file changed, 8 insertions(+)
     create mode 100644 foo.c
               staged     unstaged path
      1:    unchanged        +2/-2 foo.c
    
    *** Commands ***
      1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
      5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
    What now>            staged     unstaged path
      1:    unchanged        +2/-2 [f]oo.c
    Patch update>>            staged     unstaged path
    * 1:    unchanged        +2/-2 [f]oo.c
    Patch update>> diff --git a/foo.c b/foo.c
    index 75522e2..3f7f049 100644
    --- a/foo.c
    +++ b/foo.c
    @@ -1,8 +1,8 @@
     int foo()
     {
    -return 42;
    +return 43;
     }
     int bar()
     {
    -return 42;
    +return 44;
     }
    Stage this hunk [y,n,q,a,d,/,s,e,?]? Split into 2 hunks.
    @@ -1,6 +1,6 @@
     int foo()
     {
    -return 42;
    +return 43;
     }
     int bar()
     {
    Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]? @@ -4,5 +4,5 @@
     }
     int bar()
     {
    -return 42;
    +return 44;
     }
    Stage this hunk [y,n,q,a,d,/,K,g,e,?]? 
    *** Commands ***
      1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
      5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
    What now> Bye.
    [master 65d7dde] foo
     Author: A U Thor <author@example.com>
     1 file changed, 1 insertion(+), 1 deletion(-)
    --- expect	2014-07-14 17:10:13.755209229 +0000
    +++ filtered	2014-07-14 17:10:13.763209258 +0000
    @@ -1 +1 @@
    -SHA  (3 entries, 0 subtrees)
    +invalid                                   (0 subtrees)
    not ok 10 - commit --interactive gives cache-tree on partial commit
    #	
    #		cat <<-\EOT >foo.c &&
    #		int foo()
    #		{
    #			return 42;
    #		}
    #		int bar()
    #		{
    #			return 42;
    #		}
    #		EOT
    #		git add foo.c &&
    #		test_invalid_cache_tree &&
    #		git commit -m "add a file" &&
    #		test_cache_tree &&
    #		cat <<-\EOT >foo.c &&
    #		int foo()
    #		{
    #			return 43;
    #		}
    #		int bar()
    #		{
    #			return 44;
    #		}
    #		EOT
    #		(echo p; echo 1; echo; echo s; echo n; echo y; echo q) |
    #		git commit --interactive -m foo &&
    #		test_cache_tree
    #	
    $ 

Note that I haven't even looked at the test failure itself yet.

However, I noticed that commit 002ccda ("cache-tree: write updated
cache-tree after commit", 11-07-2014) passes that test just fine, but
that the merge commit 7608c87e fails. Looking at the details of the
merge resolution, made me think of Duy's split index work.

I probably won't look at this further tonight, so this is just a
heads-up on a possible problem.

HTH

ATB,
Ramsay Jones
