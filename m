From: Junio C Hamano <gitster@pobox.com>
Subject: Re: False alarms from git-fsck(1) about missing commits/trees pushed
 after the run started
Date: Mon, 28 Feb 2011 08:23:56 -0800
Message-ID: <7vbp1wjffn.fsf@alter.siamese.dyndns.org>
References: <AANLkTimrgepw4r=z5na-d74XY67QuRRgFepWZh87xrCq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 17:24:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu5tL-0005aW-2q
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 17:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527Ab1B1QYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 11:24:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab1B1QYF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 11:24:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16F5C3D26;
	Mon, 28 Feb 2011 11:25:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4LMxpkZgcZhi
	oTsRttv422OpdMU=; b=PIMBytHjzgROiQBjrW0v1rQanqPPL7g+VLKU2EDu5gRj
	kJpwjhwHgJuUaHAwm0d0KLTdmirfjI30JFE9ZxJbqce0bws0QmuLGb+vP/QWl/3r
	FfYFAQ1HdHnoW4VHWpMxyGawqlnjV8bCRRiM1+dzOdvJO9pddnrgE2DZzs4qOUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NcwZ3d
	evkaRFkX9YGld7O2vSQHqAf/DYxBD7cQhxmJLdwUWSLFlH+IvOf0NCuRSvlKMyOa
	fYPxzKIo/QED+gTW83A+t3m4ClXNaZI3958Apn/0tySyMkehzddxtW9nHnMbHm+b
	s94DKu4kYM8UrNi+nkYb9rnVoPTjfkgluiFcY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E53E23D24;
	Mon, 28 Feb 2011 11:25:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EC78E3D1C; Mon, 28 Feb 2011
 11:25:16 -0500 (EST)
In-Reply-To: <AANLkTimrgepw4r=z5na-d74XY67QuRRgFepWZh87xrCq@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 28 Feb
 2011 13\:38\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55A1EC90-4357-11E0-A23B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168119>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But actually these things aren't missing. They were just pushed to th=
e
> repo after the fsck run started.
>
> Is this a known limitation of git-fsck,...

Yes.

We validate the contents of the objects we find in the repository (we d=
o
this by directly visiting .git/objects/??/ and .git/objects/packs/
directories and validate the contents of even unreachable objects), mar=
k
their existence while doing so, and then traverse the reachability DAG
from refs to find dangling & missing.

It always is possible to have objects we mark as reachable in the secon=
d
phase that are not marked as existing in the first phase if you are
actively adding objects to the repository (e.g. by pushing into it, by
fetching into it, or by running "git add") while running fsck, as these
new objects may not exist during the first phase but then later can bec=
ome
reachable by ref updates.

> ..., is it documented anywhere?

I don't know for sure but I doubt it; please make it so.
