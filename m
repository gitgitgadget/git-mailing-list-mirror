From: John <john@puckerupgames.com>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Fri, 14 May 2010 08:54:02 -0400
Message-ID: <4BED47EA.9090905@puckerupgames.com>
References: <4BEAF941.6040609@puckerupgames.com> <20100514051049.GF6075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 14:54:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCuPC-0005gJ-Lr
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 14:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419Ab0ENMyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 08:54:06 -0400
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:47384 "EHLO
	postalmail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754498Ab0ENMyF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 08:54:05 -0400
X-Greylist: delayed 151190 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 May 2010 08:54:05 EDT
Received: from dev.newmarket (c-71-225-50-119.hsd1.pa.comcast.net [71.225.50.119])
	by postalmail-a4.g.dreamhost.com (Postfix) with ESMTP id EDF33E2383;
	Fri, 14 May 2010 05:54:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <20100514051049.GF6075@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147087>

Thanks so much. It's version 1.5.6.5. I compiled it 3 months ago. For example, 
in one repo, there are 1200 source files, each on average 109K in size, for a 
total size of 127M. The largest source file is 82M. Most of the non-text source 
files are already compressed.

I packed the bare repo, then ran `gc --aggressive`. Then I did a `git pull`, 
which took 35 minutes. The git processes in `top` seemed to peak at around 300M 
of memory. Since then, I added 'binary -delta' to the .gitattributes for various 
files, based on suggestions from this mailing list, but by that time did not 
wish to repeat the 35 minute pull to test it out. Let's hope that made a difference.

You can simulate it all by generating a batch of 1-100 MB files from 
/dev/urandom (since they won't compress), commit them, then do it again many 
times to simulate edits. Every few iterates, push it somewhere.


I noticed some other folks on this list apparently having the same issues, but 
they don't know it yet ("git hangs while compressing objects", etc.). That's 
probably the first symptom they'll see. It *appears* to hang, but it's really 
spinning away on the `pack` gizmo.

I'm open to alternative suggestions -- some kind of dual-mode, where text files 
are "fully" version'd, diff'd, delta'd, index'd, stash'd, pack'd, compress'd, 
object'd and whatever else git needs to do, while non-text files are archived in 
a "lesser" manner.  On the other hand, I get the sense that the LAST thing git 
needs is another "mode"!




On 05/14/2010 01:10 AM, Jeff King wrote:
> On Wed, May 12, 2010 at 02:53:53PM -0400, John wrote:
>
>> We're seeing serious performance issues with repos that store media
>> files, even relatively small files. For example, a web site with less
>> than 100 MB of images can take minutes to commit, push, or pull when
>> images have changed.
>
> That sounds way too slow from my experiences. I have a repository with 3
> gigabytes of photos and videos. Committing 20M of new images takes a
> second or two. The biggest slowdown is doing the sha1 over the new data
> (which actually happens during "git add").
>
> What version of git are you using? Have you tried "commit -q" to
> suppress the diff at the end of commit?
>
> Can you show us exactly what commands you're using, along with timings
> so we can see where the slowness is?
>
> For pushing and pulling, you're probably seeing delta compression, which
> can be slow for large files (though again, minutes seems kind of slow to
> me). It _can_ be worth doing for images, if you do things like change
> only exif tags but not the image data itself. But if the images
> themselves are changing, you probably want to try setting the "-delta"
> attribute. Like:
>
>    echo '*.jpg -delta'>.gitattributes
>
> Also, consider repacking your repository, which will generate a packfile
> that will be re-used during push and pull.
>
>> Our first guess was that git is repeatedly attempting to
>> compress/decompress data that had already been compressed. We tried
>
> Git does spend a fair bit of time in zlib for some workloads, but it
> should not create problems on the order of minutes.
>
>>     core.compression 0   ## Docs say this disables compression. Didn't seem to work.
>
> That should disable zlib compression of loose objects and objects within
> packfiles. It can save a little time for objects which won't compress,
> but you will lose the size benefits for any text files.
>
> But it won't turn off delta compression, which is what the
> "compressing..." phase during push and pull is doing. And which is much
> more likely the cause of slowness.
>
>>     pack.depth 1     ## Unclear what this does.
>
> It says you can't make a chain of deltas deeper than 1. It's probably
> not what you want.
>
>>     pack.window 0    ## No idea what this does.
>
> It sets the number of other objects git will consider when doing delta
> compression. Setting it low should improve your push/pull times. But you
> will lose the substantial benefit of delta-compression of your non-image
> files (and git's meta objects). So the "-delta" option above for
> specific files is a much better solution.
>
>>     gc.auto 0        ## We hope this disables automatic packing.
>
> It disables automatic repacking when you have a lot of objects. You
> _have_ to pack when pushing and pulling, since packfiles are the
> on-the-wire format. What will help is:
>
>    1. Having repositories already packed, since git can re-use the packed
>       data.
>
>    2. Using -delta so that things which delta poorly are just copied into
>       the packfile as-is.
>
>> Is there a trick to getting git to simply "copy files as is"?  In
>> other words, don't attempt to compress them, don't attempt to "diff"
>> them, just store/copy/transfer the files as-is?
>
> Hopefully you can pick out the answer to that question from the above
> statements. :)
>
> -Peff
