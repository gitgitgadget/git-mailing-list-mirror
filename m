From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: add shared repo upgrade
Date: Mon, 05 Aug 2013 14:02:14 -0700
Message-ID: <7vwqnzj1gp.fsf@alter.siamese.dyndns.org>
References: <1375730567-3240-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joern Hees <dev@joernhees.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 23:03:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Rv8-0005Su-0E
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 23:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349Ab3HEVCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 17:02:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247Ab3HEVCT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 17:02:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 886BC36146;
	Mon,  5 Aug 2013 21:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zXsw82Edb7pMK+tcFyESrN9Sgoc=; b=T+zKw+
	wgwInDjV+k4OdM+yx2j6QkpJbmUttztm+4UgVaTwny3gMUkSoeW/2pnYdGnU4qRo
	Aq283YNyINbwRC0mb5qearR8HexlDaaERXgalY4TJgAwHLgAtXWmocGkORr420/Q
	M6vKfeP3p0nvlCWV7ldvR9ZeSqaXSQvG9NJXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I2KAnOQjMJwB8RDL9CIK0AKxHNUsK3Z3
	BSlJtyWi3+E7BMQEX8/WMaV9bLgiIH3rr0fCIk1YzheslmeKAhvINWYKc9cHL8gL
	fMVV+BxpoqQ868fi4eSP+ipFtGTfYlL0D3766psUdkrAXz5ZvPlXU8ancKqKCSio
	yBTFCPz/FxA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BC4D36144;
	Mon,  5 Aug 2013 21:02:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDBE736141;
	Mon,  5 Aug 2013 21:02:15 +0000 (UTC)
In-Reply-To: <1375730567-3240-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Mon, 5 Aug 2013 21:22:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EB4BEB2-FE12-11E2-BB63-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231703>

Antoine Pelisse <apelisse@gmail.com> writes:

> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> 6796d49 (remote-hg: use a shared repository store) introduced a bug by
> making the shared repository '.git/hg', which is already used before
> that patch, so clones that happened before that patch, fail after that
> patch, because there's no shared Mercurial repo.
>
> It's trivial to upgrade to the new organization by copying the Mercurial
> repo from one of the remotes (e.g. 'origin'), so let's do so.
>
> ...
> +        # check and upgrade old organization
> +        hg_path = os.path.join(shared_path, '.hg')
> +        if os.path.exists(shared_path) and not os.path.exists(hg_path):
> +            repos = os.listdir(shared_path)
> +            for x in repos:
> +                local_hg = os.path.join(shared_path, x, 'clone', '.hg')
> +                if not os.path.exists(local_hg):
> +                    continue
> +                shutil.copytree(local_hg, hg_path)

The log message talks about "one of the remotes (e.g. 'origin')" and
you are creating a copy of one that you encounter in os.listdir(); I
may be missing some underlying assumptions but I wonder what happens
after you copy and create hg_path directory, which does not change
in the loop, to the remaining iterations of the loop.  Is the untold
and obvious-to-those-who-are-familiar-with-this-codepath assumption
that it is guaranteed that there is at most one "*/clone/.hg" under
shared_path?

> +        # setup shared repo (if not there)
> +        try:
> +            hg.peer(myui, {}, shared_path, create=True)
> +        except error.RepoError:
> +            pass
>  
>          if not os.path.exists(dirname):
>              os.makedirs(dirname)
