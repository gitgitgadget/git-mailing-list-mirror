From: Petr Baudis <pasky@suse.cz>
Subject: Re: CIA hook for contrib/
Date: Wed, 21 Apr 2010 12:10:02 +0200
Message-ID: <20100421101002.GD3563@machine.or.cz>
References: <20100327102632.GA5043@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 12:10:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Wsq-0003WO-4Y
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 12:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab0DUKKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 06:10:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54756 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564Ab0DUKKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 06:10:08 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 16C3586208E; Wed, 21 Apr 2010 12:10:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100327102632.GA5043@thyrsus.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145425>

  Hi!

On Sat, Mar 27, 2010 at 06:26:32AM -0400, Eric Raymond wrote:
> Upon investigating further, I find that ciabot.sh seems to be a
> derivative of ciabot.pl, which is a dangling bit of the moribund
> Cogito project.  I have been unable to get responses from the authors
> of either ciabot.sh or ciabot.pl.

  Strange, I received no mail from you. When did you send it?

> A fixed and working version in shell is enclosed.

  It would have been easier to review if it was quotable. ;-)
(I have also looked at the current checked in version.)

  I'm happy that someone resurrected the hook script, thanks for that!
By the way, you seem to drop support for XML::RPC altogether while the
original ciabot.pl could use both. While XML::RPC requires another
dependency (not sure if plain Python installation can do it) and it can
time out in case of CIA server trouble (not sure how common these are
nowadays), the distinct advantage is that the commits will always end up
in correct order, while it seemed to be common that by mail, push of
multiple commits would reorder them randomly.

> # update: You have to call it once per merged commit:
> #
> #       refname=$1
> #       oldhead=$2
> #       newhead=$3
> #       for merged in $(git rev-list ${oldhead}..${newhead} | tac) ; do
> #               /path/to/ciabot.bash ${refname} ${merged}
                  ^^^^^^^^^^^^^^^^^^^^

Obsolete .bash reference.

> rev=$(git describe ${merged} 2>/dev/null)
> # ${merged:0:12} was the only bashism left in the 2008 version of this
> # script, according to checkbashisms.  Replace it with ${merged} here
> # because it was just a fallback anyway, and it's worth taking accepting
> # a longer fallback for faster execution and removing the bash deoendency.
> [ -z ${rev} ] && rev=${merged}

I personally find git-describe'd revspecs extremely ugly, unreadable and
less practical than plain hex ids (maybe I'm weird?), it would be really
nice to get a configuration choice between git describe and just:

	rev=$(echo "$merged" | cut -c 1-12)

(Not sure about the bashism rant since you can trivially just replace it
with the cut.)

> # This discards the part of the author's address after @.
> # Might be nice to ship the full email address, if not
> # for spammers' address harvesters - getting this wrong
> # would make the freenode #commits channel into harvester heaven.

The comment is not accurate since that code seems to be doing a lot of
other things as well.

I would personally prefer to have this configurable; I consider trying
to protect your e-mail address against harvesters is a lost fight anyway
and you'd be much better off just getting a good spam filter, rather
than making yours and others' life harder by trying to fight in vain.
But it's not too important for me since I can just disable this easily.

> rawcommit=$(git cat-file commit ${merged})
> author=$(echo "$rawcommit" | sed -n -e '/^author .*<\([^@]*\).*$/s--\1-p')
> logmessage=$(echo "$rawcommit" | sed -e '1,/^$/d' | head -n 1)
> logmessage=$(echo "$logmessage" | sed 's/\&/&amp\;/g; s/</&lt\;/g; s/>/&gt\;/g')
> ts=$(echo "$rawcommit" | sed -n -e '/^author .*> \([0-9]\+\).*$/s--\1-p')

Your life would be much easier in both the shell and python script if
you used something like:

	git log -1 '--pretty=format:%an <%ae>%n%at%n%s'

You would also get <ts> in the correct format, incl. timezone correction.

  Kind regards,

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
