From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] File system difference handling in git
Date: Tue, 22 Jan 2008 02:24:07 -0800
Message-ID: <7vtzl6qhtk.fsf@gitster.siamese.dyndns.org>
References: <3f4fd2640801220121w60cb9a69u8519a7ceb81d3414@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 11:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHGJY-00071v-Rc
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 11:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758437AbYAVKYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 05:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758428AbYAVKYP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 05:24:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757458AbYAVKYO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 05:24:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C0ACB56C6;
	Tue, 22 Jan 2008 05:24:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 26C9A56C2;
	Tue, 22 Jan 2008 05:24:08 -0500 (EST)
In-Reply-To: <3f4fd2640801220121w60cb9a69u8519a7ceb81d3414@mail.gmail.com>
	(Reece Dunn's message of "Tue, 22 Jan 2008 09:21:02 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71440>

"Reece Dunn" <msclrhd@googlemail.com> writes:

>   1.  File name representation
>
> For Linux file systems ...
> Therefore, you have:
>
>    os_to_git_path( const NATIVECHAR * ospath, strbuf * gitpath );
>    git_to_os_path( const char * gitpath, const NATIVECHAR * ospath, int oslen );

It is not that simple, I am afraid.  Legacy encodings can be
used in pathnames.  With bog-standard traditional UNIX pathname
semantics, all pathnames are sequences of non-NUL, non-slash
bytes, separated with slashes, so if you do not allow choices
(which is a very sensible ideal world scenario), you can declare
that the "git" encoding is UTF-8 and always check things out
as-is.

But if you want a project ("git" in your above parlance) to be
checked out in two repositories, one with legacy and the other
with UTF-8, you cannot just say os_to_git/git_to_os.  You would
need a bit more information from the repository owners what
encodings are suitable.  So your os_to_git()/git_to_os() will
not be an identity function even on Linux to support such.

I used to have a data directory on my Linux box with EUC-JP
pathname and exported as an SMB share to my wife's Windows box,
telling samba to transliterate to whatever encoding the other
end liked.  I did not want to have the pathname on the Linux end
in UTF-8 because I did not have enough energey to update my
Emacs configuration to grok Japanese in UTF-8 (even though I
finally bit the bullet and switched to UTF-8 on the Linux side
recently).

I know, this is painful.  Real life hurts.  Even on Linux,
not everybody can live in UTF-8-only world.

>   2.  Case (in)sensitivity
>
> Here, you have the following cases:
> ...
>   3.  git says that the files are different, but the filesystem says
> that the files are the same.
>
> Allow the move, updating the git directory tree only.

Sorry, I cannot really tell what you are talking about.  You
seem to imply, with "Allow the move", that you are describing a
scenario that involves a move of one existing file to another,
but it is not clear.  E.g. did you mean, by 3, "When the user
says 'move a b', and if git says a and b are different but if
the filesystem says a and b are the same, then..."?
