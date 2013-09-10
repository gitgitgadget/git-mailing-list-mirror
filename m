From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL REQUEST] initial pack v4 support
Date: Tue, 10 Sep 2013 14:21:47 -0700
Message-ID: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.03.1309091526430.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyn =?utf-8?Q?Th=C3=A1i?= Ngc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 23:21:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJVNk-0004B6-L2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 23:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047Ab3IJVVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 17:21:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886Ab3IJVVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 17:21:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 250EC40685;
	Tue, 10 Sep 2013 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w88dfYKfBq0+NEcTzh8O+CVivDY=; b=K73maq
	p7JlNWeuOzJUwn0Zj6n9Lgphd5SoMAFRVxVmGdxKzyAxtnUKaBBGIE8a85PJ0GVD
	XfPotgjcYJptU1NzseqY6CXo7RHzKB5pjn/xerTtD/g6wUWVXI7ciCC12BmO5qfJ
	iotqGokXmpYHqAgrCnoVJFSqQF+ya1NhdJ9As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HX1NqbRD+ZXMLJXGmHpVJv5l6zC+Ku+4
	VL4jXrAD0JUpGV+RoUJkjrmBonCkFKpqG7hUgRFFnIjMJik+qK9yW7KcU4Vds0I0
	Jjic84JzNtG80g2TgsFHESuEjzpENBr5IvTWb6/56JQAyQqHdz0OKfaTVZqw3YF1
	EXzj4X8uyaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 195D640684;
	Tue, 10 Sep 2013 21:21:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D83C40680;
	Tue, 10 Sep 2013 21:21:49 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309091526430.20709@syhkavp.arg> (Nicolas
	Pitre's message of "Mon, 09 Sep 2013 15:52:10 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 012574D4-1A5F-11E3-A4D4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234484>

Nicolas Pitre <nico@fluxnic.net> writes:

> Junio, would you please pull the following into pu:
>
> 	git://git.linaro.org/people/nico/git
>
> This is the pack v4 work to date which is somewhat getting usable.  It 
> is time it gets more exposure, and possibly some more people's attention 
> who would like to work on the missing parts as I need to scale down my 
> own involvement.

Thanks.  Parked on 'pu'.

>       packv4-parse.c: allow tree entry copying from a canonical tree object

This one needed a small fix-up to make it compile.

I do not particularly like reusing that "size" variable, but it
seemed to be dead at that point, so...

 packv4-parse.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index f96acc1..3f95ed4 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -365,13 +365,14 @@ static int copy_canonical_tree_entries(struct packed_git *p, off_t offset,
 		update_tree_entry(&desc);
 	end = desc.buffer;
 
-	if (end - from > *sizep) {
+	size = (const char *)end - (const char *)from;
+	if (size > *sizep) {
 		free(data);
 		return -1;
 	}
-	memcpy(*dstp, from, end - from);
-	*dstp += end - from;
-	*sizep -= end - from;
+	memcpy(*dstp, from, size);
+	*dstp += size;
+	*sizep -= size;
 	free(data);
 	return 0;
 }
-- 
1.8.4-468-g1185e84
