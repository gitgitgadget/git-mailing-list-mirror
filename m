From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFE: support change-id generation natively
Date: Wed, 23 Oct 2013 09:00:46 -0700
Message-ID: <xmqqzjq0q8nl.fsf@gitster.dls.corp.google.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
	<201310212029.01589.thomas@koch.ro>
	<1382380858.25852.36711509.53CF173C@webmail.messagingengine.com>
	<201310211249.49568.mfick@codeaurora.org>
	<xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>
	<CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>, james.moger@gitblit.com,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 18:00:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0re-00082T-S1
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 18:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab3JWQAu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Oct 2013 12:00:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab3JWQAt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 12:00:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8086E4CA87;
	Wed, 23 Oct 2013 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9uENQQA4YOLE
	23yWON1989vfHRo=; b=w9BuYNYz3w1h5Y6Nd6NVwHy4eJchPq+PeOUqnOeyxt2K
	Hyt3yN59pV4oK4E0MVaVD0HF5itzVIB+MBxPAqf75/rfIzO+bQMLNp9T/SoOmy5n
	OQZ4duPQ3aUmzRwChZ4ID+sX1KhhGgdl1TWnbOPxh/0enGhlLmCOEw9t8LycYYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=b6Sq17
	CZXrR2HnfaWGJeFisawgr3wxxU1fLP03rt/w88+PS8fG11NR6oFBU+51sWLxp9fK
	tGCPlp7C3t1dht1Nhru4EkTEF2DUon9HeEYxm6zjHvaI6l1CjKR6kL6WaecBwwOA
	Q7Oq48nvBgNf4M55XjQ1ROw7+FgJkKqpMNamg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E9444CA86;
	Wed, 23 Oct 2013 16:00:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBB274CA81;
	Wed, 23 Oct 2013 16:00:47 +0000 (UTC)
In-Reply-To: <CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 23 Oct 2013 13:36:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4815FF62-3BFC-11E3-A511-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236532>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Oct 23, 2013 at 2:50 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> It would be just the matter of updating commit_tree_extended() in
>> commit.c to:
>>
>>  - detect the need to add a new Change-Id: trailer;
>>
>>  - call hash_sha1_file() on the commit object buffer (assuming that
>>    a commit object that you can actually "git cat-file commit" using
>>    the change Id does not have to exist anywhere for Gerrit to
>>    work---otherwise you would need to call write_sha1_file()
>>    instead) before adding Change-Id: trailer;
>>
>>  - add Change-Id: trailer to the buffer; and then finally
>>
>>  - let the existing write_sha1_file() to write it out.
>
> I'm not objecting special support for Gerrit, but if the change is
> just commit_tree_extended() why don't we just ship the commit hook in
> a new "Gerrit" template?

It is not clear to me how you envision to make it work.

Na=C3=AFvely thinking, an obvious place to do this kind of thing may be
the "commit-msg" hook, where the hook reads what the user prepared,
finds that there is no existing "Change-Id:" trailer, and decides to
add one.

But what value would it add on that line as the Id?

It wants to use the name of the commit object that would result if
it were to return without further editing the given message, but we
do not give such a commit object name to the hook, so the hook needs
to duplicate the logic to come up with one.  It may be doable (after
all, builtin/commit.c is open source), but we do not give the hook
the commit object header (i.e. it does not know what the tree,
parent(s), author, committer lines would say, nor it does not know
if we are going to add an encoding line), so the hook needs to guess
what we will put there, too.
