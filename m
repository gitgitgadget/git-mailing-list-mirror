From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] pack-objects: don't loosen objects available in 
 alternate or kept packs
Date: Sun, 22 Mar 2009 12:06:41 -0700
Message-ID: <7viqm15qda.fsf@gitster.siamese.dyndns.org>
References: <ee63ef30903211526n47c40052mc40dc018f25c99fd@mail.gmail.com>
 <7vbpru9nh9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 20:08:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlT1y-00024g-5a
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 20:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbZCVTGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 15:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbZCVTGu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 15:06:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbZCVTGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 15:06:50 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BCCA0A3C59;
	Sun, 22 Mar 2009 15:06:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 73B4AA3C54; Sun,
 22 Mar 2009 15:06:43 -0400 (EDT)
In-Reply-To: <7vbpru9nh9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 21 Mar 2009 21:43:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97936852-1714-11DE-8321-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114165>

Junio C Hamano <gitster@pobox.com> writes:

>> +static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
>> +{
>> +	static struct packed_git *last_found = (void *)1;
>> +	struct packed_git *p;
>> +
>> +	p = (last_found == (void *)1) ? packed_git : last_found;
>
> Why (void *)1, not like:
>
> 	static struct packed_git *last_found;
> 	struct packed_git *p = last_found ? last_found : packed_git;
>
> Am I missing something?
>
>> +	while (p) {
>> +		if ((!p->pack_local || p->pack_keep) &&
>> +			find_pack_entry_one(sha1, p)) {
>> +			last_found = p;
>> +			return 1;
>> +		}
>> +		if (p == last_found)
>> +			p = packed_git;
>> +		else
>> +			p = p->next;
>> +		if (p == last_found)
>> +			p = p->next;
>> +	}
>> +	return 0;
>> +}

Yes I was.

If you allow (last_found == NULL), the loop iterates over packed_git list,
and when it has its last element in p after discovering nothing matches
the criteria, this happens:

	if (p == last_found) /* false, p is the last element on the list */
        	p = packed_git; /* not taken */
	else
        	p = p->next; /* taken, p == NULL now */
	if (p == last_found) /* true! */
		p = p->next; /* OOPS */
