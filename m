From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git Future Proofing
Date: Mon, 21 Nov 2005 17:13:05 -0800
Message-ID: <7vmzjxjxi6.fsf@assigned-by-dhcp.cox.net>
References: <11326192921291-git-send-email-matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 02:13:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeMif-0001q2-5z
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 02:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVKVBNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 20:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVKVBNJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 20:13:09 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15780 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964811AbVKVBNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 20:13:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122011308.OFHZ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 20:13:08 -0500
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <11326192921291-git-send-email-matlads@dsmagic.com> (Martin
	Atukunda's message of "Tue, 22 Nov 2005 03:28:12 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12513>

Martin Atukunda <matlads@dsmagic.com> writes:

> Patch 2 fixes init-db's template copy so that it handles
> copying a config file.

The readdir() loop in init_db_config_check() confuses me.  Why
check the prefix config (and "config" has 6 bytes not 5 ;-) not
just open("$template_path/config")???

> Patch 6 fixes up init-db config copying so as to never copy anything newer.

>> It however, warns if the copy will result in a downgrade of the repo format
>> version, as git tools are supposed (or will be able) to handle this case :)

I suspect that it is not enough to copy an older version of
config file along with older version of templates.

Suppose version 0 had .git/remotes/{origin,linus,...} and
version 1 moved that information to a flat file ".git/remotes",
that has a bunch of sections like [remotes.origin] in the config
file format, because we have a mechanism in your patch 5 that
lets us read from more than one configuration file.

Now suppose you are running a version 1 repository, so all your
remotes trees you subscribe to are described in .git/remotes
file.  You somehow used git-init-db to reiniailize it, using
version 0 template, which has "remotes/origin" and
"remotes/linus".  What happens?

Template-copying is designed not to overwrite what is in the
repository, so your .git/remotes file will hopefully be kept,
and the configuration file now claims the repository is in
version 0 format.  But is it really in version 0 format?  You
cannot create .git/remote/frotz file in such a repository.

I think copying older one into a fresh repository might be safe,
but I'd feel safer if we do not play downgrade games like this.
