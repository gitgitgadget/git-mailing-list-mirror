From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sat, 14 Jul 2007 22:46:39 +0200
Message-ID: <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 22:46:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9oVo-0005EW-85
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 22:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762205AbXGNUql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 16:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761595AbXGNUql
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 16:46:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:65265 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761558AbXGNUqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 16:46:40 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1042947wah
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 13:46:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ycr0sYcM9ifvVlhscZNIYKMh2/JSlP+4ULWIt8tWLHKqtxEYY4DaZVOF2MytXeT9E9vOzF7A0MNheQ2ctwjrT2QYwayuSnMs2XkvGAhYKhArCHLwELPauO9QSWqf9++pvH2IosiGJrCeAeprZdqeW0HDIZs4CmQ+LFcnqRxAdMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m9zGRfpCicvL/uuoSCdLKcN24+cMze7Ds8qxbdC6jU9vFsbR44X2WV8RPSDJpWOJuYeibQHlqDRVSLWsLXPjk3pfB20mQkrZJwPdktvreb66MocHJfKY5KzbSrt9YgByO2KlwODA3MNqDj+3fin5ypixvkOuWA8kO0v7ms1VjCM=
Received: by 10.114.176.1 with SMTP id y1mr2794590wae.1184445999816;
        Sat, 14 Jul 2007 13:46:39 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sat, 14 Jul 2007 13:46:39 -0700 (PDT)
In-Reply-To: <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52508>

On 7/14/07, Junio C Hamano <gitster@pobox.com> wrote:
>
> "size" is a bit vague here.  What if we later want to extend
> things so that you can ask for the entire log entry size
> including the patch output part (I am not saying that would be
> an easy change --- I am more worried about the stability of the
> external interface).  So is --show-"size".  "message-size" would
> have been a bit easier to swallow, but I sense the problem runs
> deeper.

What about --section-sizes?

You can add in the output line all the sizes you want, message, patch
and future extensions separated by a space. An example output for
message and patch sizes.

sizes 456 565\n

Or, as a stream friendly alternative (and also more elegant) you can
output 'section size' before each section, so as example

commit d9e940....
section size 456
< log header and message body>
section size 565
<patch diff content>
section size 232
<other type of content>


> I have a more basic question. If you are reading from non "-p"
> output, where do you exactly have the wasted cycles in your
> reader's processing?

qgit loading works like this:

git log output is read as a series of big binary chunks by a Qt
library function that calls read(), these chunks are read each one in
a different buffer and there they stay for all the application life
time (or until a data refresh), so there is no copy of data in qgit,
the buffers are allocated and the pointers passed to read(), that's
all.

It's a kind of software DMA ;-)

The only information that qgit needs to infere at startup is where to
find the first line of each commit, for parent information and
revision's counting, all the other data is read and consumed only on
demand, i.e. for showing to user, but because only the screen visible
part of the list is needed, data is read from these buffers and parsed
*in small chunks* and only when user scrolls the view.

The problem is that to get the first line of each revision the message
boundaries of _all_ the commits must be known/found.

Because currently there is no message size information the application have to:

-get the offset of commit first line
-try to find the delimiting '\0' if existing (binary chunks could be
truncated at any point)
-get the offset of commit first line of next revision
-and so on for all the revisions

Finding the delimiting '\0' it means to loop across the whole buffers
and _this_ is the expensive and not needed part. If just after the
first line would be possible to point to the beginning of the next
revision this seeking for '\0' would be not necessary anymore.

When user asks for data of revision 'x' then because offset of
revision 'x' is known, application could just point to the correct
offset in the correct data buffer and parse out the (small) needed
info.

Hope I have explained clearly enough, I have some problems writing in
at late evening ;-)


Marco
