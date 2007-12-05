From: Junio C Hamano <gitster@pobox.com>
Subject: Re: builtin command's prefix question
Date: Wed, 05 Dec 2007 15:22:55 -0800
Message-ID: <7vk5nsloa8.fsf@gitster.siamese.dyndns.org>
References: <fcaeb9bf0712050856t5d730779q82783fdb9876f41@mail.gmail.com>
	<7vlk88n648.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 00:23:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J03aR-0007BB-6q
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 00:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbXLEXXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 18:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbXLEXXE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 18:23:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47902 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbXLEXXD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 18:23:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 074C12F0;
	Wed,  5 Dec 2007 18:23:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6EDAE9C5BD;
	Wed,  5 Dec 2007 18:23:19 -0500 (EST)
In-Reply-To: <7vlk88n648.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 05 Dec 2007 14:12:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67210>

Junio C Hamano <gitster@pobox.com> writes:

>  * I would say it is a misconfiguration if GIT_DIR is not set and
>    GIT_WORK_TREE is, as the sole purpose of GIT_WORK_TREE is so that you
>    can work from a subdirectory when you set GIT_DIR.  I may be missing
>    an obvious use case that this is useful, but I do not think of any.
>    Dscho may be able to correct me on this, as he fixed up the original
>    work tree series that was even messier quite a bit during the last
>    round.

I had a short discussion with Dscho on this.  One scenario that was
brought up was this.

You have a work tree of mixed contents that logically belong to
separate repository.  Think $HOME/.?*, and tracking .vimrc and
.pinerc as separate "projects".  You have $HOME/gits/vim.git and
$HOME/gits/pine.git bare-looking repositories.

The "kosher" way of doing this might be:

        $ cd $HOME
        $ GIT_WORK_TREE=$HOME; export GIT_WORK_TREE
        $ edit .vimrc
        $ GIT_DIR=gits/vim.git git commit .vimrc
        $ edit .pinerc
        $ GIT_DIR=gits/pine.git git commit .pinerc

However, if we define setup() to behave this way when GIT_DIR is not
defined and GIT_WORK_TREE is:

 (1) internally pretend as if GIT_DIR was specified to be the
     directory where the command was started from (iow, do getcwd()
     once upon startup);

 (2) chdir to GIT_WORK_TREE (which means "callers of setup() always
     run from the top of the work tree");

 (3) set prefix to NULL;

Then this workflow becomes possible:

	$ cd $HOME
        $ GIT_WORK_TREE=$HOME; export GIT_WORK_TREE
	$ edit .vimrc .pinerc
        $ cd $HOME/gits/vimrc.git && git commit .vimrc
        $ cd $HOME/gits/pinerc.git && git commit .pinerc

I am not convinced this is giving any natural user experience, nor an
alternative:

	$ cd $HOME
        $ GIT_WORK_TREE=$HOME; export GIT_WORK_TREE
        $ cd $HOME/gits/vimrc.git
	$ edit $HOME/.vimrc
        $ git commit .vimrc
        $ cd $HOME/gits/pinerc.git
	$ edit $HOME/.pinerc
        $ git commit .pinerc

While I still think the combination is simply crazy and does not make
any sense, if enough users on the list agrees that it makes sense, I
wouldn't mind setup() did (1) to (3) mentioned above.  The alternative
is simply to declare GIT_WORK_TREE without GIT_DIR is a nonsense and
either error error out or ignore GIT_WORK_TREE, which might be easier to
explain to people.

Opinions?
