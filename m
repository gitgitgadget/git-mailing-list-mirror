From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Tue, 22 May 2007 00:33:23 -0700
Message-ID: <56b7f5510705220033p43d20aabnbf86f1f6959d611a@mail.gmail.com>
References: <46528A48.9050903@gmail.com> <20070522063050.GD11636@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 22 09:33:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqOs7-0007EJ-Jf
	for gcvg-git@gmane.org; Tue, 22 May 2007 09:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbXEVHdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 03:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755451AbXEVHdZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 03:33:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:46703 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbXEVHdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 03:33:25 -0400
Received: by wx-out-0506.google.com with SMTP id h29so148442wxd
        for <git@vger.kernel.org>; Tue, 22 May 2007 00:33:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WxFvXBwpwYM3WEMLOQFVx9Sra9BsEx2TMsaJHy3ValUo+qW5WO4dgz49tJzbHkltLyaI5Ct5P+U3MbpR0TQlTBBrUzYvxSGeR2HL3Ga76Th1Yu6UwlqyqlD4yY0KI0KKkAKrXoYWYeppTXbXAbnFYXPoc4Lb9YesXrBbxNGwd/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ugfrvr0QIMzz1aY0cMU+IHSoEuwt2G04stLRPdM/2pNXBBAwu+C8H1UhJedSTaNl5iqO4XJo9/t1BV/FwkDSM8YpFEpSURQqHXH/PxyYhk4ILTWq0TbZrEzON0aLxZd2OZJrCnnLDE/GgSNT8noVwFLkQ7DIM9RVzAhY6/swme4=
Received: by 10.78.187.17 with SMTP id k17mr479501huf.1179819203360;
        Tue, 22 May 2007 00:33:23 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Tue, 22 May 2007 00:33:23 -0700 (PDT)
In-Reply-To: <20070522063050.GD11636@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48083>

On 5/21/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Dana How <danahow@gmail.com> wrote:
> > ...  Operations
> > such as "git-log --pretty=oneline" were about 30X faster
> > on a cold cache and 2 to 3X faster otherwise.  Process sizes
> > remained reasonable.
>
> Can you give me details about your system?  Is this a 64 bit binary?
RHEL4/Nahant on an Opteron. Yes.

> What is your core.packedGitWindowSize and core.packedGitLimit set to?
I didn't change the default.

> It sounds like the packed version was almost 3 GiB smaller, but
> was slower because we were mmap'ing far too much data at startup
> and that was making your OS page in things that you didn't really
> need to have.
The difference in size is because of the "Custom compression levels"
patch -- now the loose objects use Z_BEST_SPEED,  whereas the packs
use Z_DEFAULT_COMPRESSION.

> Mind trying git-log with a smaller core.packedGitWindow{Size,Limit}?
> Perhaps its just as simple as our defaults are far far too high for
> your workload...
I think that's a good idea and it should be easy to try tomorrow.
It will improve the cold cache case definitely.

But we need to consider both *read* and *creation* performance.
The portion of the repo I imported to git grows at about 500MB/week
(compressed).  Should I repack -a every week? Every month?  In any case,
should I use default window/depth, or 0/0?  If default, run-times are
prohibitive (in fact, I've always killed each attempt so the machine
could be used for "real" work), and if 0/0, then I lose deltification
on all objects.

These megablobs really are outliers and stress the "one size fits
all" approach of packing in git.  As a thought experiment,
let's (1) pretend git-repack takes --max-blob-size= and --max-pack-size= ,
(2) pretend the patch doesn't add the repack.maxblobsize variable,
and (3) do the following:
 % git-repack -a -d --max-blob-size=256
 % git-repack --max-pack-size=2047 --window=0 --depth=0
The first step makes a digestible 13MB packfile, and the second
puts all the megablobs in 6+ 2GB packfiles.  Is there really any
advantage to carrying out the second step?  If I'm processing
a 100MB+ blob,  do I really care about an extra open(2) call?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
