From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Tags
Date: Sat, 2 Jul 2005 18:32:19 -0400
Message-ID: <20050702223219.GA21865@delft.aura.cs.cmu.edu>
References: <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com> <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com> <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com> <20050702203805.GB19206@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 00:32:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoqXO-0007Xq-B9
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 00:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVGBWc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 18:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVGBWc0
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 18:32:26 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:7892 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261315AbVGBWcU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2005 18:32:20 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DoqX5-0006fU-00; Sat, 02 Jul 2005 18:32:19 -0400
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
Content-Disposition: inline
In-Reply-To: <20050702203805.GB19206@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 02, 2005 at 04:38:06PM -0400, Jan Harkes wrote:
> - Then you run the following script (untested)

Ok, I tested it and it was pretty broken, I assumed that git-fetch-script
accepted the same arguments as git-pull-script.

Here is one that actually seems to work.

Jan


#!/bin/sh
#
# combine per-user private trees into a single repository.
# assumes that user repositories are stored as "$repos/<user>/<tree>.git"
#
global=global.git
repos=/path/to/user/repositories

export GIT_DIR="$global"

# create global repository if it doesn't exist
git-init-db

for tree in $(cd "$repos" && find . -name '*.git' -prune | sed 'sX./XX')
do
    root="$repos/$tree"
    for ref in $(cd "$root" && find refs -type f)  ; do
	echo Synchronizing $tree
	git fetch "$root" "$ref"

	type=$(echo "$ref" | sed -ne 'sX^refs/\([^/]*\)/.*$X\1Xp')
	name=$(echo "$ref" | sed -ne 'sX^refs/[^/]*/\(.*\)$X\1Xp')
	dest="$GIT_DIR/refs/$type/$tree/$name"
	mkdir -p $(dirname "$dest")
	cat "$GIT_DIR/FETCH_HEAD" > "$dest"
    done
done
