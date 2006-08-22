From: Junio C Hamano <junkio@cox.net>
Subject: Re: git clone dies (large git repository)
Date: Mon, 21 Aug 2006 17:23:44 -0700
Message-ID: <7v3bbpty7j.fsf@assigned-by-dhcp.cox.net>
References: <op.teh30gmyies9li@rygel.lnxi.com>
	<7vfyfs313t.fsf@assigned-by-dhcp.cox.net>
	<op.tenp9fv1ies9li@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 02:23:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFK3c-0000gu-2V
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 02:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWHVAXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 20:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWHVAXs
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 20:23:48 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3560 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750896AbWHVAXs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 20:23:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822002345.WZVS29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Aug 2006 20:23:45 -0400
To: "Troy Telford" <ttelford@linuxnetworx.com>
In-Reply-To: <op.tenp9fv1ies9li@rygel.lnxi.com> (Troy Telford's message of
	"Mon, 21 Aug 2006 17:30:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25828>

"Troy Telford" <ttelford@linuxnetworx.com> writes:

> I'm thinking of it as an option for git-repack-- that the user can set
> the maximum size of any individual pack, and after that limit is
> reached, a  new pack file is started.  (ie. --max-size 2GB) and will
> end up with two  packs, each 2GB in size.

The way I would suggest you do it is not by size but by distance
from the latest.  If you want to split the kernel history for
example, you repack up to 2.6.14 for example, and then repack
the remainder.  That way, you can optimize for size for older
(presumably less frequently used) data while optimizing for
speed for more reent stuff.

There is no wrapper support for the above splitting in
git-repack.  The low-level plumbing tools can be used this way
for example:

	name=`
                git rev-list --objects $list_old_tags_here |
                git pack-objects --window=50 --depth=50 --non-empty .tmp-pack
        ` &&
        mv -f .tmp-pack-$name.{pack,idx} .git/objects/pack/

	name=`
		git revlist --objects --all --not $list_old_tags_here |
		git pack-objects --non-empty .tmp-pack
	` &&
        mv -f .tmp-pack-$name.{pack,idx} .git/objects/pack/

If you are splitting into more than two, you would instead have
more than one $list_old_tags_here list, and iterate them
through, something like:

	pack_between () {
        	already_done="$1"
                do_this_time="$2"
                w=${3-10}
		name=`
			git rev-list --objects \
                        	$do_this_time \
                                --not $already_done |
			git pack-objects --window=$w --depth=$w \
                        	--non-empty .tmp-pack
                ` &&
                mv -f .tmp-pack-$name.{pack,idx} .git/objects/pack/
	}

	pack_between "" "$prehistoric_tag_list" 100
	pack_between "$prehistoric_tag_list" "$more_recent_tag_list" 50
	pack_between "$more_recent_tag_list" --all

All untested, of course, so do not play with it in your precious
repository you do not have any other copy, but hopefully you get
an idea ;-).
