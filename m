From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Mon, 15 Dec 2008 02:35:07 -0800
Message-ID: <7vljuhwwtg.fsf@gitster.siamese.dyndns.org>
References: <20081210201259.GA12928@localhost>
 <20081215004651.GA16205@localhost>
 <7v63lm1c76.fsf@gitster.siamese.dyndns.org>
 <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0812151032230.14632@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 15 11:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCAoU-00072A-S8
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 11:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbYLOKfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 05:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbYLOKfQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 05:35:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYLOKfO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 05:35:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EEDD11A4F0;
	Mon, 15 Dec 2008 05:35:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 787EC1A4E9; Mon,
 15 Dec 2008 05:35:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0E95F870-CA94-11DD-852D-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103153>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> merge-recursive: do not clobber untracked working tree garbage
>> ...
>> +static int would_lose_untracked(const char *path)
>> +{
>> +	int pos = cache_name_pos(path, strlen(path));
>> +
>> +	if (pos < 0)
>> +		pos = -1 - pos;
>> +	while (pos < active_nr &&
>> +	       !strcmp(path, active_cache[pos]->name)) {
>> +		/*
>> +		 * If stage #0, it is definitely tracked.
>> +		 * If it has stage #2 then it was tracked
>> +		 * before this merge started.  All other
>> +		 * cases the path was not tracked.
>> +		 */
>> +		switch (ce_stage(active_cache[pos])) {
>> +		case 0:
>> +		case 2:
>> +			return 0;
>> +		}
>> +		pos++;
>> +	}
>> +	return file_exists(path);
>
> I wonder if it is cheaper to test file_exists() when the index contains a 
> lot of files...

"cheaper" than what?

The test with the index is not about efficiency, but is all about
correctness.

If the file in the work tree came from the index that represents "our"
branch, we do not want to say "yes" from this function, even when
(actually, "especially when") the path exists in the work tree.
unpack-trees decided that the path matches the index (otherwise you are
already guaranteeing that we wouldn't have come this far, right?)  and we
are about to write out the (potentially partial) merge result to the
working tree file.
