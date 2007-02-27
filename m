From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 11:55:48 -0500
Message-ID: <2BBADC5E-7188-4F77-BF5A-28131B435EF0@adacore.com>
References: <200702261540.27080.ttelford.groups@gmail.com> <20070226235510.GF1639@spearce.org> <alpine.LRH.0.82.0702261916560.29426@xanadu.home> <20070227003118.GH1639@spearce.org> <alpine.LRH.0.82.0702262306100.29426@xanadu.home> <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com> <alpine.LRH.0.82.0702270002100.29426@xanadu.home> <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com> <20070227161122.GE3230@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 17:57:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM5dM-00050E-NQ
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 17:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbXB0Q45 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 11:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbXB0Q44
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 11:56:56 -0500
Received: from nile.gnat.com ([205.232.38.5]:46413 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbXB0Q44 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 11:56:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 443A748D1D0;
	Tue, 27 Feb 2007 11:55:49 -0500 (EST)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 22499-01-10; Tue, 27 Feb 2007 11:55:49 -0500 (EST)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id 0A72048D1C0;
	Tue, 27 Feb 2007 11:55:49 -0500 (EST)
In-Reply-To: <20070227161122.GE3230@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40760>

On Feb 27, 2007, at 11:11, Shawn O. Pearce wrote:
> Geert Bosch <bosch@adacore.com> wrote:
>> When I import a large code-base (such as a *.tar.gz), I don't know
>> beforehand how many objects I'm going to create. Ideally, I'd like
>> to stream them directly into a new pack without ever having to write
>> the expanded source to the filesystem.
>
> See git-fast-import.  If you are coming from a tar, also see
> contrib/fast-import/import-tars.perl.  :-)

Yes, I saw that, really nice. I had written something myself to
create pack files from a streaming data source. Basically, I'm
breaking arbitrary data-streams (mostly backups) into chunks
along content-defined boundaries and then link the chunks
together in a tree. This eliminates any duplicate files,
and even chunks of larger files that are identical. I create
new pack files whenever the old one gets larger than a certain
predefined size (128 MB, currently).

I'm happy I can base this on git-fast-import now.

>> So for creating a large pack from a stream of data, you have to do
>> the following:
>>   1. write out a temporary pack file to disk without correct count
>>   2. fix-up the count
>>   3. read the entire temporary pack file to compute the final SHA-1
>>   4. fix-up the SHA1 at the end of the file
>>   5. construct and write out the index
>
> Yes, this is exactly what git-fast-import does.  Yes, it sort of
> sucks.  But its not as bad as you think.

For smaller packs, the I/O is all going to be buffered anyway,
but if we're going to have >4GB pack files, it adds a lot of real
I/O  and SHA1 computation for no good reason. If we get a rare chance
to have a new pack format, why not fix this wart at the same time?

   -Geert
