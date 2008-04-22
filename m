From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 22 Apr 2008 01:13:19 -0700
Message-ID: <7vhcdu1f4w.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 10:14:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoDdu-0004XC-EO
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 10:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbYDVINf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 04:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756798AbYDVINe
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 04:13:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbYDVINc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 04:13:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 480E5229F;
	Tue, 22 Apr 2008 04:13:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8D9F8229E; Tue, 22 Apr 2008 04:13:27 -0400 (EDT)
In-Reply-To: <7vabjm78v2.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Apr 2008 22:32:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80079>

Junio C Hamano <junio@pobox.com> writes:

>> +mark_prefix=refs/rebase-marks/
>> +
>>  warn () {
>>  	echo "$*" >&2
>>  }
>> @@ -105,7 +107,13 @@ die_with_patch () {
>>  }
>>  
>>  cleanup_before_quit () {
>> -	rm -rf "$DOTEST"
>> +	rm -rf "$DOTEST" &&
>> +	for ref in "$GIT_DIR/$mark_prefix"*
>> +	do
>> +		test "$ref" = "$GIT_DIR/$mark_prefix*" && continue
>> +		git update-ref -d "${ref#$GIT_DIR/}" "${ref#$GIT_DIR/}" || \
>> +			return 1
>> +	done
>
> In practice nobody would "run" pack-refs during the rebase session, but I
> have to wonder if it can be triggered to run as part of automated gc or
> something, in which case this loop does not work as intended. It needs to
> be rewritten using for-each-ref.
>
>> @@ -244,6 +252,19 @@ peek_next_command () {
>>  	sed -n "1s/ .*$//p" < "$TODO"
>>  }
>>  
>> +mark_to_ref () {
>> +	case "$1" in
>> +	:[!/]*)
>> +		# :/SOMETHING is a reference for the last commit whose
>> +                # message starts with SOMETHING
>> +		echo "$mark_prefix${1#:}"
>> +		;;
>
> What was the conclusion of the mark-syntax discussion?

Eh, sorry, I was commenting on a stale one.  Disregard this part please.

But the "$GIT_DIR/$mark_prefix/*" comment still stands.  I've applied the
series as is to 'next' so let's fix them up in-tree as needed.
