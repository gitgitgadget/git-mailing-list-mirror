From: Sivakumar Selvam <gerritcode@gmail.com>
Subject: Re: git repack command on larger pack file
Date: Tue, 27 Oct 2015 02:04:23 +0000 (UTC)
Message-ID: <loom.20151027T025257-333@post.gmane.org>
References: <loom.20151026T065553-934@post.gmane.org> <xmqq611ujfn0.fsf@gitster.mtv.corp.google.com> <xmqqziz6hzom.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 03:04:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqtcs-0001jM-Ry
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 03:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbbJ0CEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 22:04:35 -0400
Received: from plane.gmane.org ([80.91.229.3]:42074 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbbJ0CEe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 22:04:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Zqtcj-0001ah-V2
	for git@vger.kernel.org; Tue, 27 Oct 2015 03:04:32 +0100
Received: from 124.215.201.5 ([124.215.201.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 03:04:29 +0100
Received: from gerritcode by 124.215.201.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 03:04:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 124.215.201.5 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280242>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Junio C Hamano <gitster <at> pobox.com> writes:
> 
> > Sivakumar Selvam <gerritcode <at> gmail.com> writes:
> >
> >> ... So
> >> I thought of splitting the pack file into 4 GB chunks.
> > ...
> > Hmmm, what is "this issue"?  I do not see anything surprising.
> 
> While the explanation might have been enlightening, the knowledge
> conveyed by the explanation by itself would not be of much practical
> use, and enlightment without practical use is never fun.
> 
> So let's do another tangent that may be more useful.
> 
> In many repositories, older parts of the history often hold the bulk
> of objects that do not change, and it is wasteful to repack them
> over and over.  If your project is at around v40.0 today, and it was
> at around v36.0 6 months ago, for example, you may want to pack
> everything that happened before v36.0 into a single pack just once,
> pack them really well, and have your "repack" not touch that old
> part of the history.
> 
>   $ git rev-list --objects v36.0 |
>     git pack-objects --window=200 --depth=128 pack
> 
> would produce such a pack [*1*]
> 
> The standard output from the above pipeline will give you a 40-hex
> string (e.g. 51c472761b4690a331c02c90ec364e47cca1b3ac, call it
> $HEX), and in the current directory you will find two files,
> pack-$HEX.pack and pack-$HEX.idx.
> 
> You can then do this:
> 
>   $ echo "v36.0 with W/D 200/128" >pack-$HEX.keep
>   $ mv pack-$HEX.* .git/objects/pack/.
>   $ git repack -a -d
> 
> A pack that has an accompanying .keep file is excempt from
> repacking, so once you do this, your future "git repack" will only
> repack objects that are not in the kept packs.
> 
> [Footnote]
> 
> *1* I won't say 200/128 gives you a good pack; you would need to
> experiment.  In general, larger depth will result in smaller pack
> but it will result in bigger overhead while you use the repository
> every day.  Larger window will spend a lot of cycles while packing,
> but will result in a smaller pack.
> 


Hi Junio,

   When I finished git repacking, I found 12 pack files with each 4 GB and
the total size is 48 GB. Again I ran the same git repack command by just
removing only --max-pack-size= parameter, the size of the single pack file
is 66 GB.

git repack -A -b -d -q --depth=50 --window=10 abc.git

Now, I see the total size of the single abc.git has become 66 GB. Initially
it was 34 GB, After using  --max-pack-size=4g it become 48 GB. When we
remove the --max-pack-size=4g parameter and tried to create a single pack
file now it become 66 GB.
   
Looks like once we do git repack with multiple pack files, we can't revert
back to the original size.  

Thanks,
Sivakumar Selvam.
