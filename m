From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/23] pack v4: commit object encoding
Date: Tue, 27 Aug 2013 13:15:44 -0700
Message-ID: <xmqqob8ic2kv.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<1377577567-27655-10-git-send-email-nico@fluxnic.net>
	<xmqqy57ndtxb.fsf@gitster.dls.corp.google.com>
	<alpine.LFD.2.03.1308271553530.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 22:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPg7-0001R1-Ma
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 22:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab3H0UPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 16:15:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099Ab3H0UPr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 16:15:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8100E3CE78;
	Tue, 27 Aug 2013 20:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I3M3wfnYE2pkkwHFbln3dqB4DxQ=; b=dgKsTH
	S8ZoCDgMrZgR0tqketYYrcDi2A5A7e3+nkrJrbMl8VmMhjcJSNuFBCQJA9YFNHNQ
	C/HkGUIQn0XL2rWO5q/C6ZH9/oDVcT5571B16uzjzUOLQamt2n9LMIj4ntSxWN88
	13KA6uq7IqL8WZuFp0sunpzsxrXAFY7e73mzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BtJyto3faluAi3PzQfvhZTF5uCI9vI2W
	GvfguGvKcVpPSXkjIzHjzDYaLhWhvsvxHmjJj2X4GcBOJ8ykMolH8tB/d+1d2jZy
	sFT/O9eDZkkyQryGRrPN6jq7011SJXxAIx2edwgrLTz3MJONIsX5IuZQ+TGjvT/m
	uDclYV4tDUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 744013CE77;
	Tue, 27 Aug 2013 20:15:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C897E3CE76;
	Tue, 27 Aug 2013 20:15:45 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1308271553530.14472@syhkavp.arg> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 15:59:20 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 74D9A2B6-0F55-11E3-89F4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233156>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Tue, 27 Aug 2013, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@fluxnic.net> writes:
>> 
>> > +	/* parse the "tree" line */
>> > +	if (in + 46 >= tail || memcmp(in, "tree ", 5) || in[45] != '\n')
>> > +		goto bad_data;
>> > +	if (get_sha1_hex(in + 5, sha1) < 0)
>> > +		goto bad_data;
>> 
>> Is this strict enough to guarantee roundtrip hash identity?  Because
>> get_sha1_hex() accepts hexadecimal represented with uppercase A-F,
>> you need to reject such a "broken" commit object, no?
>
> BTW, is there any such objects in existence where sha1 ascii strings are 
> represented using uppercase letters?

Any commit or tag object that refers to another object with SHA-1
using uppercase letters is broken and invalid.  get_sha1_hex() is
not limited to reading these (i.e. it also is used to read object
name given on the command line) so it is lenient, but the above
codepath should care so that the result of hashing will stay the
same.

> Because there would be a simple 
> way to encode that fact in the pack v4 sha1 reference... but that change 
> has to happen now.

Hence, I do not think we care.

> I'm already claiming we won't support mixed case though.

Yeah, I am already claiming we won't support any uppercase ;-).
