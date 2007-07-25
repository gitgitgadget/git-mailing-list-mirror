From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodule init problem
Date: Wed, 25 Jul 2007 15:20:12 -0700
Message-ID: <7v8x94dt2b.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	<7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
	<20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
	<b6ebd0a50707201023h12ed3c61v31ccb2b356c1ee42@mail.gmail.com>
	<7vsl7jvthk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707201933360.14781@racer.site>
	<d4b731510707241709pcad0a4bj85b71892cd2de84c@mail.gmail.com>
	<d4b731510707241730u45755c0dwfde5e0b14b14f1da@mail.gmail.com>
	<7vir89fe1l.fsf@assigned-by-dhcp.cox.net>
	<20070725081508.GN1591MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org,
	Ricky Nite <ricky.nite@gmail.com>,
	Chris Larson <clarson@kergoth.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu Jul 26 00:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDpDP-00028Y-0w
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 00:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237AbXGYWUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 18:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbXGYWUQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 18:20:16 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43791 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbXGYWUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 18:20:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725222013.TLZV1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 25 Jul 2007 18:20:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TyLC1X00P1kojtg0000000; Wed, 25 Jul 2007 18:20:13 -0400
In-Reply-To: <20070725081508.GN1591MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Wed, 25 Jul 2007 10:15:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53725>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Tue, Jul 24, 2007 at 06:49:26PM -0700, Junio C Hamano wrote:
>> Ok, this appears it most likely to be related to the fact that
>> one is a prefix of the other in problematic case.
>
> Yes, this has been noted before and Chris Larson sent in a patch,
> but he didn't follow up on it.

Ok, I re-read the thread and came up with a different solution.
How does this look?

-- >8 --
git-submodule module_name: avoid using unwieldy "value_regexp" feature.

"module_name $path" function wants to look up a configuration
variable "submodule.<modulename>.path" whose value is $path, and
return the <modulename> found.  "git-config --get-regexp" is the
natural thing to use for this, but (1) its value matching has an
unfortunate "feature" that takes leading '!' specially, and (2)
its output needs to be parsed with sed to extract <modulename>
part anyway.

This changes the call to "git-config --get-regexp" not to use
the value-regexp part, and moves the "pick the one whose value
is $path" part to the downstream sed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 git-submodule.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1f0cb99..afbaec7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -46,8 +46,11 @@ get_repo_base() {
 #
 module_name()
 {
-       name=$(GIT_CONFIG=.gitmodules git config --get-regexp '^submodule\..*\.path$' "$1" |
-       sed -nre 's/^submodule\.(.+)\.path .+$/\1/p')
+	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
+	re=$(printf '%s' "$1" | sed -e 's/\([^a-zA-Z0-9_]\)/\\\1/g')
+	name=$( GIT_CONFIG=.gitmodules \
+		git config --get-regexp '^submodule\..*\.path$' |
+		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
        test -z "$name" &&
        die "No submodule mapping found in .gitmodules for path '$path'"
        echo "$name"
