From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 12:59:44 -0800
Message-ID: <xmqqegpkz4cf.fsf@gitster.dls.corp.google.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
	<CACsJy8Dortn4fHwF8xSgJ=KoJ9o1qzmc_UyaVq003D2sxFZEuQ@mail.gmail.com>
	<1424392969.30029.15.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 21:59:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOug1-0000TL-7M
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 21:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbbBTU7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 15:59:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754432AbbBTU7w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 15:59:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2288939DBF;
	Fri, 20 Feb 2015 15:59:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZdmYx9LRiFYKvo/fMGgsQU8V27I=; b=gviRhK
	nZ+GuNlvCaQxF2eRmszexhizrEON0OLr5WEeKFlhrWiakb/HmyP4KFCue0N3wcPB
	uqCYCdo5S7MRmoiUdAJR0ek1I+U+cIA1EgMaOPwZblrCqd/Gotr7Ifzd3GLlvY5w
	foVFQ1oI+0VCE60WmXnMVnq0YngIbBfbx6zWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pm8vImijeYP9cP+qNqcxbEE/t/mR0muJ
	TIWiLUvE3r2RnJWRYjozS9SblSNXVW92zI0ncdgoVEB1tDexvRv2esEkqDg8eFJV
	TOW4INOeQ+IMw8mOU9nnQs5yeZo+m+6HMTND+i4dQ0IqtgP6tfSmMHH1uHge9728
	/FfnkFsPGpI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1637839DBE;
	Fri, 20 Feb 2015 15:59:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E5A639DBC;
	Fri, 20 Feb 2015 15:59:45 -0500 (EST)
In-Reply-To: <1424392969.30029.15.camel@leckie> (David Turner's message of
	"Thu, 19 Feb 2015 19:42:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 65EDFCB8-B943-11E4-A6C0-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264185>

David Turner <dturner@twopensource.com> writes:

> On Fri, 2015-02-20 at 06:38 +0700, Duy Nguyen wrote:
>> >    * 'git push'?
>> 
>> This one is not affected by how deep your repo's history is, or how
>> wide your tree is, so should be quick..
>> 
>> Ah the number of refs may affect both git-push and git-pull. I think
>> Stefan knows better than I in this area.
>
> I can tell you that this is a bit of a problem for us at Twitter.  We
> have over 100k refs, which adds ~20MiB of downstream traffic to every
> push.
>
> I added a hack to improve this locally inside Twitter: The client sends
> a bloom filter of shas that it believes that the server knows about; the
> server sends only the sha of master and any refs that are not in the
> bloom filter.  The client  uses its local version of the servers' refs
> as if they had just been sent....

Interesting.

Care to extend the discussion to improve the protocol exchange,
which starts at $gmane/263932 [*1*], where I list the known issues
around the current protocol (and a possible way to correct them in
footnotes)?


[Footnote]

*1* http://thread.gmane.org/gmane.comp.version-control.git/263898/focus=263932
