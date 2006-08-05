From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Sat, 5 Aug 2006 01:40:23 -0400
Message-ID: <9e4733910608042240u581dd23q3859ebcfe4268ce2@mail.gmail.com>
References: <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
	 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
	 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
	 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
	 <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
	 <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
	 <46a038f90608042115m71adc8ffo77de7940efa847a8@mail.gmail.com>
	 <9e4733910608042212p6bf56224ye0ecf3f06b2840cf@mail.gmail.com>
	 <20060805052135.GA18679@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Linus Torvalds" <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 05 07:40:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Eth-0007Yj-Hc
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 07:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWHEFk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 01:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbWHEFk0
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 01:40:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:41504 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932628AbWHEFkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 01:40:25 -0400
Received: by nf-out-0910.google.com with SMTP id x37so1291784nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 22:40:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FCR9iLSLRa1LWoDQIeB/vejtA56inARqdEwf7TNBnaWna7wn8J3VeLXLJQx6gOU/PY/r31NK9FusszyYgClhl7G0TEe0YKhyLFKJzdGLS+wfgpdVuXX9e/5/oQqmyRHIUSLGZgffNFdSEWDkqE7Q096zuCDggkSR/BTIpnzN6TA=
Received: by 10.78.177.3 with SMTP id z3mr1811760hue;
        Fri, 04 Aug 2006 22:40:23 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Fri, 4 Aug 2006 22:40:22 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060805052135.GA18679@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24886>

On 8/5/06, Shawn Pearce <spearce@spearce.org> wrote:
> I'm almost done with what I'm calling `git-fast-import`.  It takes
> a stream of blobs on STDIN and writes the pack to a file, printing
> SHA1s in hex format to STDOUT.  The basic format for STDIN is a 4
> byte length (native format) followed by that many bytes of blob data.
> It prints the SHA1 for that blob to STDOUT, then waits for another
> length.
>
> It naively deltas each object against the prior object, thus it
> would be best to feed it one ,v file at a time working from the most
> recent revision back to the oldest revision.  This works well for
> an RCS file as that's the natural order to process the file in.  :-)

I am already doing this.

> When done you close STDIN and it'll rip through and update the pack
> object count and the trailing checksum.  This should let you pack
> the entire repository in delta format using only two passes over the
> data: one to write out the pack file and one to compute its checksum.

Thinking about this some more, the existing repack code could be made
to work with minor changes. I would like to feed repack 1M revisions
which are sorted by file and then newest to oldest. The problem is
that my expanded revs take up 12GB disk space.

How about adding a flag to repack that simply says delete the objects
when done with them? I'd still create all of the objects on disk.
Repack would assume that they have at least been sorted by filename.
So repack could read in object names until it sees a change in the
file name, sort them by size, deltafy, write out the pack and then
delete the objects from that batch. Then repeat this process for the
next file name on stdin.

I'm making two assumptions, first that blocks from a deleted file
don't get written to disk. And that by deleting the file the file
system will use the same blocks over and over. If those assumptions
are close to being true then the cache shouldn't thrash. They don't
have to be totally true, close is good enough.

Of course eliminating the files all together will be even faster.

-- 
Jon Smirl
jonsmirl@gmail.com
