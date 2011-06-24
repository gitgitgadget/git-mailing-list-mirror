From: Junio C Hamano <gitster@pobox.com>
Subject: Re* ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Thu, 23 Jun 2011 21:13:46 -0700
Message-ID: <7vy60r27et.fsf_-_@alter.siamese.dyndns.org>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com>
 <7v7h8c4nv3.fsf@alter.siamese.dyndns.org> <4E0390A7.8040505@web.de>
 <7vboxo2ne9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>, Maarten Billemont <lhunath@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas =?utf-8?Q?K=C3=B6hler?= <andi5.py@gmx.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 24 06:13:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZxmF-00083H-Q1
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 06:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983Ab1FXENu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jun 2011 00:13:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab1FXENt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2011 00:13:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E3D5672D;
	Fri, 24 Jun 2011 00:15:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=but0j75XTmqrfZZS8eCq1A0HRjw=; b=tSUetE
	nhckjnry4nkKs2k7/njS/V5mXgGE8CU2AKbeHo8NK6+8p7H4NceXJiGVsrxglSUG
	NyZ7DM5m/SX8hMK0txyesJGZYizqOskwEpw7sGc41xhcRc/HfHMiv/Ymj5lRZsTY
	0NoNXpWfXy5i3bQd1uA7tLu35b2WflJ7voXhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IY9eW908wonWOq+ygUk1IYVFD0gm8AsY
	f3k71cU9R+YjSB6XlKlJFP0YisGH1QzmYyom8aW1Cv5zSEUjj5pZZF1gVBdo2fx1
	eM/d/cD0MCSBmDPuoocSuP2TtUd0aV3FJACVyjfKYKkyL1SwKig68Bv1c8l0jow3
	KwNenHS9IkE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 665F06721;
	Fri, 24 Jun 2011 00:15:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8FC846720; Fri, 24 Jun 2011
 00:15:58 -0400 (EDT)
In-Reply-To: <7vboxo2ne9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 23 Jun 2011 15:28:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9C81E9A-9E18-11E0-A3BC-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176302>

Junio C Hamano <gitster@pobox.com> writes:

> Actually, shouldn't the fix be more like this patch, which is directly on
> top of 33f072f?  I think this is more in line with what the end user wants
> to tell the system with "submodule init", namely "I am interested in this
> submodule".

This, when merged with jl/submodule-add-relurl-wo-upstream topic in "pu",
breaks a test in t7400, which was introduced by 4d68932 (submodule add:
allow relative repository path even when no url is set, 2011-06-06).

A workaround patch (shown offset below) to make it "pass" exposes that the
test was relying on the too aggressive "submodule sync" behaviour I just
fixed with the previous patch.

And I do not think the particular workaround is correct.

Shouldn't "submodule add" add an entry for .git/config even when it cloned
from elsewhere?

When adding a local subdirectory that houses the subproject with
"submodule add", the code does add an entry to .git/config, but when the
moule is cloned from elsewhere (by calling module_clone), nobody adds the
corresponding entry to .git/config.  "submodule add $URL $path" should
result in exactly the same state as if the user said "submodule init
$path" and then "submodule update $path" to instantiate the path in a
superproject that was cloned from elsewhere, no?

I suspect this fix will cascade to breakage elsewhere, but I've run out of
energy and inclination to look at the submodule code tonight, so I'll let
the list to take it further from here.

-- >8 --
Subject: [RFC] submodule add: initialize .git/config entry

When "git submodule add $path" is run to add a subdirectory $path to the
superproject, and $path is already the top of the working tree of the
submodule repository, the command created submodule.$path.url entry in the
configuration file in the superproject. However, when adding a repository
$URL that is outside the respository of the superproject to $path that
does not exist (yet) with "git submodule add $URL $path", the command
forgot to set it up.

The user is expressing the interest in the submodule and wants to keep a
checkout; the "submodule add" command should consistently set up the
submodule.$path.url entry in either case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    (A workaround patch that may not be a correct fix for the test breakage)

        diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
        index 9099e80..cfe81e3 100755
        --- a/t/t7400-submodule-basic.sh
        +++ b/t/t7400-submodule-basic.sh
        @@ -446,16 +446,17 @@ test_expect_success 'add should fail when pat...
                )
         '

         test_expect_success 'use superproject as upstream when path is rel...
                (
                        cd addtest &&
                        git submodule add ../repo relative &&
                        test "$(git config -f .gitmodules submodule.relativ...
        +		git submodule init relative &&
                        git submodule sync relative &&
                        test "$(git config submodule.relative.url)" = "$sub...
                )
         '

         test_expect_success 'set up for relative path tests' '
                mkdir reltest &&
                (

 git-submodule.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b0a8e63..8a16ad1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -238,7 +238,6 @@ cmd_add()
 			die "'$path' already exists and is not a valid git repo"
 		fi
 
-		git config submodule."$path".url "$realrepo"
 	else
 
 		module_clone "$path" "$realrepo" "$reference" || exit
@@ -253,6 +252,8 @@ cmd_add()
 		) || die "Unable to checkout submodule '$path'"
 	fi
 
+	git config submodule."$path".url "$realrepo"
+
 	git add $force "$path" ||
 	die "Failed to add submodule '$path'"
 
