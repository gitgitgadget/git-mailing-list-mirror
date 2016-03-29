From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 08:08:29 -0700
Message-ID: <xmqqshz9z5hu.fsf@gitster.mtv.corp.google.com>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
	<CAPZ477PD7SkRg7T_Y_n27Hjw5TeW6Sh0-vtoP6-4xUDraC7OiA@mail.gmail.com>
	<20160329123306.GD1578@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elliott Cable <me@ell.io>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 29 17:13:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akvG1-0001Kn-6u
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 17:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126AbcC2PId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 11:08:33 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752701AbcC2PIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 11:08:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 329924FF26;
	Tue, 29 Mar 2016 11:08:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pu5y3a/Voq2+MlXf/Nixai7q6B0=; b=YBUvlS
	b1zSWQQa7p/kplYTBw9NxrjArKwnblqomJcz1fxOOycTqk5c6rd2YH7dkpxsBJ9D
	3ZQJ/XaB11MArDGRX1kGf1eb8OlOFivx/FkToMpv7i34PJ606Ft4xgy7qQPdObgG
	KznIf3T2U52EDvKmb0eslOUeve/n1LscrHbBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yai0ehAbKOFZp1McAeY0cFb45/dR70fj
	9Jij1rMO3OuOTy1Vu45RssXmWirAnYcQ0PHIZw2Wk1Gdfh9YoXWuSp+kjXqsBwcg
	3J/WLBtDV70QNybxmvDWB0xzMYxe65rI0ako7/IwfQ9PTD4QJd+IjHtG3j76rPJp
	3heK/7GUHgY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28E824FF25;
	Tue, 29 Mar 2016 11:08:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 904C34FF24;
	Tue, 29 Mar 2016 11:08:30 -0400 (EDT)
In-Reply-To: <20160329123306.GD1578@serenity.lan> (John Keeping's message of
	"Tue, 29 Mar 2016 13:33:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 18F78522-F5C0-11E5-883A-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290142>

John Keeping <john@keeping.me.uk> writes:

> If you set GIT_WORK_TREE you're telling Git to override all of the
> normal detection logic.

I didn't carefully read the other parts of the discussion, but this
is not entirely correct.

The actual/intended rules are fairly simple.

 * With GIT_DIR (without GIT_WORK_TREE), you specify where the .git
   directory is, and refuse the "normal detection logic".  As you
   refuse the normal "where is the root of the working tree and its
   .git directory?" logic, Git uses the current directory as the
   root of the working tree.

 * But that means if you set GIT_DIR, you cannot work from a
   subdirectory of your working tree--you always have to run Git
   from the root level of your working tree.  This may be
   inconvenient.

 * That is why GIT_WORK_TREE exists.  It allows you to say "No, I am
   not at the root level but am in a subdirectory somewhere inside
   the working tree. The root level of the working tree is there
   above, not here".

So it is a misconfiguration if you only set GIT_WORK_TREE without
setting GIT_DIR.

Also, if you set both and run Git from outside $GIT_WORK_TREE, even
though Git may try to do its best to give you a reasonable behaviour
[*1*], it is working by accident not by design (see the statement
you are making by setting GIT_WORK_TREE in the third bullet above).

IOW, running from outside GIT_WORK_TREE is a misconfiguration.

[Footnote]

*1* Think what should happen when you are outside GIT_WORK_TREE and
    say this:

	$ git grep foo

    As you are not even inside the working tree, the command would
    not know in which subdirectory you want to find the string foo;
    the "reasonable behaviour" is to work on the whole working tree
    in this case.
