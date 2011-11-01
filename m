From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: problem with commit 97a21ca50ef8
Date: Mon, 31 Oct 2011 22:08:41 -0400
Message-ID: <20111101020841.GA8116@arf.padd.com>
References: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 03:08:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL3mV-0007Hl-Bg
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 03:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab1KACIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 22:08:46 -0400
Received: from honk.padd.com ([74.3.171.149]:54423 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab1KACIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 22:08:45 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 6F5F33BB;
	Mon, 31 Oct 2011 19:08:44 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AA1DC31412; Mon, 31 Oct 2011 22:08:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184551>

michaelwookey@gmail.com wrote on Tue, 01 Nov 2011 10:11 +1100:
> [ please CC me as I am not subscribed to the list ]
> 
> Hi,
> 
> Commit 97a21ca50ef893a171a50c863fe21a924935fd2a "git-p4: stop ignoring
> apple filetype" isn't correct. Without knowing too much about how
> git-p4 works, it appears that the "apple" filetype includes the
> resource fork, and the "p4 print" that is used to obtain the content
> from the perforce server doesn't take this into account, or maybe some
> post processing of the file needs to be done to include the data, but
> not the resource fork, before inclusion into the git repo.
> 
> With the above commit, a binary blob that literally contains the
> resource fork and data is included within the git repo. Of course,
> without the above commit, the intended file was never included in the
> git repo at all. Perhaps the resource fork issue was a known problem
> by the original git-p4 author.
> 
> A sample file that that demonstrates what the above commit produces is
> here (use curl/wget):
> 
>   http://dl.dropbox.com/u/1006983/sample_image_fail.png
> 
> This is literally a binary blob with about 110 KiB of resource fork
> plus the PNG data. The same image, minus about 110 KiB of resource
> fork is here:
> 
>   http://dl.dropbox.com/u/1006983/sample_image_correct.png
> 
> I'm happy to test patches as we have a perforce repository with files
> of the "apple" filetype.

Thanks so much for taking the time to find this and to narrow it
down.

I found icnsutils that shows the fail.png file has a bunch of
icons glued onto the front of the correct image file.

We can certainly revert this commit, but first I'd like to
understand what the right behavior should be.

I managed to include an apple filetype in a repo from a linux box
by hacking:

    $ cp /tmp/sample_image_fail.png fail.png
    $ p4 add -t apple fail.png 
    $ p4 submit -dfail-apple
    Submitting change 2.
    Locking 1 files ...
    add //depot/fail.png#1
    Unable to read AppleDouble Header.
    open for read: /home/pw/src/perforce/cli/%fail.png: No such
    file or directory
    Submit aborted -- fix problems then use 'p4 submit -c 2'.
    Some file(s) could not be transferred from client.

Hrm.  Fake it by copying your example apple file to what it asks
for:

    $ cp fail.png %fail.png
    $ p4 submit -c 2
    Submitting change 2.
    add //depot/fail.png#1
    Change 2 submitted.

(But later p4 sync -f destroy both files.)

Voila:

    $ p4 fstat //depot/fail.png
    ... depotFile //depot/fail.png
    ... clientFile /home/pw/src/perforce/cli/fail.png
    ... isMapped 
    ... headAction add
    ... headType apple
    ... headTime 1320111844
    ... headRev 1
    ... headChange 2
    ... headModTime 1320111842
    ... haveRev 1

And git-p4 checks it out intact:

    $ git p4 clone //depot
    [..]
    $ sha1sum depot/fail.png /tmp/sample_image_fail.png 
    93d175ad906147f4d75296bd2adb6d706f798c64  depot/fail.png
    93d175ad906147f4d75296bd2adb6d706f798c64  /tmp/sample_image_fail.png

Which is what I thought an apple-filetype user would want.
Reverting the patch causes _no_ file to be created.  Is
this better?  Maybe the single-blob file, since it no longer
appears in AppleDouble format, is just as useless as no file?

The other option is to use "p4 print" without the -G, which
seems to retrieve only the data fork, and leave that in the repo.
Of course, if you change it, and submit it, it makes a mess.

Would it be good if git-p4 understood how to identify and create
AppleDouble files on Mac?  If yes, eventually, we can revert the
commit and explain how this feature doesn't quite work yet.
Even if no, it seems like we should revert and complain that
this apple support is broken.

		-- Pete
