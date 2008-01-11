From: Sam Vilain <sam@vilain.net>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 14:01:01 +1300
Message-ID: <4786BFCD.1000303@vilain.net>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org> <478691EB.1080704@vilain.net> <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org> <47869C24.3000400@vilain.net> <alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 02:01:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD8HH-0007VR-Ru
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 02:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbYAKBBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 20:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYAKBBO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 20:01:14 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:40031 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753873AbYAKBBN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 20:01:13 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 72B0021D191; Fri, 11 Jan 2008 14:01:11 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id F2E6121D18B;
	Fri, 11 Jan 2008 14:01:01 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70113>

Linus Torvalds wrote:
> 
> On Fri, 11 Jan 2008, Sam Vilain wrote:
>> Drat, guess that means I'll have to recompute the deltas - I was trying
>> to avoid that.
> 
> Well, you could try to reuse the delta base information itself, but then 
> recompute the actual delta data contents. It would require some 
> source-code changes, but that may be faster (and result in a more accurate 
> before/after picture) than actually recomputing the deltas.

Yes, it would - but my runs have finished.

Without compression of deltas:

wilber:~/src/perl-preview$ git-repack -a -d -f --window=250 --depth=100
Compressing objects: 100% (236554/236554), done.
Writing objects: 100% (244360/244360), done.
Total 244360 (delta 182343), reused 0 (delta 0)
wilber:~/src/perl-preview$ du -sk .git/objects/pack/
86781   .git/objects/pack/

With compression of deltas:

wilber:~/src/perl-preview$ time git-repack -a -d -f --window=250 --depth=100
Counting objects: 244360, done.
Compressing objects: 100% (236554/236554), done.
Writing objects: 100% (244360/244360), done.
Total 244360 (delta 182343), reused 0 (delta 0)

real    20m34.985s
user    20m1.003s
sys     0m25.558s
wilber:~/src/perl-preview$ du -sk .git/objects/pack/
72907   .git/objects/pack/

wilber:~/src/perl-preview$ git --version
git version 1.5.4.rc2.7.g079c9-dirty

Of course those compression parameters are quite insane.

And as a side note either repack-objects got significantly better about
memory use between 1.5.3.5 and that version (the OOM killer fired -
killing first firefox and thunderbird :)) or apparently running
git-repack with a ulimit stops it from allocating too much VM.

Sam.
