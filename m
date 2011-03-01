From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2011, #07; Mon, 28)
Date: Tue, 01 Mar 2011 09:50:13 -0800
Message-ID: <7voc5uenmy.fsf@alter.siamese.dyndns.org>
References: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org>
 <AANLkTiksROE_dQTUn3Y_1Op6NDpGzEsSJ70JNYyYrufS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 18:50:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuTiT-0008F6-5f
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 18:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab1CARu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 12:50:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1CARu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 12:50:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B5FBB45BE;
	Tue,  1 Mar 2011 12:51:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NYf6ge7xx//Njj32YFExAadBJRE=; b=hVolNr
	uTjMbrJV6MzieScFDU5kl/P46yvqvULeb8yylhJwgzakzPDF/Ht1+Y58PIccI4Ac
	ZJ3JW0/Z0TdQKJ3obL5KJIRw3fgdVLrkAChKP+P/hLdj0zcDMNslsOuUTfKXEiLC
	mPYp5gUqeODQ+xbTt0q6GD99cKlco2VCcExOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O7mfD1oXaKggVUBXF1Ooa5s//EsqyiKH
	tHt51NXieWbV+dwx5gaHWV+5wEwkKPWjZoJm0EqI0sQFthHKSgmMmGjLBObM4p5V
	jmbgFo76W/RhA0sAauMdyTWp81/MoXBJ4nAzhaPu4u1d3I2fW9DmifmXADAqkTZv
	3P50m+TCwUE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8454045BB;
	Tue,  1 Mar 2011 12:51:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3042245BA; Tue,  1 Mar 2011
 12:51:36 -0500 (EST)
In-Reply-To: <AANLkTiksROE_dQTUn3Y_1Op6NDpGzEsSJ70JNYyYrufS@mail.gmail.com>
 (Erik Faye-Lund's message of "Tue\, 1 Mar 2011 09\:39\:07 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 908484FA-442C-11E0-82BD-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168234>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> Erik, please check the made-up commit log message and sign it off.
>> Will merge to 'next' after that.
>
> Do you have any hint on how I can create a repo with more than 2048
> packs so I can test that the patch works?

A stupid and brute force way is to prepare an empty bare repository, add
something like the following to its config:

    [transfer]
            unpacklimit = 1

    [gc]
            auto = 0
            autopacklimit = 0

and push into it from a random existing repository starting from a
reasonably old commit, walking to a newer commit.  You can use something
like (totally untested):

        git rev-list --first-parent master |
        head -n 2000 |
        tac |
        while read commit
        do
		git push ../victim.git $commit:refs/heads/master
	done

> There's also the added complication that _open_osfhandle also seems to
> be limited by this 2048 limit (see the third comment here:
> http://bugs.mysql.com/bug.php?id=24509). We use this function for
> pipes and sockets as well. This alone might be a reason to corner-case
> test the resulting binary on Windows properly.

As long as the use of osfhandles for non filedescriptors is reasonably
bounded, it may be enough to make the 25 slop configurable per platform,
no?
