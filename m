From: thestar@fussycoder.id.au
Subject: Re: [PATCH] git-p4: improve performance with large files
Date: Thu, 05 Mar 2009 10:05:27 +1100
Message-ID: <20090305100527.shmtfbdvk0ggsk4s@webmail.fussycoder.id.au>
References: <20090304215438.GA12653@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 00:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf0KV-0001v9-Kq
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 00:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbZCDXPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 18:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbZCDXPS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 18:15:18 -0500
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:50972
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751137AbZCDXPR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 18:15:17 -0500
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2009 18:15:16 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Al8DAK+XrknLWHaZ/2dsb2JhbACTWCKBe8JchAgG
X-IronPort-AV: E=Sophos;i="4.38,304,1233493200"; 
   d="scan'208";a="370805"
Received: from cherry.cbr.hosting-server.com.au ([203.88.118.153])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 05 Mar 2009 10:05:34 +1100
Received: (qmail 21111 invoked by uid 48); 5 Mar 2009 10:05:27 +1100
Received: from  ( [unknown]) by webmail.fussycoder.id.au (Horde MIME
	library) with HTTP; Thu, 05 Mar 2009 10:05:27 +1100
In-Reply-To: <20090304215438.GA12653@zoy.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112245>

Quoting Sam Hocevar <sam@zoy.org>:

>    The current git-p4 way of concatenating strings performs in O(n^2)
> and is therefore terribly slow with large files because of unnecessary
> memory copies. The following patch makes the operation O(n).

The reason why it uses simple concatenation is to cut down on memory usage.
  - It is a tradeoff.

I think the modification you have made below is reasonable, however be  
aware that memory usage could double, which substantially reduce the  
size of the changesets that git-p4 would be able to import /at all/,  
rather than to merely be slow.

That said, you do need to delete the data temporary array to cut down  
on memory.
  -- I would do this immediately after the "".join(data).

>
>    Using this patch, importing a 17GB repository with large files
> (50 to 500MB) takes 2 hours instead of a week.
>
> Signed-off-by: Sam Hocevar <sam@zoy.org>
> ---
>  contrib/fast-import/git-p4 |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 9fdb0c6..09e9746 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -990,11 +990,12 @@ class P4Sync(Command):
>          while j < len(filedata):
>              stat = filedata[j]
>              j += 1
> -            text = ''
> +            data = []
>              while j < len(filedata) and filedata[j]['code'] in   
> ('text', 'unicode', 'binary'):
> -                text += filedata[j]['data']
> +                data.append(filedata[j]['data'])
>                  del filedata[j]['data']
>                  j += 1
> +            text = "".join(data)
>
>              if not stat.has_key('depotFile'):
>                  sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
> --
> 1.6.1.3
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
