From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 14:17:04 -0700
Message-ID: <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
References: <1430341032.14907.9.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:17:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZM1-0006O1-T7
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbbD2VRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:17:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751551AbbD2VRH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:17:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C05F4D593;
	Wed, 29 Apr 2015 17:17:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9UcsHrXmYTJpNCybXFgs26SvWCI=; b=osQGSx
	yvZ/1tJ/6EudxVYmeR5uayE5JP1QBSlAWnYwWPmmpSk9ErQJhZJwMdmjPE0Md8LC
	Jpyk+sFNTlEkicIxy+DTvP5USXLOjWTIR3wfcmrUpBDNqag3nRetLndZYe6sU/dk
	qD6V7F75vT0eD3iMxNMdQxdg6YuO3J5AMKcOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VGUPyH8Rk2dxmVU5tHv7gfDcRpe35N/8
	Zscyf49Bk6iw4sZ7eyJbbD+2osiE6M/BHOQubpcWB0NPfUzrP7xU18B7lqSfNHS6
	7MTmTrm3nYmvAz0z+DgXU0bDy1WONqiGbB9Kim6Wcd4fGiofKeLWNKI3rXYdIM23
	h1O4vy/Ldek=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 960414D592;
	Wed, 29 Apr 2015 17:17:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F1724D590;
	Wed, 29 Apr 2015 17:17:05 -0400 (EDT)
In-Reply-To: <1430341032.14907.9.camel@ubuntu> (David Turner's message of
	"Wed, 29 Apr 2015 13:57:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 15DF01FC-EEB5-11E4-A21A-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268006>

David Turner <dturner@twopensource.com> writes:

> Do people think this is reasonable?

I personally don't, exactly because we track the contents of the
symlink itself, not the referent.  Your "major wrinkle" that they
can point outside the repository is a mere manifestation of that.

The format specifiers the --batch option takes do not exactly give
you what the in-tree type of the thing is, to allow the receiving
end that parses the tagline (which it needs to do anyway in order to
find out where the current record ends) act on it.  %(objecttype)
would just say "blob" and you cannot tell if it is a plain file,
executable or a symbolic link.

Perhaps an ideal interface might be something like this:

    $ echo HEAD:RelNotes |
      git cat-file --batch='%(objecttype) %(intreemode) %(objectsize)'
    blob 160000 32
    Documentation/RelNotes/2.4.0.txt

I suspect it would be just the matter of teaching "cat-file --batch"
to read from get_sha1_with_context() in batch_one_object(), instead
of reading from get_sha1() which it currently does.

And that inteferface I think I can live with.
