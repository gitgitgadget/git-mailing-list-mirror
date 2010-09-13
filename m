From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log --author: take union of multiple "author"
 requests
Date: Mon, 13 Sep 2010 11:11:40 -0700
Message-ID: <7vfwxdbjj7.fsf@alter.siamese.dyndns.org>
References: <AANLkTikONxneEgF5m+m6100pwzThTnaiAB+OFzYufcC2@mail.gmail.com>
 <7veidlkxdb.fsf@alter.siamese.dyndns.org>
 <7vmxrmawg0.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTinaj4AsPE9j-gS2-0Cn8jx7a1uYYGtmq5oC=YVB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Emil Sit <sit@emilsit.net>
X-From: git-owner@vger.kernel.org Mon Sep 13 20:12:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvDVa-0007hk-H0
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 20:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372Ab0IMSLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 14:11:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab0IMSLy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 14:11:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 344D0D5D0C;
	Mon, 13 Sep 2010 14:11:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=421l6qP+urIHW8+Z2ZKEDbXwryU=; b=O4+mji
	OnnnTwB8gvvlef+TdwHijwcimqPY98xN5dbLEq6hZ58sdtu3fuE08Sj1gVTOYX2X
	FEUA/SqkJSxE1KMUH00TzmH6INZ+mjmYuDBdqqTjuTepuyVM49nRypo+OLd4oJhc
	MC/eGWr5tPAeN6aPCTbruyhpL4c202NuCn/9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MFuyzZVz+mFHmjDFEysHh9EmMgSkS+cy
	SN8ojizUTvF3dLppKiFI6OVaohdtZHd2R0ukrRPYnXh9wouncfJsnbuXOl3agW0w
	OhtHQB8ucX/E8mU6DC0PZVNmKs+mhLn9Ao5KuyYbDTq3H48p2DeV/ebkM92uEOIY
	pM2zs+njDIQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 118ACD5D0A;
	Mon, 13 Sep 2010 14:11:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F32F1D5D09; Mon, 13 Sep
 2010 14:11:47 -0400 (EDT)
In-Reply-To: <AANLkTinaj4AsPE9j-gS2-0Cn8jx7a1uYYGtmq5oC=YVB@mail.gmail.com>
 (Emil Sit's message of "Mon\, 13 Sep 2010 12\:17\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 61A7185E-BF62-11DF-9E3E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156105>

Emil Sit <sit@emilsit.net> writes:

> I'm a little confused about the implementation with regards to
> --all-match; does there still need to be an all-match flag?

When used in the context of "git log --grep/--author/--committer" (as
opposed to more flexible "git grep"), in conjunction with either of the
"header match" element (--author/committer), all-match is implied.

The implementation of the all-match rewriting gets a bit trickier than
necessary, as our internal representation of nodes does not have n-ary
ALL-MATCH (nor n-ary OR/AND) node.

An (ALL-MATCH 1 2 3 4) node is instead represented by this grep_expr
binary tree (rooted at the leftmost OR node):

      OR--OR--OR--4
      |   |   |
      1   2   3

and requiring the top-level terms of backbone OR chain (i.e. 1 2 3 4) to
all match.

In order to represent

    (ALL-MATCH
     (PATTERN this)
     (OR (AUTHOR A) (AUTHOR B)))

we cannot simply do

     OR--------------OR-----------author B
     |               |
     pattern "this"  author A

because this requires both (AUTHOR A) and (AUTHOR B) to match, in addition
to "this".  We instead need to do something like:


     OR--------------OR---TRUE
     |               |
     pattern "this"  OR---author B
                     |
                     author A

to say "this" must match and (OR (author A) (author B)) must match (IOW
the terms on the backbone OR chain are (PATTERN this), (OR (AUTHOR A/B))
and TRUE and they all have to match).
