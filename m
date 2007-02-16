From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for disconnected transfer
Date: Fri, 16 Feb 2007 11:57:59 -0800
Message-ID: <7vhctl50zc.fsf@assigned-by-dhcp.cox.net>
References: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 20:58:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI9Dd-0008FA-0n
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 20:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946095AbXBPT6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 14:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946098AbXBPT6E
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 14:58:04 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:64500 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946095AbXBPT6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 14:58:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216195800.DZFA21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 14:58:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QKxz1W00s1kojtg0000000; Fri, 16 Feb 2007 14:58:00 -0500
In-Reply-To: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
	(Mark Levedahl's message of "Fri, 16 Feb 2007 06:53:13 -0600 (CST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39945>

Mark Levedahl <mdl123@verizon.net> writes:

>>>
>>Also as Shawn pointed out, the script too heavily depends on GNU
>>tar.  Can we do something about it?
>
> Let me ponder, I'm sure I can do something. As I noted in
> another response, Cygwin won't let me reliably pipe the pack
> file through bash, so I'm forced to use some archiver.

Mark, how urgent do you want to have "bundle" in my tree?  As I
understand it, this came out of your working zip based
implementation your group already use, so I am suspecting that
you do not have urgent need to have a different one in git.git
in a half-baked shape.

The reason I say this is because I very much in favor of the
general idea of an archive file that can be used to sneakernet
repository updates, but I find the current bundle-unbundle
interface a bit awkward to integrate into the rest of the
system.

Wouldn't it be nice if you can treat a bundle as just a
different kind of git URL that you can "git fetch"?

	$ git fetch file.bdl 'refs/heads/*:refs/heads/*'

As the way I read the current implementation of git-unbundle is
that it is designed to only overwrite (with fast-forward check
not to lose changes from the target) all the refs in place.  It
does not, for example, allow extracting only one branch, nor
storing the branch in a tracking branch by renaming.  I think it
would be nicer to change the external interface from the bundle
subsystem to the calling scripts, so that it behaves closer to
git-fetch-pack.

I haven't thought things through, but I think something like this
would be sufficient:

	# create a bundle.
	$ git bundle --create v1.5.0..maint master next >file.bdl

	# you can view the tips of refs it contains.  This is
        # similar to "ls-remote" output.
	$ git bundle --list-heads file.bdl
        efa13f7b7ea1605deab3a6478fa0d0706c828170 refs/heads/maint
        af99711cd84c30a16450f73dbc21ba9f9f9803e6 refs/heads/master
        664e83a22b604fc5af1a84ddd48549b005cf4bc9 refs/heads/next

        # optionally allow checking if the pre-requisites of the
        # bundle are available.
	$ git bundle --verify file.bdl
	error: file.bdl depends on the following commits you lack
	in the repository:
        82bf92f9846326a743102e27fa9827422dddfada v1.5.0-564-g82bf92f
	4d462883de41190afd23672c8236361c61a9e6bd v1.5.0-34-g4d46288

	# extract the packfile part, run index-pack and report
        # the result the same way as git-fetch-pack
        $ git bundle --unbundle file.bdl
	pack	340e3faa26616ca8c38b369a6d323ecf7a34f4fb
        efa13f7b7ea1605deab3a6478fa0d0706c828170 refs/heads/maint
        af99711cd84c30a16450f73dbc21ba9f9f9803e6 refs/heads/master
        664e83a22b604fc5af1a84ddd48549b005cf4bc9 refs/heads/next

Then git-ls-remote can be taught about a bundle file and use the
'git bundle --list-heads'.  Also, with something like this in
your config:

	[remote "bundle"]
        	url = /home/me/tmp/file.bdl
                fetch = refs/heads/*:refs/remotes/origin/*

You can first sneakernet the bundle file to ~/tmp/file.bdl and
then these commands:

	$ git ls-remote bundle
        $ git fetch bundle
	$ git pull bundle

would treat it as if it is talking with a remote side over the
network.

Hmm?
