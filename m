From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Mon, 26 Aug 2013 00:14:11 -0700
Message-ID: <xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
	<CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
	<xmqqa9k6moif.fsf@gitster.dls.corp.google.com>
	<20130825042314.GE2882@elie.Belkin>
	<xmqqk3jal4t7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 09:14:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDr0G-0004Hl-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 09:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab3HZHOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 03:14:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755929Ab3HZHOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 03:14:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBD3D39F0C;
	Mon, 26 Aug 2013 07:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wVBeU0cebkY1jP0GknOsDB01ypg=; b=iZjMj6
	hZUlj/5HJgnhYg6DmOQNP4Goia78pHDu6dsxqrEvU2ras4K21NYAexyWVuD5s8yv
	ZxY6cafWpK+0aAPAYe76uZPgn05a4A+3kLBL+gUoRr5P8hWlu6NCsfgYaQZ24IFH
	krtE5f5d3qHgw5+6vL4/vS4XkqPbzFN4RZlbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P7VVK5rwKVK8RKMZKVom86tJvM3d3LZC
	SiljKuNsGHXMhcpNVgqAWFhxViGpI79kymZO4qnN8Cg/GHZTb3y3OnTS3GgmgO78
	NKJi41fWw4jo0+GFNEtAZAGWDmEyG80LC/qS08bIvuqqMEgbdJX45RRz0pt+j8EL
	fayOqM6/fjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEF1F39F0B;
	Mon, 26 Aug 2013 07:14:14 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AB0639F09;
	Mon, 26 Aug 2013 07:14:14 +0000 (UTC)
In-Reply-To: <xmqqk3jal4t7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 24 Aug 2013 22:25:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1CE0907E-0E1F-11E3-9F47-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232980>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I think Phil meant that when "git grep" is asked to search within
>> "HEAD:some/path", filenames tacked on at the end should be appended
>> with a '/' separator instead of the usual ':' (e.g.,
>> "HEAD:some/path/inner/path.c", not "HEAD:some/path:inner/path.c").
>
> Ah, OK.
>
> I am not sure if we have a proper hint in the revision parser
> machinery, but it may not be too hard to teach rev-cmdline interface
> to keep that kind of information (i.e. "This tree object name is a
> result of parsing '<tree-ish>:path' syntax").

Actually, having thought about this a bit more, I am no longer sure
if this is even a good idea to begin with.

An output line that begins with HEAD:some/path:inner/path.c from
"git grep" is an answer to this question: find the given pattern in
a tree-ish specified with "HEAD:some/path".

On the other hand, HEAD:some/path/inner/path.c is an answer to a
different question: find the pattern in a tree-ish specified with
"HEAD".  The question may optionally be further qualified with "but
limit the search to some/path".  Both the question and its answer
are more intuitive than the former one.

And we have a nice way to ask that question directly, i.e.

    $ git grep -e pattern HEAD some/path

which can be extended naturally to more than one path, e.g.

    $ git grep -e pattern HEAD some/path another/hierarchy

without having to repeat HEAD: part again for each path.

If the user asked the question of the former form, i.e.

    $ git grep -e pattern HEAD:some/path

there may be a reason why the user wanted to ask it in that
(somewhat strange) way.  I am not 100% sure if it is a good idea to
give an answer to a question different from what the user asked by
internally rewriting the question to

    $ git grep -e pattern HEAD -- some/path

So...
