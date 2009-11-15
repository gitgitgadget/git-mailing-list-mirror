From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] format-patch: Ensure that author and commit time are not
 lost
Date: Sun, 15 Nov 2009 13:03:42 -0800
Message-ID: <7vzl6nfqkx.fsf@alter.siamese.dyndns.org>
References: <4B000141.5070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 22:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9mGo-0003uR-2E
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 22:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbZKOVDq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 16:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbZKOVDq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 16:03:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZKOVDp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 16:03:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7987D80237;
	Sun, 15 Nov 2009 16:03:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=HqGorcskC9kRF+O1NJ3lPDA0A
	AQ=; b=sJNmD/itlNUX7ekix2Z9FSvvZx+EDz+AXf1zWeQmadIT56V4fEB2Hq5ij
	ADaDBNjS7DHQvgOJQaIfg7nesFGura1FZ4+PF5Axci79k8NMi08SHcFDffGK1Whd
	cBO2VU+selVSw2rBWPc7tLrYA015GS6UnvGto+et4MxjKsBo5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=iz7nKMjVuXjmR1H5Diw
	OHbzfwKFX+YdWmuj6eJt5yQ8mJ2Sj8gHf9Vs5YEivfJQCFEOx0DlLfsukXkbaW4C
	mkF5gT1r73NjnEUnjHVKJ/+8O0VJzuFEXvoANO/KgQ4VAUNELXOT15pOG5MbHAml
	HgDMSa+HNYDLI+zYC1UBtPw0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5528A80236;
	Sun, 15 Nov 2009 16:03:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F06280235; Sun, 15 Nov
 2009 16:03:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5DE0ABAC-D22A-11DE-8E05-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132961>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> 'git format-patch' encodes the author of the commit in the From: head=
er
> and the time of the commit in the Date: header.  Depending on how the
> email is sent, however, those headers can be lost before the email
> reaches its destination.
>
> Therefore, if the sender of the email (i.e. the configuration options
> user.name and user.email) are different from the author of a commit,
> insert From: and Date: headers at the beginning of the body of the
> commit message.

I think you are addressing a very valid issue, but I suspect that you a=
re
doing so at a wrong place in the "patch mail-out" workflow.

> +static int sender_is_not_author(const char *message)
> +{
> +	const char **msg_p =3D &message;
> +
> +	for (;;) {
> ...
> +	}
> +}

This new function is not about "Is the _sender_ the same as the author?=
",
but is about "Is the person who is running format-patch the same as the
author?".  There is a big difference.

What you want to catch is really "Does the MUA that sends out the final
message have the name of the author on its 'From: ' header?", and that=20
depends on how the output from format-patch command is processed in the
downstream of the workflow.

You may read the file into your MUA edit session.  You would typically
edit the first three lines out and move Subject: to the MUA's subject l=
ine.
You can choose to keep From:/Date: when you do so.  This happens to be =
the
way I work, by the way.

The output may not even be used by a MUA; you may upload it to web base=
d
thingy like Bugzilla or FrySpray.  The recipient will download the whol=
e
thing and there is no need to edit.

I would expect the right solution would be to give send-email an abilit=
y
to either (1) use "Sender:" to record the operator of the MUA while
keeping "From: " taken from the payload, or (2) duplicate "From: " as a=
n
in-body header when it sends out.

It is a separate issue if that ability should be on by default or
controlled by an option, of course.  But I do not think it should be in
the format-patch.
