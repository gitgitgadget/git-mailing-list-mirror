From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document the underlying protocol used by shallow
 repositories and --depth commands.
Date: Tue, 07 Jun 2011 13:23:31 -0700
Message-ID: <7v1uz55r24.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=SVZPebW2YXRnaLvkxEDGy_rrtJ3jayt8Oco6Sn8hciQ@mail.gmail.com>
 <7vvcwi95yi.fsf@alter.siamese.dyndns.org>
 <loom.20110606T213817-376@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Neronskiy <zakmagnus@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 22:23:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU2oS-0000Eg-Eg
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 22:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab1FGUXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 16:23:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab1FGUXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 16:23:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E53A5EBD;
	Tue,  7 Jun 2011 16:25:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iTdsT2IGfyAUmHKFPCsoozlT/KA=; b=kDaFpd
	rx9Q2Ao7nqNI4dBXxleWODoDXaaPJGRLTZ/Sr8VCfpqv34hi2GBpQ0wyAi9vfDt8
	2+kSuYRjrTB8Mev/ImIxGCWnXn6nKzIM4IQZUUWHlJRxjBm/2vThs0MBhV2xmUWJ
	kpNsPAPszSDkzU6f/ofOlWoJ/byh/SuW0LvPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sku65esvUxour2MuVWCehPxRnB9YX2zj
	p3yiV8nYSm8UIvPUew3T+fVlHXlekuTBNk775+NBgQIOrT3vJgf351TcBQpD1UbA
	3TwUw6qmRjtnseEyzvvke+KGhSuqZQTpwtv9G+vqf20pqVZh4x7zgxQ+gzXMain4
	YgDcyzcsuwE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A3665EB9;
	Tue,  7 Jun 2011 16:25:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2FD0A5EB8; Tue,  7 Jun 2011
 16:25:42 -0400 (EDT)
In-Reply-To: <loom.20110606T213817-376@post.gmane.org> (Alex Neronskiy's
 message of "Mon, 6 Jun 2011 19:56:00 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 515EE7D8-9144-11E0-9E4E-85C8C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175263>

Alex Neronskiy <zakmagnus@google.com> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>
>> > +Once all the 'want's and 'shallow's (and optional 'deepen') are
>> > +transferred, clients MUST send a flush-pkt. If the client has all
>> > +the references on the server, and as much of their commit history
>> > +as it is interested in, client flushes and disconnects.
>> 
>> Hmmmmm, are you describing "everything-local then flush and all-done" in
>> do_fetch_pack() with the second sentence? If so, placing the description
>> here is misleading. In that case, I do not think any of the find-common
>> exchange starting from the "upload-request" phase happens.
>
> No, this refers to the same event which was already described in that document,
> which I believe happens from inside find_common.

"The same event which was already described in that document" meaning at
the beginning of "Packfile Negotiation" section?  That is primarily about
the "ls-remote" that probed the server for the list of current refs, which
is received in connect.c::get_remote_heads(), but it also covers another
case. When fetching, after connect.c::get_remote_heads() finds the list of
current refs, do_fetch_pack() is called, and then everything_local() in it
checks if we have all the objects we are going to ask. If so, we flush and
jump to all_done to terminate the connection, skipping find_common(),
without doing any of the want/shallow/depth/etc.

I don't seem to be able to find where in find_common() and its callee we
could quit without telling the server anything (unless we crash ;-). Even
if get_rev() loop finds nothing, we would at least say "done".
