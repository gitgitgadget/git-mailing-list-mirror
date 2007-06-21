From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Basename matching during rename/copy detection
Date: Wed, 20 Jun 2007 20:13:46 -0700
Message-ID: <7vsl8m3sph.fsf@assigned-by-dhcp.pobox.com>
References: <20070621030622.GD8477@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, govindsalinas <govindsalinas@yahoo.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 05:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1D7G-000779-KZ
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 05:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbXFUDNt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 23:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbXFUDNt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 23:13:49 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46380 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbXFUDNs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 23:13:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621031348.TNRN4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Jun 2007 23:13:48 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E3Dm1X00T1kojtg0000000; Wed, 20 Jun 2007 23:13:47 -0400
In-Reply-To: <20070621030622.GD8477@spearce.org> (Shawn O. Pearce's message of
	"Wed, 20 Jun 2007 23:06:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50586>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> So Govind Salinas has found an interesting case in the rename
> detection code:
>
>   $ git clone git://repo.or.cz/Widgit.git
>   $ git diff -M --raw -r 192e^ 192e | grep .resx
>   :100755 000000 4c8ab79... 0000000... D  Form1.resx
>   :100755 100755 9e70146... 9e70146... R100       CommitViewer.resx       UI/CommitViewer.resx
>   :100755 100755 90929fd... b40ff98... C091       RepoManager.resx        UI/Form1.resx
>   :100755 100755 90929fd... 90929fd... C100       PreferencesEditor.resx  UI/PreferencesEditor.resx
>   :100755 100755 90929fd... 90929fd... R100       PreferencesEditor.resx  UI/RepoManager.resx
>   :100755 100755 90929fd... 8535007... R097       RepoManager.resx        UI/RepoTreeView.resx
>
> In this case several files had identical old images, and some
> kept that old image during the rename.  Unfortunately because of
> the ordering of the files in the tree Git has decided to "rename"
> the PreferencesEditor.resx file to UI/RepoManager.resx, rather than
> renaming RepoManager.resx to UI/RepoManager.resx.  Go Git.
>
> I'm wondering if we shouldn't play the game of trying to match
> delete/add pairs up by not only similarity, but also by path
> basename.  In the case above its exactly what Govind thought should
> happen; he moved the file from one directory to another, and didn't
> even change its content during the move.  But Git decided "better"
> to use a totally different file in the "rename".

Actually, git did not decide anything, and certainly not better.

Having many "identical files" in the preimage is just stupid to
begin with (if you know they are identical, why are you storing
copies, instead of your build procedure to reuse the same file),
so the algorithm did not bother finding a better match among
"equals".

I am not opposed to a patch that says "Ok, these two preimages
have identical similarity score, *AND* indeed the preimages have
the same contents --- we tiebreak them with other heuristics to
help stupid projects better".  And I can see basename similarity
one of the useful heuristics you could use.
