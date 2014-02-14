From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff weirdness (bug?)
Date: Fri, 14 Feb 2014 12:03:50 -0800
Message-ID: <xmqq8utdihqx.fsf@gitster.dls.corp.google.com>
References: <52FE6C64.4060700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dario Bertini <berdario@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 21:04:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOzX-0005xx-IL
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 21:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbaBNUEC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 15:04:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbaBNUEB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 15:04:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B34976C53D;
	Fri, 14 Feb 2014 15:04:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2DZE45pE65tyb4joyMaMcMjIecc=; b=T4o8Mh
	i0vw1ymw2JckPFVzCqpkLYz+VBalehem4Rjz8aPIdP745DbEsB8nZ5kz9av5uisO
	6L6UDFZy6CGg8LlIFvjVsovWvxBM7D5oD2I+8fNPqhm1Q32T5LWKfKjsFLfsPPm5
	/prfKTsEwON111ZmHijzGLZGOi1eMzh5tZ5DY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cHrpjMAHmzl6ae9FdYDK0rRymZYYAe83
	E04Zuno9l1YWWZnrE6NhechtnJ+NgyyiC39JJzph6lNNvTRFGGuMbNszRATs5hY+
	I1VtC+zdLd9iKB0G7KeYlpV6aydeT564t7HRyICL+PuPMQI31iJbJToL8sn7oM+H
	8+dWpgklvKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2FC46C52D;
	Fri, 14 Feb 2014 15:03:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3318C6C51B;
	Fri, 14 Feb 2014 15:03:53 -0500 (EST)
In-Reply-To: <52FE6C64.4060700@gmail.com> (Dario Bertini's message of "Fri, 14
	Feb 2014 20:20:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 20BD1246-95B3-11E3-8386-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242140>

Dario Bertini <berdario@gmail.com> writes:

> git clone git@github.com:ansible/ansible.git
> git revert 3616dffb68badb2b8d56
>
> manually solve the conflict (you can look at the commit here:
> https://github.com/ansible/ansible/commit/3616dffb68badb2b8d56ef34391d7aae8de79cd6
> )
>
> git diff will output:
>
> dario@macbook ~/P/ansible (devel*+|REVERTING)> git diff
> diff --cc lib/ansible/constants.py
> index c055ccf,6eac602..0000000
> --- a/lib/ansible/constants.py
> +++ b/lib/ansible/constants.py
> @@@ -84,16 -61,8 +84,12 @@@ active_user   = pwd.getpwuid(os.geteuid
>
>   # Needed so the RPM can call setup.py and have modules land in the
>   # correct location. See #1277 for discussion
> - if getattr(sys, "real_prefix", None):
> -     # in a virtualenv
> -     DIST_MODULE_PATH = os.path.join(sys.prefix, 'share/ansible/')
> - else:
> -     DIST_MODULE_PATH = '/usr/share/ansible/'
> + DIST_MODULE_PATH = os.path.join(sys.prefix, 'share/ansible/')
>
>  +# check all of these extensions when looking for yaml files for things
> like
>  +# group variables
>  +YAML_FILENAME_EXTENSIONS = [ "", ".yml", ".yaml" ]
>  +
>   # sections in config file
>   DEFAULTS='defaults'
>
>
>
> now, it weirdly/incorrectly says that we added the YAML-related lines

This is a combined diff, and yaml-related lines are added relative
to your _other_ branch you are merging (notice these + are indented
by one place).  Relative to what you had at the tip of your branch
before you started this operation that ended up conflicted, the
half-merged result removes if/else that sets DIST_MODULE_PATH and
replaces it with a single line (their +/- are on the first column,
signifying that these are differences relative to the first parent,
i.e. your state before you started the operation).

> if we remove these 3 lines, we'll get this diff:

With that understanding, I think the output after removing these
three lines is perfectlyh understandable and correct.  You are
looking at the three lines that used to exist in the version you
started from, that were missing from the other side.  If you remoe
them, it will show as removal from _your_ version (notice these -
that shows what _you_ did manually are on the first column, saying
that that is relative to _your_ version).
