From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] submodule: Try harder to fetch needed sha1 by direct fetching sha1
Date: Mon, 22 Feb 2016 16:01:06 -0800
Message-ID: <xmqqzius2t31.fsf@gitster.mtv.corp.google.com>
References: <1456180548-20996-1-git-send-email-sbeller@google.com>
	<1456180548-20996-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, dborowitz@google.com,
	jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:01:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY0Pi-0005sz-MR
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 01:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432AbcBWABK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 19:01:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756210AbcBWABJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 19:01:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 708114711D;
	Mon, 22 Feb 2016 19:01:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W9kBvKdr6GsgQXvhiXGpfk8OUV0=; b=wjtuYh
	5G82xQWo9YY+no3D8DBK96TRcV/l12IMpooE4sysxrKvdGQ0JXm2Nc1riSe0EotO
	SplzugOWK7oHA/faxtzFBqi5OqyfdjmB1sJbxh3QGBr28SFkoZWcmHtAfBbbyBOc
	oJHY85FjABHwgYhDQRfsOGImqjZPuQyLH9TOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GxXFGUJ8NpOXpjopAgc4OMkaBV6lL19H
	bpBb1qJnYzHfzd/8K0CV1Vep5GASHAvVwZzYowkWxJdlJhkJ+bYz/ojyQDmqpfFA
	DjGGeJZdA61WL2FLNSHsZ/3fjUaXerBrTzYYtCA7nO6hSy0HCMTnjO6nahc9GoAt
	gRKkhxtXYn0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 666754711C;
	Mon, 22 Feb 2016 19:01:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D65AF4711B;
	Mon, 22 Feb 2016 19:01:07 -0500 (EST)
In-Reply-To: <1456180548-20996-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 22 Feb 2016 14:35:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A1F2C8A-D9C0-11E5-ABB2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287002>

Stefan Beller <sbeller@google.com> writes:

> We may want to discuss the error message. It is the same as in the case
> before (git-fetch <no args>), this is good for translation, but may be bad
> for the user as we may want to give extra information.
> ("We fetched for you and it worked, however the sha1 was not included,
> so we fetched again the server broke it, so we error out.  You used to
> see error message: ....")
>
> Although this may be too much information?

Now the "go to that submodule directory and see if $sha1 is
reachable from any of the ref" check is written twice exactly the
same way, it deserves to become a small helper function, I think.

Perhaps something along this line?

 git-submodule.sh | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f..836348f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -591,6 +591,24 @@ cmd_deinit()
 	done
 }
 
+is_tip_reachable () (
+	clear_local_git_env
+	cd "$1" &&
+	rev=$(git rev-list -n 1 "$2" --not --all 2>/dev/null) &&
+	test -z "$rev"
+)
+
+fetch_in_submodule () (
+	clear_local_git_env
+	cd "$1" &&
+	case "$2" in
+	'')
+		git fetch ;;
+	*)
+		git fetch $(get_default_remote) "$2" ;;
+	esac
+)
+
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -745,9 +763,14 @@ Maybe you want to use 'update --init'?")"
 			then
 				# Run fetch only if $sha1 isn't present or it
 				# is not reachable from a ref.
-				(clear_local_git_env; cd "$sm_path" &&
-					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
-					 test -z "$rev") || git-fetch)) ||
+				is_tip_reachable "$sm_path" "$sha1" ||
+				fetch_in_submodule "$sm_path" ||
+				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
+
+				# Now we tried the usual fetch, but $sha1 may
+				# not be reachable from any of the refs
+				is_tip_reachable "$sm_path" "$sha1" ||
+				fetch_in_submodule "$sm_path" "$sha1" ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 			fi
 
