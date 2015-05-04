From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git-p4 edit_template() and P4EDITOR w/options
Date: Mon, 04 May 2015 15:34:48 -0700
Message-ID: <xmqq4mnsottj.fsf@gitster.dls.corp.google.com>
References: <5D2E2EAF-FFE7-437F-A716-E152E865E634@pixar.com>
	<xmqqh9rsovd4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Chris Lasell <chrisl@pixar.com>
X-From: git-owner@vger.kernel.org Tue May 05 00:34:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpOwy-00086m-JS
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 00:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbbEDWex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 18:34:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750699AbbEDWev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 18:34:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64C464F14E;
	Mon,  4 May 2015 18:34:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sOFnDP/a61pUy03igh+SWu86mpI=; b=wJX9Yn
	csjYsAwzxLaDvAdXhxA6ONu6E3rgGVmEj3fJkNntUVgH8JxMkRx9Nvyg/TE5z4NC
	1VUllkm0PnNtxheI00frMirk13zm/hUQa+G2O27Lrm/bdSl5Xm+M7WlJf4Dg0JRq
	TFH8en/H4agIADuIrj5raHhsM4PTgcULlZNRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r4CeOAf8wM/RU6folvDJHsklDPa7xeF/
	4sgY4wXdS6Gw9aNu55ae+iCxCWqTeNZGM/o69o1K66VGqrN50xRNNrbw+cQRX/i0
	TvqnSoSPLZifUmj9U6WQ7Nmf+lAMywnzkEP+udd9TEEybugSz2evJQwTz1nBM78X
	r1a2f4v4WOk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E52D4F14D;
	Mon,  4 May 2015 18:34:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2E884F149;
	Mon,  4 May 2015 18:34:49 -0400 (EDT)
In-Reply-To: <xmqqh9rsovd4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 04 May 2015 15:01:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C656512E-F2AD-11E4-A78D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268367>

Junio C Hamano <gitster@pobox.com> writes:

> The relevant part of git-p4 is this:
>
>         # invoke the editor
>         if os.environ.has_key("P4EDITOR") and (os.environ.get("P4EDITOR") != ""):
>             editor = os.environ.get("P4EDITOR")
>         else:
>             editor = read_pipe("git var GIT_EDITOR").strip()
>         system([editor, template_file])
>
> It grabs $EDITOR (or $GIT_EDITOR) and treats it as the path to the
> editor executable, without letting shell to split that into words at
> whitespace boundaries, so that you can say things like
>
> 	EDITOR="/User/me/My Programs/nano"
>
> The way we spawn EDITOR in our core codepaths matches what git-p4
> does, too:
>
> 	const char *args[] = { editor, real_path(path), NULL };
> 	struct child_process p = CHILD_PROCESS_INIT;
> 	int ret, sig;
>
> 	p.argv = args;
> 	p.env = env;
> 	p.use_shell = 1;
> 	if (start_command(&p) < 0)
> 		return error("unable to start editor '%s'", editor);
> 	...
>
> So...

Well, I'll take that back.  I misread p.use_shell line.
