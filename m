From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Faster git grep.
Date: Thu, 25 Jul 2013 13:41:13 -0700
Message-ID: <7vli4u4bkm.fsf@alter.siamese.dyndns.org>
References: <20130725182905.GA7664@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Thu Jul 25 22:41:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2SLg-0001F3-TP
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 22:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab3GYUlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 16:41:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736Ab3GYUlQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jul 2013 16:41:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84E0A33BE5;
	Thu, 25 Jul 2013 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OsNIQqVRLJkp
	1drKItP//XGvh00=; b=inCFQaDCWcQbCuCO2BqPXqcPUxlf8gc4+9lIb+F/Eaf1
	30GBALGUpmArGi/ybI+mlHhtXg4G6b5i9oozlDO5nk7Y5Rz8GCmd+wMvjEVs4Edz
	Px/F5EVhsRuP7Viu7iSxHZtnJdEomUJhyXERaRzGz1jSoX+VxiaiaOgDHS0TojE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r5pJZj
	VyspHg5Z+RVp57IxHoydWnBrF9N37gAOawry3e+r+XT8nuq00VV9Q02fHYRwOHDW
	7ZsWMlyCLbprfCOsG/r6PpDrlkh8BKmUPvq4QYGxZ1ffkVD96+htSwWC+jr7/QCT
	75VaiIe7x9kUzg9NVydvIRjWUTV40qal/f388=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 793FB33BE3;
	Thu, 25 Jul 2013 20:41:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A8B233BD7;
	Thu, 25 Jul 2013 20:41:14 +0000 (UTC)
In-Reply-To: <20130725182905.GA7664@domone.kolej.mff.cuni.cz>
 (=?utf-8?Q?=22Ond=C5=99ej=09B=C3=ADlka=22's?= message of "Thu, 25 Jul 2013
 20:29:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C772D26-F56A-11E2-8FC0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231150>

Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> writes:

> One solution would be to use same trick as was done in google code.=20
> Build and keep database of trigraphs and which files contain how many=
 of
> them. When querry is made then check
> only these files that have appropriate combination of trigraphs.

This depends on how you go about trying to reducing the database
overhead, I think.  For example, a very naive approach would be to
create such trigraph hit index for each and every commit for all
paths.  When "git grep $commit $pattern" is run, you would consult
such table with $commit and potential trigraphs derived from the
$pattern to grab the potential paths your hits _might_ be in.

But the contents of a path usually do not change in each and every
commit.  So you may want to instead index with the blob object names
(i.e. which trigraphs appear in what blobs).  But once you go that
route, your "git grep $commit $pattern" needs to read and enumerate
all the blobs that appear in $commit's tree, and see which blobs may
potentially have hits.  Then you would need to build an index every
time you make a new commit for blobs whose trigraphs have not been
counted.

Nice thing is that once a blob (or a commit for that matter) is
created and its object name is known, its contents will not change,
so you can index once and reuse it many times.  But I am not yet
convinced if pre-indexing is an overall win, compared to the cost of
maintaining such a database.
