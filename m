From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ignore trailing slash when creating leading directories
Date: Tue, 02 Sep 2008 11:38:38 -0700
Message-ID: <7vk5dul7f5.fsf@gitster.siamese.dyndns.org>
References: <20080902081909.GA2059@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Sep 02 20:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaan8-00009B-F5
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 20:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbYIBSip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 14:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbYIBSip
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 14:38:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYIBSio (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 14:38:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 69D26700C0;
	Tue,  2 Sep 2008 14:38:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 63C3A700BF; Tue,  2 Sep 2008 14:38:40 -0400 (EDT)
In-Reply-To: <20080902081909.GA2059@localhost> (Clemens Buchacher's message
 of "Tue, 2 Sep 2008 10:19:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E98AB82-791E-11DD-B247-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94690>

Clemens Buchacher <drizzd@aon.at> writes:

> 'git clone <repo> path/' (note the trailing slash) fails, because the
> entire path is interpreted as leading directories. So when mkdir tries to
> create the actual path, it already exists.
>
> This makes sure a trailing slash is ignored.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Thanks.

I have a few comments.

 (1) Addition of strerror(errno) is a good thing, but it is a separate
     topic;

 (2) I always thought that it was a clever feature to allow callers that
     would want to prepare a directory in advance to ask for "xyzzy/" and
     cause the whole path created.  You are breaking it, which may or may
     not be a bad thing per-se, because I do not think any existing caller
     depends on this behaviour;

 (3) If you *are* to break that feature, then I think you should also
     handle a user input that is broken in the same fashion as your clone
     example, namely, "git clone <repo> path//".  It does not make much
     senseto say "path/" as the last parameter to clone is not a user
     error but "path//" is.

If a change in behaviour to strip trailing slashes inside safe_c_l_d() is
agreed to be a good thing (I do not mind that myself, but there could be
some private patches people are using in their trees that depend on the
current behaviour --- we never know), I think it should go through the
usual next-master cycle as a feature enhancement / clean-up patch, so that
we have better chance to catch breakages this might cause to other people.

As a "bugfix" patch meant to apply to 'maint', I'd prefer a fix to the
caller (builtin-clone.c that calls the function), which should be of much
less impact.  It is fine to include the change to add strerror(errno) in
that patch, whose title would be "clone: fix creation of explicitly named
target directory".

> diff --git a/sha1_file.c b/sha1_file.c
> index 9ee1ed1..3cb9414 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -97,7 +97,7 @@ int safe_create_leading_directories(char *path)
>  
>  	while (pos) {
>  		pos = strchr(pos, '/');
> -		if (!pos)
> +		if (!pos || !*(pos + 1))

(minor nit) I think

		if (!pos || !pos[1])

is shorter and easier on the eye.

>  			break;
>  		*pos = 0;
>  		if (!stat(path, &st)) {
> -- 
> 1.6.0
