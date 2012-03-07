From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multiple --reference arguments to submodule add/update
Date: Wed, 07 Mar 2012 09:57:48 -0800
Message-ID: <7vboo8nvj7.fsf@alter.siamese.dyndns.org>
References: <m3hay0ldf4.fsf@passepartout.tim-landscheidt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Landscheidt <tim@tim-landscheidt.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:58:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5L7c-0001Vi-Qk
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 18:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268Ab2CGR5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 12:57:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758389Ab2CGR5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 12:57:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E85A73D8;
	Wed,  7 Mar 2012 12:57:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FoDA7eMRyMCT8mAjXrPje3qEcvM=; b=bd696e
	gZLBgypg5TaoZWnWumzX4GCmeckrBX58q+qNMV33pXHAVJucpzlCuj7jTuO7oTjm
	X8ikHnmAQhjRkBQQqmzOs7tBdFUst5m9GI4+Y1xTmimz70PHotgKce1GztGzdA4h
	hTxaMU9GfVF7omdgrTgIesphgp/iseDSljtjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a2rBP76vDOvG/+DgKFgJ1dzByoImN+0t
	Eb/JmUZbJfFApZI4ks8XeUqg3+RKAnSOUEPq++kyuv/eGofIJ2bhVJEU9/O9r5t9
	Kaef86oxMuN4Z7iOfuCKrtz/9RXtvbaLf3lelvImKF6ahRxgi7QqxFxwrVpMwLm5
	Dfy2NGOa0KE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8195973D7;
	Wed,  7 Mar 2012 12:57:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDACA73D6; Wed,  7 Mar 2012
 12:57:49 -0500 (EST)
In-Reply-To: <m3hay0ldf4.fsf@passepartout.tim-landscheidt.de> (Tim
 Landscheidt's message of "Wed, 07 Mar 2012 13:59:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DD2394E-687F-11E1-B3ED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192467>

Tim Landscheidt <tim@tim-landscheidt.de> writes:

> It's trivial to fix this for trivial repository specifiers.
> But for specifiers with white space, quote or shell meta
> characters, my mind boggles :-).

Something like this. As always, totally untested.

 git-submodule.sh |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bb2e13..f9991cb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,6 +30,10 @@ nofetch=
 update=
 prefix=
 
+sq () {
+    git rev-parse --sq-quote "$@"
+}
+
 # Resolve relative url by appending to parent's url
 resolve_relative_url ()
 {
@@ -121,7 +125,7 @@ module_clone()
 {
 	path=$1
 	url=$2
-	reference="$3"
+	references=$3
 	quiet=
 	if test -n "$GIT_QUIET"
 	then
@@ -163,13 +167,11 @@ module_clone()
 		echo "gitdir: $rel_gitdir" >"$path/.git"
 		rm -f "$gitdir/index"
 	else
-		mkdir -p "$gitdir_base"
-		if test -n "$reference"
-		then
-			git-clone $quiet "$reference" -n "$url" "$path" --separate-git-dir "$gitdir"
-		else
-			git-clone $quiet -n "$url" "$path" --separate-git-dir "$gitdir"
-		fi ||
+		mkdir -p "$gitdir_base" &&
+		cmd='git clone $quiet '"$references" &&
+		cmd="$cmd "' -n "$url" "$path" --separate-git-dir "$gitdir"' &&
+		# echo "$cmd" && # if you want to debug this
+		eval "$cmd" ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
 	fi
 }
@@ -200,11 +202,11 @@ cmd_add()
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
-			reference="--reference=$2"
+			reference="$reference --reference=$(sq "$2") "
 			shift
 			;;
 		--reference=*)
-			reference="$1"
+			reference="$reference$(sq "$1") "
 			shift
 			;;
 		--)
@@ -450,12 +452,12 @@ cmd_update()
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
-			reference="--reference=$2"
-			orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
+			reference="$reference --reference=$(sq "$2") "
+			orig_flags="$orig_flags $(sq "$1")"
 			shift
 			;;
 		--reference=*)
-			reference="$1"
+			reference="$reference$(sq "$1") "
 			;;
 		-m|--merge)
 			update="merge"
@@ -523,7 +525,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
-			module_clone "$path" "$url" "$reference"|| exit
+			module_clone "$path" "$url" "$reference" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
