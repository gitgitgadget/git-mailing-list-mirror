From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] `git stash drop --help` removes stash
Date: Tue, 22 May 2012 10:58:00 -0700
Message-ID: <7vwr443xp3.fsf@alter.siamese.dyndns.org>
References: <95877607-FED0-41C0-9F12-B91FE9DE7871@openforce.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Daniel <alexander.daniel@openforce.com>
X-From: git-owner@vger.kernel.org Tue May 22 19:58:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWtLZ-0002Mv-LV
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145Ab2EVR6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 13:58:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36601 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572Ab2EVR6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 13:58:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1848272;
	Tue, 22 May 2012 13:58:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B8mnYHcgtziBuHzlMvJ0pZ9qbHA=; b=DYw4GB
	i2T96Y1LzIoU9Oih0DhOwVkgMiXR8BitHCDq88ZWswhL/P5fQXoueHDumUAG0gnG
	YHkOYhcu6owFMNNH863Oo8DEuzNBV0osnUi22AuM2hpdzmzh3Cez7TyBV4SRaKO+
	C2Tf2HStq8aKEwLz4cfyLzGIAF+ymn9XunXEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jv8FaK23CS9toCsyCQz5vbu/r3pEu9sN
	8r1iXJC3wzgW2DEmwnY5pl7jAA/sVmmp6fQB+udOoa90it6EYsEiJ9Rv4okFnORr
	3YtzpqHL+9O0UM2DQ73kbLgMSsGFYKvYXsG4/5n9AQxPD1TtSG149Rsdh3ueOIh6
	gkFMz3t9lLU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E63928271;
	Tue, 22 May 2012 13:58:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A544D8254; Tue, 22 May 2012
 13:58:01 -0400 (EDT)
In-Reply-To: <95877607-FED0-41C0-9F12-B91FE9DE7871@openforce.com> (Alexander
 Daniel's message of "Tue, 22 May 2012 09:29:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC7168C4-A437-11E1-9833-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198216>

Alexander Daniel <alexander.daniel@openforce.com> writes:

> SUMMARY
> `git stash drop --help` removes stash@{0}

Thanks.

Unfortunately there is no subcommand specific help text, so a quick fix
would be along the lines of the attached patch.

The right fix would be to instead add support for subcommand specific help
text.  Such a change would tweak assert_stash_like and assert_stash_ref
not to die when --help is given even if there is no stash (or an explicit
command line argument did not name a stash), and then make all subcommand
implementations in the script (e.g. find places where these two functions
are called) notice that the user asked for --help and give subcommand
specific help text from there.


 git-stash.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index 4e2c7f8..487e2b5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -339,6 +339,9 @@ parse_flags_and_rev()
 			--index)
 				INDEX_OPTION=--index
 			;;
+			--help)
+				usage
+			;;
 			-*)
 				FLAGS="${FLAGS}${FLAGS:+ }$opt"
 			;;
