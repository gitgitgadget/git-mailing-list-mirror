From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Tracking OpenOffice files/other compressed files with Git
Date: Tue, 09 Sep 2008 12:28:05 +0200
Message-ID: <48C64FB5.6080007@fastmail.fm>
References: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se> <48C61F94.3060400@viscovery.net> <loom.20080909T085002-376@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 12:29:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd0TG-0002lm-0x
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 12:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbYIIK2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 06:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbYIIK2K
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 06:28:10 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53689 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751824AbYIIK2J (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 06:28:09 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 191F515E593;
	Tue,  9 Sep 2008 06:28:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 09 Sep 2008 06:28:08 -0400
X-Sasl-enc: WW7Ax1/jbCglwKdOA0A6jxJHVbD+LgvxFOV9aeVVkbBP 1220956086
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A9098D083;
	Tue,  9 Sep 2008 06:28:06 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <loom.20080909T085002-376@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95369>

Sergio venit, vidit, dixit 09.09.2008 11:02:
> Johannes Sixt <j.sixt <at> viscovery.net> writes:
> 
>> Peter Krefting schrieb:
>>> Since OpenOffice doucuments are just zipped xml files, I wondered how
>>> difficult it would be to create some hooks/hack git to track the files
>>> inside the archives instead?
>> You could write a "clean" filter that "recompresses" the archive with
>> level 0 upon git-add.
>>
> 
> 
> A couple of notes:
> 
> 1) For Openoffice documents whose size is dominated by embed images and other
> large objects, the git delta mechanism already performs reasonably well, since
> OO files are Zip archives where each file is compressed separately.  If you do
> not change an image, then that image remains stored in the same way and the
> delta can be done.
> 
> 2) For OO documents whose size is dominated by plain content, the git delta
> mechanism cannot work, since the zip compression introduces "mixing" and a small
> change in the document is converted into a very large change in the zip file.
> 
> It could be possible to write a clean filter to uncompress before commit.
> However there is a trick with the complementary smudge filter to be used at
> checkout. If you do not smudge properly, git always shows the file as changed
> wrt the index.  Smudging correctly would mean using the very same compression
> ratio and compress method that OO uses, which can be a little tricky. I have
> tried using the zip binary both in the clean and the smudge phases and it does
> not work nicely. The smudged file is always different from the original one. One
> should probably work at a lower level to have a finer control on what is
> happening (libzip) and prepend to the uncompressed file the compression
> parameters to be restored on smudging.
> 
> The bigger issue is however that the clean/smudge thing can be really slow when
> dealing with large OO files.

I made similar observations when I experimented with tracking pdf and
sqlite (FF profile) files. Problems occurred so far:

PDF: on compressing/uncompressing with pdftk there seems to be a random
order of objects. We need something bijective.

sqlite files for FF profiles: uncompressing (i.e. dumping) and
recompressing gives something different than what FF writes. FF seems to
write out "holes" in the db to be filled out later.

I know, you and I will be told that git is not meant to track OO, PDF,
sql. Anyways, I think it's all up to finding a strictly bijective and
reasonably efficient compress/uncompress pair.

It turns out that when I have a choice between tracking larger or
smaller formats, such as ps/dvi vs pdf, it's often better to track the
larger one if it's mostly clear text.

On a side note, gc'ing helps a lot with binary files.

Michael
