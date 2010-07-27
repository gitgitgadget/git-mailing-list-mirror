From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Tue, 27 Jul 2010 19:51:26 -0400
Message-ID: <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com> 
	<9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 01:52:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdtwF-0007I6-Dr
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 01:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933Ab0G0Xvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 19:51:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47308 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921Ab0G0Xvr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 19:51:47 -0400
Received: by wwj40 with SMTP id 40so1860201wwj.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 16:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=g36xT+gTRPxFTKSKrtMnXU4rPUxnTAdNFQ9lKL7Kjj8=;
        b=lrgBn86xhZIohf0dMVo0luhCQ+BkiPxfTZdcWvzC5vPmQHOFKh1wWXk3Yy9C/Umel6
         m4YMCaRGPfZvqj3b23mWoC16eWfm5DZO6l2MyDxUYSHh1E9uDOtfZ0UzitiXi/SRKdzS
         iJZvMrKUIPLUqlg+QbuzqwtoiJ5F5nCa4mq/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rtYp3IeMwfJJJBWOOxB0hVFFND6b8eWMgmkCTI9nV9HUpakWdnUuOtlphVOabBlRNZ
         dgaYbO3S5CypePzhMtmi4WIShVpcfidmF125dGn66cp3LMlGfQeHLakAbSOMZfOP1AKJ
         SI/ukZ93YFSSOixWZ3ZKgMU4YMhNNIESB37eQ=
Received: by 10.216.21.204 with SMTP id r54mr3275639wer.95.1280274706183; Tue, 
	27 Jul 2010 16:51:46 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Tue, 27 Jul 2010 16:51:26 -0700 (PDT)
In-Reply-To: <9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152017>

On Tue, Jul 27, 2010 at 7:39 PM, Joshua Juran <jjuran@gmail.com> wrote:
> On Jul 27, 2010, at 4:29 PM, Avery Pennarun wrote:
>
>> An inotify daemon could easily keep track of which files have been
>> added that aren't in the index... but where would it put the list of
>> files git doesn't know about? =A0Do they go in the index with a spec=
ial
>> NOT_REALLY_INDEXED flag?
>
> One option is not to write it to disk at all. =A0The client could con=
sult the
> daemon directly.

True.  What would the client-server protocol look like, though?  "Give
me the list of unknown files?"  Does the daemon need to understand
=2Egitignore or will it send back a list of all my million *.o files
every time?  etc.

Offhandedly, I think it would be nice to have an inotify daemon just
maintain (something like) the git index file where it just has a list
of *all* the files in a form that's a) random access, not just
sequential, and b) really fast when accessed sequentially.

Knowing that large numbers of files can cause slowness, I was planning
ahead for inotify when I designed bup's index file format, and it
meets the above criteria.  Unfortunately I screwed up other stuff
(adding new files is too slow) and it still needs to be rewritten
anyway.  Oh well.

While we're here, it's probably worth mentioning that git's index file
format (which stores a sequential list of full paths in alphabetical
order, instead of an actual hierarchy) does become a bottleneck when
you actually have a huge number of files in your repo (like literally
a million).  You can't actually binary search through the index!  The
current implementation of submodules allows you to dodge that
scalability problem since you end up with multiple smaller index
files.  Anyway, that's fixable too.

Have fun,

Avery
