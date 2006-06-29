From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 14:26:37 -0700
Message-ID: <7vbqsbpsaa.fsf@assigned-by-dhcp.cox.net>
References: <20060628223744.GA24421@coredump.intra.peff.net>
	<7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
	<20060629180011.GA4392@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
	<20060629185335.GA6704@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
	<20060629195201.GA10786@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 29 23:26:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw426-0006rI-P8
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWF2V0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWF2V0k
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:26:40 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:25739 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932717AbWF2V0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 17:26:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629212638.YTID16011.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 17:26:38 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain> (Nicolas
	Pitre's message of "Thu, 29 Jun 2006 16:24:01 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22907>

Nicolas Pitre <nico@cam.org> writes:

> The negative delta cache concept is certainly attractive even for normal 
> repositories, especially for public servers, since when used in 
> conjonction with delta reuse it makes the creation of a pack basically 
> free.  So I think this idea really has merits, as long as the cache 
> remains small.

Yes, I agree it is very attractive.

One thing to watch out for is that we probably would not want to
let git-daemon write into public repositories.  Which means that
use of negative cache should be strict "opt-in".

 - "$GIT_DIR/delta-cache" is read but not necessarily is written
   back when it exists; git-daemon uses it that way.

 - The owner of the repository shouldn't have to tell the tool
   to update the negative cache every time repack happens.

Which suggests that pack-objects.c can learn an option that
tells it to call delta_cache_save(), and we use it in
git-repack, perhaps like this:

diff --git a/git-repack.sh b/git-repack.sh
index 640ad8d..b07ed9b 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -44,7 +44,7 @@ case ",$all_into_one," in
 esac
 pack_objects="$pack_objects $local $quiet $no_reuse_delta$extra"
 name=$(git-rev-list --objects --all $rev_list 2>&1 |
-	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
+	git-pack-objects --update-delta-cache --non-empty $pack_objects .tmp-pack) ||
 	exit 1
 if [ -z "$name" ]; then
 	echo Nothing new to pack.
 
diff --git a/pack-objects.c b/pack-objects.c
index bed2497..46b9775 100644
--- a/pack-objects.c
+++ b/pack-objects.c
...
@@ -1342,5 +1350,7 @@ int main(int argc, char **argv)
 	if (progress)
 		fprintf(stderr, "Total %d, written %d (delta %d), reused %d (delta %d)\n",
 			nr_result, written, written_delta, reused, reused_delta);
+	if (update_delta_cache)
+		delta_cache_save();
 	return 0;
 }
