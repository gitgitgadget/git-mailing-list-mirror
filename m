From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Toy PATCH] Avoid spilling collided entries in object hash table
 to the next slots
Date: Fri, 29 Mar 2013 10:15:19 -0700
Message-ID: <7vd2uip1p4.fsf@alter.siamese.dyndns.org>
References: <1364568469-2250-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 18:15:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULcu7-0003Q5-CS
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 18:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258Ab3C2RPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 13:15:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756234Ab3C2RPW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Mar 2013 13:15:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDD93EB7D;
	Fri, 29 Mar 2013 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j+XHMjdmdgUf
	lHxEDJzU3sYxVeQ=; b=It0rBl1+CI2/kFBzYxXstnfg3NQni2IMC1gWuRVESKyB
	NjUSY8CeKtUkFv4ZKhOvJl3LA4k7ToV4a9uiI90zVwYY9sz2e2Txs/VUH60RAGiu
	IcEJOsoGtKltHhi72R5GIi759Da8jNPn4UheBoA1ubRawldwXk1CNmi6fyXdYtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dv4VCk
	AO7EmXz4G+jmsRB+M731wpknd6Zd2Csai8ALtYdXq3HypML5TnU0GwMGHOIsfpL7
	86URtum1+fINojgzXo6Z+rwSB35KsuwNRgMvyCVKa7/tasv6j8ukUXsHwcw4TMZi
	5y8papp0MPiLMxW/Mx9M7WBQy/NC0+M2F19r0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C12B4EB7C;
	Fri, 29 Mar 2013 17:15:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45BD6EB79; Fri, 29 Mar 2013
 17:15:21 +0000 (UTC)
In-Reply-To: <1364568469-2250-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 29 Mar
 2013 21:47:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C8CAAF8-9894-11E2-8FB6-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219509>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> If a position in object hash table is taken, we currently check out
> the next one. This could potentially create long object chains. We
> could create linked lists instead and leave the next slot alone.

In the current code, not just the logic in lookup_object(), but the
logic to enforce load factor when create_object() decides to call
grow_object_hash() and object enumeration implemented by
get_max_object_index() and get_indexed_object() are closely tied to
the open addressing scheme.  If you want to switch to any other
method (e.g. separate chaining) these need to be updated quite a
bit.

I do not see get_max_object_index() and get_indexed_object() updated
at all.  Do fsck, index-pack, name-rev and upload-pack still work?

This particular implementation that uses a fake "union" is a bit
ugly, but in general, it may be worth rethinking the object hash
implementation.  I vaguely recall trying cuckoo in the vicinity of
this code.
