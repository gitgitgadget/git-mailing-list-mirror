From: Mark Hills <mark@pogo.org.uk>
Subject: Re: git-clone file permissions and cpio
Date: Sun, 4 May 2008 12:32:07 +0100 (BST)
Message-ID: <alpine.BSO.1.10.0805041227550.5819@zrgural.vwaro.pbz>
References: <alpine.BSO.1.10.0804210911170.21918@zrgural.vwaro.pbz> <480C7D82.9000602@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun May 04 13:33:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JscSh-0005AX-VE
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 13:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbYEDLcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 07:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbYEDLcJ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 07:32:09 -0400
Received: from mailout.ijneb.com ([212.13.201.26]:46097 "EHLO
	metheny.ijneb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752189AbYEDLcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 07:32:08 -0400
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1JscRr-0001tF-ED; Sun, 04 May 2008 12:32:07 +0100
In-Reply-To: <480C7D82.9000602@gnu.org>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81171>

On Mon, 21 Apr 2008, Paolo Bonzini wrote:

>> I got some kind of working behaviour with the diff below, which stops 
>> cpio 'fixing' the file permissions (only on the directories). But it 
>> seems the underlying cause is cpio trying to copy file permissions 
>> which it would be better off not doing in this case (and which there 
>> isn't a flag to disable).
>
> I don't think you want to have the setgid bit on files, only on 
> directories, so your patch seems okay to me.

I'm spent some time investigating this, as the patch has different 
behaviour with different version of cpio because of various bugs [1].

I looked at various other ways of achieving the copy of the directory 
including variations on cpio, tar, pax, rsync and decided it was best to 
explicitly divide this into two steps: create the directories honouring 
umask and setgid etc. at the destination, and then copy the files over 
with read-only permissions using the existing method.

I'll send a [PATCH] mail with this new diff, although I can see this might 
be superceded by a built in clone in the future.

Mark

[1] http://www.gnu.org/software/cpio/

diff --git a/git-clone.sh b/git-clone.sh
index 8c7fc7f..53c7e06 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -334,7 +334,10 @@ yes)
  			fi
  		fi &&
  		cd "$repo" &&
-		find objects -depth -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
+		# Create dirs using umask and permissions and destination
+		find objects -type d -print | (cd "$GIT_DIR" && xargs mkdir -p) &&
+		# Copy 0444 permissions on files
+		find objects -type f -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
  			exit 1
  	fi
  	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
