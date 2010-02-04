From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Making custom git-remove-tree command
Date: Thu, 04 Feb 2010 10:55:17 +0100
Message-ID: <4B6A9985.4050909@viscovery.net>
References: <87iqad2x09.fsf@mithlond.arda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Feb 04 10:55:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcyQv-0001dr-H7
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 10:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569Ab0BDJzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 04:55:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46763 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757545Ab0BDJzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 04:55:20 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NcyQg-0000yi-8e; Thu, 04 Feb 2010 10:55:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 068241660F;
	Thu,  4 Feb 2010 10:55:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <87iqad2x09.fsf@mithlond.arda>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138960>

Teemu Likonen schrieb:
> I'm doing a script named git-remove-tree which removes the working tree
> known to Git. It doesn't touch untracked files; it only deletes
> directories if they are empty. The script seems to work, but because I'm
> not very good at Git plumbing and there can be some corner cases which I
> don't know about, I'd appreciate if more experienced users would have a
> look. Is the following script safe?
> 
> 
> #!/bin/sh
> # git-remove-tree
> 
> is_wt=$(git rev-parse --is-inside-work-tree)
> if [ "$is_wt" = false ]; then
> 	echo "You must run this inside a working tree."
> 	exit 1
> elif [ -z "$is_wt" ]; then
> 	exit 1
> fi
> 
> top=$(git rev-parse --show-toplevel)
> cd "$top" || {
> 	echo "Can't go to top-level directory $top"
> 	exit 1
> }
> 
> git ls-tree --name-only -r -z HEAD | xargs -0r -- sh -c '
> for f in "$@"; do
> 	rm -f -- "$f"
> 	d=$(dirname -- "$f")
> 	[ "$d" = . ] || rmdir -p -- "$d" 2>/dev/null
> done' dollar0_argument

I think you should be able to reduce all of this to just

git read-tree --index-output=/tmp/empty.index -m -u \
	4b825dc642cb6eb9a060e54bf8d69288fbee4904 # empty tree
rm -f /tmp/empty.index

(with the usual caveats about temporary files).

> 
> echo 'Use "git reset --hard HEAD" to populate the working tree again.'

-- Hannes
