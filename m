From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] notes: avoid recommitting identical trees
Date: Tue, 31 Aug 2010 11:43:05 -0700
Message-ID: <7vvd6qaaiu.fsf@alter.siamese.dyndns.org>
References: <4C7CD65F.10509@atlas-elektronik.com>
 <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net> <20100831160145.GC11014@sigill.intra.peff.net> <4C7D2AAE.9000701@drmicha.warpmail.net> <7vfwxud94w.fsf@alter.siamese.dyndns.org> <4C7D495A.1080806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Johan Herland <johan@herland.net>,
	stefan.naewe@atlas-elektronik.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:43:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVoH-0005eV-0B
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064Ab0HaSnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:43:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab0HaSnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 14:43:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87EA8D24FE;
	Tue, 31 Aug 2010 14:43:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sJBHlHAhnAwb8KnM8Xv/vntpORA=; b=xFIinW
	8hJdIZnAf+ZnlA6xM5g809JarsrlMM99wbTy3pu+o4Cg9kpApAr1Ec1pJTTJ9dxH
	e9AbtNoTmMl6rQyhcZ7mRGtBWcn/IPuovNihWcXzKEgGqmgw+JUhS7XkIOxcgMS+
	b3VhC8wrNLb6+/2pry5FrPLYFhnEGLK+hL3ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pChYrfQraHp8bmjeDKCfwXesm8BvSFBu
	5XCDrOr1ZOIp5PjcIxdFh4dIDHyCsZfqxOKgOGbFMSRhjodUF+pzxNvWqVKbrrBS
	klAgrtOF9kQyjcb0rap/s4hebZ6q8MMdcdxvTeo22lczZ59+9KD92pZ3KPgFv1xS
	5JXm00SdBoI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27532D24FB;
	Tue, 31 Aug 2010 14:43:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E720DD24F6; Tue, 31 Aug
 2010 14:43:06 -0400 (EDT)
In-Reply-To: <4C7D495A.1080806@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue\, 31 Aug 2010 20\:26\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9CB0D896-B52F-11DF-9E24-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154960>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 31.08.2010 18:44:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>>>> +	if (!parent || parse_commit(parent->item) || parse_tree(parent->item->tree) ||
>>>>> +		hashcmp(parent->item->tree->object.sha1, tree_sha1)) {
>>>>
>>>> I didn't check, but I can imagine you can drop the parse_tree here. We
>>>> should know the object sha1 once the commit is parsed.
>>>
>>> parse_commit() does a lookup_tree() but I don't think that it parses the
>>> tree, i.e. I don't hink it fills in tree->object.sha1.
>> 
>> Huh?  parse_tree(tree) calls read_sha1_file(tree->object.sha1) to parse
>> the tree.  How can it do without filling tree->object.sha1?
>
> Sure parse_tree() does that. That's why I call it. I never claimed it
> doesn't.

Sorry, My second sentence was incorrect.

       How can it do so without getting a tree with tree->object.sha1
       already filled?
