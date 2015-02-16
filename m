From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/24] dir.c: optionally compute sha-1 of a .gitignore file
Date: Mon, 16 Feb 2015 13:59:34 -0800
Message-ID: <xmqq4mql5xh5.fsf@gitster.dls.corp.google.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
	<1423385748-19825-2-git-send-email-pclouds@gmail.com>
	<xmqqiof8ta6f.fsf@gitster.dls.corp.google.com>
	<CACsJy8AyAeNa0CoUA-jAYGN5S8yJ1wRzdZe==z-xbT-f2j0HaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:59:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNThd-0000lO-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 22:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbbBPV7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 16:59:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751604AbbBPV7h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 16:59:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AC9F374FD;
	Mon, 16 Feb 2015 16:59:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YZcY8ltZSsQIJEOeh+yTJ+N0LuY=; b=FlMgp2
	GOD2eUD1kTzY3u+UiCFai0hkjd47WMR18jMga+d8vhJRjvMHPlhQNrpS7MTpJd8g
	Zt2oRjp6SYPWix0mGjJMy2N9UXFDfq1L2B6fZTTZUi8mVPCPp7NK24n5x7g+BVsH
	FoLqu0R77R3hrKqERnPkPjMNYMCCeWWdhRXWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rgbscFdq/ExTborqRMyivNbxD16kc0Hu
	/xNBdTezrNFESuBs+C3VJYSkKrNAMl0TEyIafqYAw/3my5SFboHx5ORimY9DYNs5
	4LF4hqBjcvV62Fha9aFgq/Hq3ChlQj8FVjoJltNNvA/wfvS/MGNCChpAXwFI9lWk
	5gbraEVnKLw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FF7C374FC;
	Mon, 16 Feb 2015 16:59:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC3A1374FA;
	Mon, 16 Feb 2015 16:59:35 -0500 (EST)
In-Reply-To: <CACsJy8AyAeNa0CoUA-jAYGN5S8yJ1wRzdZe==z-xbT-f2j0HaQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 16 Feb 2015 16:45:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 188BD8BA-B627-11E4-BFD4-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263918>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 12, 2015 at 4:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> If you want to detect the content changes across working tree, index
>> and the tree objects by reusing hash_sha1_file(), however, you must
>> not feed the checked out (aka "smudged") representation to it.
>> You'd need to turn it into "cleaned" representation by doing the
>> equivalent of calling index_path().  Some helpers in the callchain
>> that originates from index_path() might directly be reusable for
>> your purpose.
>
> Urgh.. you're right this test would fail when some filters are
> involved. I'm not sure if we want to check the cleaned version though.
> What matters to exclude machinery is the checkout version. 

Oh, I wouldn't suggest getting lines from the cleaned version.  It
is just that you must hash the cleaned version if you want to decide
"Ah, the content is different from what the internal cache is based
on, so I need to invalidate my cache" and "Because the version I
have on the filesystem matches what is in the index, which is what
my cache is based on, I would use my cached version".  The latter
would break (i.e. the signature would not match when it should) and
you end up invalidating the cache when you do not have to.
