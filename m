From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Tue, 28 Jun 2011 11:29:15 -0700
Message-ID: <7v1uydvmh0.fsf@alter.siamese.dyndns.org>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com>
 <1309112987-3185-3-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, hvoigt@hvoigt.net,
	jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 20:48:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbdKN-00053Q-TG
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 20:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759464Ab1F1SaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 14:30:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758738Ab1F1S3T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 14:29:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 796CA57E2;
	Tue, 28 Jun 2011 14:31:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=me6a1uI3zpGF21w+fpmw2vroVmM=; b=IYUVt3
	PHacQXz8bOznrwiKWzOkALzhlrc79A7loHm5oPoQ9PFZe62gZDjDZ99WQks7kCjA
	ky2VnwF6MsidYvIXUcmQT5LLEXbXOuMTxdxMaGPfEsn69+xhxBnY3Pjut1d7kGxi
	n4yiNpKwqeyK1wD3PF2t+hyXWKWXRJSXgTjTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b1mywgC3ImiEd3FcFRgbK9nTTFtLLA/8
	LVNzSCXBBf0TqEyAXclGNiglUjG1xloJnlIUp+QWYT4s8hWCr5q69oI/7aFtRh1u
	QDTHNdJS2Nh2TLlkr1mErCrSLw0qNYjR5Lr5OJfyV9wnMqaV3MAUibBnlj66Ij4v
	961z2bEoRxg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7295057E1;
	Tue, 28 Jun 2011 14:31:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B749C57E0; Tue, 28 Jun 2011
 14:31:30 -0400 (EDT)
In-Reply-To: <1309112987-3185-3-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Sun, 26 Jun 2011 20:29:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7C97952-A1B4-11E0-9D40-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176413>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> +static int is_submodule_commit_pushed(const char *path, const unsigned char sha1[20])
> +{
> +	int is_pushed = 0;
> +	if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
> +		struct child_process cp;
> +		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		argv[1] = sha1_to_hex(sha1);
> +		memset(&cp, 0, sizeof(cp));
> +		cp.argv = argv;
> +		cp.env = local_repo_env;
> +		cp.git_cmd = 1;
> +		cp.no_stdin = 1;
> +		cp.out = -1;
> +		cp.dir = path;
> +		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 41))
> +			is_pushed = 1;
> +		close(cp.out);
> +		strbuf_release(&buf);
> +	}

What if

 (1) you are binding somebody else's project as your own submodule, you do
     not make any local changes (you won't be pushing them out anyway),
     and you do not have remote tracking branches in that submodule
     project?

 (2) you have a project you can push to that is bound as a submodule, you
     have pushed the commit that is bound in the superproject's tree to
     that submodule project, but you do not have remote tracking branches
     in that submodule project?

 (3) you have a project you can push to that is bound as a submodule, you
     have multiple remotes defined (e.g. one for the public server you
     intend for this check to be in effect, the other is just for your
     private backup), and you have pushed the necessary commit to your
     backup but not to the public one?

The above check would fail in cases (1) and (2) even though it does not
have to. It would succeed in case (3), but people would not be able to use
the superproject as the necessary commit is not there but only on your
work and backup repositories.

What am I missing?

I am not sure if the check imposed on the client end is such a great
idea. I suspect that it would depend on the superproject which submodule
commit must exist "out there" for others to fetch. If you assume a closed
environment where all the superprojects and necessary submodule projects
are housed at a central location everybody pushes into and have tight
control over how project participants clone and check out the
superprojects and submodules, you do not have to worry about any of the
above, but then the server-side can perform the check when it accepts a
push (and you would already be doing other checks there in your hooks
anyway in the industrial setup, I would guess).
