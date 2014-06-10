From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 08:23:55 -0700
Message-ID: <xmqq38fcbxf8.fsf@gitster.dls.corp.google.com>
References: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com>
	<53971BBE.8030108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:28:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuNyI-0007j4-Bi
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 17:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbaFJP2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 11:28:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53620 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbaFJP2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 11:28:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0FCEC1CEDD;
	Tue, 10 Jun 2014 11:28:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mWCYpmZDRl2j
	7cCQ7xrDG5U0nmY=; b=id1O9LWvAfFG5W1CbxLfd9FNHVKL5+ImPkNR4f1Idqkd
	wYa/ABBlIrRC3bJauapKWO3EoIWdsujU68eHJELtUBi5SsGy/IqZtDhZ8agLwP6v
	EqyuXbpLEKvcY8WfhEZ0JXvczs+NHBz/MB7PNbOESloWBhWtFo2Id7tKSjNZAC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LEQD2N
	y7kHTEkwjX73NOJnxOlGugFp1I6fvensP24UnVKuXLcmV/zhrTpZh+WcIrz0vlT+
	+QxRfTi7ab9KAGsPnTC7hEONs37A6lIbKVX/esaD+TabZoZuH/Pvbo2l/8eHF3CT
	EGNhIzKIO3T3XELqAxJZUCB26dZ1c8ZtD0bpo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 05C361CEDC;
	Tue, 10 Jun 2014 11:28:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9739B1CDC9;
	Tue, 10 Jun 2014 11:23:57 -0400 (EDT)
In-Reply-To: <53971BBE.8030108@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 10 Jun 2014 16:52:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3DB532B0-F0B3-11E3-A2E8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251198>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2014-06-10 14.28, Elia Pinto wrote:
> []
>>  		# before the first commit: compare with an empty tree
>>  		head=3D$(git hash-object -w -t tree --stdin </dev/null)
>> @@ -1056,13 +1056,17 @@ cmd_summary() {
>>  		while read mod_src mod_dst sha1_src sha1_dst status sm_path
>>  		do
>>  			# Always show modules deleted or type-changed (blob<->module)
>> -			test $status =3D D -o $status =3D T && echo "$sm_path" && contin=
ue
>> +			case "$status" in
>> +			([DT])
> Does this look strange? ^
> Should it be
> case "$status" in
> D|T)

Actually POSIX allows matching parentheses for case arm labels
(surprise!).

And some shells misparse

	var=3D$( ... case arm) action ;; esac ... )

as if the ')' after the arm label closes the whole command
substitution.

Having said that, I'd prefer to see the following squashed into that
patch.

The first hunk is purely a bugfix.  It used to be=20

	if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git

that is: unless "$sm_path/.git" is directory or file, do this.
And the rewrite broke that logic.

The second hunk is to avoid "case" that confuses without helping
readability that much.

I would also have preferred to see the echo to printf substitution
left out of this patch.  There are other places where $sm_path is
echoed and fixing only one of them in an otherwise unrelated patch
feels wrong---it should be a separate follow-up patch, I would
think.

 git-submodule.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d6a1dea..27ca7d5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -832,7 +832,7 @@ Maybe you want to use 'update --init'?")"
 			continue
 		fi
=20
-		if ! test -d "$sm_path"/.git || test -f "$sm_path"/.git
+		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
 			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exi=
t
 			cloned_modules=3D"$cloned_modules;$name"
@@ -1056,11 +1056,11 @@ cmd_summary() {
 		while read mod_src mod_dst sha1_src sha1_dst status sm_path
 		do
 			# Always show modules deleted or type-changed (blob<->module)
-			case "$status" in
-			([DT])
-				printf '%s\n' "$sm_path" &&
+			if test "$status" =3D D || test "$status" =3D T
+			then
+				printf '%s\n' "$sm_path"
 				continue
-			esac
+			fi
 			# Respect the ignore setting for --for-status.
 			if test -n "$for_status"
 			then
