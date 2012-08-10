From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 07/13] Read resolve-undo data
Date: Thu, 09 Aug 2012 17:02:49 -0700
Message-ID: <7vboijmx5i.fsf@alter.siamese.dyndns.org>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-8-git-send-email-t.gummerer@gmail.com>
 <7vk3x7n0fl.fsf@alter.siamese.dyndns.org>
 <20120809232320.GD5127@tommy-fedora.scientificnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:03:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szcgx-0007gV-3E
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 02:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760076Ab2HJACx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 20:02:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760073Ab2HJACw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 20:02:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EA668B79;
	Thu,  9 Aug 2012 20:02:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PSaVl4CKincRG59YswJDkBMYJaQ=; b=niE3tX
	vN8XbwP4MNYt7yYGQkM984pNACHOAluCMcVFcwKSMPdp7RdoLGVxqwgDMGofqATX
	tUx2u/BEJgvhoX8LXU0LicpgAXSD/ocur22wN3yOyu0df0GPvqCTDgdOLFzDw5Es
	nRzeByHE3D1b0xFtIbWnebMD3u95Ov4FJIEfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eyOrP9bFZ3u39znfY81HZml0AZlxqWL8
	wCLPHWQsCUagKPbFNLDunqx8B6Ps8iHf72ePtDRVzLQUdjMiflBqcrU+CieHB9nY
	Q1hqZTd8Z26Sbk4obwKe/3hiu1XpfKm86/SdKSCCBImlDYYik620v+JDlX6GddsA
	SdxAYwbMs5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B4888B78;
	Thu,  9 Aug 2012 20:02:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1DC98B74; Thu,  9 Aug 2012
 20:02:50 -0400 (EDT)
In-Reply-To: <20120809232320.GD5127@tommy-fedora.scientificnet.net> (Thomas
 Gummerer's message of "Fri, 10 Aug 2012 01:23:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9AF47EC-E27E-11E1-A698-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203191>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 08/09, Junio C Hamano wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>> 
>> > Make git read the resolve-undo data from the index.
>> >
>> > Since the resolve-undo data is joined with the conflicts in
>> > the ondisk format of the index file version 5, conflicts and
>> > resolved data is read at the same time, and the resolve-undo
>> > data is then converted to the in-memory format.
>> 
>> This, and the next one, are both about reading extension data from
>> the v2 formatted index, no?
>
> Yes, exactly.
>
>> Again, mild NAK.
>> 
>> I think it is a lot more logical for the v5 code to read data stored
>> in the resolve-undo and cache-tree extensions using the public API
>> just like other users of these data do, and write out whatever in a
>> way that is specific to the v5 index format.
>> 
>> If the v5 codepath needs some information that is not exposed to
>> other users of istate->resolve_undo and istate->cache_tree, then the
>> story is different, but I do not think that is the case.
>
> Sorry it's not clear to me what you mean with using the public API here.
> Do you mean using resolve_undo_write() and resolve_undo_read()?

The code that reads from istate->resolve_undo is fine to do the v5
specific conversion, but it does not belong to resolve-undo.c file
which is about the resolve-undo extension.  Moving it to v5 specific
file you added for this topic, read-cache-v5.c, and everything looks
more logical.  When we taught ls-files to show the paths with
resolve-undo data, we didn't add any function to resolve-undo.c that
does ls-files's work for it.  Instead, ls-files just uses the public
API (the data structure you find at the_index.resolve_undo is part
of the API) to find what it needs to learn, and I think v5 code can
do the same.

"then the story is different" comment refers to a possibilty that
v5 code might need something more than callers outside resolve-undo.c
can find from its public interface, but I do not think it is the
case.
