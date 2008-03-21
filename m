From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: Fix overtight refspec validation
Date: Fri, 21 Mar 2008 16:59:06 -0700
Message-ID: <7vy78bmxx1.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org>
 <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210014100.19665@iabervon.org>
 <7vmyosskyu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
 <7v3aqksic6.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803211148120.19665@iabervon.org>
 <7vlk4boh6v.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803211840480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 00:59:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcr9Q-00012B-JK
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 00:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbYCUX7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 19:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbYCUX7P
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 19:59:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbYCUX7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 19:59:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 411501852;
	Fri, 21 Mar 2008 19:59:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5C36A184F; Fri, 21 Mar 2008 19:59:09 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803211840480.19665@iabervon.org> (Daniel
 Barkalow's message of "Fri, 21 Mar 2008 19:12:15 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77777>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> +		/*
>> +		 * Do we want to validate LHS?
>> + ...
>> +		 * Hence we check non-empty LHS for fetch, and
>> +		 * colonless or glob LHS for push here.
>> +		 */
>
> Wouldn't this be clearer and not meaningfully harder in 
> parse_fetch_refspec and parse_push_refspec?

Do you mean you want the callers of this internal implementation to also
loop over the input set of refs?  I think that would be more complex code
but I do not see much gain by doing so.

>> +		if (fetch ? (*rs[i].src) : (!rhs || is_glob)) {
>
> This is an odd combination of locals and struct members.
>                                        : (!rs[i].dst || rs[i].pattern) {

Sorry, I do not understand what's wrong about it.

	!!rhs === (did we see a colon) === !!rs[].dst
        is_glob === (did they both end with "/*") === rs[].pattern

They are equivalent, and local variables are primarily what the logic
works on and bases its decisions to store what in rs[] structures.

Ahh...  do you mean:

	(*rs[i].src) === (is lhs non empty?) === !!llen

I guess using "llen" there is more consistent and is moderately cleaner.

Perhaps squash this as a clean-up?

diff --git a/remote.c b/remote.c
index 4117bfc..86113b7 100644
--- a/remote.c
+++ b/remote.c
@@ -453,7 +453,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		 * "empty" for removal) in LHS, and we cannot check
 		 * for error until it actually gets used.
 		 */
-		if (fetch ? (*rs[i].src) : (!rhs || is_glob)) {
+		if (fetch ? llen : (!rhs || is_glob)) {
 			st = check_ref_format(rs[i].src);
 			if (st && st != CHECK_REF_FORMAT_ONELEVEL)
 				goto invalid;
