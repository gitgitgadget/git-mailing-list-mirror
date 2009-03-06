From: thestar@fussycoder.id.au
Subject: Re: [PATCH] git-p4: improve performance with large files
Date: Fri, 06 Mar 2009 11:01:07 +1100
Message-ID: <20090306110107.cv3x1n7uskwg04cs@webmail.fussycoder.id.au>
References: <20090304215438.GA12653@zoy.org>
	<20090305100527.shmtfbdvk0ggsk4s@webmail.fussycoder.id.au>
	<20090305172332.GF25693@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 01:02:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfNWb-0005ae-AD
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 01:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbZCFABT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 19:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754850AbZCFABT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 19:01:19 -0500
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:46057
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754310AbZCFABS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 19:01:18 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgYDABP2r0nLWHaZ/2dsb2JhbACTXiKBfsIshAgG
X-IronPort-AV: E=Sophos;i="4.38,310,1233493200"; 
   d="scan'208";a="663968"
Received: from cherry.cbr.hosting-server.com.au ([203.88.118.153])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 06 Mar 2009 11:01:15 +1100
Received: (qmail 27918 invoked by uid 48); 6 Mar 2009 11:01:07 +1100
Received: from  ( [unknown]) by webmail.fussycoder.id.au (Horde MIME
	library) with HTTP; Fri, 06 Mar 2009 11:01:07 +1100
In-Reply-To: <20090305172332.GF25693@zoy.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112359>

Quoting Sam Hocevar <sam@zoy.org>:

> On Thu, Mar 05, 2009, thestar@fussycoder.id.au wrote:
>
>> >   The current git-p4 way of concatenating strings performs in O(n^2)
>> >and is therefore terribly slow with large files because of unnecessary
>> >memory copies. The following patch makes the operation O(n).
>>
>> The reason why it uses simple concatenation is to cut down on memory usage.
>>  - It is a tradeoff.
>>
>> I think the modification you have made below is reasonable, however be
>> aware that memory usage could double, which substantially reduce the
>> size of the changesets that git-p4 would be able to import /at all/,
>> rather than to merely be slow.
>
>    Uhm, no. The memory usage could be an additional X, where X is the
> size of the biggest file in the commit. Remember that commit() stores
> the complete commit data in memory before sending it to fast-import.
> Also, on my machine the extra memory is already used because at some
> point, "text += foo" calls realloc() anyway and often duplicates the
> memory used by text.

You are correct - sorry, got confused as I somehow got mistaken that  
that form (foo += bar) can potentially be optimized, but it doesn't.   
That's what I get for not paying enough attention to the language  
used... :(

>    The ideal solution is to use a generator and refactor the commit
> handling as a stream. I am working on that but it involves deeper
> changes, so as I am not sure it will be accepted, I'm providing the
> attached compromise patch first. At least it solves the appaling speed
> issue. I tuned it so that it never uses more than 32 MiB extra memory.

That is definitely the ideal solution - I would hope that it gets  
accepted if you manage to cut down on memory usage - as it really is a  
limitation for certain repositories. (Infact, this is why I no-longer  
use git-p4).

>
> Signed-off-by: Sam Hocevar <sam@zoy.org>
> ---
>  contrib/fast-import/git-p4 |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 3832f60..151ae1c 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -984,11 +984,19 @@ class P4Sync(Command):
>          while j < len(filedata):
>              stat = filedata[j]
>              j += 1
> +            data = []
>              text = ''
>              while j < len(filedata) and filedata[j]['code'] in   
> ('text', 'unicod
> e', 'binary'):
> -                text += filedata[j]['data']
> +                data.append(filedata[j]['data'])
>                  del filedata[j]['data']
> +                # p4 sends 4k chunks, make sure we don't use more   
> than 32 MiB
> +                # of additional memory while rebuilding the file data.
> +                if len(data) > 8192:
> +                    text += ''.join(data)
> +                    data = []
>                  j += 1
> +            text += ''.join(data)
> +            del data
>
>              if not stat.has_key('depotFile'):
>                  sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
>
> --
> Sam.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
