From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Wed, 03 Feb 2010 18:27:08 -0800
Message-ID: <7vk4utybur.fsf@alter.siamese.dyndns.org>
References: <20100129012350.GD20488@spearce.org>
 <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com>
 <20100129183705.GB22101@spearce.org>
 <7vockc45ut.fsf@alter.siamese.dyndns.org>
 <7vmxzw15dt.fsf@alter.siamese.dyndns.org>
 <7v3a1oyrkp.fsf@alter.siamese.dyndns.org> <20100201152826.GE8916@spearce.org>
 <7v7hqtzrmq.fsf@alter.siamese.dyndns.org>
 <20100204020756.GP14799@spearce.org>
 <7vock5yby2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:27:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcrRG-0002SZ-7R
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 03:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab0BDC1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 21:27:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044Ab0BDC1U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 21:27:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 794A896811;
	Wed,  3 Feb 2010 21:27:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z0IyWoA8oSk030TpzV4l3I2Tz4A=; b=jSzzSW
	78LjhmBIgI+IHQ8I2nd0ZvlRiyXuEiJiEWY9mpkz97b6rMUst7n1cn5LQiskY3fh
	zCV22at0dHmOAx/IlXd76P16hvECc+PYq2RFcdNK3OrErykQ6Z1pih5lMz5Ovpb3
	J+2UY4kiGA42Ji7XPEsJNqheTeuZhdBevfvB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ei9pInVnn1auiPgTdv5fB32sga6RfWUs
	qKWHM9lWfn6bbs73Y6eOZ/DF96dZ8JPG+16wk0wUVYypQsIQpQlkvtagkv5JLjdu
	V79X8n9SWQ+uqY6QbNbsB/pHKo7GWOg6n+kSay7HECjYsKhTfuQtNpswTr+Tyn+f
	DUXMvw8SUSc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 310F296806;
	Wed,  3 Feb 2010 21:27:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A352967F5; Wed,  3 Feb
 2010 21:27:09 -0500 (EST)
In-Reply-To: <7vock5yby2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 03 Feb 2010 18\:25\:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF80F4C6-1134-11DF-831C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138935>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> In my v3 patch I thought I replaced this code with:
>>
>> +               else if (!prefixcmp(a, "--big-file-threshold=")) {
>> +                       unsigned long v;
>> +                       if (!git_parse_ulong(a + 21, &v))
>> +                               usage(fast_import_usage);
>> +                       big_file_threshold = v;
>>
>> So we relied on git_parse_ulong to handle unit suffixes as well.
>
> Yeah, you did; but it didn't carried through the merge process across the
> code restructure to add "option_blah" stuff.  Sorry about that.

And this is a fix-up for the mismerge.  I didn't touch max-pack-size stuff.

 fast-import.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ca21082..a6730d0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2800,7 +2800,10 @@ static int parse_one_option(const char *option)
 	if (!prefixcmp(option, "max-pack-size=")) {
 		option_max_pack_size(option + 14);
 	} else if (!prefixcmp(option, "big-file-threshold=")) {
-		big_file_threshold = strtoumax(option + 19, NULL, 0) * 1024 * 1024;
+		unsigned long v;
+		if (!git_parse_ulong(option + 19, &v))
+			return 0;
+		big_file_threshold = v;
 	} else if (!prefixcmp(option, "depth=")) {
 		option_depth(option + 6);
 	} else if (!prefixcmp(option, "active-branches=")) {
